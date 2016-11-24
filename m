From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Nov 2016 17:48:33 +0100
Subject: [LTP] [PATCH v3 2/2] testcases/clock_nanosleep01: convert to
 use new test library API
In-Reply-To: <184a4d332234197dc9c1f61ca24f6f15aea4ee0b.1480002155.git-series.pvorel@suse.cz>
References: <26cbebb57e3e9df7ed9f76b7ccc67d5f104ad376.1480002155.git-series.pvorel@suse.cz>
 <184a4d332234197dc9c1f61ca24f6f15aea4ee0b.1480002155.git-series.pvorel@suse.cz>
Message-ID: <20161124164832.GH14986@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	tst_res(TINFO, "remain time: %ld %ld", rm.tv_sec, rm.tv_nsec);

Looking closer this message should be printed only for the SEND_SIGINT
testcase.

> +	/* result check */
> +	if (!TEST_RETURN && (elapsed_ms < expect_ms - MAX_MSEC_DIFF
> +		|| elapsed_ms > expect_ms + MAX_MSEC_DIFF)) {
> +		tst_res(TFAIL| TTERRNO, "time range check returned %ld, expected %d, expected errno %s (%d)",
> +			TEST_RETURN, tc->exp_ret, tst_strerrno(tc->exp_err), tc->exp_err);
> +		return;
>  	}

Sorry that I missed that in the earlier patches. The actuall tst_res()
message should explain the reason for the failure here. So something as:

tst_res(TFAIL, "The clock_nanosleep() haven't slept correctly, "
        "measured %ldms, expected %ldms +- %d", elapsed_ms, expect_ms,
	MAX_MSEC_DIFF);

> -	cleanup();
> -	tst_exit();
> -
> +	if (tc->ttype == SEND_SIGINT && !rm.tv_sec && !rm.tv_nsec) {
> +		tst_res(TFAIL | TTERRNO, "remain time check returned %ld, expected %d, expected errno %s (%d)",
> +			TEST_RETURN, tc->exp_ret, tst_strerrno(tc->exp_err), tc->exp_err);

Here as well, we should note that the timespec wasn't updated with
remaining time. And we should also zero the structure before the
SEND_SIGINT test, since otherwies this will pass even if kernel does not
store the value since it will contain random data from stack.

And if we wanted to be even more pedantic we should also check that the
remaining time is <= sleep time.

> +		return;
> +	}
> +	if (TEST_RETURN != tc->exp_ret) {
> +		tst_res(TFAIL | TTERRNO, "returned %ld, expected %d, expected errno: %s (%d)",
> +			TEST_RETURN, tc->exp_ret, tst_strerrno(tc->exp_err), tc->exp_err);
> +		return;
> +	}
> +	tst_res(TPASS, "returned %ld", TEST_RETURN);
>  }

Otherwise this version looks very good. Just keep in mind to keep the
lines under 80 characters.

-- 
Cyril Hrubis
chrubis@suse.cz
