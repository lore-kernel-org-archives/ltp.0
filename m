From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 20:21:37 +0200
Subject: [LTP] [PATCH v4 1/1] docparse: Handle special characters in JSON
In-Reply-To: <YJQAukLCEqSX1X/9@yuki>
References: <20210506132745.16973-1-pvorel@suse.cz>
 <YJQAukLCEqSX1X/9@yuki>
Message-ID: <YJQzsUBhaD4wQyrF@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,
> Hi!
> > * escape backslash (/) and double quote (")
>                       ^
> 		      \
+1

> >   escaping backslash effectively escapes other C escaped strings (\t,
> >   \n, ...), which we sometimes want (in the comment) but sometimes not
> >   (in .option we want to have them interpreted)
> > * replace tab with 8x space
> > * skip and TWARN invalid chars (< 0x20, i.e. anything before space)
>              ^
> 	     warn on? We are not actually using TWARN o here right?
Yep, I didn't update commit message (first I included tst_test.h with
TST_NO_DEFAULT_MAIN but there was missing include path => stderr is enough).

> >   defined by RFC 8259 (https://tools.ietf.org/html/rfc8259#page-9)

> > NOTE: atm fix is required only for ", but tab was problematic in the past.

> > TODO: This is just a "hot fix" solution before release. Proper solution
> > would be to check if chars needed to be escaped (", \, /) aren't already
> > escaped.

> > Also for correct decision whether \n, \t should be escaped or interpreted
> > we should decide in the parser which has the context. C string should be
> > probably interpreted (thus nothing needed to be done as it escapes in
> > a compatible way with JSON), but comments probably should display \n, \t
> > thus add extra \.

> > Fixes: c39b29f0a ("bpf: Check truncation on 32bit div/mod by zero")

> > Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> > Co-developed-by: Cyril Hrubis <chrubis@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  docparse/data_storage.h | 36 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 35 insertions(+), 1 deletion(-)

> > diff --git a/docparse/data_storage.h b/docparse/data_storage.h
> > index ef420c08f..9f36dd6f0 100644
> > --- a/docparse/data_storage.h
> > +++ b/docparse/data_storage.h
> > @@ -256,6 +256,40 @@ static inline void data_fprintf(FILE *f, unsigned int padd, const char *fmt, ...
> >  	va_end(va);
> >  }

> > +
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

+1.

I'll test it and merge under your as it's basically your work :).
Thanks!

Kind regards,
Petr
