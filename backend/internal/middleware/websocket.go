package middleware

import (
	"github.com/gofiber/fiber/v2"
	fwebsocket "github.com/gofiber/websocket/v2"
)

// WebSocketUpgrade middleware to upgrade HTTP to WebSocket
func WebSocketUpgrade() func(*fiber.Ctx) error {
	return func(c *fiber.Ctx) error {
		// Check if client requested WebSocket upgrade
		if fwebsocket.IsWebSocketUpgrade(c) {
			c.Locals("allowed", true)
			return c.Next()
		}
		return fiber.ErrUpgradeRequired
	}
}

// WebSocketHandler handles WebSocket connections
func WebSocketHandler(c *fwebsocket.Conn) {
	// This is a placeholder - actual implementation will be in handlers
	// For now, just echo messages back
	for {
		mt, msg, err := c.ReadMessage()
		if err != nil {
			break
		}
		if err := c.WriteMessage(mt, msg); err != nil {
			break
		}
	}
}
