[ ![Codeship Status for NestedData/SpeakNoEvil](https://www.codeship.io/projects/04ee87d0-14be-0132-d27b-7e5e22028118/status)](https://www.codeship.io/projects/33508)

## Methodology:

Searches a string for a substring match of each phrase in the blacklist

## USAGE:

```coffee
MSUProfanityFilter = new SpeakNoEvil(["a", "b", "c"])
result = MSUProfanityFilter.check("a possibly profane string")
if result
  console.log "string was profane"
```