From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Oct 2020 14:04:34 +0200
Subject: [LTP] [PATCH V4 2/3] syscalls: select: Verify that data is
 available to read
In-Reply-To: <63646c1ba9e1a3061b44be4f1f9a29d9d6d03f2e.1603254560.git.viresh.kumar@linaro.org>
References: <fb31dd18ad396ab602ba8957ee01a666f79ad9bb.1599558175.git.viresh.kumar@linaro.org>
 <63646c1ba9e1a3061b44be4f1f9a29d9d6d03f2e.1603254560.git.viresh.kumar@linaro.org>
Message-ID: <20201021120434.GB10861@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	else if (!TST_RET)
> +		tst_res(TFAIL, "select() timed out %s", tc->desc);
> +	else if (TST_RET != exp_ret)
> +		tst_res(TFAIL, "select() returned incorrect value %s, expected: %d, got: %lu", tc->desc, exp_ret, TST_RET);
> +	else if (FD_ISSET(*tc->readfd, tc->readfds) && (!tc->writefd || FD_ISSET(*tc->writefd, tc->writefds)))
>  		tst_res(TPASS, "select() passed %s", tc->desc);
> +	else
> +		tst_res(TFAIL, "select() returned expected value %s, but all file descriptors aren't ready", tc->desc);

In the end I've rewritten this part to use returns in order to avoid
this if else maze with overly long lines and pushed, thanks.

I guess that we still need a test where select would clear the bits from
fd->set though, I supposes that the easiest solution would be to add
select04.c for that...

-- 
Cyril Hrubis
chrubis@suse.cz
