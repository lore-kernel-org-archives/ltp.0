From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 May 2019 13:38:47 +0200
Subject: [LTP] [PATCH v1 3/4] syscalls/pidfd_send_signal02
In-Reply-To: <20190515120116.11589-3-camann@suse.com>
References: <20190515120116.11589-1-camann@suse.com>
 <20190515120116.11589-3-camann@suse.com>
Message-ID: <20190528113847.GB14548@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void verify_pidfd_send_signal(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	TEST(tst_pidfd_send_signal(*tc->fd, tc->signal, tc->siginf, tc->flags));
> +	if (tc->exp_err != TST_ERR) {
> +		tst_res(TFAIL | TTERRNO,
> +			"pidfd_send_signal() did not fail with %s but",
> +			tst_strerrno(tc->exp_err));
> +		return;
> +	}
> +
> +	tst_res(TPASS,
> +		"pidfd_send_signal() failed as expected!");

I tend to pass TTERRNO to the passing message for negative testcases
like this one so that the output has some information about what has
been tested.

I would have done something as here:

	tst_res(TPASS | TTERRNO, "pidfd_send_signal() failed");

Other than this the test looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
