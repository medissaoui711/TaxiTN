package main

import (
	"log"
	"os"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
	"github.com/gofiber/fiber/v2/middleware/logger"
	"github.com/gofiber/fiber/v2/middleware/recover"
	"github.com/joho/godotenv"

	"github.com/medissaoui711/taxitn-backend/internal/database"
	"github.com/medissaoui711/taxitn-backend/internal/handlers"
	"github.com/medissaoui711/taxitn-backend/internal/middleware"
)

func main() {
	// Load environment variables
	if err := godotenv.Load(); err != nil {
		log.Println("No .env file found, using environment variables")
	}

	// Initialize database connections
	db, err := database.InitPostgres()
	if err != nil {
		log.Fatalf("Failed to connect to PostgreSQL: %v", err)
	}

	redisClient, err := database.InitRedis()
	if err != nil {
		log.Fatalf("Failed to connect to Redis: %v", err)
	}

	// Run database migrations
	if err := database.Migrate(db); err != nil {
		log.Fatalf("Failed to migrate database: %v", err)
	}

	// Initialize Fiber app
	app := fiber.New(fiber.Config{
		AppName:      "TaxiTN API v1.0",
		ErrorHandler: middleware.ErrorHandler,
	})

	// Global middleware
	app.Use(recover.New())
	app.Use(logger.New(logger.Config{
		Format: "[${time}] ${status} - ${method} ${path}\n",
	}))
	app.Use(cors.New(cors.Config{
		AllowOrigins: "*",
		AllowHeaders: "Origin, Content-Type, Accept, Authorization",
		AllowMethods: "GET, POST, PUT, DELETE, OPTIONS",
	}))

	// Health check
	app.Get("/health", func(c *fiber.Ctx) error {
		return c.JSON(fiber.Map{
			"status":  "healthy",
			"service": "TaxiTN API",
			"version": "1.0.0",
		})
	})

	// API v1 routes
	v1 := app.Group("/v1")

	// Initialize handlers
	handler := handlers.NewHandler(db, redisClient)

	// Auth routes (public)
	auth := v1.Group("/auth")
	auth.Post("/register", handler.Register)
	auth.Post("/login", handler.Login)
	auth.Post("/verify-otp", handler.VerifyOTP)
	auth.Post("/refresh", handler.RefreshToken)

	// Protected routes
	api := v1.Group("/api", middleware.AuthRequired())

	// User routes
	api.Get("/users/profile", handler.GetProfile)
	api.Put("/users/profile", handler.UpdateProfile)

	// Driver routes
	api.Post("/drivers/register", handler.RegisterDriver)
	api.Post("/drivers/location", handler.UpdateLocation)
	api.Post("/drivers/online", handler.SetOnlineStatus)

	// Ride routes
	api.Post("/rides/estimate", handler.EstimateRide)
	api.Post("/rides", handler.CreateRide)
	api.Get("/rides/:id", handler.GetRide)
	api.Post("/rides/:id/cancel", handler.CancelRide)

	// Order routes
	api.Post("/orders", handler.CreateOrder)
	api.Get("/orders/:id", handler.GetOrder)

	// Restaurant routes (public)
	v1.Get("/restaurants", handler.ListRestaurants)
	v1.Get("/restaurants/:id", handler.GetRestaurant)

	// Payment routes
	api.Get("/payments/methods", handler.GetPaymentMethods)
	api.Get("/payments/wallet", handler.GetWallet)

	// WebSocket endpoint for real-time updates
	v1.Get("/ws", middleware.WebSocketUpgrade(), handler.HandleWebSocket)

	// Get port from environment
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Printf("🚀 TaxiTN API starting on port %s", port)
	if err := app.Listen(":" + port); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
