From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 4 May 2021 16:44:59 +0200
Subject: [LTP] [PATCH v3 1/1] docparse: Escape backslash,
 tab and double quote in JSON
In-Reply-To: <YJFH4vLeaXnc8mzN@yuki>
References: <20210504125729.18781-1-pvorel@suse.cz>
 <YJFH4vLeaXnc8mzN@yuki>
Message-ID: <YJFd6x+P7lFhLfXm@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > +static inline void data_fprintf_esc(FILE *f, unsigned int padd, const char *str)
> > +{
> > +	while (padd-- > 0)
> > +		fputc(' ', f);
> > +
> > +	fputc('"', f);
> > +
> > +	while (*str) {
> > +		switch (*str) {
> > +		case '\\':
> > +			fputs("\\\\", f);
> > +			break;
> > +		case '"':
> > +			fputs("\\\"", f);
> > +			break;
> > +		case '\t':
> > +			fputs("\\t", f);
> > +			break;
> > +		default:
> > +			putc(*str, f);
> > +			break;
> > +		}
> > +		str++;
> > +	}
> > +
> > +	fputc('"', f);
> > +}

> Also does this even escape newlines? If you write "\n" in C it's stored
> in memory as [0x0a, 0x00], no actual \ are stored in the string. What
> the '\\' case does it to escape literal backslash i.e. "\\" which is
> stored as [0x5c, 0x00].
Well, due first handling '\\' any text written as \n will be kept as \n
(obviously anything starting with \ will be handled the same, e.g. \t, \r, \b, \f).
We'd like to interpret \n at least for .options (unless we transform them
to array of arrays as you suggested). But I'm not sure if we want to do
everywhere, e.g. in doc there might be \n which we want to keep, thus I'd prefer
to interpret only tabs ('\t' => "\\t") and the rest escape via escaping '\\'
(already in the patch).

I don't think there is real new line character in our JSON (unlike tab, which
was put there into CAN tests and needed to be reverted). If yes, I think we'd
prefer to interpret it instead escaping it (as well as form feed and carriage return).
Unless any of these is ascii before 0x20 (which will be handled by last change
you're suggested.

> Looking at JSON specification anything that is
> in ascii before 0x20 (space) is invalid character in a JSON string. I
> guess that the safest to write strings would be:
Very good point.

> 	...
> 	default:
> 		if (*str >= 20)
> 			putc(*str, f);
> 	}
Thus this should be the only change.

> And we would have to add escape at least for '\n' the same way we have
> for '\t' in the switch.
And I'd avoid this due previous explanation.

I can merge this under your name with my Reviewed-by: tag.
Or feel free to commit these changes yourself.

Kind regards,
Petr
