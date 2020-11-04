From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Nov 2020 19:12:52 +0100
Subject: [LTP] [PATCH] Convert dup02 to new API and clean up
In-Reply-To: <20201104132116.20712-1-radoslav.kolev@suse.com>
References: <20201104132116.20712-1-radoslav.kolev@suse.com>
Message-ID: <20201104181252.GA10153@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Radoslav,

>  testcases/kernel/syscalls/dup/dup02.c | 212 ++++++--------------------
...

> +	struct tcase *testcase = &testcases[n];
Maybe shorter names (tc)?

> +
> +	TEST(dup(testcase->fd));
> +
> +	if (TST_RET < -1) {
> +		tst_res(TFAIL, "Invalid dup() return value %ld", TST_RET);
I'd use here also TERRNO (on this unexpected error.

> +	} else if (TST_RET == -1) {
> +		if (TST_ERR == testcase->expected_errno) {
		if (testcase->expected_errno ==  TST_ERR) {
(checkpatch.pl script from kernel warning; checkpatch.pl warnings aren't hard
requirements but it's good try to remove them if possible).

> +			tst_res(TPASS | TERRNO, "dup(%d) failed as expected",
> +				testcase->fd);
> +		} else {
> +			tst_res(TFAIL | TERRNO, "dup(%d) Failed unexpectedly",
> +				testcase->fd);
>  		}
> +	} else {
> +		tst_res(TFAIL, "dup(%d) Succeeded unexpectedly", testcase->fd);
> +		SAFE_CLOSE(TST_RET);
>  	}

Nested if/else blocks are hard to read. We're trying to reduce them with return:
(not hard requirement, but really more readable)

	if (TST_RET < -1) {
		tst_res(TFAIL | TTERRNO, "Invalid dup() return value %ld", TST_RET);
		return;
	}

	if (TST_RET == -1) {
		if (testcase->expected_errno ==  TST_ERR) {
			tst_res(TPASS | TERRNO, "dup(%d) failed as expected",
				testcase->fd);
		} else {
			tst_res(TFAIL | TERRNO, "dup(%d) Failed unexpectedly",
				testcase->fd);
		}

		return;
	}

	tst_res(TFAIL, "dup(%d) Succeeded unexpectedly", testcase->fd);
	SAFE_CLOSE(TST_RET);

Otherwise LGTM :).

Kind regards,
Petr
