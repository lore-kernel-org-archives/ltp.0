From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 May 2021 09:57:35 +0200
Subject: [LTP] [RFC PATCH 1/6] API: Make some internal symbols static
In-Reply-To: <20210517163029.22974-2-rpalethorpe@suse.com>
References: <20210517163029.22974-1-rpalethorpe@suse.com>
 <20210517163029.22974-2-rpalethorpe@suse.com>
Message-ID: <YKNzbz36pAadTD9M@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> These do not appear to be referenced anywhere outside the library.

> diff --git a/include/old/test.h b/include/old/test.h
> index 2ae7dba71..a8994c08e 100644
> --- a/include/old/test.h
> +++ b/include/old/test.h
> @@ -113,7 +113,6 @@ void tst_parse_opts(int argc, char *argv[], const option_t *user_optarg,
>                      void (*user_help)(void));

>  /* lib/tst_res.c */
> -const char *strttype(int ttype);

I would not touch legacy API, but this looks to be safe.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
