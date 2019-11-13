# README

This application runs on Rails 6.0 using React and Webpacker.
To install run
```
bundle install
```

```
rails s
```

and separately to reload the views and ease development

```
./bin/webpack-dev-server
```

### API

The API allows to us to record events and returns statistics for them and can be reached at the following
```
GET  /api/events/
GET  /api/events/statistics/
POST /api/events/
``` 

Example requests and responses
```
$ curl -X "GET" -H "X-API-Key: EXAMPLE_KEY" -H "Content-Type: application/json" -d '{"category":"os_version"}' "127.0.0.1:3000/api/events"
{"status":"success","total":9324,"page":1,"results":[{"id":1,"category":"os_version","value":"4.93","machine_id":"ba355227-ee0d-4363-bf8e-fd251833d690","created_at":"2019-10-04T14:17:01.000Z","updated_at":"2019-10-14T02:49:23.249Z"}]}

$ curl -X "GET" -H "X-API-Key: EXAMPLE_KEY" -H "Content-Type: application/json" -d '{"category":"os_version"}' "127.0.0.1:3000/api/events/statistics"
{"status":"success","results":[{"name":"7.0.9","value":1}]}

$ curl -X "POST" -H "X-API-Key: EXAMPLE_KEY" -H "Content-Type: application/json" -d '{"category":"os_version"}' "127.0.0.1:3000/api/events"
{"status":"error","errors":["Machine can't be blank"]}
```
