From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 11 Nov 2020 17:38:52 +0000
Subject: [LTP] [PATCH] lib: tst_bool_expr: Add support for strings
In-Reply-To: <20201111143744.GA16874@yuki.lan>
References: <20201111131131.17360-1-chrubis@suse.cz>
 <87mtzoou23.fsf@suse.de> <20201111143744.GA16874@yuki.lan>
Message-ID: <87k0urpzdf.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Why not skip the whole switch statement if in_string and just check for
>> the closing '"' instead?
>
> I guess that we can instead do:
>
> diff --git a/lib/tst_bool_expr.c b/lib/tst_bool_expr.c
> index dd147cde3..387c38b91 100644
> --- a/lib/tst_bool_expr.c
> +++ b/lib/tst_bool_expr.c
> @@ -81,6 +81,13 @@ static unsigned int tokenize(const char *expr, struct tst_expr_tok *last)
>                         token_cnt += new_tok(&last, &expr[j], i - j);
>                         j = i+1;
>                 break;
> +               case '"':
> +                       while (expr[i+1] != '"' && expr[i+1])
> +                               i++;
> +
> +                       if (expr[i+1] == '"')
> +                               i++;
> +               break;
>                 default:
>                 break;
>                 }
>
>
> Not sure if this is more readable.

It's probably easier to understand, it atleast keeps string processing
separate.

>
>> >  		break;
>> >  		default:
>> >  		break;
>> > -- 
>> > 2.26.2
>> 
>> It should probably be an error if tokenize exits with in_string=1?
>
> Well my opinion is that we do not care since we will get error later on, in
> case of the kernel config we would get obviously wrong variable value. But if
> you think that this is important we can change the return type to int
> and return -1 on tokenizer failure.

I suppose it depends how much later and how such an error would look. If
the error will happen directly after leaving this function then I don't
think it matters either, but if it is possible that it manages to
complete the whole evaluation process before failing with TCONF because
the vars don't match then this has the potential to waste some time.

-- 
Thank you,
Richard.
