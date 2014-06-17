Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wwq4H-0000KO-Qo
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 09:52:41 +0000
Date: Tue, 17 Jun 2014 11:52:29 +0200
From: chrubis@suse.cz
Message-ID: <20140617095229.GB29213@rei.Home>
References: <1402060015.2086.2.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1402060015.2086.2.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] add new errno testes for timerfd_*
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> diff --git a/include/lapi/timerfd.h b/include/lapi/timerfd.h
> new file mode 100644
> index 0000000..ba02003
> --- /dev/null
> +++ b/include/lapi/timerfd.h
> @@ -0,0 +1,49 @@
> +/*
> + * Copyright (c) International Business Machines  Corp., 2007
> + * Copyright (c) 2014 Fujitsu Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifndef TIMERFD_H
> +#define TIMERFD_H
> +
> +#include <time.h>
> +#include "config.h"
> +#include "linux_syscall_numbers.h"
> +
> +#if !defined(HAVE_TIMERFD_CREATE)
> +int timerfd_create(int clockid, int flags)
> +{
> +	return ltp_syscall(__NR_timerfd_create, clockid, flags);
> +}
> +#endif
> +
> +#if !defined(HAVE_TIMERFD_GETTIME)
> +int timerfd_settime(int fd, int flags, const struct itimerspec *new_value,
> +		    struct itimerspec *old_value)
> +{
> +	return ltp_syscall(__NR_timerfd_settime, fd, flags, new_value,
> +			   old_value);
> +}
> +#endif
> +
> +#if !defined(HAVE_TIMERFD_SETTIME)
> +int timerfd_gettime(int fd, struct itimerspec *curr_value)
> +{
> +
> +	return ltp_syscall(__NR_timerfd_gettime, fd, curr_value);
> +}
> +#endif
> +
> +#endif /* TIMERFD_H */

This header is fine but I cannot find accompanying configure check for
timerfd functions, forget to add it to the commit?

> diff --git a/testcases/kernel/syscalls/timerfd/timerfd_create01.c b/testcases/kernel/syscalls/timerfd/timerfd_create01.c
> new file mode 100644
> index 0000000..4793928
> --- /dev/null
> +++ b/testcases/kernel/syscalls/timerfd/timerfd_create01.c
> @@ -0,0 +1,106 @@
> +/*
> + * Copyright (c) 2014 Fujitsu Ltd.
> + * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +/*
> + * DESCRIPTION
> + *  Verify that,
> + *   1. The clockid argument is neither CLOCK_MONOTONIC nor CLOCK_REALTIME,
> + *	EINVAL would return.
> + *   2. flags is invalid, EINVAL would return.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "lapi/timerfd.h"

You should include the sys/timerfd.h either here or in the
lapi/timerfd.h because otherwise the system function definitions, if
present, are not used. And the same applies to the rest of the
testcases.

Note that this needs the configure check in-place so that we use either
the system definitions or the LTP syscall wrappers.

> diff --git a/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c b/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
> new file mode 100644
> index 0000000..2442b79
> --- /dev/null
> +++ b/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
> @@ -0,0 +1,131 @@
> +/*
> + * Copyright (c) 2014 Fujitsu Ltd.
> + * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +/*
> + * DESCRIPTION
> + *  Verify that,
> + *   1. fd is not a valid file descriptor, EBADF would return.
> + *   2. curr_value is not valid a pointer, EFAULT would return.
> + *   3. fd is not a valid timerfd file descriptor, EINVAL would return.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +#include "lapi/timerfd.h"
> +
> +char *TCID = "timerfd_gettime01";
> +
> +static int bad_clockfd = -1;
> +static int clockfd;
> +static int fd;
> +
> +static struct test_case_t {
> +	int *fd;
> +	struct itimerspec *curr_value;
> +	int exp_errno;
> +} test_cases[] = {
> +	{&bad_clockfd, NULL, EBADF},
> +	{&clockfd, (struct itimerspec *)-1, EFAULT},
> +	{&fd, NULL, EINVAL},
> +};
> +
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +static void setup(void);
> +static void timerfd_gettime_verify(const struct test_case_t *);
> +static void cleanup(void);
> +static int exp_enos[] = { EBADF, EFAULT, EINVAL, 0 };
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	const char *msg;
> +	int i;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +		for (i = 0; i < TST_TOTAL; i++)
> +			timerfd_gettime_verify(&test_cases[i]);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	if ((tst_kvercmp(2, 6, 25)) < 0)
> +		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.25 or newer");
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	TEST_EXP_ENOS(exp_enos);
> +
> +	tst_tmpdir();
> +
> +	clockfd = ltp_syscall(__NR_timerfd_create, CLOCK_REALTIME, 0);

You should use the timerfd_create() here instead (and the same for the
rest of the code, you should not use the raw syscall once you are sure
that either there are system defintions or LTP wrappers in place).

> +	if (clockfd == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "timerfd_create() fail");
> +
> +	fd = SAFE_OPEN(cleanup, "test_timerfd", O_RDWR | O_CREAT, 0644);
                                   ^
				   I would set it to just "test_file"
				   because the newly created file is not
				   timer at all and this may be slightly
				   misleading.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
