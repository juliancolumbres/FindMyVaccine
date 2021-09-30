# FindMyVaccine

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)
3. [Milestone 1: Creating User Interface](#Milestone-1-Creating-User-Interface)
4. [Milestone 2: Displaying Data](#Milestone-2-Displaying-Data)
5. [Milestone 3: Viewing Website](#Milestone-3-Viewing-Website)
6. [Milestone 4: Directions and Location Access Denial](#Milestone-4-Directions-and-Location-Access-Denial)



## Overview
### Description
Find my vaccine is an app that allows users to browse for COVID-19 vaccination locations. Within the app, users can look for vaccination sites near their current location. 

### Overview
- **Category:** Health
- **Mobile:** This app is developed to run on iOS devices.
- **Story:** Users find COVID-19 vaccination locations, and use GPS to navigate to that locations.
- **Market:** All individuals who are looking to get a vaccine or are seeking more info.
- **Habit:** Users would need this when they are going through the vaccination process.
- **Scope:** Locations shown depend on availability of vaccines at each site. This app can find nearby locations or sites near any specified zipcode.

## Product Spec

### 1. User Stories

* [x] Animated launch screen to detail screen
* [x] Displaying a list of locations through table view
* [x] Providing access to location's website within the app
* [x] Setiting default location for users who deny location access
* [x] Providing GPS directions for user to navigate to vaccine locations
* [x] Users can see a list of all nearby locations through infinite scroll   

### 2. Screen Archetypes
   
* Location Details Screen
    * Showing location information.
     
* Map Screen
    * Displaying available locations on a map.    


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Location Details Screen
* Map Screen

**Flow Navigation** (Screen to Screen)

* Location -> Location Details Screenf
* Map -> Map screen

## Wireframes

Figma: https://www.figma.com/file/atYJ0tVcHPd97EGZril6MF/find-my-vaccine-wireframe?node-id=0%3A1


<img src="https://i.imgur.com/GY9PtKZ.jpg" width=600>


## Schema 

### Models

#### Location

| Property      | Type     | Description |
| ------------- | -------- | ------------|
| name  | String  | Name of the location |
| address | String | Address of vaccine site |
| vaccineTypes | String Array | Types of vaccine offered |
| vaccineStatus | boolean | Whether vaccine is available |
| vaccineUrl | String | Carrier website URL |

### Networking

#### We are accessing existing API to get data.

- Vaccine API

Base URL - https://www.vaccinespotter.org/api/v0/states/CA.json

## Milestone 1: Creating User Interface

### Adding App Icon 

<img src="https://i.imgur.com/GSrvGpo.png" width=250> 



### Creating Location Detail Screen

- The location detail screen consists of three main information: provider name, appointment status, and address.

<img src='http://g.recordit.co/aj7eTB4R64.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />



### Creating Map View

- From location detail screen, user can see the location on a map in map view screen.

<img src='http://g.recordit.co/3eST1BJzlB.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />



## Milestone 2: Displaying Data 


### Pin locations on Map View

<img src='http://g.recordit.co/R5FTUVhshN.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />


### Displaying Location Detail

<img src='http://g.recordit.co/9rvOa9mqEJ.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />


## Milestone 3: Viewing Website


### Open vaccine centers' websites 

<img src='https://i.imgur.com/wTHgeYo.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />

## Milestone 4: Directions and Location Access Denial

### Getting directions with Apple maps

<img src='https://i.imgur.com/5nOv0oj.gif' title='Video Walkthrough' width='250' alt='Getting directions with Apple maps' />



### Set default location to L.A. if user denies location access 

![](https://i.imgur.com/wexhJUY.gif)




