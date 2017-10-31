From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Oct 2017 09:25:43 +0100
Subject: [LTP] [PATCH] syscalls/request_key03: new test for key
 instantiation races
In-Reply-To: <20171030185036.126451-1-ebiggers3@gmail.com>
References: <20171030185036.126451-1-ebiggers3@gmail.com>
Message-ID: <20171031082543.udhds5dvuj42kcqr@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> From: Eric Biggers <ebiggers@google.com>

> Add a test for two related bugs in the keyrings subsystem which each
> allowed unprivileged local users to cause a kernel oops (at best) by
> attempting to "add" a key concurrently with "requesting" it.

> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks very nice to me. Just two notes below.

<snip>

> +
> +	SAFE_WAITPID(add_key_pid, &status, 0);
> +	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
> +		tst_res(TPASS, "didn't crash while updating key of type '%s'",
> +			type);
> +	} else if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
> +		/* Probably CVE-2017-15299 */
> +		tst_res(TFAIL, "kernel oops while updating key of type '%s'",
> +			type);
> +	} else {
> +		tst_brk(TBROK, "add_key child %s", tst_strstatus(status));
> +	}
> +
> +	SAFE_WAITPID(request_key_pid, &status, 0);
> +	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
> +		tst_res(TPASS, "didn't crash while requesting key of type '%s'",
> +			type);
> +	} else if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
> +		/* Probably CVE-2017-15951 */
> +		tst_res(TFAIL, "kernel oops while requesting key of type '%s'",
> +			type);
> +	} else {
> +		tst_brk(TBROK, "request_key child %s", tst_strstatus(status));
> +	}

You evaluate test twice: for add_key_pid and then for request_key_pid.
This can lead to FAIL and PASS together. It's probably ok, it's just unusual for me.
./request_key03 
tst_test.c:958: INFO: Timeout per run is 0h 05m 00s
request_key03.c:136: FAIL: kernel oops while updating key of type 'encrypted'
request_key03.c:144: PASS: didn't crash while requesting key of type 'encrypted'
...


> +static void do_test(void)
> +{
> +	/*
> +	 * Briefly test the "encrypted" and/or "trusted" key types when
> +	 * availaible, mainly to reproduce CVE-2017-15299.
> +	 */
> +	test_with_key_type("encrypted", "update user:foo 32", 2);
> +	test_with_key_type("trusted", "update", 2);
> +
> +	/*
> +	 * Test the "user" key type for longer, mainly in order to reproduce
> +	 * CVE-2017-15951.  However, without the fix for CVE-2017-15299 as well,
> +	 * WARNs may show up in the kernel log.
> +	 */
> +	test_with_key_type("user", "payload", 15);
I wonder (out of curiosity how did you get values for effort (2 and 15).

<snip>

Kind regards,
Petr
