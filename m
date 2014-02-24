Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WI0nD-0000ws-Sl
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 19:02:19 +0000
Date: Mon, 24 Feb 2014 20:01:59 +0100
From: chrubis@suse.cz
Message-ID: <20140224190159.GA31562@rei>
References: <1389352876-28625-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389352876-28625-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] llseek/llseek03.c: add SEEK_CUR,
	SEEK_END flag test
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> new file mode 100644
> index 0000000..99d0c06
> --- /dev/null
> +++ b/testcases/kernel/syscalls/llseek/llseek03.c
> @@ -0,0 +1,214 @@
> +/*
> + * Copyright (c) 2014 Fujitsu Ltd.
> + * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
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
> +/*
> + * Description:
> + * Verify that,
> + *    1. llseek() succeeds to set the file pointer position to the current
> + *  specified location, when 'whence' value is set to SEEK_CUR and the data
> + *  read from the specified location should match the expected data.
> + *    2. llseek() succeeds to set the file pointer position to the end of
> + *  the file when 'whence' value set to SEEK_END and any attempts to read
> + *  from that position should return 0.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <unistd.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <utime.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <sys/resource.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <inttypes.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +#define TEST_FILE "testfile"
> +
> +static void setup(int ac, char **av);
> +static void cleanup(void);
> +
> +static void setup_seekcur(void);
> +static void testfunc_seekcur(void);
> +static void cleanup_seekcur(void);
> +
> +static void setup_seekend(void);
> +static void testfunc_seekend(void);
> +static void cleanup_seekend(void);
> +
> +static struct test_case_t {
> +	int whence;
> +	void (*setup)(void);
> +	void (*testfunc)(void);
> +	void (*cleanup)(void);
> +} test_cases[] = {
> +	{ SEEK_CUR, setup_seekcur, testfunc_seekcur, cleanup_seekcur},
> +	{ SEEK_END, setup_seekend, testfunc_seekend, cleanup_seekend},
> +};
> +
> +char *TCID = "llseek03";
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +static char read_buf[BUFSIZ];
> +
> +static int fd;
> +static size_t file_size;
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int i;
> +
> +	setup(ac, av);
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++) {
> +			if (test_cases[i].setup)
> +				test_cases[i].setup();
> +			if (test_cases[i].testfunc)
> +				test_cases[i].testfunc();
> +			if (test_cases[i].cleanup)
> +				test_cases[i].cleanup();
> +		}
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(int ac, char **av)
> +{
> +	char *msg;
> +	char write_buf[BUFSIZ];
> +	struct stat stat_buf;
> +
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	tst_tmpdir();
> +
> +	TEST_PAUSE;
> +
> +	if (strcpy(write_buf, "abcdefgh") != write_buf)
> +		tst_brkm(TBROK | TERRNO, NULL, "strcpy failed");

strcpy() does not fail.

> +	fd = SAFE_CREAT(cleanup, TEST_FILE, 0644);
> +
> +	SAFE_WRITE(cleanup, 1, fd, write_buf, strlen(write_buf));

Moreover you don't have to copy the string to the buffer to pass it
here. You can do:

#define STR "abcdefgh"

SAFE_WRITE(cleanup, 1, fd, STR, sizeof(STR) - 1);

> +	if (fstat(fd, &stat_buf) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "fstat of %s failed", TEST_FILE);
> +	}
> +	file_size = stat_buf.st_size;
> +
> +	SAFE_CLOSE(cleanup, fd);
> +}
> +
> +static void setup_seekcur(void)
> +{
> +	/* reopen TEST_FILE and file offset will be 0 */
> +	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY);
> +
> +	/* after read, file offset will be 4 */
> +	SAFE_READ(cleanup, 1, fd, read_buf, 4);
> +}
> +
> +static void testfunc_seekcur(void)
> +{
> +	TEST(lseek64(fd, (loff_t) 1, SEEK_CUR));
> +
> +	if (TEST_RETURN == (loff_t) -1) {
> +		tst_resm(TFAIL | TTERRNO, "llseek failed on %s ", TEST_FILE);
> +		return;
> +	}
> +
> +	if (TEST_RETURN != 5) {
> +		tst_resm(TFAIL, "llseek return a incorrect file offset");
> +		return;
> +	}
> +
> +	memset(read_buf, 0, sizeof(read_buf));
> +
> +	/* the expected characters are "fgh" */
> +	SAFE_READ(cleanup, 1, fd, read_buf, 3);
> +
> +	if (strcmp(read_buf, "fgh"))
> +		tst_resm(TFAIL, "test SEEK_SET for llseek failed");

This message should bettter describe what has happened.

"Read wrong bytes after llseek"

> +	else
> +		tst_resm(TPASS, "test SEEK_SET for llseek success");
> +}
> +
> +static void cleanup_seekcur(void)
> +{
> +	SAFE_CLOSE(cleanup, fd);
> +}
> +
> +static void setup_seekend(void)
> +{
> +	/* reopen TEST_FILE and file offset will be 0 */
> +	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY);
> +}
> +
> +static void testfunc_seekend(void)
> +{
> +	ssize_t nread;
> +
> +	TEST(lseek64(fd, (loff_t) 0, SEEK_END));
> +
> +	if (TEST_RETURN == (loff_t) -1) {
> +		tst_resm(TFAIL | TTERRNO, "llseek failed on %s ", TEST_FILE);
> +		return;
> +	}
> +
> +	if (TEST_RETURN != file_size) {
> +		tst_resm(TFAIL, "llseek return a incorrect file offset");
> +		return;
> +	}
> +
> +	memset(read_buf, 0, sizeof(read_buf));
> +
> +	nread = SAFE_READ(cleanup, 0, fd, read_buf, file_size);
> +	if (nread > 0)
> +		tst_resm(TFAIL, "test SEEK_END for llseek failed");

Here as well:

"Read bytes after llseek to end of file."

> +	else
> +		tst_resm(TPASS, "test SEEK_END for llseek success");
> +
> +}
> +static void cleanup_seekend(void)
> +{
> +	SAFE_CLOSE(cleanup, fd);
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +
> +	tst_rmdir();
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
