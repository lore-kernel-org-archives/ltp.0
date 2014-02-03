Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WAKeA-0004vC-T2
	for ltp-list@lists.sourceforge.net; Mon, 03 Feb 2014 14:37:14 +0000
Date: Mon, 3 Feb 2014 15:36:43 +0100
From: chrubis@suse.cz
Message-ID: <20140203143643.GB3996@rei>
References: <1390298574-2966-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1390298574-2966-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1390298574-2966-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/3] fcntl/fcntl30.c: add F_SETPIPE_SZ,
 F_GETPIPE_SZ test for fcntl(2)
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
> +#include <stdio.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <sys/types.h>
> +#include <pwd.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +char *TCID = "fcntl30";
> +int TST_TOTAL = 1;
> +
> +#if defined(F_SETPIPE_SZ) && defined(F_GETPIPE_SZ)

The same here.

> +static void setup(void);
> +static void cleanup(void);
> +
> +static int pipe_fds[2];
> +static int test_fd;
> +static int orig_pipe_size;
> +static int new_pipe_size;
> +
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	char *msg;
> +
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		TEST(fcntl(test_fd, F_SETPIPE_SZ, new_pipe_size));
> +		if (TEST_RETURN < 0) {
> +			tst_brkm(TFAIL | TTERRNO, cleanup,
> +				 "fcntl test F_SETPIPE_SZ failed");
> +		}
> +
> +		TEST(fcntl(test_fd, F_GETPIPE_SZ));
> +		if (TEST_RETURN < 0) {
> +			tst_brkm(TFAIL | TTERRNO, cleanup,
> +				 "fcntl test F_GETPIPE_SZ failed");
> +		}
> +		tst_resm(TINFO, "orig_pipe_size: %d new_pipe_size: %d",
> +			 orig_pipe_size, new_pipe_size);
> +		if (TEST_RETURN >= new_pipe_size) {
> +			tst_resm(TPASS, "fcntl test F_GETPIPE_SZ"
> +				 "and F_SETPIPE_SZ success");
> +		} else {
> +			tst_resm(TFAIL, "fcntl test F_GETPIPE_SZ"
> +				 "and F_SETPIPE_SZ fail");
> +		}
> +
> +		/* restore the original pipe size*/
> +		TEST(fcntl(test_fd, F_SETPIPE_SZ, orig_pipe_size));
> +		if (TEST_RETURN < 0) {
> +			tst_brkm(TFAIL | TTERRNO, cleanup, "fcntl "
> +				 "restore orignal pipe size failed");

                There is a small logic error here. You say that the test
		has exactly one testcase but if we get here the test
		will print passed then failed which would indicate that
		there are two testcases.

		What I would do instead is to set the size to new pipe
		size on even iteration s and original pipe size on odd
		iterations.

> +		}
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	if ((tst_kvercmp(2, 6, 35)) < 0) {
> +		tst_brkm(TCONF, NULL, "This test can only run on kernels"
> +			 "that are 2.6.35 and higher");
> +	}
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	tst_tmpdir();
> +
> +	TEST_PAUSE;
> +
> +	SAFE_PIPE(cleanup, pipe_fds);
> +	test_fd = pipe_fds[1];
> +
> +	TEST(fcntl(test_fd, F_GETPIPE_SZ));
> +	if (TEST_RETURN < 0) {
> +		tst_brkm(TFAIL | TTERRNO, cleanup,
> +			 "fcntl get pipe size failed");
> +	}
> +
> +	orig_pipe_size = TEST_RETURN;
> +	new_pipe_size = orig_pipe_size * 2;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +
> +	if (pipe_fds[0] > 0)
> +		SAFE_CLOSE(NULL, pipe_fds[0]);
> +	if (pipe_fds[1] > 0)
> +		SAFE_CLOSE(NULL, pipe_fds[1]);
> +
> +	tst_rmdir();
> +}
> +#else
> +
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "This test can only run on kernels"
> +		 "that are 2.6.35 and higher");
> +}
> +#endif
> -- 
> 1.8.2.1
> 
> 
> ------------------------------------------------------------------------------
> CenturyLink Cloud: The Leader in Enterprise Cloud Services.
> Learn Why More Businesses Are Choosing CenturyLink Cloud For
> Critical Workloads, Development Environments & Everything In Between.
> Get a Quote or Start a Free Trial Today. 
> http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
