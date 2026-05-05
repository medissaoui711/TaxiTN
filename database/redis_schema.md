# TaxiTN Redis Data Structures

## نظرة عامة
Redis يُستخدم في TaxiTN للـ:
- **Caching**: تخزين مؤقت للبيانات الشائعة
- **Real-time Location**: مواقع السائقين المُحدّثة لحظياً
- **Session Management**: JWT tokens و user sessions
- **Rate Limiting**: تقييد الطلبات
- **Pub/Sub**: إشعارات Real-time عبر WebSockets

---

## Data Structures

### 1. Driver Locations (Geospatial)

**Key**: `drivers:locations`  
**Type**: Redis Geo  
**TTL**: 5 minutes (if not updated, driver considered offline)

```redis
# Add/update driver location
GEOADD drivers:locations <lng> <lat> <driver_id>

# Find nearby drivers (within 5km)
GEORADIUS drivers:locations <lng> <lat> 5 km WITHDIST ASC

# Remove driver when offline
ZREM drivers:locations <driver_id>
```

**Additional Hash for driver details:**
```
Key: driver:location:<driver_id>
Type: Hash
Fields:
  - lat: float
  - lng: float
  - heading: int
  - speed: float
  - updated_at: timestamp
  - vehicle_type: string
  - is_available: bool
```

---

### 2. Active Rides

**Key**: `ride:<ride_id>`  
**Type**: Hash  
**TTL**: 24 hours after completion

```
Fields:
  - id: string
  - customer_id: string
  - driver_id: string (nullable)
  - status: string (pending, accepted, in_progress, completed)
  - pickup_lat: float
  - pickup_lng: float
  - dest_lat: float
  - dest_lng: float
  - estimated_fare: float
  - service_type: string
  - created_at: timestamp
```

**Ride Status Index:**
```
Key: rides:pending
Type: Set
Members: [ride_id_1, ride_id_2, ...]
```

**Driver Current Ride:**
```
Key: driver:ride:<driver_id>
Type: String (value: ride_id)
TTL: 4 hours
```

**Customer Current Ride:**
```
Key: customer:ride:<customer_id>
Type: String (value: ride_id)
TTL: 4 hours
```

---

### 3. JWT Sessions

**Key**: `session:<user_id>:<device_id>`  
**Type**: Hash  
**TTL**: 7 days

```
Fields:
  - access_token: string
  - refresh_token: string
  - device_info: string
  - ip_address: string
  - created_at: timestamp
  - last_used: timestamp
```

**Token Blacklist (for logout):**
```
Key: token:blacklist:<jti>
Type: String
Value: "revoked"
TTL: Until token expiry
```

---

### 4. Rate Limiting

**Key**: `ratelimit:<ip>:<endpoint>`  
**Type**: String (counter)  
**TTL**: 1 minute

**Key**: `ratelimit:user:<user_id>`  
**Type**: String (counter)  
**TTL**: 1 minute

```
# Rate limits:
- General API: 100 requests/minute per IP
- Auth endpoints: 5 requests/minute per IP
- Driver location updates: 1 request/10 seconds per driver
```

---

### 5. Caching

#### User Profile Cache
```
Key: cache:user:<user_id>
Type: Hash/String (JSON)
TTL: 1 hour
```

#### Restaurant Cache
```
Key: cache:restaurant:<restaurant_id>
Type: String (JSON)
TTL: 30 minutes
```

#### Menu Cache
```
Key: cache:menu:<restaurant_id>
Type: String (JSON)
TTL: 15 minutes
```

#### Fare Estimate Cache
```
Key: cache:fare:<hash_of_locations>
Type: String (JSON)
TTL: 5 minutes
```

---

### 6. Pub/Sub Channels

**Channels:**
- `driver:location:<driver_id>` - موقع السائق (for customers)
- `ride:updates:<ride_id>` - تحديثات الرحلة
- `order:updates:<order_id>` - تحديثات الطلب
- `notifications:<user_id>` - إشعارات المستخدم
- `broadcast:all` - إشعارات عامة
- `broadcast:drivers` - إشعارات للسائقين
- `broadcast:customers` - إشعارات للعملاء

