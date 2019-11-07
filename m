From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Nov 2019 14:23:59 +0100
Subject: [LTP] [PATCH v4 2/2] syscalls/prctl09: New timer sample test
 for PR_SET_TIMERSLACK
In-Reply-To: <1570767798-26685-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20191009121906.GA7677@rei.lan>
 <1570767798-26685-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1570767798-26685-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20191107132359.GE22352@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <errno.h>
> +#include <sys/prctl.h>
> +#include "lapi/prctl.h"
> +#include "tst_timer_test.h"
> +
> +int sample_fn(int clk_id, long long usec)
> +{
> +	struct timespec t = tst_us_to_timespec(usec);
> +
> +	TEST(prctl(PR_SET_TIMERSLACK, 200000));

This is a bit more complicated.

First of all it does not make sense to set the timerslack in the sample
function. It should be done once in the test setup.

Also in the tst_timer_test.c we store the timerslack value in the
timer_setup(), which executes the test setup() at the end of the
function, so we would have to move the part that gets the timerslack()
after the test setup() function so that the library includes the newly
set timerslack in the calculation.

> +	if (TST_RET != 0) {
> +		tst_res(TFAIL | TTERRNO,
> +			"prctl(), returned %li", TST_RET);
> +		return 1;
> +	}
> +
> +	tst_timer_start(clk_id);
> +	TEST(nanosleep(&t, NULL));
> +	tst_timer_stop();
> +	tst_timer_sample();
> +
> +	if (TST_RET != 0) {
> +		tst_res(TFAIL | TTERRNO,
> +			"nanosleep() returned %li", TST_RET);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct tst_test test = {
> +	.scall = "prctl()",
> +	.sample = sample_fn,
> +};
> -- 
> 2.18.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
