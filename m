From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Mar 2016 16:13:15 +0100
Subject: [LTP] [PATCH v3] epoll_pwait/epoll_pwait01.c: add new testcase
In-Reply-To: <1456993485-2849-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <56D7E9A0.4060701@cn.fujitsu.com>
 <1456993485-2849-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160303151315.GC3055@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two changes, thanks.

> +#ifndef EPOLL_PWAIT_H
> +#define EPOLL_PWAIT_H
> +
> +#include <sys/types.h>
> +#include "config.h"
> +#include "linux_syscall_numbers.h"
> +
> +#if !defined(HAVE_EPOLL_PWAIT)
> +int epoll_pwait(int epfd, struct epoll_event *events, int maxevents,
> +	int timeout, const sigset_t *sigmask)
> +{
> +	return ltp_syscall(__NR_epoll_pwait, epfd, events, maxevents,
> +		timeout, sigmask);

The syscall takes one more parameter than the glibc wrapper. I had to
add the size of the sigmask i.e. _NSIG/8 here otherwise we will get
EINVAL from kernel.

> +}
> +#endif

...

> +static void verify_nonsigmask(void)
> +{
> +	if (TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "epoll_wait() succeeded unexpectedly");
> +	} else {
> +		if (TEST_ERRNO == EINTR) {
> +			tst_resm(TPASS | TTERRNO,
> +				 "epoll_wait() failed as expected");
> +		} else {
> +			tst_resm(TFAIL | TTERRNO,
> +				 "epoll_wait() failed unexpectedly, "
> +				 "expected errno is EINTR");
> +		}
> +	}
> +}

And changed these two verify function to use return after tst_resm() so
that we don't have to do the else-if spagetti code.

-- 
Cyril Hrubis
chrubis@suse.cz
