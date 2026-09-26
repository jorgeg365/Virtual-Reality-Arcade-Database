# Virtual Reality Arcade Management System

**CIS 344 - Project 1**

This project is a MySQL database designed to manage the daily operations of a virtual reality arcade.

## Project Overview

The database manages:

- Customers
- Bookings
- VR stations
- Games
- Employees
- Payments
- Equipment maintenance

The database is named `vr_arcade_db` and contains eight related tables:

`CUSTOMER`, `BOOKING`, `VR_STATION`, `GAME`, `EMPLOYEE`, `PAYMENT`, `MAINTENANCE`, and `BOOKING_GAME`.

The `BOOKING_GAME` junction table resolves the many-to-many relationship between bookings and games.

## Repository Contents

- `Virtual_Reality_Arcade.sql` - Database creation script, sample data, and SQL queries
- `Virtual_Reality_Arcade.mwb` - MySQL Workbench database model
- `Virtual_Reality_Arcade.pdf` - Hand-drawn Chen ER diagram
- `Virtual_Reality_Arcade_UML_EER.pdf` - UML/EER diagram created in MySQL Workbench
- `Project1.docx` - Final project report

## Database Features

- Primary keys and foreign keys
- One-to-many, one-to-one, and many-to-many relationships
- `BOOKING_GAME` junction table
- Indexes and constraints
- Sample data
- JOIN queries
- Aggregate query
- UPDATE example

## Software

- MySQL
- MySQL Workbench

## Research Sources

Requirements were informed by online research of real virtual reality arcades:

- Sandbox VR: https://sandboxvr.com/
- Zero Latency VR: https://zerolatencyvr.com/en
