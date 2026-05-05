package database

import (
	"context"
	"fmt"
	"os"
	"strconv"
	"time"

	"github.com/redis/go-redis/v9"
)

var Redis *redis.Client

// InitRedis initializes Redis connection
func InitRedis() (*redis.Client, error) {
	host := getEnv("REDIS_HOST", "localhost")
	port := getEnv("REDIS_PORT", "6379")
	password := os.Getenv("REDIS_PASSWORD")
	
	dbStr := getEnv("REDIS_DB", "0")
	db, err := strconv.Atoi(dbStr)
	if err != nil {
		db = 0
	}

	client := redis.NewClient(&redis.Options{
		Addr:     fmt.Sprintf("%s:%s", host, port),
		Password: password,
		DB:       db,
		PoolSize: 100,
		MinIdleConns: 10,
		MaxRetries: 3,
		DialTimeout: 5 * time.Second,
		ReadTimeout: 3 * time.Second,
		WriteTimeout: 3 * time.Second,
	})

	// Test connection
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := client.Ping(ctx).Err(); err != nil {
		return nil, fmt.Errorf("failed to connect to Redis: %w", err)
	}

	Redis = client
	return client, nil
}

// Redis helper functions for TaxiTN

// SetDriverLocation updates driver location in Redis
func SetDriverLocation(ctx context.Context, driverID string, lat, lng float64) error {
	// Add to geospatial index
	key := "drivers:locations"
	member := redis.GeoLocation{
		Name:      driverID,
		Latitude:  lat,
		Longitude: lng,
	}
	
	if err := Redis.GeoAdd(ctx, key, &member).Err(); err != nil {
		return err
	}

	// Also store detailed location info
	detailKey := fmt.Sprintf("driver:location:%s", driverID)
	locationData := map[string]interface{}{
		"lat":        lat,
		"lng":        lng,
		"updated_at": time.Now().Unix(),
	}
	
	if err := Redis.HSet(ctx, detailKey, locationData).Err(); err != nil {
		return err
	}
	
	// Set TTL
	return Redis.Expire(ctx, detailKey, 5*time.Minute).Err()
}

// GetNearbyDrivers finds drivers within radius
func GetNearbyDrivers(ctx context.Context, lat, lng float64, radiusKm float64) ([]redis.GeoLocation, error) {
	key := "drivers:locations"
	
	locations, err := Redis.GeoRadius(ctx, key, lng, lat, &redis.GeoRadiusQuery{
		Radius:    radiusKm,
		Unit:      "km",
		WithDist:  true,
		WithCoord: true,
		Count:     10,
		Sort:      "ASC",
	}).Result()
	
	if err != nil {
		return nil, err
	}
	
	return locations, nil
}

// SetActiveRide stores active ride in Redis
func SetActiveRide(ctx context.Context, rideID string, data map[string]interface{}) error {
	key := fmt.Sprintf("ride:%s", rideID)
	
	if err := Redis.HSet(ctx, key, data).Err(); err != nil {
		return err
	}
	
	// Add to pending set if status is pending
	if status, ok := data["status"].(string); ok && status == "pending" {
		Redis.SAdd(ctx, "rides:pending", rideID)
	}
	
	return Redis.Expire(ctx, key, 24*time.Hour).Err()
}

// Cache helper functions
func SetCache(ctx context.Context, key string, value interface{}, ttl time.Duration) error {
	return Redis.Set(ctx, key, value, ttl).Err()
}

func GetCache(ctx context.Context, key string) (string, error) {
	return Redis.Get(ctx, key).Result()
}

func DeleteCache(ctx context.Context, key string) error {
	return Redis.Del(ctx, key).Err()
}
