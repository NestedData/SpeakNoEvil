assert = require("chai").assert

SNE = require '../lib/SpeakNoEvil'

describe 'SpeakNoEvil', ->
  beforeEach (done) ->
    @filter = new SNE()
    @valid_blacklist = ["a", "b", "c"]
    @invalid_blacklist = {}
    done()

  
  describe 'constructor', ->
    it 'should set the default list if no blacklist is provided', ->
      @filter.setBlacklist()
      assert.equal SNE.DEFAULT_BLACKLIST.length, @filter.blacklist.length

    it 'should set the default list if an invalid blacklist is provided', ->
      @filter.setBlacklist(@invalid_blacklist)
      assert.equal SNE.DEFAULT_BLACKLIST.length, @filter.blacklist.length

    it 'should set the specified blacklist if it is valid', ->
      @filter.setBlacklist @valid_blacklist
      assert.equal @valid_blacklist.length, @filter.blacklist.length

    it 'should reset to the default blacklist', ->
      @filter.resetBlacklist()
      assert.equal SNE.DEFAULT_BLACKLIST.length, @filter.blacklist.length


  describe '_replacePunctation', ->
    it 'should replace ".,/?-_=+" with "        "', ->
      text = ".,/?-_=+"
      goal_text = "        "
      new_text = @filter._replacePunctuation(text)
      assert.equal new_text, goal_text

    it 'should replace "[]{}()" with "      "', ->
      text = "[]{}()"
      goal_text = "      "
      new_text = @filter._replacePunctuation(text)
      assert.equal new_text, goal_text

    it 'should replace "!@#$%^&*" with "        "', ->
      text = "!@#$%^&*"
      goal_text = "        "
      new_text = @filter._replacePunctuation(text)
      assert.equal new_text, goal_text


  describe "_replaceAccents", ->
    it 'should replace àáäâèéëêìíïîòóöôùúüûñç·', ->
      bad_chars = /àáäâèéëêìíïîòóöôùúüûñç·/

      clean_text = @filter._replaceAccents "àáäâèéëêìíïîòóöôùúüûñç·"
      assert.equal clean_text, "aaaaeeeeiiiioooouuuunc-"


  describe 'check', ->
    it 'should match a single profane word', ->
      text = "ass"
      res = @filter.check text
      assert.isTrue res

    it 'should match a single profane word in the middle of a string', ->
      text = "foo ass foo"
      res = @filter.check text
      assert.isTrue res

    it 'should match a single profane word regardless of case', ->
      text = "ASs"
      res = @filter.check text
      assert.isTrue res

    it 'should match a single custom profane hashtag at the beginning of a string', ->
      text = "#alpha beta"
      @filter.setBlacklist ["#alpha"]
      # console.log @filter.blacklist
      res = @filter.check text
      @filter.resetBlacklist()
      assert.isTrue res

    it 'should match a single custom profane hashtag in the middle of a string', ->
      text = "gamma #alpha beta"
      @filter.setBlacklist ["#alpha"]
      res = @filter.check text
      @filter.resetBlacklist()
      assert.isTrue res

    it 'should match a single custom profane hashtag at the end of a string', ->
      text = "gamma #alpha beta"
      @filter.setBlacklist ["#alpha"]
      res = @filter.check text
      @filter.resetBlacklist()
      assert.isTrue res

    it 'should match a single custom profane hashtag with special characters', ->
      text = "#A&M beta"
      @filter.setBlacklist ["#A&M"]
      # console.log @filter.blacklist
      res = @filter.check text
      @filter.resetBlacklist()
      assert.isTrue res

    it 'should not match a single clean word', ->
      text = "Rabbit"
      res = @filter.check text
      assert.isFalse res

    it 'should match a profane phrase', ->
      blacklist = ["ole miss"]
      text = "ole miss"
      @filter.setBlacklist(blacklist)
      res = @filter.check text
      assert.isTrue res
      @filter.resetBlacklist()

    it 'should not match a clean phrase', ->
      blacklist = ["ole miss"]
      text = "old george"
      @filter.setBlacklist(blacklist)
      res = @filter.check text
      assert.isFalse res
      @filter.resetBlacklist()

    it 'should match a profane phrase with punctuation', ->
      blacklist = ["ole miss"]
      text = "ole miss!"
      @filter.setBlacklist(blacklist)
      res = @filter.check text
      assert.isTrue res
      @filter.resetBlacklist()

    it 'should match a profane word in a sentence', ->
      text = "That ass cut me off!"
      res = @filter.check text
      assert.isTrue res

    it 'should match a profane phrase in a sentence', ->
      blacklist = ["ole miss"]
      text = "We'd better beat ole miss!"
      @filter.setBlacklist(blacklist)
      res = @filter.check text
      assert.isTrue res
      @filter.resetBlacklist()

    it 'should not match a profane word that appears as part of another word', ->
      text = "dickerson"
      res  = @filter.check text
      assert.isFalse res
