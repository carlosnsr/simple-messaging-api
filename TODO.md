# TODO

Viewpoint: the client app is always operating from the sender's point of view (a.k.a. me)
"Me" is always the sender
All of the operations are from the sender's point of view

1. can send short message from one user (sender) to another (recipient)
  POST /message (re-route to /me/{sender_id}/messages/to/{recipient_id}???)
    {
      message {
        sender,
        to,
        text
      }
    }
  REPLY: :created
    {
      message {
        id
        timestamp
      }
      my_recent_uri: /to/{sender_id}/messages/from/{recipient_id}?timestamp={timestamp}
   }
  REPLY: :error(sender doesn't exist|recipient doesn't exist|content is too large)


  POST /me/{sender_id}/messages/to/{recipient_id} (reroute to /message ???)
    {
      content
    }
  REPLY: :created
    {
      message_id
      timestamp
      recipient_name
      my_recent_uri: /to/{sender_id}/messages/from/{recipient_id}?timestamp={timestamp}
    }
2. recent messages requested for a recipient, from a sender
  GET /to/{recipient_id}/messages/from/{sender_id}?timestamp={timestamp}
  REPLY: :ok
    {
      sender_name,
      reply_to_uri,
      my_recent_uri: /to/{recipient_id}/messages/from/{sender_id}?timestamp={timestamp}
      messages [
        {
          content,
          timestamp
        },
        ...
      ]
    }
3. all recent messages to recipient, from all senders
  GET /to/{recipient_id}/messages?timestamp={timestamp}
  REPLY: :ok
    [
      timestamp,
      all_my_recent_uri: /to/{recipient_id}/messages?timestamp={timestamp}
      {
        sender_name,
        reply_to_uri,
        my_recent_uri: /to/{recipient_id}/messages/from/{sender_id}?timestamp={timestamp}
        messages [
          {
            content,
            timestamp
          },
          ...
        ]
      }
    ]
4. all recent messages (any recipient) from all senders
  WAT!  So insecure, so much data leakage
1-3: Test throughout
5. Document

Entities
  message
    belongs_to 1 sender
    belongs_to 1 recipient
    content
    timestamp
  user
    has many messages
    name
