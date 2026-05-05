package middleware

import (
	"github.com/gofiber/fiber/v2"
)

// ErrorHandler custom error handler
func ErrorHandler(c *fiber.Ctx, err error) error {
	// Default error response
	code := fiber.StatusInternalServerError
	message := "Internal Server Error"

	// Check if it's a Fiber error
	if e, ok := err.(*fiber.Error); ok {
		code = e.Code
		message = e.Message
	}

	// Log error (in production, use proper logging)
	// log.Printf("Error [%d]: %s - %s", code, c.Path(), err.Error())

	// Return JSON response
	return c.Status(code).JSON(fiber.Map{
		"success": false,
		"error":   message,
		"code":    code,
	})
}
