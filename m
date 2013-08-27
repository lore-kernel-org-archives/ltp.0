Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VEIkE-0001p9-3W
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 12:51:38 +0000
Date: Tue, 27 Aug 2013 14:51:44 +0200
From: chrubis@suse.cz
Message-ID: <20130827125144.GI10995@rei.Home>
References: <521C4688.9020305@cn.fujitsu.com> <521C46FB.7020308@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <521C46FB.7020308@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2 v2] quotactl/quotactl02.c: create a case to
 test basic flags of quotactl(2)
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
> +/*
> + * func_qoff() - check the functionality of the Q_XQUOTAOFF flag of quotactl
> + */

These type of comments is not usefull at all. Just name the function so
that it's clear what it does, for this one something like
check_qoff(void) would do.

> +static void func_qoff(void)
> +{
> +	int ret;
> +
> +	ret = ltp_syscall(__NR_quotactl, USRQCMD(Q_XGETQSTAT),
> +			  dev, uid, &qstat);
> +	if (ret != 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "fail to get quota stat");
> +
> +	if (qstat.qs_flags & XFS_QUOTA_UDQ_ENFD) {
> +		tst_resm(TFAIL, "enforcement is not off");
> +		return;
> +	}
> +
> +	tst_resm(TPASS, "enforcement is off");
> +}
> +
> +/*
> + * func_qon() - check the functionality of the Q_XQUOTAON flag of quotactl
> + */
> +static void func_qon(void)
> +{
> +	int ret;
> +	ret = ltp_syscall(__NR_quotactl, USRQCMD(Q_XGETQSTAT),
> +			  dev, uid, &qstat);
> +	if (ret != 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "fail to get quota stat");
> +
> +	if (!(qstat.qs_flags & XFS_QUOTA_UDQ_ENFD)) {
> +		tst_resm(TFAIL, "enforcement is off");
> +		return;
> +	}
> +
> +	tst_resm(TPASS, "enforcement is on");
> +}
> +
> +/*
> + * func_getq() - check the functionality of the Q_XGETQUOTA flag of quotactl
> + */
> +static void func_getq(void)
> +{
> +	if (!(dquota.d_flags & XFS_USER_QUOTA)) {
> +		tst_resm(TFAIL, "get incorrect quota type");
> +		return;
> +	}
> +
> +	tst_resm(TPASS, "get the right quota type");
> +}
> +
> +/*
> + * setup_setqlim() - set up for the Q_XSETQLIM flag of quotactl
> + */
> +static void setup_setqlim(void)
> +{
> +	dquota.d_rtb_hardlimit = RTBLIMIT;
> +	dquota.d_fieldmask = FS_DQ_LIMIT_MASK;
> +}

You don't need to have function to statically initialize a structure, I
would just initialized it statically and passed right pointer to the
testcase addr.

> +/*
> + * func_setqlim() - check the functionality of the Q_XSETQLIM flag of quotactl
> + */
> +static void func_setqlim(void)
> +{
> +	int ret;
> +	ret = ltp_syscall(__NR_quotactl, USRQCMD(Q_XGETQUOTA),
> +			  dev, uid, &dquota);
> +	if (ret != 0)
> +		tst_brkm(TFAIL | TERRNO, NULL,
> +			 "fail to get quota information");
> +
> +	if (dquota.d_rtb_hardlimit != RTBLIMIT) {
> +		tst_resm(TFAIL, "limit on RTB, except %lu get %lu",
> +			 (uint64_t)RTBLIMIT,
> +			 (uint64_t)dquota.d_rtb_hardlimit);
> +		return;
> +	}
> +
> +	tst_resm(TPASS, "quotactl works fine with Q_XSETQLIM");
> +}
> +
> +/*
> + * func_getqstat() - check the functionality of
> + * the Q_XGETQSTAT flag of quotactl
> + */
> +static void func_getqstat(void)
> +{
> +	if (qstat.qs_version != FS_QSTAT_VERSION) {
> +		tst_resm(TFAIL, "get incorrect qstat version");
> +		return;
> +	}
> +
> +	tst_resm(TPASS, "get correct qstat version");
> +}
> +
> +static void setup(void)
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

I think that copying block_dev to dev is pointless, I haven't seen a
single place where block_dev couldn't be used directly, or am I
mistaken?

> +	tst_mkfs(NULL, dev, "xfs", "-f");

I still think that the '-f' should go to the library instead. Or we can
zero start of the device (where the filesystem superblock and signatures
are, which should be first few bytes) before we call the mkfs.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
