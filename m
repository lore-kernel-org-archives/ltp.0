From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Oct 2020 15:06:00 +0200
Subject: [LTP] [PATCH V3 2/3] syscalls: select: Verify that data is
 available to read
In-Reply-To: <20201019101048.knbl2w3q2xev6ywc@vireshk-i7>
References: <6fbfc6919c0000e7a7745afbc3c94baab02603fa.1599558175.git.viresh.kumar@linaro.org>
 <fb31dd18ad396ab602ba8957ee01a666f79ad9bb.1599558175.git.viresh.kumar@linaro.org>
 <20201014121343.GD31816@yuki.lan>
 <20201019101048.knbl2w3q2xev6ywc@vireshk-i7>
Message-ID: <20201020130600.GA16294@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Maybe I haven't understood what you meant when you said this earlier:
> 
>   And the coverate in these tests is a bit lacking, we do not have a
>   single tests that would send a data over a pipe to a fd select is
>   watching and check that select was woken up by that. There is no such
>   test in the pselect/ directory either.
> 
> > Also I would like to be more specific. E.g. expecting specific return
> > instead of just non-zero and also making sure the right bits are enabled
> > in the fd sets.
> 
> Something like this ?

This is much better, I suppose that we should as well check the
individual bits in the fd_sets to make it perfect.

> diff --git a/testcases/kernel/syscalls/select/select01.c b/testcases/kernel/syscalls/select/select01.c
> index e4b5caecbb10..4b33c0a01380 100644
> --- a/testcases/kernel/syscalls/select/select01.c
> +++ b/testcases/kernel/syscalls/select/select01.c
> @@ -38,12 +38,15 @@ static void run(unsigned int n)
>         struct tcases *tc = &tests[n];
>         struct timeval timeout;
>         char buf;
> +       int exp_ret = 1;
>  
>         timeout.tv_sec = 0;
>         timeout.tv_usec = 100000;
>  
> -       if (tc->writefd)
> +       if (tc->writefd) {
>                 SAFE_WRITE(0, *tc->writefd, &buf, sizeof(buf));
> +               exp_ret++;
> +       }
>  
>         TEST(do_select(*tc->nfds + 1, tc->readfds, tc->writefds, 0, &timeout));
>  
> @@ -51,6 +54,8 @@ static void run(unsigned int n)
>                 tst_res(TFAIL | TTERRNO, "select() failed %s", tc->desc);
>         else if (!TST_RET)
>                 tst_res(TFAIL, "select() timed out %s", tc->desc);
> +       else if (TST_RET != exp_ret)
> +               tst_res(TFAIL, "select() returned incorrect value: %s, expected: %d, got: %lu", tc->desc, exp_ret, TST_RET);
>         else
>                 tst_res(TPASS, "select() passed %s", tc->desc);
>  }
> 
> -- 
> viresh

-- 
Cyril Hrubis
chrubis@suse.cz
