# Simple Messaging API

This is a very simple messaging API.
It enables the building of a very simple messenger application.

Currently, it does not provide the creation of users.

## Operations

It allows these operations centered around `Messages`
- sending a short message between 2 existing users (a sender, and a recipient)
- getting a recipient's most recent messages (in last 30 days, up to 100) from any sender
- getting a recipient's most recent messages (in last 30 days, up to 100) from a particular sender

# Group Messages


## Messages [/messages]


### Send a message [POST /api/v1/messages]
Saves a short text message, from a sender to a recipient.
This message will show up in that recipient's recent messages.

+ Parameters
    + recipient_id: `123` (number, required)
    + sender_id: `456` (number, required)
    + text: `Hello` (text, required)

+ Request returns the message id and timestamp
**POST**&nbsp;&nbsp;`/api/v1/messages?recipient_id=2&sender_id=1&text=Synth retro quinoa viral helvetica master cleanse fap high life.`

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
                "timestamp": "2020-05-15T20:28:40.534Z"
              }
            }

+ Request returns an error, if recipient_id is missing
**POST**&nbsp;&nbsp;`/api/v1/messages?sender_id=1&text=Farm-to-table Portland mustache PBR echo park party.`

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
**POST**&nbsp;&nbsp;`/api/v1/messages?recipient_id=2&text=Austin leggings next level Banksy master cleanse skateboard tattooed.`

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

### Get recent messages [GET /api/v1/messages?recipient_id={recipient_id}]
Provided a recipient's ID, gets messages that were sent to that recipient.

Gets the first 100 most recent messages,
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
                  "text": "Shoreditch Rerry Richardson irony art stumptown Banksy master cleanse.",
                  "timestamp": "2020-05-15T20:28:40.564Z"
                },
                {
                  "sender_id": 3,
                  "recipient_id": 1,
                  "text": "Farm-to-table skateboard art before they sold out helvetica 8-bit.",
                  "timestamp": "2020-05-14T20:28:40.567Z"
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

### Get recent messages (alternative) [GET /api/v1/recipents/{recipient_id}/messages]
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
                  "text": "Squid cred vegan raw denim messenger bag.",
                  "timestamp": "2020-05-15T20:28:40.633Z"
                },
                {
                  "sender_id": 3,
                  "recipient_id": 1,
                  "text": "Sartorial organic mustache craft beer skateboard tofu readymade you probably haven't heard of them cardigan.",
                  "timestamp": "2020-05-14T20:28:40.636Z"
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

### Get recent messages from sender [GET /api/v1/messages?recipient_id={recipient_id}&sender_id={sender_id}]
Provided a recipient's ID and a sender's ID,
gets messages that were sent to that recipient.
by that sender.

Gets the first 100 most recent messages,
no older than 30 days, and ordered most-recent-first.

+ Parameters
    + recipient_id: `123` (number, required)
    + sender_id: `456` (number, required)

+ Request returns empty array of messages if no messages from that sender
**GET**&nbsp;&nbsp;`/api/v1/messages?recipient_id=1&sender_id=3`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "messages": [
            
              ]
            }

+ Request returns all messages from that sender
**GET**&nbsp;&nbsp;`/api/v1/messages?recipient_id=1&sender_id=2`

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
                  "text": "Marfa wolf trust fund cardigan iPhone food truck.",
                  "timestamp": "2020-05-15T20:28:40.679Z"
                }
              ]
            }
