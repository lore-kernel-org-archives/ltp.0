From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 12 Oct 2017 15:27:26 +0200
Subject: [LTP] [PATCH] Test for CVE-2017-2618 in setprocattr
In-Reply-To: <20170831074404.26337-1-fenggw-fnst@cn.fujitsu.com>
References: <20170831074404.26337-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <87k2007ayp.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Guangwen Feng writes:

> +
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include "tst_test.h"
> +
> +#define LOOPS	100
> +#define PATH_ATTRFS	"/proc/self/attr/fscreate"

Will this exist on all systems? I am guessing that if SELINUX is not
configured in the kernel then this won't exist. So it is probably best
to exit with TCONF if we can not find it.

> +
> +static void do_test(void)
> +{
> +	int i, fd;
> +
> +	for (i = 0; i < LOOPS; i++) {
> +		if (!SAFE_FORK()) {
> +			fd = SAFE_OPEN(PATH_ATTRFS, O_WRONLY);
> +			write(fd, "\n", 1);
> +			SAFE_CLOSE(fd);
> +			exit(0);
> +		}
> +
> +		tst_reap_children();
> +	}
> +
> +	tst_res(TPASS, "Bug not reproduced");
> +}
> +
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.test_all = do_test,
> +};
> --
> 2.9.4

Otherwise this looks good.

--
Thank you,
Richard.
