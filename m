From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Oct 2019 10:47:52 +0200
Subject: [LTP] [PATCH v3 2/4] tst_test.c: Add tst_multiply_timeout()
In-Reply-To: <20191016161519.11256-2-cfamullaconrad@suse.de>
References: <1571225126.8494.1.camel@suse.de>
 <20191016161519.11256-1-cfamullaconrad@suse.de>
 <20191016161519.11256-2-cfamullaconrad@suse.de>
Message-ID: <20191017084751.GA12047@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clemens,

> This function is used to adjust timeout values with environment
> variables like LTP_TIMEOUT_MUL.

> Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM, minor formatting/wording bellow.

...
> -void tst_set_timeout(int timeout)
> +unsigned int tst_multiply_timeout(unsigned int timeout)
>  {
> -	char *mul = getenv("LTP_TIMEOUT_MUL");
> +	char *mul;
> +	float mul_float;
> +
> +	if (timeout_mul == -1){
Please add space before { (on more places + unnecessary { }).
linux/scripts/checkpatch.pl --terse --no-tree -f lib/tst_test.c
would tell you :)
([1] but we don't follow it fully - common sense is applied, but we try).

> +		mul = getenv("LTP_TIMEOUT_MUL");
> +		if (mul) {
> +			timeout_mul = mul_float = atof(mul);
> +			if (timeout_mul != mul_float){
> +				timeout_mul++;
> +				tst_res(TINFO, "ceiling LTP_TIMEOUT_MUL to %d", timeout_mul);
> +			}
> +		} else {
> +			timeout_mul = 1;
> +		}
> +	}
> +	if (timeout_mul < 1)
> +		tst_brk(TBROK, "LTP_TIMEOUT_MUL need to be int >= 1! (%d)", timeout_mul);
> +
> +	if (timeout < 1)
> +		tst_brk(TBROK, "timeout need to be >= 1! (%d)", timeout);
nit: need => maybe must/needs ?

Kind regards,
Petr
[1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#131-c-coding-style