**Message Format (JSON):**
```json
{
  "event": "location_update",
  "data": {
    "lat": 36.8065,
    "lng": 10.1815,
    "heading": 90,
    "eta_min": 5
  },
  "timestamp": "2026-05-05T10:30:00Z"
}
```

---

### 7. Real-time Stats

**Platform Stats:**
```
Key: stats:online_drivers
Type: String (counter)

Key: stats:active_rides
Type: String (counter)

Key: stats:pending_orders
Type: String (counter)

Key: stats:today_rides
Type: String (counter)
Reset: Daily at midnight

Key: stats:today_earnings
Type: String (float)
Reset: Daily at midnight
```

**Driver Stats (Real-time):**
```
Key: driver:stats:<driver_id>:today
Type: Hash
Fields:
  - rides_count: int
  - earnings: float
  - online_hours: float
Reset: Daily at midnight
```

---

### 8. Temporary Data

**OTP Codes:**
```
Key: otp:<phone_number>
Type: String
Value: 6-digit code
TTL: 5 minutes
```

**Password Reset Tokens:**
```
Key: pwdreset:<token>
Type: String (user_id)
TTL: 1 hour
```

**Pending Driver Verifications:**
```
Key: driver:pending:<driver_id>
Type: Hash
Fields:
  - submitted_at: timestamp
  - documents_count: int
  - reviewed_by: admin_id (nullable)
TTL: 7 days
```

---

### 9. Leaderboards (Optional)

**Top Drivers (Weekly):**
```
Key: leaderboard:drivers:weekly
Type: Sorted Set
Score: rides_count or earnings
Member: driver_id
Reset: Every Sunday at midnight
```

---

## Redis Commands Examples

### Driver Location Tracking
```redis
# Update location (called every 10 seconds when moving)
GEOADD drivers:locations 10.1815 36.8065 driver_123
HSET driver:location:driver_123 lat 36.8065 lng 10.1815 heading 90 speed 45 updated_at 1714903800
EXPIRE driver:location:driver_123 300

# Find nearby available drivers
GEORADIUS drivers:locations 10.1815 36.8065 5 km WITHDIST WITHCOORD ASC COUNT 10

# Publish location update to subscribers
PUBLISH driver:location:driver_123 '{"lat":36.8065,"lng":10.1815,"eta":5}'
```

### Ride Matching
```redis
# Create ride request
HSET ride:ride_456 id ride_456 customer_id cust_789 status pending pickup_lat 36.8065 ...
SADD rides:pending ride_456
EXPIRE ride:ride_456 86400

# Driver accepts ride
HSET ride:ride_456 driver_id driver_123 status accepted
SREM rides:pending ride_456
SET driver:ride:driver_123 ride_456 EX 14400
SET customer:ride:cust_789 ride_456 EX 14400

# Publish ride update
PUBLISH ride:updates:ride_456 '{"status":"accepted","driver_id":"driver_123"}'
```

### Caching
```redis
# Cache user profile
SET cache:user:user_123 '{"id":"user_123","name":"Ahmed"}' EX 3600

# Get cached profile
GET cache:user:user_123

# Cache invalidation on update
DEL cache:user:user_123
```

---

## Memory Management

### Key Expiration Strategy
- **Driver locations**: 5 minutes (considered offline if not updated)
- **Sessions**: 7 days (with refresh token rotation)
- **Ride data**: 24 hours after completion
- **Cache data**: 15-60 minutes based on volatility
- **OTP codes**: 5 minutes
- **Temp tokens**: 1 hour

### Memory Optimization
- Use Redis Hash for structured data (more memory efficient than JSON strings)
- Set appropriate TTLs for all keys
- Use Redis LRU eviction policy for cache keys
- Monitor memory usage with `INFO memory`
- Consider Redis Cluster for horizontal scaling

---

## Monitoring Keys

```redis
# Total keys
DBSIZE

# Memory usage
INFO memory

# Keys by pattern
SCAN 0 MATCH driver:location:* COUNT 100

# TTL of a key
TTL driver:location:driver_123
```

---

## Backup Strategy

1. **RDB Snapshots**: Every 15 minutes
2. **AOF**: Enabled for durability
3. **Replication**: Redis Sentinel for high availability
4. **External backup**: Daily dumps to S3

---

**Version**: 1.0.0  
**Last Updated**: May 2026
