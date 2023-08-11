// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.19.1

package database

import (
	"database/sql"
	"time"

	"github.com/google/uuid"
)

type Auth struct {
	UserID    uuid.UUID
	CreatedAt time.Time
	UpdatedAt time.Time
	Password  string
}

type Session struct {
	UserID     uuid.UUID
	CreatedAt  time.Time
	SessionKey string
}

type User struct {
	ID        uuid.UUID
	CreatedAt time.Time
	UpdatedAt time.Time
	Email     string
}

type UserProfile struct {
	UserID    uuid.UUID
	CreatedAt time.Time
	UpdatedAt time.Time
	Username  string
	About     sql.NullString
	PpUrl     sql.NullString
}
