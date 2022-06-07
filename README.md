# README

## Home budgte

### Setup
- First install required gems by running below command
``` 
bundle install 
```
- Setup database by running below command
``` 
rails db:setup 
```

### Usage
- Default headers that have to be sent on each request:
```
  Accept: application/json
  Content-Type: application/json
```
- For authentcated requests additional `Authorization` header has to be sent, example:
```
  Authorization: b74dCaZwiEUmV0kE03tvksECtfmDq3xMU856FCAVWRJ5GABWbOSMy5FHw6yy
```
`Authorization` header value is returned on register user and create session requests as `auth_token`.

- Postman collection 
```
  API.postman_collection.json
```