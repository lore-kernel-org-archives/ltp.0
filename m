Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X42UI-00032q-41
	for ltp-list@lists.sourceforge.net; Mon, 07 Jul 2014 06:33:18 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X42UF-0000Nu-EY
	for ltp-list@lists.sourceforge.net; Mon, 07 Jul 2014 06:33:18 +0000
Message-ID: <53BB90C6.9020101@cn.fujitsu.com>
Date: Tue, 8 Jul 2014 14:33:42 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <20140704031641.GA20446@localhost.localdomain>
In-Reply-To: <20140704031641.GA20446@localhost.localdomain>
Subject: Re: [LTP] [RFC PATCH] regression test for 64bit sendfile capped at
 2G
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
To: hanpt@linux.vnet.ibm.com
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi,

On 07/04/2014 11:16 AM, Han Pingtian wrote:
> Hi,
> 
> Please review this patch. Thanks.
> 
> There is a bug on 64bit sendfile() with large file, please see
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118128.html
> for details.

I'd like to ask an irrelevant question about that where can we get such bug report or similar issues
about syscalls from a stable place(url), or how did you found this issue, thanks.

Give that currently there are 1039 test cases about syscalls in LTP(cat runtest/syscalls | grep -v "^#" | sed -e '/^$/d' | wc -l),
we can tell that syscalls is a very big test suite in LTP, so I'd like to add all similar regression test about
syscalls to LTP, which will expand ltp's test coverage, thanks. 

Regards,
Xiaoguang Wang


