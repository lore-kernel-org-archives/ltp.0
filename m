Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UzQj6-00063T-KB
	for ltp-list@lists.sourceforge.net; Wed, 17 Jul 2013 12:21:00 +0000
Date: Wed, 17 Jul 2013 14:22:44 +0200
From: chrubis@suse.cz
Message-ID: <20130717122244.GC25145@rei>
References: <51E6272B.3020509@cn.fujitsu.com> <51E628D6.4030002@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51E628D6.4030002@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] quotactl/quotactl02.c: create a case to test
 basic flags of quotactl(2)
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif

That ifndef shouldn't be needed unless somebody has defined _GNU_SOURCE
on the compiler command line, which we do not.

> +#include "config.h"
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <sys/mount.h>
> +#include <linux/fs.h>
> +#include <sys/types.h>

The config.h should be after the system includes.

> +#if defined(HAVE_XFS_QUOTA)
> +#include <xfs/xqm.h>
> +#else
> +#define BROKEN_XFS_QUOTA 1
> +#endif
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "linux_syscall_numbers.h"
> +#include "safe_macros.h"
> +
> +#define USRQCMD(cmd)	((cmd) << 8)
> +#define RTBLIMIT	2000
> +
> +char *TCID = "quotactl02";
> +int TST_TOTAL = 5;
> +
> +#ifndef BROKEN_XFS_QUOTA
> +static void func_test(int i);
> +static void setup(void);
> +static void cleanup(void);
> +static void help(void);
> +
> +static int dflag;
> +static int uid = -1;
> +static char dev[PATH_MAX];
> +static char *block_dev;
> +static struct fs_disk_quota dquota;
> +static struct fs_quota_stat qstat;
> +static unsigned int qflag = XFS_QUOTA_UDQ_ENFD;
> +static const char mntpoint[] = "mnt_point";
> +
> +static option_t options[] = {
> +	{"D:", &dflag, &block_dev},
> +	{NULL, NULL, NULL},
> +};
> +
> +static struct test_case_t {
> +	int cmd;
> +	const char *dev;
> +	int *id;
> +	void *addr;
> +} TC[] = {
> +	{Q_XQUOTAOFF, dev, &uid, &qflag},
> +	{Q_XQUOTAON, dev, &uid, &qflag},
> +	{Q_XGETQUOTA, dev, &uid, &dquota},
> +	{Q_XSETQLIM, dev, &uid, &dquota},
> +	{Q_XGETQSTAT, dev, &uid, &qstat},
> +};

It seems pointless to pass pointers to global variables via the
test_case_t structure.

> +int main(int argc, char *argv[])
> +{
> +	int i;
> +	int lc;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, options, &help);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	if (!dflag)
> +		tst_brkm(TBROK, NULL,
> +			 "you must specify the device used for mounting with "
> +			 "the -D option");
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++) {
> +
> +			TEST(ltp_syscall(__NR_quotactl,
> +					 USRQCMD(TC[i].cmd), TC[i].dev,
> +					 *TC[i].id, TC[i].addr));
> +
> +			if (TEST_RETURN != 0)
> +				tst_resm(TFAIL | TERRNO,
> +					 "cmd=0x%x failed", TC[i].cmd);
> +
> +			if (STD_FUNCTIONAL_TEST)
> +				func_test(i);
> +			else
> +				tst_resm(TPASS,
> +					 "quotactl call succeeded");
> +
> +		}
> +	}
> +
> +	cleanup();
> +
> +	tst_exit();
> +
> +}


