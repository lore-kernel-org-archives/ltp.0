From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Aug 2017 10:41:39 +0200
Subject: [LTP] [PATCH v2] syscalls/fanotify08: add sanity check for
	FAN_CLOEXEC
In-Reply-To: <1502421199-6364-1-git-send-email-xzhou@redhat.com>
References: <20170605140332.GB24454@rei.lan>
 <1502421199-6364-1-git-send-email-xzhou@redhat.com>
Message-ID: <20170811084138.GA3341@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define _GNU_SOURCE
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/syscall.h>
> +#include "tst_test.h"
> +#include "fanotify.h"
> +
> +#if defined(HAVE_SYS_FANOTIFY_H)
> +#include <sys/fanotify.h>
> +
> +static void cleanup(void);

This cleanup definition is completely useless here as the test structure
is defined at the end of the code.

> +static void test01(int flag);
> +static int fd_notify;
> +
> +void test_coe(void)
> +{
> +	test01(FAN_CLOEXEC);
> +	test01(0);
> +}

Can we turn this into two separate testcases?

> +static void test01(int flag)
> +{
> +	int coe;
> +
> +	fd_notify = fanotify_init(FAN_CLASS_NOTIF|flag, O_RDONLY);
> +
> +	if (fd_notify < 0) {
> +
> +		if (errno == ENOSYS) {
> +			tst_brk(TCONF,
> +				"fanotify is not configured in this kernel.");
> +		} else {
> +			tst_brk(TBROK | TERRNO, "fanotify_init failed");
> +		}
> +	}
> +
> +	coe = SAFE_FCNTL(fd_notify, F_GETFD);
> +
> +	if (coe & FD_CLOEXEC) {
> +		if (flag == 0)
> +			tst_res(TFAIL, "set close-on-exit");
> +		else
> +			tst_res(TPASS, "set close-on-exit");
> +	} else {
> +		if (flag == 0)
> +			tst_res(TPASS, "not set close-on-exit");
> +		else
> +			tst_res(TFAIL, "not set close-on-exit");
> +	}

I would mildly prefer if we split this test functions into two one for
FAN_CLOEXEC and one for case without the flag. All we need is to put the
part that checks the fanotify_init() return value into a separate
function and ideally we should put it into a header so that it could be
reused in all fanotify testcases, but unfortunately we would have to
convert the rest of the fanotify tests to the new library first...

> +	SAFE_CLOSE(fd_notify);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd_notify > 0)
> +		SAFE_CLOSE(fd_notify);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = test_coe,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +};
> +
> +#else
> +	TST_TEST_TCONF("system doesn't have required fanotify support");
> +#endif
> -- 
> 1.8.3.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
