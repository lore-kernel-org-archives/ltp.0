Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RnwHK-0007Xe-4Y
	for ltp-list@lists.sourceforge.net; Thu, 19 Jan 2012 18:00:02 +0000
Date: Thu, 19 Jan 2012 19:12:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120119181208.GC4024@saboteur.suse.cz>
References: <1326358488-15419-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1326358488-15419-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH 1/2] syscalls/getxattr03: new testcase to test
 getxattr(2)
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
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Eryu Guan <guaneryu@gmail.com>

Hi!
> +#include "config.h"
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#ifdef HAVE_ATTR_XATTR_H
> +#include <attr/xattr.h>
> +#endif
> +#include "test.h"
> +#include "usctest.h"
> +
> +char *TCID = "getxattr03";
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +#define XATTR_TEST_KEY "user.testkey"
> +#define XATTR_TEST_VALUE "test value"
> +#define TESTFILE "getxattr03testfile"
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +int TST_TOTAL = 1;
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +
> +		TEST(getxattr(TESTFILE, XATTR_TEST_KEY, NULL, 0));
> +
> +		if (TEST_RETURN == strlen(XATTR_TEST_VALUE))

You could use sizeof(XATTR_TEST_VALUE) - 1, which would be computed at
compile time.

> +			tst_resm(TPASS, "getxattr(2) returned correct value");
> +		else
> +			tst_resm(TFAIL | TTERRNO, "getxattr(2) failed");
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	int fd;
> +
> +	tst_require_root(NULL);
> +
> +	tst_tmpdir();
> +
> +	/* Test for xattr support and set attr value */
> +	fd = creat(TESTFILE, 0644);
> +	if (fd == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Create %s failed", TESTFILE);
> +	close(fd);
> +
> +	if (setxattr(TESTFILE, XATTR_TEST_KEY, XATTR_TEST_VALUE,
> +	    strlen(XATTR_TEST_VALUE), XATTR_CREATE) == -1) {

Here too.

> +		if (errno == ENOTSUP)
> +			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
> +			    "mount without user_xattr option");

Should rather say ... of fs mounted without ...

> +		else
> +			tst_brkm(TBROK | TERRNO, cleanup, "setxattr %s failed",
> +			    TESTFILE);
> +	}
> +
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +	tst_rmdir();
> +}
> +#else /* HAVE_ATTR_XATTR_H */
> +int main(int argc, char *argv[])
> +{
> +	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
> +}
> +#endif

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
