# TaxiTN Backend

Backend API for TaxiTN - Delivery & Ride Hailing Platform built with Go (Golang), Fiber, PostgreSQL, and Redis.

## 🚀 Features

- **Authentication**: JWT-based auth with OTP verification
- **Real-time**: WebSockets for live driver tracking
- **Geospatial**: PostGIS for location-based queries
- **Caching**: Redis for performance optimization
- **High Concurrency**: Go's goroutines for handling thousands of simultaneous connections

## 🛠️ Tech Stack

- **Go 1.21+**
- **Fiber** - Fast web framework
- **GORM** - ORM for PostgreSQL
- **Redis** - Caching & real-time data
- **PostgreSQL + PostGIS** - Database with geospatial support
- **JWT** - Authentication tokens

## 📁 Project Structure

```
backend/
├── cmd/
│   └── server/
│       └── main.go          # Entry point
├── internal/
│   ├── database/
│   │   ├── postgres.go      # PostgreSQL connection
│   │   └── redis.go         # Redis connection & helpers
│   ├── handlers/
│   │   └── handler.go       # HTTP handlers
│   ├── middleware/
│   │   ├── auth.go          # JWT authentication
│   │   ├── error.go         # Error handling
│   │   └── websocket.go     # WebSocket upgrade
│   ├── models/
│   ├── services/
│   └── ...
├── pkg/
│   └── utils/
├── configs/
├── go.mod
├── go.sum
├── .air.toml                # Hot reload config
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- Go 1.21+
- PostgreSQL 15+ with PostGIS
- Redis 7+
- Docker & Docker Compose (optional)

### Environment Setup

1. Copy environment variables:
```bash
cp ../docker/.env.example .env
```

2. Edit `.env` with your configuration:
```env
DB_HOST=localhost
DB_PORT=5432
DB_USER=taxitn
DB_PASSWORD=taxitn123
DB_NAME=taxitn

REDIS_HOST=localhost
REDIS_PORT=6379

JWT_SECRET=your-secret-key
PORT=8080
```

### Run with Docker (Recommended)

```bash
cd ../docker
docker-compose up -d
```

This will start:
- PostgreSQL on port 5432
- Redis on port 6379
- Backend on port 8080
- pgAdmin on port 5050
- Redis Insight on port 5540

### Run Locally

1. Install dependencies:
```bash
go mod download
```

2. Run with hot reload:
```bash
# Install Air (hot reload tool)
go install github.com/cosmtrek/air@latest

# Run with Air
air
```

Or run directly:
```bash
go run ./cmd/server
```

## 🔌 API Endpoints

### Authentication (Public)
- `POST /v1/auth/register` - Register new user
- `POST /v1/auth/login` - Login user
- `POST /v1/auth/verify-otp` - Verify OTP
- `POST /v1/auth/refresh` - Refresh token

### Protected (Requires JWT)
- `GET /v1/api/users/profile` - Get profile
- `PUT /v1/api/users/profile` - Update profile
- `POST /v1/api/drivers/register` - Register as driver
- `POST /v1/api/drivers/location` - Update location
- `POST /v1/api/rides` - Create ride
- `GET /v1/api/rides/:id` - Get ride
- `POST /v1/api/orders` - Create order

### Public
- `GET /v1/restaurants` - List restaurants
- `GET /v1/restaurants/:id` - Get restaurant

### WebSocket
- `WS /v1/ws` - Real-time connection

## 🧪 Testing

```bash
# Run tests
go test ./...

# Run with coverage
go test -cover ./...
```

## 📦 Deployment

### Build Docker Image
```bash
docker build -t taxitn-backend:latest -f ../docker/Dockerfile .
```

### Production Deployment
1. Set environment variables
2. Run migrations
3. Start server

## 📚 Documentation

- [OpenAPI Spec](../api/openapi.yaml) - API documentation
- [Database Schema](../database/postgres_schema.sql)
- [Redis Data Structures](../database/redis_schema.md)

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Open Pull Request

## 📝 License

MIT License - see LICENSE file
