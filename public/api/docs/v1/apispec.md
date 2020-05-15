# Simple Messaging API

This is a very simple messaging API.
It enables the building of a very simple messenger application.

## Operations

It allows these operations centered around `Messages`
- sending a short message between 2 existing users
- getting the most recent (in last 30 days, up to 100)messages sent to a user (a.k.a. `recipient`)

# Group Messages


## Messages [/messages]


### Post a message, from a sender to a recipient [POST /api/v1/messages]

+ Parameters
    + recipient_id: `123` (number, required)
    + sender_id: `456` (number, required)
    + text: `Hello` (text, required)

+ Request returns the message id and timestamp
**POST**&nbsp;&nbsp;`/api/v1/messages?recipient_id=2&sender_id=1&text=Mcsweeney's Wayfarers sustainable trust fund whatever vegan salvia iPhone.`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "message": {
                "id": 1,
                "timestamp": "2020-05-15T18:42:28.756Z"
              }
            }

+ Request returns an error, if recipient_id is missing
**POST**&nbsp;&nbsp;`/api/v1/messages?sender_id=1&text=Whatever twee Rerry Richardson salvia you probably haven't heard of them.`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "error": "param is missing or the value is empty: recipient_id"
            }

+ Request returns an error, if sender_id is missing
**POST**&nbsp;&nbsp;`/api/v1/messages?recipient_id=2&text=Dreamcatcher biodiesel brunch vinyl fap trust fund bicycle rights vice.`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "error": "param is missing or the value is empty: sender_id"
            }

+ Request returns an error, if text is missing
**POST**&nbsp;&nbsp;`/api/v1/messages?recipient_id=2&sender_id=1`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "error": "param is missing or the value is empty: text"
            }

### Get recipient's recent messages [GET /api/v1/messages?recipient_id={recipient_id}]
Provided a recipient's ID, gets messages that were sent to that recipient.

Gets the first 100 of the recipient's most recent messages,
no older than 30 days, and ordered most-recent-first.

+ Parameters
    + recipient_id: `123` (number, required)

+ Request returns the message
**GET**&nbsp;&nbsp;`/api/v1/messages?recipient_id=1`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "messages": [
                {
                  "sender_id": 2,
                  "recipient_id": 1,
                  "text": "Diy Austin Carles blog Marfa viral brunch.",
                  "timestamp": "2020-05-15T18:42:28.786Z"
                },
                {
                  "sender_id": 3,
                  "recipient_id": 1,
                  "text": "Organic Wes Anderson fanny pack Carles tumblr.",
                  "timestamp": "2020-05-14T18:42:28.788Z"
                }
              ]
            }

+ Request returns an error if the recipient does not exist
**GET**&nbsp;&nbsp;`/api/v1/messages?recipient_id=1234`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "error": "recipient 1234 does not exist"
            }

### Get recipient's recent messages (alternative) [GET /api/v1/recipents/{recipient_id}/messages]
An alternative way to get a recipient's messages.
Same behavior and results as `/api/v1/messages?recipient_id={recipient_id}`.

+ Parameters
    + recipient_id: `123` (number, required)

+ Request returns the message
**GET**&nbsp;&nbsp;`/api/v1/recipients/1/messages`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "messages": [
                {
                  "sender_id": 2,
                  "recipient_id": 1,
                  "text": "Synth keffiyeh gluten-free echo park twee mustache letterpress jean shorts master cleanse.",
                  "timestamp": "2020-05-15T18:42:28.807Z"
                },
                {
                  "sender_id": 3,
                  "recipient_id": 1,
                  "text": "Scenester photo booth sartorial next level cred.",
                  "timestamp": "2020-05-14T18:42:28.809Z"
                }
              ]
            }

+ Request returns an error if the recipient does not exist
**GET**&nbsp;&nbsp;`/api/v1/recipients/1234/messages`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "error": "recipient 1234 does not exist"
            }
