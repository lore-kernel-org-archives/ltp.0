From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Oct 2019 14:50:53 +0200
Subject: [LTP] [PATCH v4 2/5] tst_test.c: Add tst_multiply_timeout()
In-Reply-To: <20191018124502.25599-3-cfamullaconrad@suse.de>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
 <20191018124502.25599-3-cfamullaconrad@suse.de>
Message-ID: <20191021125053.GA18513@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clements,

> +	if (timeout_mul < 1)
> +		tst_brk(TBROK, "LTP_TIMEOUT_MUL must to be int >= 1! (%d)",
> +				timeout_mul);
> +
> +	if (timeout < 1)
> +		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);
> +
> +	return timeout * timeout_mul;
> +}

> +void tst_set_timeout(int timeout)
> +{
>  	if (timeout == -1) {
>  		tst_res(TINFO, "Timeout per run is disabled");
>  		return;
>  	}

> -	results->timeout = timeout;
> +	if (timeout < 1)
> +		tst_brk(TBROK, "timeout need to be >= 1! (%d)", timeout);
need => needs, but better to use must (to be consistent with the previous one:
		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);

I also wonder, if this check is needed, next step is
results->timeout = tst_multiply_timeout(timeout);
which does the same check.

Can be changed with the committer (unless you plan to do v5 for some reason).

> -	if (mul) {
> -		float m = atof(mul);
> -
> -		if (m < 1)
> -			tst_brk(TBROK, "Invalid timeout multiplier '%s'", mul);
> -
> -		results->timeout = results->timeout * m + 0.5;
> -	}
> +	results->timeout = tst_multiply_timeout(timeout);

>  	tst_res(TINFO, "Timeout per run is %uh %02um %02us",
>  		results->timeout/3600, (results->timeout%3600)/60,

Kind regards,
Petr
