<a name="readme-top"></a>

<!-- PROJECT SHIELDS -->

<div align="right">

[![Maintainability](https://api.codeclimate.com/v1/badges/26f1b36435ef838c9599/maintainability)](https://codeclimate.com/github/AMSterling/market_money/maintainability)
<!-- ![SimpleCov coverage](https://coverage.traels.it/badges/Z2l0QGdpdGh1Yi5jb206QU1TdGVybGluZy9tYXJrZXRfbW9uZXkuZ2l0) -->

</div>

[![Contributors][contributors-shield]][contributors-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<br>

<div align="center">

# Market Money

[![Rails][Rails]][Rails-url] [![Ruby][Ruby]][Ruby-url] [![RSpec][RSpec]][RSpec-url] [![Atom][Atom]][Atom-url] [![PostgreSQL][PostgreSQL]][PostgreSQL-url] [![Postman][Postman]][Postman-url]

</div>

## Description

Market Money is a Backend Service Oriented Architecture application that utilizes RESTful architecture.

<br>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#architecture">Architecture</a></li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#gem-documentation">Gem Documentation</a></li>
    <li>
      <a href="#endpoints">Endpoints</a>
      <ul>
        <a href="#markets">Markets</a>
        <ul>
          <li><a href="#all-markets">All Markets</a></li>
          <li><a href="#one-market">One Market</a></li>
          <li><a href="#vendors-for-a-market">Vendors For a Market</a></li>
          <li><a href="#one-vendor-for-a-market">One Vendor For a Market</a></li>
          <li><a href="#nearest-atms">Nearest ATMs</a></li>
        </ul>
        <a href="#markets_search">Markets Search</a>
        <ul>
          <li><a href="#search-markets-by-name">Search Markets By Name</a></li>
          <li><a href="#search-markets-by-name-and-state">Search Markets By Name and State</a></li>
          <li><a href="#search-markets-by-name-city-state">Search Markets By Name City State</a></li>
        </ul>
        <a href="#vendors">Vendors</a>
        <ul>
          <li><a href="#all-vendors">All Vendors</a></li>
          <li><a href="#one-vendor">One Vendor</a></li>
          <li><a href="#create-vendor">Create Vendor</a></li>
          <li><a href="#update-vendor">Update Vendor</a></li>
          <li><a href="#delete-vendor">Delete Vendor</a></li>
          <li><a href="#markets-for-a-vendor">Markets For a Vendor</a></li>
          <li><a href="#one-market-for-a-vendor">One Market For a Vendor</a></li>
        </ul>
        <a href="#marketvendors">MarketVendors</a>
        <ul>
          <li><a href="#create-marketvendor">Create MarketVendor</a></li>
          <li><a href="#delete-marketvendor">Delete MarketVendor</a></li>
        </ul>
      </ul>
    </li>  
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>
<br>

<!-- Architecture -->
## Architecture

<img width="1089" alt="MarketMoneySchema" src="https://github.com/AMSterling/market_money/assets/103849872/0b13a4f6-30da-4e6c-af28-f415d74349af">

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

Ruby:
  ```sh
  3.1.1
  ```
Rails:
  ```sh
  7.0.4
  ```
Database:
  ```sh
  postgresql@14
  ```

API Keys:
Market Money uses <a href="https://developer.tomtom.com/" target="_blank" rel="noopener noreferrer">TomTom API</a>

---

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Installation

Instructions to set up a local version of Market Money:

Fork and clone the project, then install the required gems with `bundle`. A full list of gems that will be installed can be found in the [gemfile][gemfile-url].

```sh
bundle install
```

Reset and seed the database:

```sh
rake db:{drop,create,migrate,seed}
```

```sh
rake db:schema:dump
```
Run:

```sh
bundle exec figaro install
```
```sh
rails generate rspec:install
```
```sh
bundle update
```

In `config/application.yml` add API keys:

```sh
tom_tom_api_key: 'YOUR TOMTOM KEY'
```

To run the test suite:

```sh
bundle exec rspec
```

To view test coverage:

```sh
open coverage/index.html
```

Push to your preferred production server or in your terminal run
 ```sh
  rails server
 ```
Then open [http://localhost:3000](http://localhost:3000) in your browser.

---
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Gem Documentation

* [factory_bot_rails][factory_bot_rails-docs]
* [faker][faker-docs]
* [figaro][figaro-docs]
* [jsonapi-serializer][jsonapi-serializer-docs]
* [multi_json][multi_json-docs]
* [pry][pry-docs]
* [rspec-rails][rspec-rails-docs]
* [shoulda-matchers][shoulda-matchers-docs]
* [simplecov][simplecov-docs]
* [vcr][vcr-docs]
* [webmock][webmock-docs]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Endpoints

Endpoints to use in Postman running a local server `rails s`

### Markets

#### All Markets

```sh
  GET http://localhost:3000/api/v0/markets
```

**Sample Response(200)**

```sh
{
    "data": [
        {
            "id": "322458",
            "type": "market",
            "attributes": {
                "name": "14&U Farmers' Market",
                "street": "1400 U Street NW ",
                "city": "Washington",
                "county": "District of Columbia",
                "state": "District of Columbia",
                "zip": "20009",
                "lat": "38.9169984",
                "lon": "-77.0320505",
                "vendor_count": 1
            }
        },
        {
            "id": "322474",
            "type": "market",
            "attributes": {
                "name": "2nd Street Farmers' Market",
                "street": "194 second street",
                "city": "Amherst",
                "county": "Amherst",
                "state": "Virginia",
                "zip": "24521",
                "lat": "37.583311",
                "lon": "-79.048573",
                "vendor_count": 35
            }
        },
        {
            "id": "322482",
            "type": "market",
            "attributes": {
                "name": "39 North Marketplace",
                "street": "Downtown Sparks Victorian Ave",
                "city": "Sparks",
                "county": "Washoe",
                "state": "Nevada",
                "zip": "89431",
                "lat": "39.534773",
                "lon": "-119.754962",
                "vendor_count": 5
            }
        },
        {...},
        {...},
        {...},
        {etc},
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### One Market

```sh
  GET http://localhost:3000/api/v0/markets/{{market_id}}
```

**Sample Response(200)**

```sh
{
    "data": {
        "id": "322474",
        "type": "market",
        "attributes": {
            "name": "2nd Street Farmers' Market",
            "street": "194 second street",
            "city": "Amherst",
            "county": "Amherst",
            "state": "Virginia",
            "zip": "24521",
            "lat": "37.583311",
            "lon": "-79.048573",
            "vendor_count": 35
        }
    }
}
```

```sh
  GET http://localhost:3000/api/v0/markets/123123123123123
```

**Sample Response(404 Not Found - Market ID doesn't exist)**

```sh
{
    "errors": [
        {
            "detail": "Couldn't find Market with 'id'=123123123123123"
        }
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Vendors For a Market

```sh
  GET http://localhost:3000/api/v0/markets/322474/vendors
```

**Sample Response(200)**

```sh
{
    "data": [
        {
            "id": "55297",
            "type": "vendor",
            "attributes": {
                "name": "Orange County Olive Oil",
                "description": "Handcrafted olive oil made from locally grown olives",
                "contact_name": "Syble Hamill",
                "contact_phone": "1-276-593-3530",
                "credit_accepted": false
            }
        },
        {
            "id": "56227",
            "type": "vendor",
            "attributes": {
                "name": "The Vodka Vault",
                "description": "Handcrafted vodka with a focus on unique and unusual flavors",
                "contact_name": "Rueben Parker DVM",
                "contact_phone": "1-140-885-8633",
                "credit_accepted": true
            }
        },
        {
            "id": "56172",
            "type": "vendor",
            "attributes": {
                "name": "The Fabric Patch",
                "description": "Upcycled fabric creations and accessories.",
                "contact_name": "Hank Simonis",
                "contact_phone": "363.062.9508",
                "credit_accepted": false
            }
        },
        {...},
        {...},
        {...},
        {etc},
    ]
}
```

```sh
  GET http://localhost:3000/api/v0/markets/123123123123123/vendors
```

**Sample Response(404 Not Found - Market ID doesn't exist)**

```sh
{
    "errors": [
        {
            "detail": "Couldn't find Market with 'id'=123123123123123"
        }
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### One Vendor For a Market

```sh
  GET http://localhost:3000/api/v0/markets/322474/vendors/55297
```

**Sample Response(200)**

```sh
{
    "data": {
        "id": "55297",
        "type": "vendor",
        "attributes": {
            "name": "Orange County Olive Oil",
            "description": "Handcrafted olive oil made from locally grown olives",
            "contact_name": "Syble Hamill",
            "contact_phone": "1-276-593-3530",
            "credit_accepted": false
        }
    }    
}
```

```sh
  GET http://localhost:3000/api/v0/markets/123123123123123/vendors/55297
```

**Sample Response(404 Not Found - Market ID doesn't exist)**

```sh
{
    "errors": [
        {
            "detail": "Couldn't find Market with 'id'=123123123123123"
        }
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Nearest ATMs

```sh
  GET http://localhost:3000/api/v0/markets/330318/nearest_atms
```

**Sample Response(200)**

```sh
{
    "data": [
        {
            "id": null,
            "type": "atm",
            "attributes": {
                "name": "Metabank",
                "address": "312 Southwest Maple Street, Ankeny, IA 50023",
                "lat": 41.729244,
                "lon": -93.608803,
                "distance": 91.431357
            }
        },
        {
            "id": null,
            "type": "atm",
            "attributes": {
                "name": "Lynk Systems",
                "address": "302 South Ankeny Boulevard, Ankeny, IA 50023",
                "lat": 41.729343,
                "lon": -93.600959,
                "distance": 596.269236
            }
        },
        {
            "id": null,
            "type": "atm",
            "attributes": {
                "name": "Lynk Systems",
                "address": "11655 Southwest Ordnance Road, Ankeny, IA 50023",
                "lat": 41.724422,
                "lon": -93.611076,
                "distance": 655.177767
            }
        },
        {...},
        {...},
        {...},
        {etc},
    ]
}
```

```sh
  GET http://localhost:3000/api/v0/markets/123123123123123/nearest_atms
```

**Sample Response(404 Not Found - Market ID doesn't exist)**

```sh
{
    "errors": [
        {
            "detail": "Couldn't find Market with 'id'=123123123123123"
        }
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Markets Search

#### Search Markets By Name

```sh
  GET  http://localhost:3000/api/v0/markets/search?name=county
```

**Sample Response(200)**

```sh
{
    "data": [
        {
            "id": "325933",
            "type": "market",
            "attributes": {
                "name": "Henry County Farmers Market",
                "street": "100 block of S Main Street",
                "city": "New Castle",
                "county": "Henry",
                "state": "Indiana",
                "zip": "47632",
                "lat": "39.9705",
                "lon": "-85.355",
                "vendor_count": 13
            }
        },
        {
            "id": "322532",
            "type": "market",
            "attributes": {
                "name": "Adams County Farmers' Market Association (PA)",
                "street": "Lincoln Square ",
                "city": "Gettysburg",
                "county": "Adams",
                "state": "Pennsylvania",
                "zip": "17325",
                "lat": "39.830706",
                "lon": "-77.230764",
                "vendor_count": 19
            }
        },
        {
            "id": "322660",
            "type": "market",
            "attributes": {
                "name": "Anoka County Growers/ St. Timothy Church Blaine",
                "street": "707 89th Ave. NE",
                "city": "Blaine",
                "county": "Anoka",
                "state": "Minnesota",
                "zip": null,
                "lat": "45.1330400",
                "lon": "-93.2525239",
                "vendor_count": 12
            }
        },
        {...},
        {...},
        {...},
        {etc},
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Search Markets By Name and State

```sh
  GET  http://localhost:3000/api/v0/markets/search?name=county&state=west%20Virginia
```

**Sample Response(200)**

```sh
{
    "data": [
        {
            "id": "323196",
            "type": "market",
            "attributes": {
                "name": "Braxton County Tailgate Market",
                "street": "Rt. 4 Gassaway",
                "city": "Gassaway",
                "county": "Braxton",
                "state": "West Virginia",
                "zip": "26624",
                "lat": "38.6753",
                "lon": "-80.7719",
                "vendor_count": 13
            }
        },
        {
            "id": "323848",
            "type": "market",
            "attributes": {
                "name": "Clay County Farmers Market",
                "street": "Old RGA Parking Lot",
                "city": "Clay",
                "county": "Clay County",
                "state": "West Virginia",
                "zip": null,
                "lat": "38.4601",
                "lon": "-81.0845",
                "vendor_count": 14
            }
        }
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Search Markets By Name City State

```sh
  GET  http://localhost:3000/api/v0/markets/search?name=county&city=GasSaway&state=west%20Virginia
```

**Sample Response(200)**

```sh
{
    "data": [
        {
            "id": "323196",
            "type": "market",
            "attributes": {
                "name": "Braxton County Tailgate Market",
                "street": "Rt. 4 Gassaway",
                "city": "Gassaway",
                "county": "Braxton",
                "state": "West Virginia",
                "zip": "26624",
                "lat": "38.6753",
                "lon": "-80.7719",
                "vendor_count": 13
            }
        }
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


```sh
  GET  http://localhost:3000/api/v0/markets/search?city=GasSaway
```

**Sample Response(422 Unprocessable Entity - City Must Be Accompanied By State)**

```sh
{
    "error": "Invalid Parameters"
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Vendors

#### All Vendors

```sh
  GET http://localhost:3000/api/v0/vendors
```

**Sample Response(200)**

```sh
{
    "data": [
        {
            "id": "54849",
            "type": "vendor",
            "attributes": {
                "name": "Organic Farms",
                "description": "This vendor specializes in selling fresh, organic fruits and vegetables grown on their farm. They may also sell jams, jellies, and pickles made from their produce.",
                "contact_name": "Msgr. Floyd Cole",
                "contact_phone": "390.398.6702",
                "credit_accepted": false
            }
        },
        {
            "id": "54850",
            "type": "vendor",
            "attributes": {
                "name": "Artisanal Bakery",
                "description": "This vendor offers a variety of fresh-baked bread, pastries, and other baked goods. They may also sell gluten-free or vegan options.",
                "contact_name": "Shelba Jenkins",
                "contact_phone": "1-228-600-4476",
                "credit_accepted": false
            }
        },
        {
            "id": "54851",
            "type": "vendor",
            "attributes": {
                "name": "Local Honey Producer",
                "description": "This vendor sells jars of honey produced by local bees. They may also sell beeswax candles, lip balms, and other products made from beeswax.",
                "contact_name": "Hai Daniel",
                "contact_phone": "670-003-3675",
                "credit_accepted": false
            }
        },
        {...},
        {...},
        {...},
        {etc},
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### One Vendor

```sh
  GET http://localhost:3000/api/v0/vendors/55297
```

**Sample Response(200)**

```sh
{
    "data": {
        "id": "55297",
        "type": "vendor",
        "attributes": {
            "name": "Orange County Olive Oil",
            "description": "Handcrafted olive oil made from locally grown olives",
            "contact_name": "Syble Hamill",
            "contact_phone": "1-276-593-3530",
            "credit_accepted": false
        }
    }
}
```

```sh
  GET http://localhost:3000/api/v0/vendors/123123123123123
```

**Sample Response(404 Not Found - Vendor ID doesn't exist)**

```sh
{
    "errors": [
        {
            "detail": "Couldn't find Vendor with 'id'=123123123123123"
        }
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Create Vendor

```sh
  POST http://localhost:3000/api/v0/vendors
```

**Sample Body**

```sh
{
    "name": "Buzzy Bees",
    "description": "local honey and wax products",
    "contact_name": "Berly Couwer",
    "contact_phone": "8389928383",
    "credit_accepted": false
}
```

**Sample Response(201 Created)**

```sh
{
    "data": {
        "id": "56544",
        "type": "vendor",
        "attributes": {
            "name": "Buzzy Bees",
            "description": "local honey and wax products",
            "contact_name": "Berly Couwer",
            "contact_phone": "8389928383",
            "credit_accepted": false
        }
    }
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

**Sample Invalid Body**

```sh
{
    "name": "Buzzy Bees",
    "description": "local honey and was products"
}
```

**Sample Response(400 Bad Request)**

```sh
{
  "data": {},
  "errors": "Parameters Missing or Invalid"
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Update Vendor

```sh
  PATCH http://localhost:3000/api/v0/vendors/56545
```

**Sample Body**

```sh
{
    "contact_name": "{{new_contact_name}}",
    "contact_phone": "{{new_contact_phone}}"
}
```

**Sample Response(200)**

```sh
{
    "data": {
        "id": "56545",
        "type": "vendor",
        "attributes": {
            "name": "Buzzy Bees",
            "description": "local honey and wax products",
            "contact_name": "Kimberly Couwer",
            "contact_phone": "8389928384",
            "credit_accepted": false
        }
    }
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Delete Vendor

```sh
  DELETE http://localhost:3000/api/v0/vendors/{{vendor_id}}
```

**Sample Response(204)**

```sh
""
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Markets For a Vendor

```sh
  GET http://localhost:3000/api/v0/vendors/55205/markets
```

**Sample Response(200)**

```sh
{
    "data": [
        {
            "id": "322646",
            "type": "market",
            "attributes": {
                "name": "Andover Farmers Market",
                "street": "13655 Round Lake Blvd. NW",
                "city": "Andover",
                "county": "Anoka",
                "state": "Minnesota",
                "zip": null,
                "lat": "45.2192618",
                "lon": "-93.3573105",
                "vendor_count": 20
            }
        },
        {
            "id": "322660",
            "type": "market",
            "attributes": {
                "name": "Anoka County Growers/ St. Timothy Church Blaine",
                "street": "707 89th Ave. NE",
                "city": "Blaine",
                "county": "Anoka",
                "state": "Minnesota",
                "zip": null,
                "lat": "45.1330400",
                "lon": "-93.2525239",
                "vendor_count": 12
            }
        },
        {
            "id": "323588",
            "type": "market",
            "attributes": {
                "name": "Centennial Lakes Farmers Market",
                "street": "7499 France Avenue",
                "city": "Edina",
                "county": "Hennepin",
                "state": "Minnesota",
                "zip": "55435",
                "lat": "44.8669",
                "lon": "-93.3264",
                "vendor_count": 18
            }
        },
        {...},
        {...},
        {...},
        {etc},
    ]
}
```

```sh
  GET http://localhost:3000/api/v0/vendors/123123123123123/markets
```

**Sample Response(404 Not Found - Vendor ID doesn't exist)**

```sh
{
    "errors": [
        {
            "detail": "Couldn't find Vendor with 'id'=123123123123123"
        }
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### One Market For a Vendor

```sh
  GET http://localhost:3000/api/v0/vendors/55205/markets/322646
```

**Sample Response(200)**

```sh
{
    "data": {
        "id": "322646",
        "type": "market",
        "attributes": {
            "name": "Andover Farmers Market",
            "street": "13655 Round Lake Blvd. NW",
            "city": "Andover",
            "county": "Anoka",
            "state": "Minnesota",
            "zip": null,
            "lat": "45.2192618",
            "lon": "-93.3573105",
            "vendor_count": 20
        }
    }
}
```

```sh
  GET http://localhost:3000/api/v0/vendors/123123123123123/markets/322646
```

**Sample Response(404 Not Found - Vendor ID doesn't exist)**

```sh
{
    "errors": [
        {
            "detail": "Couldn't find Vendor with 'id'=123123123123123"
        }
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### MarketVendors

#### Create MarketVendor

```sh
  POST http://localhost:3000/api/v0/market_vendors
```

**Sample Body**

```sh
{
      "market_id": 322925,
      "vendor": {
        "name": "Buzzy Bees",
        "description": "local honey and wax products",
        "contact_name": "Berly Couwer",
        "contact_phone": "8389928383",
        "credit_accepted": false
}
  }
```

```sh
{
      "market_id": 322925,
      "vendor_id": 56546
  }
```

**Sample Response(201)**

```sh
{
    "data": {
        "id": "443547",
        "type": "market_vendor",
        "attributes": {
            "market_id": 322925,
            "vendor_id": 56546
        }
    }
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


**Sample Invalid Body**

```sh
{
      "market_id": 322925,
      "vendor": {
        "name": "",
        "description": "local honey and wax products",
        "contact_name": "Berly Couwer",
        "contact_phone": "8389928383",
        "credit_accepted": false
}
  }
```

```sh
{
      "market_id": 123123123123123123123,
      "vendor_id": 56546
  }
```

**Sample Response(400)**

```sh
{
  "data": {},
  "errors": "Parameters Missing or Invalid"
}
```

**Sample Response(404)**

```sh
{
    "errors": [
        {
            "detail": "Couldn't find Market with 'id'=123123123123123"
        }
    ]
}
```

**Sample Response(422 - Existing Association)**

```sh
{
    "data": {},
    "errors": "Association already exists"
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Delete MarketVendor

```sh
  DELETE http://localhost:3000/api/v0/market_vendors
```

**Sample Body**

```sh
{
  "market_id": 322925,
  "vendor_id": 56546
}
```

**Sample Response(204)**

```sh
""
```


**Sample Ivalid Body**

```sh
{
  "market_id": 123123123123123123123,
  "vendor_id": 56546
}
```

**Sample Response(404)**

```sh
{
    "errors": [
        {
            "detail": "Couldn't find Market with 'id'=123123123123123"
        }
    ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Contact

Anna Marie Sterling - [LinkedIn][linkedin-url]

Project Link: [https://github.com/AMSterling/market_money](https://github.com/AMSterling/market_money)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->

<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/AMSterling/market_money.svg?style=for-the-badge
[contributors-url]: https://github.com/AMSterling/market_money/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/AMSterling/market_money.svg?style=for-the-badge
[forks-url]: https://github.com/AMSterling/market_money/network/members
[gemfile-url]: https://github.com/AMSterling/market_money/blob/main/Gemfile
[stars-shield]: https://img.shields.io/github/stars/AMSterling/market_money.svg?style=for-the-badge
[stars-url]: https://github.com/AMSterling/market_money/stargazers
[issues-shield]: https://img.shields.io/github/issues/AMSterling/market_money.svg?style=for-the-badge
[issues-url]: https://github.com/AMSterling/market_money/issues
[license-shield]: https://img.shields.io/github/license/AMSterling/market_money.svg?style=for-the-badge
[license-url]: https://github.com/AMSterling/market_money/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/sterling-316a6223a/

[Atom]: https://img.shields.io/badge/Atom-66595C?style=for-the-badge&logo=Atom&logoColor=white
[Atom-url]: https://github.com/atom/atom/releases/tag/v1.60.0

[Bootstrap]: https://img.shields.io/badge/bootstrap-%23563D7C.svg?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com/

[Capybara]: https://custom-icon-badges.demolab.com/badge/Capybara-F7F4EF?style=for-the-badge&logo=capybara
[Capybara-url]: https://www.patreon.com/capybara

[CodeClimate]: https://a11ybadges.com/badge?style=for-the-badge&logo=codeclimate
[CodeClimate-url]: https://codeclimate.com

[CircleCI]: https://img.shields.io/badge/circle%20ci-%23161616.svg?style=for-the-badge&logo=circleci&logoColor=white
[CircleCI-url]: https://circleci.com/developer

[CSS]: https://img.shields.io/badge/CSS-239120?&style=for-the-badge&logo=css3&logoColor=white
[CSS-url]: https://en.wikipedia.org/wiki/CSS

[Fly]: https://custom-icon-badges.demolab.com/badge/Fly-DCDCDC?style=for-the-badge&logo=fly-io
[Fly-url]: https://fly.io/

[Git Badge]: https://img.shields.io/badge/GIT-E44C30?style=for-the-badge&logo=git&logoColor=white
[Git-url]: https://git-scm.com/

[GitHub Badge]: https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white
[GitHub-url]: https://github.com/<Username>/

[GitHub Actions]: https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white
[GitHub Actions-url]: https://github.com/features/actions

[GraphQL]: https://img.shields.io/badge/-GraphQL-E10098?style=for-the-badge&logo=graphql&logoColor=white
[GraphQL-url]: https://graphql.org/

[Heroku]: https://img.shields.io/badge/Heroku-430098?style=for-the-badge&logo=heroku&logoColor=white
[Heroku-url]: https://www.heroku.com/

[Homebrew]: https://custom-icon-badges.demolab.com/badge/Homebrew-2e2a24?style=for-the-badge&logo=homebrew_logo
[Homebrew-url]: https://brew.sh/

[HTML5]: https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white
[HTML5-url]: https://en.wikipedia.org/wiki/HTML5

[JavaScript]: https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E
[JavaScript-url]: https://www.javascript.com/

[jQuery]: https://img.shields.io/badge/jquery-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white
[jQuery-url]: https://github.com/rails/jquery-rails

[LinkedIn Badge]: https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white
[LinkedIn-url]: https://www.linkedin.com/in/<Username>/

[MacOS]: https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=macos&logoColor=F0F0F0
[MacOS-url]: https://www.apple.com/macos

[Miro]: https://img.shields.io/badge/Miro-050038?style=for-the-badge&logo=Miro&logoColor=white
[Miro-url]: https://miro.com/

[Postgres]: https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white
[Postgres-url]: https://www.postgresql.org/

[PostgreSQL]: https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white
[PostgreSQL-url]: https://www.postgresql.org/

[Postman]: https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white
[Postman-url]: https://web.postman.co/

[Rails]: https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[Rails-url]: https://rubyonrails.org/

[Redis]: https://img.shields.io/badge/redis-%23DD0031.svg?&style=for-the-badge&logo=redis&logoColor=white
[Redis-url]: https://redis.io/

[Replit]: https://img.shields.io/badge/replit-667881?style=for-the-badge&logo=replit&logoColor=white
[Replit-url]: https://replit.com/

[RSpec]: https://custom-icon-badges.demolab.com/badge/RSpec-fffcf7?style=for-the-badge&logo=rspec
[RSpec-url]: https://rspec.info/

[RuboCop]: https://img.shields.io/badge/RuboCop-000?logo=rubocop&logoColor=fff&style=for-the-badge
[RuboCop-url]: https://docs.rubocop.org/rubocop-rails/index.html

[Ruby]: https://img.shields.io/badge/Ruby-000000?style=for-the-badge&logo=ruby&logoColor=CC342D
[Ruby-url]: https://www.ruby-lang.org/en/

[Slack]: https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white
[Slack-url]: https://slack.com/trials?remote_promo=f4d95f0b&utm_medium=ppc&utm_source=google&utm_campaign=ppc_google_amer_en_brand_selfserve_discount&utm_term=Slack_Exact_._slack_._e_._c&utm_content=611662283461&gclid=Cj0KCQiA54KfBhCKARIsAJzSrdptOf7OUrgfeH0CWCC7LaOjR8arXoBnBMZjUSTJqmzTKvH6Jh-YXzAaAjfWEALw_wcB&gclsrc=aw.ds

[Tailwind]: https://img.shields.io/badge/tailwindcss-%2338B2AC.svg?style=for-the-badge&logo=tailwind-css&logoColor=white
[Tailwind-url]: https://tailwindcss.com/

[Visual Studio Code]: https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white
[Visual Studio Code-url]: https://code.visualstudio.com/

[XCode]: https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white
[XCode-url]: https://developer.apple.com/xcode/

[Zoom]: https://img.shields.io/badge/Zoom-2D8CFF?style=for-the-badge&logo=zoom&logoColor=white
[Zoom-url]: https://zoom.us/

[bcrypt-docs]: https://github.com/bcrypt-ruby/bcrypt-ruby
[capybara-docs]: https://github.com/teamcapybara/capybara
[factory_bot_rails-docs]: https://github.com/thoughtbot/factory_bot_rails
[faker-docs]: https://github.com/faker-ruby/faker
[faraday-docs]: https://lostisland.github.io/faraday/
[figaro-docs]: https://github.com/laserlemon/figaro
[jsonapi-serializer-docs]: https://github.com/jsonapi-serializer/jsonapi-serializer
[launchy-docs]: https://www.rubydoc.info/gems/launchy/2.2.0
[multi_json-docs]: https://github.com/intridea/multi_json
[omniauth-google-oauth2-docs]: https://github.com/zquestz/omniauth-google-oauth2
[orderly-docs]: https://github.com/jmondo/orderly
[pry-docs]: https://github.com/pry/pry
[rspec-rails-docs]: https://github.com/rspec/rspec-rails
[shoulda-matchers-docs]: https://github.com/thoughtbot/shoulda-matchers
[simplecov-docs]: https://github.com/simplecov-ruby/simplecov
[vcr-docs]: https://github.com/vcr/vcr
[webmock-docs]: https://github.com/bblimke/webmock
