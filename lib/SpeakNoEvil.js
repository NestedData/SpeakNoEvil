(function() {
  var SpeakNoEvil;

  SpeakNoEvil = (function() {
    SpeakNoEvil.DEFAULT_BLACKLIST = ["anus", "arse", "arsehole", "ass", "ass-hat", "ass-pirate", "assbag", "assbandit", "assbanger", "assbite", "assclown", "asscock", "asscracker", "assface", "assfuck", "assfucker", "assgoblin", "asshat", "asshead", "asshole", "asshopper", "assjacker", "asslick", "asslicker", "assmonkey", "assmunch", "assmuncher", "assnigger", "asspirate", "assshit", "assshole", "asssucker", "asswad", "asswipe", "bampot", "bastard", "beaner", "beastial", "beastiality", "beastility", "bestial", "bestiality", "bitch", "bitchass", "bitcher", "bitchin", "bitching", "bitchtit", "bitchy", "blow job", "blowjob", "bollocks", "bollox", "boner", "bullshit", "butt plug", "camel toe", "choad", "chode", "clit", "clitface", "clitfuck", "clusterfuck", "cock", "cockbite", "cockburger", "cockface", "cockfucker", "cockhead", "cockmonkey", "cocknose", "cocknugget", "cockshit", "cocksuck", "cocksucked", "cocksucker", "cocksucking", "cocksucks", "coochie", "coochy", "cooter", "cum", "cumbubble", "cumdumpster", "cummer", "cumming", "cumshot", "cumslut", "cumtart", "cunillingus", "cunnie", "cunnilingus", "cunt", "cuntface", "cunthole", "cuntlick", "cuntlicker", "cuntlicking", "cuntrag", "cuntslut", "cyberfuc", "cyberfuck", "cyberfucked", "cyberfucker", "cyberfucking", "dago", "damn", "deggo", "dick", "dickbag", "dickbeaters", "dickface", "dickfuck", "dickhead", "dickhole", "dickjuice", "dickmilk", "dickslap", "dickwad", "dickweasel", "dickweed", "dickwod", "dildo", "dink", "dipshit", "doochbag", "dookie", "douche", "douche-fag", "douchebag", "douchewaffle", "dumass", "dumb ass", "dumbass", "dumbfuck", "dumbshit", "dumshit", "ejaculate", "ejaculated", "ejaculates", "ejaculating", "ejaculation", "fag", "fagbag", "fagfucker", "fagging", "faggit", "faggot", "faggotcock", "faggs", "fagot", "fags", "fagtard", "fart", "farted", "farting", "farty", "fatass", "felatio", "fellatio", "feltch", "fingerfuck", "fingerfucked", "fingerfucker", "fingerfucking", "fingerfucks", "fistfuck", "fistfucked", "fistfucker", "fistfucking", "flamer", "fuck", "fuckass", "fuckbag", "fuckboy", "fuckbrain", "fuckbutt", "fucked", "fucker", "fuckersucker", "fuckface", "fuckhead", "fuckhole", "fuckin", "fucking", "fuckme", "fucknut", "fucknutt", "fuckoff", "fuckstick", "fucktard", "fuckup", "fuckwad", "fuckwit", "fuckwitt", "fudgepacker", "fuk", "gangbang", "gangbanged", "goddamn", "goddamnit", "gooch", "gook", "gringo", "guido", "handjob", "hardcoresex", "heeb", "hell", "ho", "hoe", "homo", "homodumbshit", "honkey", "horniest", "horny", "hotsex", "humping", "jackass", "jap", "jigaboo", "jism", "jiz", "jizm", "jizz", "jungle bunny", "junglebunny", "kike", "kock", "kondum", "kooch", "kootch", "kum", "kumer", "kummer", "kumming", "kums", "kunilingus", "kunt", "kyke", "lezzie", "lust", "lusting", "mcfagget", "mick", "minge", "mothafuck", "mothafucka", "mothafuckaz", "mothafucked", "mothafucker", "mothafuckin", "mothafucking", "mothafucks", "motherfuck", "motherfucked", "motherfucker", "motherfuckin", "motherfucking", "muff", "muffdiver", "munging", "negro", "nigga", "nigger", "niglet", "nut sack", "nutsack", "orgasim", "orgasm", "paki", "panooch", "pecker", "peckerhead", "penis", "penisfucker", "penispuffer", "phonesex", "phuk", "phuked", "phuking", "phukked", "phukking", "phuks", "phuq", "pis", "pises", "pisin", "pising", "pisof", "piss", "pissed", "pisser", "pisses", "pissflaps", "pissin", "pissing", "pissoff", "polesmoker", "pollock", "poon", "poonani", "poonany", "poontang", "porch monkey", "porchmonkey", "porn", "porno", "pornography", "pornos", "prick", "punanny", "punta", "pusies", "pussies", "pussy", "pussylicking", "pusy", "puto", "renob", "rimjob", "ruski", "sandnigger", "schlong", "scrote", "shit", "shitass", "shitbag", "shitbagger", "shitbrain", "shitbreath", "shitcunt", "shitdick", "shited", "shitface", "shitfaced", "shitfull", "shithead", "shithole", "shithouse", "shiting", "shitspitter", "shitstain", "shitted", "shitter", "shittiest", "shitting", "shitty", "shity", "shiz", "shiznit", "skank", "skeet", "skullfuck", "slut", "slutbag", "sluts", "smeg", "smut", "snatch", "spic", "spick", "splooge", "spunk", "tard", "testicle", "thundercunt", "tit", "titfuck", "tittyfuck", "twat", "twatlips", "twatwaffle", "unclefucker", "va-j-j", "vag", "vagina", "vjayjay", "wank", "wetback", "whore", "whorebag", "whoreface"];

    function SpeakNoEvil(blacklist) {
      if (blacklist && this.setBlacklist(blacklist)) {

      } else {
        this.resetBlacklist();
      }
    }

    SpeakNoEvil.prototype._replaceAccents = function(text) {
      var from, i, l, to;
      from = "àáäâèéëêìíïîòóöôùúüûñç·";
      to = "aaaaeeeeiiiioooouuuunc-";
      i = 0;
      l = from.length;
      while (i < l) {
        text = text.replace(new RegExp(from.charAt(i), "g"), to.charAt(i));
        i++;
      }
      return text;
    };

    SpeakNoEvil.prototype._replacePunctuation = function(text) {
      var regex;
      regex = /[\.,-\/#!$%\^&\*;:{}=\-_`~()<>\[\]\?@\+]/g;
      return text.replace(regex, " ");
    };

    SpeakNoEvil.prototype.cleanText = function(text) {
      return text = this._replacePunctuation(this._replaceAccents(text));
    };

    SpeakNoEvil.prototype.check = function(text) {
      var result;
      text = this.cleanText(text);
      text = text.toLowerCase();
      result = this.blacklist.some((function(_this) {
        return function(black_phrase) {
          var regex, search_result;
          black_phrase = _this.cleanText(black_phrase).trim();
          regex = new RegExp("\\b" + black_phrase + "\\b", "g");
          search_result = text.search(regex) > -1;
          return search_result;
        };
      })(this));
      return result;
    };

    SpeakNoEvil.prototype.setBlacklist = function(blacklist) {
      if (!this.validBlackList(blacklist)) {
        return null;
      }
      return this.blacklist = blacklist.map(function(word) {
        return word.toLowerCase();
      });
    };

    SpeakNoEvil.prototype.resetBlacklist = function() {
      return this.blacklist = this.constructor.DEFAULT_BLACKLIST;
    };

    SpeakNoEvil.prototype.validBlackList = function(blacklist) {
      return Array.isArray(blacklist);
    };

    return SpeakNoEvil;

  })();

  module.exports = SpeakNoEvil;

}).call(this);
