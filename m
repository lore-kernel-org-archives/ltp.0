From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jul 2017 14:15:57 +0200
Subject: [LTP] [PATCH] lib/tst_timer_test.c: fix unsigned int overflow
 on RHEL5.11GA
In-Reply-To: <1500274437-26154-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1500274437-26154-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170719121557.GG1015@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> On RHEL5.11GA, pselect01 gets signal SIGSEGV due to unsigned int
> overflow when all members of the samples array are less than usec
> in do_timer_test().  all tests which apply timer measurement library
> could trigger this issue on RHEL5.11GA regularly.

Ah righ, I've forgotten to add check for the array boundary there as
well.

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  lib/tst_timer_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
> index f30ad73..178e232 100644
> --- a/lib/tst_timer_test.c
> +++ b/lib/tst_timer_test.c
> @@ -295,9 +295,9 @@ void do_timer_test(long long usec, unsigned int nsamples)
>  			i, samples[0], samples[i-1]);
>  	}
>  
> -	for (i = nsamples - 1; samples[i] < usec; i--);
> +	for (i = nsamples - 1; i < nsamples && samples[i] < usec; i--);

But this does not seem right, we are decrementing i, hence we should
check that i > 0, otherwise we overflow anyway. With i < nsamples we
will break the cycle after the overflow, which is wrong and works only
by accident (since i is unsigned we overflow to UINT_MAX if we decrement
0).


This should be the correct patch to fix the problem:

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index f30ad73dc..0b675f78d 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -295,7 +295,7 @@ void do_timer_test(long long usec, unsigned int nsamples)
                        i, samples[0], samples[i-1]);
        }
 
-       for (i = nsamples - 1; samples[i] < usec; i--);
+       for (i = nsamples - 1; samples[i] < usec && i > 0; i--);
 
        if (i < nsamples - 1) {
                tst_res(TFAIL, "%s woken up early %u times range: [%lli,%lli]",

-- 
Cyril Hrubis
chrubis@suse.cz
