From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 21:35:01 +0200
Subject: [LTP] [PATCH v4 1/1] docparse: Handle special characters in JSON
In-Reply-To: <YJQAukLCEqSX1X/9@yuki>
References: <20210506132745.16973-1-pvorel@suse.cz>
 <YJQAukLCEqSX1X/9@yuki>
Message-ID: <YJRE5TQQfezcPeKr@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Looking at your code, I'm not sure if it's needed.

> > +static inline void data_fprintf_esc(FILE *f, unsigned int padd, const char *str)
> > +{
> > +	while (padd-- > 0)
> > +		fputc(' ', f);
> > +
> > +	fputc('"', f);

> 	int was_backslash = 0;

> > +	while (*str) {
> > +		switch (*str) {
> > +		case '\\':
> > +		break;
> > +		case '"':
> > +			fputs("\\\"", f);
> 			was_backslash = 0;
> > +			break;
> > +		case '\t':
> > +			fputs("        ", f);
> > +			break;
> > +		default:
> > +			/* RFC 8259 specify  chars before 0x20 as invalid */
> > +			if (*str >= 0x20)
> > +				putc(*str, f);
> > +			else
> > +				fprintf(stderr, "%s:%d %s(): invalid character for JSON: %x\n",
> > +						__FILE__, __LINE__, __func__, *str);
> > +			break;
> > +		}

> 		if (was_backslash)
> 			fputs("\\\\", f);

> 		was_backslash = (*str == '\\');
> > +		str++;
> > +	}
> > +
> > +	fputc('"', f);
> > +}

> This should avoid "unescaping" an escaped double quote. We deffer
> printing the backslash until we know the character after it and we make
> sure that we do not excape backslash before ".

> Consider what would happen if someone did put a "\"text\"" into options
> strings, the original code would escape the backslashes and we would end
> up with "\\"text"\\" which would break parser again.

> This way we can at least avoid parsing errors until we fix the problem
> one level down in the parser where we have the context required for a
> proper fix.

It looks to me it it works exactly the same with and w/a was_backslash.

Trying to escape \" will results in first escape \ (=> \\), then " (=> \")

Example C code:

/*\
 * [Description]
 * "expected" \\ behaviour "\"text\""
 */

static struct tst_test test = {
	.options = (struct tst_option[]) {
		{"a:", &can_dev_name, "\"text \\ \""},
		{}
	},
};

results from both original code and your with was_backslash are valid JSON,
but was_backslash add extra backslashes.

result from original code:

  "testfile": {
   "options": [
     [
      "a:",
      "can_dev_name",
      "\\\"text \\\\ \\\""
     ]
    ],
   "doc": [
     "[Description]",
     "\"expected\" \\\\ behaviour \"\\\"text\\\"\""
    ],
   "fname": "testfile.c"
  }

result from was_backslash:
  "testfile": {
   "options": [
     [
      "a:",
      "can_dev_name",
      "\\\"text \\\\\\ \\\\\""
     ]
    ],
   "doc": [
     "[Description]",
     "\"expected\" \\\\\\ \\behaviour \"\\\"text\\\"\""
    ],
   "fname": "testfile.c"
  }

What am I missing?

Kind regards,
Petr
