Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YuJbC-0007ZJ-Ee
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2015 11:52:46 +0000
Date: Mon, 18 May 2015 13:52:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150518115203.GE4104@rei>
References: <20150504063425.GA9995@localhost.localdomain>
	<20150504115324.GB7674@rei.suse.de>
	<20150506135504.GC2752@localhost.localdomain>
	<5551F71E.7090400@huawei.com> <20150512134858.GA11906@rei.suse.de>
	<55530742.3030707@huawei.com> <20150513090359.GB3409@rei.suse.de>
	<5555A746.4080006@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5555A746.4080006@huawei.com>
Subject: Re: [LTP] [PATCH] open/open12: Check the kernel version for
 'MS_STRICTATIME'
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net, zhuyanpeng@huawei.com, zhanyongming@huawei.com

Hi!
> > This is not right place to do it. The flag is used only when we need to
> > mount the loop device so the check should be done only if we are about
> > to acquire the device. And we should set the skip_noatime flag there as
> > well.
> > 
> Your opinion is to add the check after `if (tst_path_has_mnt_flags(cleanup, NULL, mount_flags))`
> and then set the skip_noatime flag to 1 ?

Yes, because there is no need to skip the test if we are not even going
to mount the loop device.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
