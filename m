From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Oct 2019 16:37:03 +0200
Subject: [LTP] [PATCH v4 2/5] tst_test.c: Add tst_multiply_timeout()
In-Reply-To: <20191018124502.25599-3-cfamullaconrad@suse.de>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
 <20191018124502.25599-3-cfamullaconrad@suse.de>
Message-ID: <20191021143703.GA27848@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (timeout_mul == -1) {
> +		mul = getenv("LTP_TIMEOUT_MUL");
> +		if (mul) {
> +			timeout_mul = mul_float = atof(mul);
> +			if (timeout_mul != mul_float) {
> +				timeout_mul++;
> +				tst_res(TINFO, "ceiling LTP_TIMEOUT_MUL to %d",
> +						timeout_mul);
> +			}

Huh, why are we ceiling the timeout multiplier?

We do that for shell because it simplifies the code and we do not care
that much about being precise for timeouts, but it does not make much
sense here.

Why can't we just convert the env variable to float and multiply?

Something as:

	if (mul) {
		if (ret = tst_parse_float(mul, &timeout_mul, 1, 10000)) {
			tst_brk(TBROK, "Failed to parse LTP_TIMEOUT_MUL: %s",
			        tst_strerrno(ret));
		}
	} else {
		timeout_mul = 1;
	}


-- 
Cyril Hrubis
chrubis@suse.cz
