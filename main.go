package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
	hello "github.com/minghsu0107/go-private-hello"
)

func main() {
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": hello.Say(),
		})
	})
	r.Run()
}