> +void func_test(int i)
> +{
> +	int ret;
> +
> +	switch (i) {
> +	case 0:
> +		/* Validate Q_XQUOTAOFF flag of quotactl call */
> +		ret = ltp_syscall(__NR_quotactl, USRQCMD(Q_XGETQSTAT),
> +				  TC[i].dev, *TC[i].id, &qstat);
> +		if (ret != 0)
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "fail to get quota stat");
> +
> +		if (qstat.qs_flags & XFS_QUOTA_UDQ_ENFD) {
> +			tst_resm(TFAIL, "enforcement is not off");
> +			return;
> +		}
> +
> +		tst_resm(TPASS, "enforcement is off");
> +		break;
> +
> +	case 1:
> +		/* Validate Q_XQUOTAON flag of quotactl call */
> +		ret = ltp_syscall(__NR_quotactl, USRQCMD(Q_XGETQSTAT),
> +				  TC[i].dev, *TC[i].id, &qstat);
> +		if (ret != 0)
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "fail to get quota stat");
> +
> +		if (!(qstat.qs_flags & XFS_QUOTA_UDQ_ENFD)) {
> +			tst_resm(TFAIL, "enforcement is off");
> +			return;
> +		}
> +
> +		tst_resm(TPASS, "enforcement is on");
> +		break;
> +
> +	case 2:
> +		/* Validate Q_XGETQUOTA flag of quotactl call */
> +		if (!(dquota.d_flags & XFS_USER_QUOTA)) {
> +			tst_resm(TFAIL, "get incorrect quota type");
> +			return;
> +		}
> +
> +		/* for case3 */
> +		dquota.d_rtb_hardlimit = RTBLIMIT;
> +		dquota.d_fieldmask = FS_DQ_LIMIT_MASK;
> +
> +		tst_resm(TPASS, "get the right quota type");
> +		break;
> +
> +	case 3:
> +		/* Validate Q_XSETQLIM flag of quotactl call */
> +		ret = ltp_syscall(__NR_quotactl, USRQCMD(Q_XGETQUOTA),
> +				  TC[i].dev, *TC[i].id, &dquota);
> +		if (ret != 0)
> +			tst_brkm(TFAIL | TERRNO, NULL,
> +				 "fail to get quota information");
> +
> +		if (dquota.d_rtb_hardlimit != RTBLIMIT) {
> +			tst_resm(TFAIL, "limit on RTB, except %lu get %lu",
> +				 (uint64_t)RTBLIMIT,
> +				 (uint64_t)dquota.d_rtb_hardlimit);
> +			return;
> +		}
> +
> +		tst_resm(TPASS, "quotactl works fine with Q_XSETQLIM");
> +		break;
> +
> +	case 4:
> +		/* Validate Q_XGETQSTAT flag of quotactl call */
> +		if (qstat.qs_version != FS_QSTAT_VERSION) {
> +			tst_resm(TFAIL, "get incorrect qstat version");
> +			return;
> +		}
> +
> +		tst_resm(TPASS, "get correct qstat version");
> +		break;
> +
> +	default:
> +		tst_brkm(TBROK, cleanup, "Got unexpected index");
> +	}
> +
> +}

I do not like this one-function-for-all switch(). I would rather see
function pointer to a particual check function in the test_case_t
structure.

> +void setup()

Missing static and void

> +{
> +
> +	tst_require_root(NULL);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	SAFE_MKDIR(cleanup, mntpoint, 0755);
> +
> +	uid = 0;
> +	strncpy(dev, block_dev, PATH_MAX);

Why copying the block_dev to dev when you can use block_dev directly?

> +	if (mount(dev, mntpoint, "xfs", 0, "uquota") < 0)
> +		tst_brkm(TFAIL | TERRNO, NULL, "mount(2) fail");
> +
> +}
> +
> +void cleanup()
> +{

Here as well.

> +	if (umount(mntpoint) < 0)
> +		tst_resm(TFAIL | TERRNO, "umount(2) fail");
> +
> +	TEST_CLEANUP;
> +	tst_rmdir();
> +}
> +
> +void help(void)
> +{
> +	printf("-D device : device used for mounting.\n");
> +}
> +#else
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "This system doesn't support xfs quota");
> +}
> +#endif

I wonder where this #else and #endif starts, but maybe I've just lost
the opening #ifdef. Ah found it it's the #ifndef BROKEN_XFS_QUOTA.

Now it would be better to have it organized as:

#if defined(HAVE_XFS_QUOTA)
# include <xfs/xqm.h>
#endif

#include "test.h"

...

#if defined(HAVE_XFS_QUOTA)


...


#else


#endif


As there is no need to define new symbol that is just an alias.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
