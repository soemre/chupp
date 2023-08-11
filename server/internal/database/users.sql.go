// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.19.1
// source: users.sql

package database

import (
	"context"

	"github.com/google/uuid"
)

const createUser = `-- name: CreateUser :exec
INSERT INTO users (id, created_at, updated_at, email)
VALUES ($1, NOW(), NOW(), $2)
`

type CreateUserParams struct {
	ID    uuid.UUID
	Email string
}

func (q *Queries) CreateUser(ctx context.Context, arg CreateUserParams) error {
	_, err := q.db.ExecContext(ctx, createUser, arg.ID, arg.Email)
	return err
}

const getUserByEmail = `-- name: GetUserByEmail :one
SELECT id, created_at, updated_at, email FROM users
WHERE email = $1
`

func (q *Queries) GetUserByEmail(ctx context.Context, email string) (User, error) {
	row := q.db.QueryRowContext(ctx, getUserByEmail, email)
	var i User
	err := row.Scan(
		&i.ID,
		&i.CreatedAt,
		&i.UpdatedAt,
		&i.Email,
	)
	return i, err
}
