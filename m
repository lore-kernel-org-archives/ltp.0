Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X47on-0003rf-54
	for ltp-list@lists.sourceforge.net; Mon, 07 Jul 2014 12:14:49 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X47ol-0005ue-Am
	for ltp-list@lists.sourceforge.net; Mon, 07 Jul 2014 12:14:49 +0000
Date: Mon, 7 Jul 2014 08:14:39 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1152474476.5259307.1404735279247.JavaMail.zimbra@redhat.com>
In-Reply-To: <20140704031641.GA20446@localhost.localdomain>
References: <20140704031641.GA20446@localhost.localdomain>
MIME-Version: 1.0
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
To: Han Pingtian <hanpt@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 4 July, 2014 5:16:41 AM
> Subject: [LTP] [RFC PATCH] regression test for 64bit sendfile capped at 2G
> 
> Hi,
> 
> Please review this patch. Thanks.

Hi,

> 
> There is a bug on 64bit sendfile() with large file, please see
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118128.html
> for details.
> 
> This sendfile09.c was copied from sendfile02.c and using plain
> file as the out_file. The file size is 4G (4294967296 bytes).

Missing Signed-off-by: line(s)

> ---
>  testcases/kernel/syscalls/sendfile/sendfile09.c | 245
>  ++++++++++++++++++++++++
>  1 file changed, 245 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/sendfile/sendfile09.c
> 
> diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c
> b/testcases/kernel/syscalls/sendfile/sendfile09.c
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
> + *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> + */
> +
> +/*
> + * NAME
> + *	sendfile09.c
> + *
> + * DESCRIPTION
> + *	Testcase copied from sendfile02.c to test the basic functionality of the
> sendfile(2) system call on large file.

^^ this line is too long. You can also reference relevant commit ids,
which introduce/fix the problem.

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

Is wait.h/waitpid() needed? (see below)

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

Please use ARRAY_SIZE macro.

> +
> +char in_file[100];
> +char out_file[100];
> +int out_fd;
> +
> +void cleanup(void);
> +void setup(void);

Please make all above static.

> +
> +struct test_case_t {
> +	char *desc;
> +	int offset;

Shouldn't this be OFF_T?

> +	int64_t exp_retval;
> +	int64_t exp_updated_offset;
> +} testcases[] = {
> +	{
> +	"Test sendfile(2) with offset = 0", 0, 4294967296, 4294967296}, {
> +	"Test sendfile(2) with offset in the middle of file", 2, 4294967294,
> 4294967296}, {
> +	"Test sendfile(2) with offset in the middle of file", 4, 4294967292,
> 4294967296}, {
> +	"Test sendfile(2) with offset in the middle of file", 6, 4294967290,
> 4294967296}

These lines are long.
Is it necessary to repeat the test 4 times? Would it be enough to do it twice
as suggested in comments above (once with offset 0 and once with offset beyond 2G)?

+ *	1. call sendfile(2) with offset = 0
+ *	2. call sendfile(2) with offset in the middle of the file

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

Is wait_status and wait_stat needed? (see below)

> +	off_t before_pos, after_pos;
> +
> +	if ((out_fd = open(out_file, O_WRONLY)) < 0) {
> +		tst_brkm(TBROK, cleanup, "open failed: %d", errno);
> +	}

braces {} are not necessary for single statement blocks
You can use kernel's scripts/checkpatch.pl to list all instances.

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

Did you mean stderror(TEST_ERRNO)?

You can use "TBROK | TERRNO" or "TBROK | TTERRNO" instead, that
applies for all tst_* calls above and below.

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

What is this waiting for?

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

you can remove this comment

> +	tst_tmpdir();
> +	sprintf(in_file, "in.%d", getpid());

in and out files will be in unique temp directory,
adding pid to file names seems unnecessary.

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

return with no value

> +	}
> +
> +	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +	}
> +#ifdef UCLINUX
> +	argv0 = av[0];
> +#endif

UCLINUX ifdefs blocks don't appear to be needed any longer.

Regards,
Jan

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
> --
> 1.9.3
> 
> 
> ------------------------------------------------------------------------------
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Edition
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
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
