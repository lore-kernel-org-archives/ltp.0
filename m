From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 11 Nov 2020 14:19:00 +0000
Subject: [LTP] [PATCH] lib: tst_bool_expr: Add support for strings
In-Reply-To: <20201111131131.17360-1-chrubis@suse.cz>
References: <20201111131131.17360-1-chrubis@suse.cz>
Message-ID: <87mtzoou23.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> diff --git a/lib/tst_bool_expr.c b/lib/tst_bool_expr.c
> index dd147cde3..35ffa5a80 100644
> --- a/lib/tst_bool_expr.c
> +++ b/lib/tst_bool_expr.c
> @@ -64,6 +64,7 @@ static unsigned int tokenize(const char *expr, struct tst_expr_tok *last)
>  {
>  	size_t i, j;
>  	unsigned int token_cnt = 0;
> +	int in_string = 0;
>  
>  	for (j = i = 0; expr[i]; i++) {


Why not skip the whole switch statement if in_string and just check for
the closing '"' instead?

>  		switch (expr[i]) {
> @@ -72,14 +73,21 @@ static unsigned int tokenize(const char *expr, struct tst_expr_tok *last)
>  		case '!':
>  		case '&':
>  		case '|':
> -			token_cnt += new_tok(&last, &expr[j], i - j);
> -			token_cnt += new_tok(&last, &expr[i], 1);
> -			j = i+1;
> +			if (!in_string) {
> +				token_cnt += new_tok(&last, &expr[j], i - j);
> +				token_cnt += new_tok(&last, &expr[i], 1);
> +				j = i+1;
> +			}
>  		break;
>  		case '\t':
>  		case ' ':
> -			token_cnt += new_tok(&last, &expr[j], i - j);
> -			j = i+1;
> +			if (!in_string) {
> +				token_cnt += new_tok(&last, &expr[j], i - j);
> +				j = i+1;
> +			}
> +		break;
> +		case '"':
> +			in_string = !in_string;
>  		break;
>  		default:
>  		break;
> -- 
> 2.26.2

It should probably be an error if tokenize exits with in_string=1?

-- 
Thank you,
Richard.
