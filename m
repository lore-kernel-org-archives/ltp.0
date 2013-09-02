Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VGVZT-0007ar-9L
	for ltp-list@lists.sourceforge.net; Mon, 02 Sep 2013 14:57:39 +0000
Date: Mon, 2 Sep 2013 16:57:49 +0200
From: chrubis@suse.cz
Message-ID: <20130902145749.GB26252@rei>
References: <521C4688.9020305@cn.fujitsu.com> <521EB988.7000407@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <521EB988.7000407@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2 v3] quotactl/quotactl02.c: create a case to
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
Cc: ltp-list@lists.sourceforge.net

Hi!
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

One last nit. What is the point of setting uid to -1 first and then
changing it here to 0? Can't we just set it to 0 from the start?

> +	tst_mkfs(NULL, block_dev, "xfs", NULL);
> +
> +	if (mount(block_dev, mntpoint, "xfs", 0, "uquota") < 0)
> +		tst_brkm(TFAIL | TERRNO, NULL, "mount(2) fail");
> +
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
