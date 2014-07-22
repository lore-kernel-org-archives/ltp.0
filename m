Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X9dKy-0006xd-5F
	for ltp-list@lists.sourceforge.net; Tue, 22 Jul 2014 16:54:48 +0000
Date: Tue, 22 Jul 2014 18:54:06 +0200
From: chrubis@suse.cz
Message-ID: <20140722165406.GA10128@rei>
References: <1347769361.12788938.1405948971664.JavaMail.zimbra@redhat.com>
	<1405955978-28590-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1405955978-28590-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH v2] containers: added pidns/pidns03.c
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +#define _GNU_SOURCE
> +#include <sys/wait.h>
> +#include <sys/mount.h>
> +#include <sys/types.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include "usctest.h"
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "libclone.h"
> +
> +
> +#define PROCDIR "proc2"

This is very minor, but we don't have to name it "proc2" now because we
create it in the newly created test temporary directory, so why not just
"proc" now?

> +char *TCID	= "pidns03";
> +int TST_TOTAL	= 1;
> +
> +
> +static void cleanup(void)
> +{
> +	umount(PROCDIR);
> +	rmdir(PROCDIR);

You don't have to remove any files/directories under the test temporary
directory, these are deleted automatically in tst_rmdir().

> +	tst_rmdir();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	tst_tmpdir();
> +	SAFE_MKDIR(cleanup, PROCDIR, 0555);
> +}
> +
> +int childFunc(void *arg)

In LKML coding style (which LTP follows), mixed case is frowned upon.

You can use checkpatch.pl (from scripts from linux kernel sources) to
check you patch before sending it to the ML.

> +{
> +	char buf[10];
> +	int result = 1;
> +
> +	if (mount("none", PROCDIR, "proc", MS_RDONLY, NULL) == -1) {
> +		perror("mount");
> +		return 1;
> +	}
> +
> +	if (readlink(PROCDIR"/self", buf, sizeof(buf)) == -1) {
> +		perror("readlink");
> +		return 1;
> +	}
> +
> +
> +	/* child should have PID 1 in a new pid namespace - if true
> +	 * procfs belongs to the new pid namespace */
> +	if (!strcmp(buf, "1"))
> +		result = 0;
> +	else
> +		fprintf(stderr, "%s contains: %s\n", PROCDIR"/self", buf);
> +
> +	return result;
> +}
> +
> +static void test(void)
> +{
> +	int status;
> +	int ret;
> +
> +	ret = do_clone_tests(CLONE_NEWPID, childFunc, NULL, NULL, NULL);
> +
> +	if (ret == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
> +	else if ((wait(&status)) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "wait failed");
> +
> +	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> +		tst_resm(TFAIL, "mounting procfs in a new namespace");
> +	else if (WIFSIGNALED(status))
> +		tst_resm(TFAIL, "child was killed with signal = %d",
> +			 WTERMSIG(status));
                         ^
			 We have tst_strsig() so that you can print
			 human readable signal name instead of the
			 number.

> +	else
> +		tst_resm(TPASS, "mounting procfs in a new namespace");

I would do:

	if (foo) {
		tst_resm(...);
		return;
	}

	if (bar) {
		tst_resm(...);
		return;
	}

	tst_resm(...);


rather than the if else if ... maze.

Also the tst_brkm() exits the test execution (does not return) so the
first else is redundand.

And we also have SAFE_WAIT() in include/safe_macros.h so you can do
just:

SAFE_WAIT(cleanup, &status);

instead of the two if (...) tst_brkm(...);

(Safe macros and library functions are documented in Test Writing Guidelines at
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
