From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 22 Oct 2020 09:09:40 +0100
Subject: [LTP] [PATCH 1/3] lib/tst_kconfig: Rewrite the parser internals
In-Reply-To: <20201021141157.GC10861@yuki.lan>
References: <20201020100910.10828-1-chrubis@suse.cz>
 <20201020100910.10828-2-chrubis@suse.cz> <878sbzx66b.fsf@suse.de>
 <20201021100605.GA10861@yuki.lan> <874kmnwy6g.fsf@suse.de>
 <20201021141157.GC10861@yuki.lan>
Message-ID: <87mu0evfzv.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> >> lines first to remove whitespace issues and expose the parser to all
>> >> possible variable name symbols and values instead of just the ones which
>> >> appear in our current tests.
>> >
>> > I guess that it's techincally possible to have a whitespaces there, but
>> > will not happen unless you hand-edit the config file before compilation,
>> > which I doubt will ever happen.
>> >
>> 
>> It can also happen if someone has their own script to modify the
>> config. At any rate, if you are confident that it will never happen then
>> there should be no problem failing hard if it does.
>
> It would be probably easier to eat the whitespace around the = if
> present. But still I would ignore anything that isn't correct variable
> assignment, since such config would fail kernel compilation anyways.

Works for me :-)

>
>> >> > +			switch (val[0]) {
>> >> > +			case '=':
>> >> > +				break;
>> >> > +			case ' ':
>> >> > +				if (is_set(val, "is not set")) {
>> >> > +					vars[i].choice = 'n';
>> >> > +					return 1;
>> >> > +				}
>> >> 
>> >> Typically such lines begin with a comment '#' and I don't see where that
>> >> is handled. Possibly this will only match non standard configs?
>> >
>> > It does work actually, since we use strstr() to get the "CONFIG_" prefix
>> > from each line of the configuration, but I guess this needs to be fixed
>> > anyways since we would detect "# CONFIG_FOO=y" as enabled config feature
>> > even if it's commented. Again this will not happen unless you hand-edit
>> > the file, but it's probably worth fixing in a follow up patch.
>> 
>> We don't actually use the result of strstr anymore?
>
> Ah right, that's a bug, the cfg should be passed to the
> kconfig_parse_line() instead, at least that's how the previous version
> worked in order to differentiate between unset and unknown variables.
>
>> >> > +				return 1;
>> >> > +			/* vars[i].id may be prefix to longer config var */
>> >> > +			default:
>> >> > +				return 0;
>> >> > +			}
>> >> >  
>> >> > -	if (!cfg)
>> >> > -		return 0;
>> >> > +			if (is_set(val, "=y")) {
>> >> > +				vars[i].choice = 'y';
>> >> > +				return 1;
>> >> > +			}
>> >> >  
>> >> > -	if (strncmp(cfg, conf, match->len))
>> >> > -		return 0;
>> >> > +			if (is_set(val, "=m")) {
>> >> > +				vars[i].choice = 'm';
>> >> > +				return 1;
>> >> > +			}
>> >> >  
>> >> > -	const char *val = &cfg[match->len];
>> >> > +			vars[i].choice = 'v';
>> >> > +			vars[i].val = strndup(val+1, strlen(val)-2);
>> >> >  
>> >> > -	switch (cfg[match->len]) {
>> >> > -	case '=':
>> >> > -		break;
>> >> > -	case ' ':
>> >> > -		if (is_set(val, "is not set")) {
>> >> > -			result->match = 'n';
>> >> > -			goto match;
>> >> > +			return 1;
>> >> >  		}
>> >> > -	/* fall through */
>> >> > -	default:
>> >> > -		return 0;
>> >> > -	}
>> >> > -
>> >> > -	if (is_set(val, "=y")) {
>> >> > -		result->match = 'y';
>> >> > -		goto match;
>> >> >  	}
>> >> >  
>> >> > -	if (is_set(val, "=m")) {
>> >> > -		result->match = 'm';
>> >> > -		goto match;
>> >> > -	}
>> >> > -
>> >> > -	result->match = 'v';
>> >> > -	result->value = strndup(val+1, strlen(val)-2);
>> >> > -
>> >> > -match:
>> >> > -	match->match = 1;
>> >> > -	return 1;
>> >> > +	return 0;
>> >> >  }
>> >> >  
>> >> > -void tst_kconfig_read(const char *const *kconfigs,
>> >> > -                      struct tst_kconfig_res results[], size_t cnt)
>> >> > +void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len)
>> >> >  {
>> >> > -	struct match matches[cnt];
>> >> > -	FILE *fp;
>> >> > -	unsigned int i, j;
>> >> > -	char buf[1024];
>> >> > -
>> >> > -	for (i = 0; i < cnt; i++) {
>> >> > -		const char *val = strchr(kconfigs[i], '=');
>> >> > -
>> >> > -		if (strncmp("CONFIG_", kconfigs[i], 7))
>> >> > -			tst_brk(TBROK, "Invalid config string '%s'", kconfigs[i]);
>> >> > +	char line[128];
>> >> > +	unsigned int vars_found = 0;
>> >> >  
>> >> > -		matches[i].match = 0;
>> >> > -		matches[i].len = strlen(kconfigs[i]);
>> >> > -
>> >> > -		if (val) {
>> >> > -			matches[i].val = val + 1;
>> >> > -			matches[i].len -= strlen(val);
>> >> > -		}
>> >> > -
>> >> > -		results[i].match = 0;
>> >> > -		results[i].value = NULL;
>> >> > -	}
>> >> > -
>> >> > -	fp = open_kconfig();
>> >> > +	FILE *fp = open_kconfig();
>> >> >  	if (!fp)
>> >> >  		tst_brk(TBROK, "Cannot parse kernel .config");
>> >> >  
>> >> > -	while (fgets(buf, sizeof(buf), fp)) {
>> >> > -		for (i = 0; i < cnt; i++) {
>> >> > -			if (match(&matches[i], kconfigs[i], &results[i], buf)) {
>> >> > -				for (j = 0; j < cnt; j++) {
>> >> > -					if (matches[j].match)
>> >> > -						break;
>> >> > -				}
>> >> > +	while (fgets(line, sizeof(line), fp)) {
>> >> > +		char *cfg = strstr(line, "CONFIG_");
>> >> >  
>> >> > -				if (j == cnt)
>> >> > -					goto exit;
>> >> > -			}
>> >> > -		}
>> >> > +		if (!cfg)
>> >> > +			continue;
>> >> 
>> >> This filtering seems unecessary and maybe will hide some corner cases
>> >> because it reduces kconfig_parses_line's exposure. Also practically
>> >> every line has 'CONFIG_' in it.
>> >
>> > Not really, there are empty lines and plenty of comments in the file
>> > generated by kernel infrastructure.
>> 
>> It seems about 80-90% of lines contain CONFIG_, however if you pass it
>> to kconfig_parse_line then this makes more sense. Still I think with
>> proper parsing this shouldn't be there.
>
> What exactly do you mean by a proper parsing?

Tokenize it and remove whitespace.

>
> The file is format is very simple each line starts either with # which
> is a comment or consists of 'key=val' pair and the key is by definition
> prefixed with CONFIG_.
>
>> >> > +
>> >> > +		if (kconfig_parse_line(line, vars, vars_len))
>> >> > +			vars_found++;
>> >> >  
>> >> > +		if (vars_found == vars_len)
>> >> > +			goto exit;
>> >> >  	}
>> >> 
>> >> Generally, this approach seems like to result in spurious TCONFs. We
>> >> need to properly parse the file and fail if some line can't be
>> >> interpreted.
>> >
>> > Well we do expect well formatted .config file from a start, if you hand
>> > edit it and put whitespaces into unexpected places more things may
>> > fail.
>> 
>> Kernel build system seems to have no problem with it. More generally
>> though we should fail hard if there is something unexpected, not produce
>> TCONF which people don't check.
>
> Even if we do I do not think that we should care about anything but
> syntactically correct input, since if you modify the file after kernel
> compilation you have lost anyways.
>
>> >> I suppose most of the problems here stem from the original code, but
>> >> your patch may as well clear it up :-)
>> >
>> > Actually the clear way how to fix this is in a separate patch so that
>> > logical changes are split into different patches.
>> 
>> I suppose that elements of the boolean parser can be used to parse the
>> kconfig and it can be combined (in a later patch). It's kind of
>> unecessary to parse a config file into RPN, but will work perfectly well
>> so we can share some code here.
>
> I do not get what you are trying to say. Are you saying that we should
> tokenize the input? I do not think that this is necessary since the file
> format is pretty simple.

Yes or atleast test the assumption you won't find configs with spaces or
other wierd stuff in by throwing an error if we find something
unexpected. If someone has a broken config we can tell them that.

-- 
Thank you,
Richard.
