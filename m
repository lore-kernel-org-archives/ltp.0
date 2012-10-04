Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TJmFd-0004jC-9h
	for ltp-list@lists.sourceforge.net; Thu, 04 Oct 2012 14:18:09 +0000
Date: Thu, 4 Oct 2012 16:18:37 +0200
From: chrubis@suse.cz
Message-ID: <20121004141837.GA20568@saboteur.suse.cz>
References: <7fa9c1ccd34208d5b20d0438629639ab3ea70cae.1345032017.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7fa9c1ccd34208d5b20d0438629639ab3ea70cae.1345032017.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 1/2] new syscall test: readahead01
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
> new file mode 100644
> index 0000000..727dd7b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/readahead/readahead01.c
> @@ -0,0 +1,161 @@
> +/*
> + * Copyright (C) 2012 Linux Test Project, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like.  Any license provided herein, whether
> + * implied or otherwise, applies only to this software file.  Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +
> +/*
> + * errno tests for readahead() syscall
> + */
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <sys/socket.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include "config.h"
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +#include "linux_syscall_numbers.h"
> +
> +char *TCID = "readahead01";
> +int  TST_TOTAL = 1;
> +
> +#if defined(__NR_readahead)
> +static void setup(char *argv[]);
> +static void cleanup(void);
> +
> +static int check_ret(long expected_ret)
> +{
> +	if (expected_ret == TEST_RETURN) {
> +		tst_resm(TPASS, "expected ret success - "
> +			"returned value = %ld", TEST_RETURN);
> +		return 0;
> +	} else
> +		tst_resm(TFAIL, "unexpected failure - "
> +			"returned value = %ld, expected: %ld",
> +			TEST_RETURN, expected_ret);

There should be curly brackets around the block after the else too. The
general rule is that once they are around one block they should be
around both of them.

> +	return 1;
> +}
> +
> +static int check_errno(long expected_errno)
> +{
> +	if (TEST_ERRNO == expected_errno) {
> +		tst_resm(TPASS|TTERRNO, "expected failure");
> +		return 0;
> +	} else if (TEST_ERRNO == 0)
> +		tst_resm(TFAIL, "call succeeded unexpectedly");
> +	else
> +		tst_resm(TFAIL|TTERRNO, "unexpected failure - "
> +			"expected = %ld : %s, actual",
> +			expected_errno, strerror(expected_errno));
> +	return 1;
> +}

Hmm, no need for the else if as there is a return in the first if
anyway, right?

> +static void test_bad_fd()
> +{
> +	char tempname[PATH_MAX] = "readahead01_XXXXXX";
> +	int fd;
> +
> +	tst_resm(TINFO, "test_bad_fd -1");
> +	TEST(syscall(__NR_readahead, -1, 0, getpagesize()));
> +	check_ret(-1);
> +	check_errno(EBADF);
> +
> +	tst_resm(TINFO, "test_bad_fd O_WRONLY");
> +	fd = mkstemp(tempname);
> +	if (fd == -1)
> +		tst_resm(TBROK|TERRNO, "mkstemp failed");
> +	close(fd);
> +	fd = open(tempname, O_WRONLY);
> +	if (fd == -1)
> +		tst_resm(TBROK|TERRNO, "Failed to open testfile");
> +	TEST(syscall(__NR_readahead, fd, 0, getpagesize()));
> +	check_ret(-1);
> +	check_errno(EBADF);
> +	close(fd);
> +	unlink(tempname);
> +}

As allready said add void to functions withouts any params.

> +static void test_invalid_fd()
> +{
> +	int fd[2];
> +
> +	tst_resm(TINFO, "test_invalid_fd pipe");
> +	if (pipe(fd) < 0)
> +		tst_resm(TBROK|TERRNO, "Failed to create pipe");
> +	TEST(syscall(__NR_readahead, fd[0], 0, getpagesize()));
> +	check_ret(-1);
> +	check_errno(EINVAL);
> +	close(fd[0]);
> +	close(fd[1]);
> +
> +	tst_resm(TINFO, "test_invalid_fd socket");
> +	fd[0] = socket(AF_INET, SOCK_STREAM, 0);
> +	if (fd[0] < 0)
> +		tst_resm(TBROK|TERRNO, "Failed to create socket");
> +	TEST(syscall(__NR_readahead, fd[0], 0, getpagesize()));
> +	check_ret(-1);
> +	check_errno(EINVAL);
> +	close(fd[0]);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;

I would add the standard parse_opts() here (otherwise TEST_LOOPING and
other things wouldn't work).

> +	setup(argv);
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +		test_bad_fd();
> +		test_invalid_fd();
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(char *argv[])
> +{
> +	tst_require_root(NULL);
> +	tst_tmpdir();
> +
> +	/* check if readahead syscall is supported */
> +	syscall(__NR_readahead, 0, 0, 0);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +	tst_rmdir();
> +}
> +
> +#else /* __NR_readahead */
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "System doesn't support __NR_readahead");
> +}
> +#endif

And please add a runtest entry suposedly to runtest/syscalls so the test
gets executed in default runs.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
