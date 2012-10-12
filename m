Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TMbxl-0007Gc-5G
	for ltp-list@lists.sourceforge.net; Fri, 12 Oct 2012 09:55:25 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TMbxj-00019Z-R1
	for ltp-list@lists.sourceforge.net; Fri, 12 Oct 2012 09:55:25 +0000
Message-ID: <5077E8A5.2080309@cn.fujitsu.com>
Date: Fri, 12 Oct 2012 17:53:41 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1349771952.git.jstancek@redhat.com>
	<538c53f77d011c2fe676abb59236c4bee6a1fb2c.1349771952.git.jstancek@redhat.com>
In-Reply-To: <538c53f77d011c2fe676abb59236c4bee6a1fb2c.1349771952.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2 1/2] new syscall test: readahead01
Reply-To: gaowanlong@cn.fujitsu.com
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

On 10/09/2012 04:51 PM, Jan Stancek wrote:
> errno testcase for readahead(2).
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  runtest/syscalls                                  |    2 +
>  testcases/kernel/syscalls/readahead/Makefile      |   22 +++
>  testcases/kernel/syscalls/readahead/readahead01.c |  172 +++++++++++++++++++++
>  3 files changed, 196 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/readahead/Makefile
>  create mode 100644 testcases/kernel/syscalls/readahead/readahead01.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index edf6c1e..e754c60 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -767,6 +767,8 @@ read02 read02
>  read03 read03
>  read04 read04
>  
> +readahead01 readahead01
> +
>  readdir01 readdir01
>  readdir02 readdir02
>  
> diff --git a/testcases/kernel/syscalls/readahead/Makefile b/testcases/kernel/syscalls/readahead/Makefile
> new file mode 100644
> index 0000000..45a3bbc
> --- /dev/null
> +++ b/testcases/kernel/syscalls/readahead/Makefile
> @@ -0,0 +1,22 @@
> +#
> +#  Copyright (C) 2012 Linux Test Project, Inc.
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
> new file mode 100644
> index 0000000..d58c074
> --- /dev/null
> +++ b/testcases/kernel/syscalls/readahead/readahead01.c
> @@ -0,0 +1,172 @@
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
> +option_t options[] = {
> +	{ NULL, NULL, NULL }
> +};
> +
> +#if defined(__NR_readahead)
> +static void setup(char *argv[]);

It seems that the argument of setup() can be declared to void.

> +static void cleanup(void);
> +
> +static int check_ret(long expected_ret)
> +{
> +	if (expected_ret == TEST_RETURN) {
> +		tst_resm(TPASS, "expected ret success - "
> +			"returned value = %ld", TEST_RETURN);
> +		return 0;
> +	}
> +	tst_resm(TFAIL, "unexpected failure - "
> +			"returned value = %ld, expected: %ld",
> +			TEST_RETURN, expected_ret);
> +	return 1;
> +}
> +
> +static int check_errno(long expected_errno)
> +{
> +	if (TEST_ERRNO == expected_errno) {
> +		tst_resm(TPASS|TTERRNO, "expected failure");
> +		return 0;
> +	}
> +
> +	if (TEST_ERRNO == 0)
> +		tst_resm(TFAIL, "call succeeded unexpectedly");
> +	else
> +		tst_resm(TFAIL|TTERRNO, "unexpected failure - "
> +			"expected = %ld : %s, actual",
> +			expected_errno, strerror(expected_errno));
> +	return 1;
> +}
> +
> +static void test_bad_fd(void)
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
> +
> +static void test_invalid_fd(void)
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
> +	char *msg;
> +	int lc;
> +
> +	msg = parse_opts(argc, argv, options, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup(argv);

argv is useless in setup().

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

ditto.

Thanks,
Wanlong Gao

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
> +
> 


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
