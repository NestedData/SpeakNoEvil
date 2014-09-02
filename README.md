[ ![Codeship Status for NestedData/SpeakNoEvil](https://www.codeship.io/projects/04ee87d0-14be-0132-d27b-7e5e22028118/status)](https://www.codeship.io/projects/33508)

## Methodology:

Searches a string for a substring match of each word/phrase in the blacklist

## Usage:

```coffee
# create a filter with the default list
Filter = new SpeakNoEvil()

# create a filter with a custom list
Filter = new SpeakNoEvil(["a", "b", "c"])

# check a string for profanity
result = Filter.check("a possibly profane string")
if result
  console.log "string was profane"
```

## Running tests
```
npm install -g grunt mocha
npm test
```