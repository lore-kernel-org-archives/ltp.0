From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Nov 2019 14:59:25 +0100
Subject: [LTP] [PATCH 2/2] lib: Allow timeout coefficient < 1
In-Reply-To: <20191107153458.16917-3-rpalethorpe@suse.com>
References: <20191107153458.16917-1-rpalethorpe@suse.com>
 <20191107153458.16917-3-rpalethorpe@suse.com>
Message-ID: <20191114135925.GA31033@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> For the Syzkaller reproducers we want to allow the test runner to set the
> timeout to be a fraction of the default amount.

I guess that this is fine for prototyping but for the real world usage
the syswrap.c should have a .timeout set in the tst_test structure
instead.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  lib/tst_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 6239acf89..2e00fd86b 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1107,7 +1107,7 @@ void tst_set_timeout(int timeout)
>  	if (mul) {
>  		float m = atof(mul);
>  
> -		if (m < 1)
> +		if (m <= 0)
>  			tst_brk(TBROK, "Invalid timeout multiplier '%s'", mul);
>  
>  		results->timeout = results->timeout * m + 0.5;
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
