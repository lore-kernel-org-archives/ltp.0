From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 May 2017 15:02:17 +0200
Subject: [LTP] [PATCH v2 2/2] controllers/memcg_test_3: Add new
 regression test
In-Reply-To: <1494328891-15634-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <5911A4B9.5070408@cn.fujitsu.com>
 <1494328891-15634-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170530130217.GA25921@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * This is a regression test for a crash caused by memcg function
> + * reentrant on RHEL6.  When doing rmdir(), a pending signal can
> + * interrupt the execution and lead to cgroup_clear_css_refs()
> + * being entered repeatedly, this results in a BUG_ON().
> + *
> + * This bug was introduced by following RHEL6 patch on 2.6.32-488.el6:
> + *
> + *  [mm] memcg: fix race condition between memcg teardown and swapin
> + *  Bugzilla: 1001197

Can you rather add a link here instead? Just "Bugzilla:" is too vague.

> + * This test can crash the buggy kernel on RHEL6.6GA, and the bug
> + * was fixed by following patch on 2.6.32-536.el6:
> + *
> + *  [mm] memcg: fix crash in re-entrant cgroup_clear_css_refs()
> + *  Bugzilla: 1168185
> + */
> +
> +#include <errno.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include "tst_test.h"
> +
> +#define MNTPOINT	"memcg"
> +#define SUBDIR	"memcg/testdir"
> +
> +static int mount_flag;
> +
> +static struct tst_kern_exv kvers[] = {
> +	{"RHEL6", "2.6.32-488"},
> +	{NULL, NULL}
> +};
> +
> +static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
> +{
> +
> +}
> +
> +static void do_child(void)
> +{
> +	while (1)
> +		SAFE_KILL(getppid(), SIGUSR1);
> +
> +	exit(0);
> +}
> +
> +static void do_test(void)
> +{
> +	int i;
> +	pid_t cpid = -1;
> +
> +	SAFE_SIGNAL(SIGUSR1, sighandler);
> +
> +	cpid = SAFE_FORK();
> +	if (cpid == 0)
> +		do_child();

Shouldn't we wait here untill the child is actually running?

I think that with just 10 iteration in the code below we may as well
finish the loop too fast.

So what about incrementing a counter in the signal handler and loop
until it reaches some small value (50 or something)?

> +	for (i = 0; i < 10; i++) {
> +		if (access(SUBDIR, F_OK))
> +			SAFE_MKDIR(SUBDIR, 0644);
> +		rmdir(SUBDIR);
> +	}
> +
> +	SAFE_KILL(cpid, SIGKILL);
> +	SAFE_WAIT(NULL);
> +
> +	tst_res(TPASS, "Bug not reproduced");
> +}
> +
> +static void setup(void)
> +{
> +	struct utsname buf;
> +
> +	SAFE_UNAME(&buf);
> +	if (!strstr(buf.release, ".el6"))
> +		tst_brk(TCONF, "This test can only run on RHEL6");
> +
> +	if (tst_kvercmp2(2, 6, 24, kvers) < 0)
> +		tst_brk(TCONF, "This test requires kernel >= 2.6.32-488.el6");

Why do we skip this test on anything but RHEL6? It does not seem to me
that the test actually does something that couldn't be tested on any
other Linux distribution. We only have to check for memcg support here
instead.

> +	SAFE_MKDIR(MNTPOINT, 0644);
> +
> +	SAFE_MOUNT("memcg", MNTPOINT, "cgroup", 0, "memory");
> +	mount_flag = 1;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (!access(SUBDIR, F_OK))
> +		SAFE_RMDIR(SUBDIR);
> +
> +	if (mount_flag)
> +		tst_umount(MNTPOINT);
> +}
> +
> +static struct tst_test test = {
> +	.tid = "memcg_test_3",
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = do_test,
> +};
> -- 
> 1.8.4.2
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
