From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 May 2021 14:38:14 +0200
Subject: [LTP] [PATCH 1/1] docparse: Escape backslash,
 tab and double quote in JSON
In-Reply-To: <YI/jqKdP7kRYK1qD@yuki>
References: <20210503085732.9637-1-pvorel@suse.cz>
 <YI/jqKdP7kRYK1qD@yuki>
Message-ID: <YI/utqVeWrPjwqYQ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> I guess that it would be easier to write a function to print json
> string, e.g.

> static inline void data_fprintf_esc_(FILE *f, unsigned int padd, const char *str)
> {
> 	while (padd-- > 0)
> 		fputc(' ', f);

> 	fputc('"', f);

> 	while (*str) {
> 		switch (*str) {
> 		case '\\':
> 			fputs("\\\\", f);
> 		break;
> 		case '"':
> 			fputs("\\\"", f);
> 		break;
> 		case '\t':
> 			fputs("\\t", f);
> 		break;
> 		default:
> 			putc(*str, f);
> 		break;
> 		}
> 		str++;
> 	}

> 	fputc('"', f);
> }

That's indeed much better, thanks! I'll send v2 with you as author.

Kind regards,
Petr
