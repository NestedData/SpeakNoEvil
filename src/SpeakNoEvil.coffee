class SpeakNoEvil
  @DEFAULT_BLACKLIST = ["anus","arse","arsehole","ass","ass-hat","ass-pirate","assbag","assbandit","assbanger","assbite","assclown","asscock","asscracker","assface","assfuck","assfucker","assgoblin","asshat","asshead","asshole","asshopper","assjacker","asslick","asslicker","assmonkey","assmunch","assmuncher","assnigger","asspirate","assshit","assshole","asssucker","asswad","asswipe","bampot","bastard","beaner","beastial","beastiality","beastility","bestial","bestiality","bitch","bitchass","bitcher","bitchin","bitching","bitchtit","bitchy","blow job","blowjob","bollocks","bollox","boner","bullshit","butt plug","camel toe","choad","chode","clit","clitface","clitfuck","clusterfuck","cock","cockbite","cockburger","cockface","cockfucker","cockhead","cockmonkey","cocknose","cocknugget","cockshit","cocksuck","cocksucked","cocksucker","cocksucking","cocksucks","coochie","coochy","cooter","cum","cumbubble","cumdumpster","cummer","cumming","cumshot","cumslut","cumtart","cunillingus","cunnie","cunnilingus","cunt","cuntface","cunthole","cuntlick","cuntlicker","cuntlicking","cuntrag","cuntslut","cyberfuc","cyberfuck","cyberfucked","cyberfucker","cyberfucking","dago","damn","deggo","dick","dickbag","dickbeaters","dickface","dickfuck","dickhead","dickhole","dickjuice","dickmilk","dickslap","dickwad","dickweasel","dickweed","dickwod","dildo","dink","dipshit","doochbag","dookie","douche","douche-fag","douchebag","douchewaffle","dumass","dumb ass","dumbass","dumbfuck","dumbshit","dumshit","ejaculate","ejaculated","ejaculates","ejaculating","ejaculation","fag","fagbag","fagfucker","fagging","faggit","faggot","faggotcock","faggs","fagot","fags","fagtard","fart","farted","farting","farty","fatass","felatio","fellatio","feltch","fingerfuck","fingerfucked","fingerfucker","fingerfucking","fingerfucks","fistfuck","fistfucked","fistfucker","fistfucking","flamer","fuck","fuckass","fuckbag","fuckboy","fuckbrain","fuckbutt","fucked","fucker","fuckersucker","fuckface","fuckhead","fuckhole","fuckin","fucking","fuckme","fucknut","fucknutt","fuckoff","fuckstick","fucktard","fuckup","fuckwad","fuckwit","fuckwitt","fudgepacker","fuk","gangbang","gangbanged","goddamn","goddamnit","gooch","gook","gringo","guido","handjob","hardcoresex","heeb","hell","ho","hoe","homo","homodumbshit","honkey","horniest","horny","hotsex","humping","jackass","jap","jigaboo","jism","jiz","jizm","jizz","jungle bunny","junglebunny","kike","kock","kondum","kooch","kootch","kum","kumer","kummer","kumming","kums","kunilingus","kunt","kyke","lezzie","lust","lusting","mcfagget","mick","minge","mothafuck","mothafucka","mothafuckaz","mothafucked","mothafucker","mothafuckin","mothafucking","mothafucks","motherfuck","motherfucked","motherfucker","motherfuckin","motherfucking","muff","muffdiver","munging","negro","nigga","nigger","niglet","nut sack","nutsack","orgasim","orgasm","paki","panooch","pecker","peckerhead","penis","penisfucker","penispuffer","phonesex","phuk","phuked","phuking","phukked","phukking","phuks","phuq","pis","pises","pisin","pising","pisof","piss","pissed","pisser","pisses","pissflaps","pissin","pissing","pissoff","polesmoker","pollock","poon","poonani","poonany","poontang","porch monkey","porchmonkey","porn","porno","pornography","pornos","prick","punanny","punta","pusies","pussies","pussy","pussylicking","pusy","puto","renob","rimjob","ruski","sandnigger","schlong","scrote","shit","shitass","shitbag","shitbagger","shitbrain","shitbreath","shitcunt","shitdick","shited","shitface","shitfaced","shitfull","shithead","shithole","shithouse","shiting","shitspitter","shitstain","shitted","shitter","shittiest","shitting","shitty","shity","shiz","shiznit","skank","skeet","skullfuck","slut","slutbag","sluts","smeg","smut","snatch","spic","spick","splooge","spunk","tard","testicle","thundercunt","tit","titfuck","tittyfuck","twat","twatlips","twatwaffle","unclefucker","va-j-j","vag","vagina","vjayjay","wank","wetback","whore","whorebag","whoreface"]

  constructor: (blacklist) ->
    if blacklist 
      @setBlacklist(blacklist)
      # console.log "Set supplied blacklist."
    else
      # console.log "Invalid blacklist specified. Setting the default."
      @resetBlacklist()

  # replace accents with their counterparts
  _replaceAccents: (text) ->
    from = "àáäâèéëêìíïîòóöôùúüûñç·"
    to = "aaaaeeeeiiiioooouuuunc-"
    i = 0
    l = from.length

    while i < l
        text = text.replace(new RegExp(from.charAt(i), "g"), to.charAt(i))
        i++
    text

  # Replace punctuation with spaces. Reduces multiple
  # punctuation to a single space.
  _replacePunctuation: (text) ->
    regex = /[\.,-\/#!$%\^&\*;:{}=\-_`~()<>\[\]\?@\+]/g
    text.replace regex, " "

  cleanText: (text) ->
    text = @_replacePunctuation(@_replaceAccents(text))

  # returns true if the text is profane
  check: (text, aggressive=false) ->
    # NOTE: this algorithm wastes a bunch of time. sorting the blacklist by common use would help
    #       but the correct solution is a better algorithm. We'd much rather check for the existance
    #       of each ngram in the text within the black list.
    text = @cleanText(text)

    # lowercase the string
    text = text.toLowerCase()
    # console.log text
    # search the string for all phrases from the blacklist
    # short circuits if a match is found
    result = @blacklist.some (black_phrase) =>
      black_phrase = @cleanText(black_phrase).trim()
      if aggressive # (dickerson is profane)
        regex = new RegExp("#{black_phrase}", "g")
      else # (dickerson is not profane)
        regex = new RegExp("\\b#{black_phrase}\\b", "g")
      search_result = text.search(regex) > -1
      return search_result

    return result

  # return null if the blacklist is invalid, otherwise returns the new blacklist
  setBlacklist: (blacklist) ->
    unless @validBlackList(blacklist)
      throw new Err("Invalid blacklist provided")

    # lowercase the profanity list
    @blacklist = blacklist.map (word) ->
      word.toLowerCase()

  resetBlacklist: ->
    @blacklist = @constructor.DEFAULT_BLACKLIST

  # return true if the blacklist passes validation
  validBlackList: (blacklist) ->
    return Array.isArray(blacklist)

module.exports = SpeakNoEvil
