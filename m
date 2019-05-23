From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 May 2019 11:40:03 +0200
Subject: [LTP] [PATCH] syscalls/prctl05.c: New test for prctl() with
 PR_{SET, GET}_NAME
In-Reply-To: <1557404414-3797-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1557404414-3797-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190523094003.GC30616@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	TEST(prctl(PR_GET_NAME, &buf));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "prctl(PR_GET_NAME) failed");
> +		return;
> +	}
> +
> +	if (!strncmp(thread_name, buf, 15) && strlen(buf) == 15)
                                                  ^
						  Here we are calling
						  strlen() on
						  potentionally
						  unterminated buffer

I guess that we should do buf[19] = 0 after the PR_GET_NAME prctl().

> +		tst_res(TPASS, "prctl(PR_GET_NAME) succeeded, "
> +				"thread name is %s", buf);
> +	else
> +		tst_res(TFAIL,
> +			"prctl(PR_GET_NAME) failed to truncate the name into "
> +			"16 byte long");

Can we also check that the /proc/self/task/$tid/comm matches as well?

> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_prctl,
> +};


Other than that it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
