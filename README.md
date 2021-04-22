# FindMyVaccine

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)
3. [Milestone 1](#Milestone-1)


## Overview
### Description
Find my vaccine is an app that allows users to browse for Covid-19 vaccination locations. With the app, users can look for a Covid vaccination location near their living areas. 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Health app
- **Mobile:** This app will be developed for IOS devices' users 
- **Story:** Users find Covid-19 vaccination locations, and use GPS to navigate to that locations.
- **Market:** Any eligible individuals who are looking to get a vaccine.
- **Habit:** Users would need this when they are going through the vaccination process
- **Scope:** Shown locations depend on availability of vaccines at each site. This app can find nearby locations or sites near any specified zipcode.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Displaying a list of locations
* Providing an url to location's website

**Optional Nice-to-have Stories**

* Find location within a specific range (zipcode, current locations, etc...)
* Provide GPS for user to navigate to vaccine locations

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
| vaccineType| String  | Types of vaccine offered |
| vaccineStatus | boolean | Whether vaccine is available |

### Networking

#### We are only using Existing API to get data. Please see the next section.

#### OPTIONAL: List endpoints if using existing API 

- Vaccine API

Base URL - https://www.vaccinespotter.org/api/v0/states/CA.json


| HTTP Verb      | Endpoint     | Description |
| ------------- | -------- | ------------|
| GET |  /FeatureCollection/1/Features | gets all vaccination sites (known as features) and their information |
| GET | /Featurecollection/1/Features?appointments_available=true  | gets all vaccination sites where appointments are available |


## Milestone 1

#### Adding App Icon


#### Adding App Icon at Launch Screen


#### Creating Location Detail Screen


#### Creating Map View



