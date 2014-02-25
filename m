Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WIKCx-0003fg-6L
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 15:46:11 +0000
Date: Tue, 25 Feb 2014 16:45:57 +0100
From: chrubis@suse.cz
Message-ID: <20140225154557.GB15595@rei>
References: <1385443532.14061.0.camel@G08JYZSD130126>
	<20131210131737.GA25334@rei>
	<1393326701.1952.59.camel@G08JYZSD130126>
	<1393326785.1952.61.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1393326785.1952.61.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 2/2] fchownat/fchownat02.c: add a new test
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
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <error.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <signal.h>
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +#include "fchownat.h"

I've added AT_SYMLINK_NOFOLLOW to lapi/fcntl.h, please include it here.

> +#define TESTFILE	"testfile"
> +#define TESTFILE_LINK	"testfile_link"
> +
> +char *TCID = "fchownat02";
> +int TST_TOTAL = 1;
> +
> +static int dirfd;
> +static uid_t set_uid = 1000;
> +static gid_t set_gid = 1000;
> +static void setup(void);
> +static void cleanup(void);
> +static void test_verify(void);
> +static void fchownat_verify(void);
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	char *msg;
> +	int i;
> +
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +		for (i = 0; i < TST_TOTAL; i++)
> +			fchownat_verify();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	struct stat c_buf, l_buf;
> +
> +	if ((tst_kvercmp(2, 6, 16)) < 0)
> +		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.16 or newer");
> +
> +	tst_require_root(NULL);
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	dirfd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
> +
> +	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
> +
> +	SAFE_SYMLINK(cleanup, TESTFILE, TESTFILE_LINK);
> +
> +	if (stat(TESTFILE_LINK, &c_buf) < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "stat() failed unexpected");
> +	if (lstat(TESTFILE_LINK, &l_buf) < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "lstat() failed unexpected");

I've added SAFE_STAT() and SAFE_LSTAT() to safe_macros.h please use them
here.

> +	if (l_buf.st_uid == set_uid || l_buf.st_gid == set_gid) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "link_uid(%d) == set_uid(%d) or link_gid(%d) == "
> +			 "set_gid(%d)", l_buf.st_uid, set_uid, l_buf.st_gid,
> +			 set_gid);
> +	}
> +}
> +
> +static void fchownat_verify(void)
> +{
> +	TEST(fchownat(dirfd, TESTFILE_LINK, set_uid, set_gid,
> +		      AT_SYMLINK_NOFOLLOW));
> +
> +	if (TEST_ERRNO != 0) {
> +		tst_resm(TFAIL | TTERRNO, "fchownat() Failed, errno=%d : %s",
> +			 TEST_ERRNO, strerror(TEST_ERRNO));
> +	} else {
> +		test_verify();
> +	}
> +}
> +
> +static void test_verify(void)
> +{
> +	struct stat c_buf, l_buf;
> +
> +	stat(TESTFILE_LINK, &c_buf);
> +	lstat(TESTFILE_LINK, &l_buf);

Safe macros here as well.

> +	if (c_buf.st_uid != set_uid && l_buf.st_uid == set_uid &&
> +	    c_buf.st_gid != set_gid && l_buf.st_gid == set_gid) {
> +		tst_resm(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");
> +	} else {
> +		tst_resm(TFAIL,
> +			 "fchownat() fail with uid: %d link_uid: %d set_uid: "
> +			 "%d | gid: %d link_gid: %d set_gid: %d", c_buf.st_uid,
> +			 l_buf.st_uid, set_uid, c_buf.st_gid, l_buf.st_gid,
> +			 set_gid);
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +
> +	TEST_CLEANUP;
> +}

Otherwise it's fine, but needs to be applied over the first patch.
(If that wasn't the case I would have fixed the minor issues and pushed
 it allready)

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
