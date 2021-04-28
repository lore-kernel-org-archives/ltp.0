From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 28 Apr 2021 14:11:45 +0200
Subject: [LTP] [PATCH 1/2] syscalls/tkill: Convert tkill01 to the new API
In-Reply-To: <YIaWnt5ksxVyBvxk@pevik>
References: <20210422065732.61222-1-xieziyao@huawei.com>
 <20210422065732.61222-2-xieziyao@huawei.com>
 <YIaWnt5ksxVyBvxk@pevik>
Message-ID: <YIlRAanTIk9uKVEP@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > -#include "test.h"
> >  #include "lapi/syscalls.h"
> > +#include "tst_test.h"
> 
> > +int sig_flag = 0;
> 
> It should be
> static int sig_flag;

It has to be volatile as well, if we are waiting in a bussy loop on it
and it's changed ansynchronously from a signal handler, otherwise
compiler may misoptimize the code.

Generally the code that waits for a signal should look like:

static volatile sig_atomic_t sig_flag;

static void setup(void)
{
	SAFE_SIGNAL(SIGUSR1, sighandler);
}

static void run(void)
{
	int timeout_ms = 1000;
	sig_flag = 0;

	TST_EXP_PASS(tst_syscall(__NR_tkill, tid, SIGUSR1));

	while (timeout_ms--) {
		if (sig_flag)
			break;

		usleep(1000);
	}

	if (sig_flag)
		tst_res(TPASS, ...);
	else
		tst_res(TFAIL, ...);
}

-- 
Cyril Hrubis
chrubis@suse.cz