> 
> This sendfile09.c was copied from sendfile02.c and using plain
> file as the out_file. The file size is 4G (4294967296 bytes).
> ---
>  testcases/kernel/syscalls/sendfile/sendfile09.c | 245 ++++++++++++++++++++++++
>  1 file changed, 245 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/sendfile/sendfile09.c
> 
> diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
> new file mode 100644
> index 0000000..d88a72f
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
> @@ -0,0 +1,245 @@
> +/*
> + *
> + *   Copyright (c) International Business Machines  Corp., 2001
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;  if not, write to the Free Software
> + *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +/*
> + * NAME
> + *	sendfile09.c
> + *
> + * DESCRIPTION
> + *	Testcase copied from sendfile02.c to test the basic functionality of the sendfile(2) system call on large file.
> + *
> + * ALGORITHM
> + *	1. call sendfile(2) with offset = 0
> + *	2. call sendfile(2) with offset in the middle of the file
> + *
> + * USAGE:  <for command-line>
> + *  sendfile09 [-c n] [-i n] [-I x] [-P x] [-t]
> + *     where,
> + *             -i n : Execute test n times.
> + *             -I x : Execute test for x seconds.
> + *             -P x : Pause for x seconds between iterations.
> + *             -t   : Turn on syscall timing.
> + *
> + *
> + * RESTRICTIONS
> + *	Only supports 64bit systems and kernel 2.6.33 or above
> + */
> +#include <stdio.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sys/stat.h>
> +#include <sys/sendfile.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <inttypes.h>
> +
> +#include "usctest.h"
> +#include "test.h"
> +
> +#ifndef OFF_T
> +#define OFF_T off_t
> +#endif /* Not def: OFF_T */
> +
> +TCID_DEFINE(sendfile09);
> +int TST_TOTAL = 4;
> +
> +char in_file[100];
> +char out_file[100];
> +int out_fd;
> +
> +void cleanup(void);
> +void setup(void);
> +
> +struct test_case_t {
> +	char *desc;
> +	int offset;
> +	int64_t exp_retval;
> +	int64_t exp_updated_offset;
> +} testcases[] = {
> +	{
> +	"Test sendfile(2) with offset = 0", 0, 4294967296, 4294967296}, {
> +	"Test sendfile(2) with offset in the middle of file", 2, 4294967294, 4294967296}, {
> +	"Test sendfile(2) with offset in the middle of file", 4, 4294967292, 4294967296}, {
> +	"Test sendfile(2) with offset in the middle of file", 6, 4294967290, 4294967296}
> +};
> +
> +#ifdef UCLINUX
> +static char *argv0;
> +#endif
> +
> +void do_sendfile(OFF_T offset, int i)
> +{
> +	int in_fd;
> +	struct stat sb;
> +	int wait_status;
> +	int wait_stat;
> +	off_t before_pos, after_pos;
> +
> +	if ((out_fd = open(out_file, O_WRONLY)) < 0) {
> +		tst_brkm(TBROK, cleanup, "open failed: %d", errno);
> +	}
> +
> +	if ((in_fd = open(in_file, O_RDONLY)) < 0) {
> +		tst_brkm(TBROK, cleanup, "open failed: %d", errno);
> +	}
> +
> +	if (stat(in_file, &sb) < 0) {
> +		tst_brkm(TBROK, cleanup, "stat failed: %d", errno);
> +	}
> +
> +	if ((before_pos = lseek(in_fd, 0, SEEK_CUR)) < 0) {
> +		tst_brkm(TBROK, cleanup,
> +			 "lseek before invoking sendfile failed: %d", errno);
> +	}
> +
> +	TEST(sendfile(out_fd, in_fd, &offset, sb.st_size - offset));
> +
> +	if (TEST_RETURN == -1) {
> +		tst_brkm(TBROK, cleanup, "sendfile(2) failed: %s",
> +			strerror(TEST_RETURN));
> +	}
> +
> +	if ((after_pos = lseek(in_fd, 0, SEEK_CUR)) < 0) {
> +		tst_brkm(TBROK, cleanup,
> +			 "lseek after invoking sendfile failed: %d", errno);
> +	}
> +
> +	if (TEST_RETURN != testcases[i].exp_retval) {
> +		tst_resm(TFAIL, "sendfile(2) failed to return "
> +			 "expected value, expected: %" PRId64 ", "
> +			 "got: %" PRId64, testcases[i].exp_retval,
> +			 TEST_RETURN);
> +	} else if (offset != testcases[i].exp_updated_offset) {
> +		tst_resm(TFAIL, "sendfile(2) failed to update "
> +			 "OFFSET parameter to expected value, "
> +			 "expected: %" PRId64 ", got: %" PRId64,
> +			 testcases[i].exp_updated_offset,
> +			 (int64_t) offset);
> +	} else if (before_pos != after_pos) {
> +		tst_resm(TFAIL, "sendfile(2) updated the file position "
> +			 " of in_fd unexpectedly, expected file position: %"
> +			 PRId64 ", " " actual file position %" PRId64,
> +			 (int64_t) before_pos, (int64_t) after_pos);
> +	} else {
> +		tst_resm(TPASS, "functionality of sendfile() is "
> +			 "correct");
> +		wait_status = waitpid(-1, &wait_stat, 0);
> +	}
> +
> +	close(in_fd);
> +	close(out_fd);
> +}
> +
> +/*
> + * setup() - performs all ONE TIME setup for this test.
> + */
> +void setup(void)
> +{
> +	int fd;
> +	int i;
> +
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	/* make a temporary directory and cd to it */
> +	tst_tmpdir();
> +	sprintf(in_file, "in.%d", getpid());
> +	if ((fd = creat(in_file, 00700)) < 0) {
> +		tst_brkm(TBROK, cleanup, "creat failed in setup, errno: %d",
> +			 errno);
> +	}
> +
> +	/* create a 4G file */
> +	for (i = 1; i <= (4 * 1024); i++) {
> +		if (lseek(fd, (1024 * 1024 - 1), SEEK_CUR) < 0) {
> +			tst_brkm(TBROK, cleanup, "lseek failed, errno: %d", errno);
> +		}
> +
> +		if (write(fd, "C", 1) < 0) {
> +			tst_brkm(TBROK, cleanup, "write failed, errno: %d", errno);
> +		}
> +	}
> +
> +	close(fd);
> +	sprintf(out_file, "out.%d", getpid());
> +	if ((fd = creat(out_file, 00700)) < 0) {
> +		tst_brkm(TBROK, cleanup, "creat failed in setup, errno: %d",
> +			 errno);
> +	}
> +	close(fd);
> +}
> +
> +/*
> + * cleanup() - performs all ONE TIME cleanup for this test at
> + *	       completion or premature exit.
> + */
> +void cleanup(void)
> +{
> +	/*
> +	 * print timing stats if that option was specified.
> +	 * print errno log if that option was specified.
> +	 */
> +	TEST_CLEANUP;
> +
> +	close(out_fd);
> +	/* delete the test directory created in setup() */
> +	tst_rmdir();
> +
> +}
> +
> +int main(int ac, char **av)
> +{
> +	int i;
> +	int lc;
> +	const char *msg;		/* parse_opts() return message */
> +
> +#if __WORDSIZE == 32
> +	tst_brkm(TCONF, NULL, "This test is only for 64bit");
> +#endif
> +
> +	if (tst_kvercmp(2, 6, 33) < 0) {
> +		tst_resm(TINFO, "sendfile(2) on large file skipped for kernels < 2.6.33");
> +		return;
> +	}
> +
> +	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +	}
> +#ifdef UCLINUX
> +	argv0 = av[0];
> +#endif
> +
> +	setup();
> +
> +	/*
> +	 * The following loop checks looping state if -c option given
> +	 */
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; ++i) {
> +			do_sendfile(testcases[i].offset, i);
> +		}
> +	}
> +	cleanup();
> +
> +	tst_exit();
> +}
> 


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
