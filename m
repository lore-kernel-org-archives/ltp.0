Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PhzUT-0007rN-Ay
	for ltp-list@lists.sourceforge.net; Wed, 26 Jan 2011 07:08:29 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PhzUS-0007kK-Hs
	for ltp-list@lists.sourceforge.net; Wed, 26 Jan 2011 07:08:29 +0000
Date: Wed, 26 Jan 2011 02:08:21 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <986462626.158608.1296025701416.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1435824546.101326.1295603761218.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] check two possible pathes for cpuset
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Garrett, any objection to merge this?

----- Original Message -----
> It can be difficult to predict if cpuset files have prefix or not,
> so only to fail after checked both.
> 
> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
> testcases/kernel/mem/lib/mem.c | 20 ++++++++++++++++----
> 1 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/mem/lib/mem.c
> b/testcases/kernel/mem/lib/mem.c
> index 297eedd..72cf319 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -90,15 +90,27 @@ void write_cpusets(void)
> tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
> 
> fd = open(CPATH_NEW "/mems", O_WRONLY);
> - if (fd == -1)
> - tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> + if (fd == -1) {
> + if (errno == ENOENT) {
> + fd = open(CPATH_NEW "/cpuset.mems", O_WRONLY);
> + if (fd == -1)
> + tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> + } else
> + tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> + }
> if (write(fd, "1", 1) != 1)
> tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> close(fd);
> 
> fd = open(CPATH_NEW "/cpus", O_WRONLY);
> - if (fd == -1)
> - tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> + if (fd == -1) {
> + if (errno == ENOENT) {
> + fd = open(CPATH_NEW "/cpuset.cpus", O_WRONLY);
> + if (fd == -1)
> + tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> + } else
> + tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> + }
> if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
> tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> close(fd);
> --
> 1.7.3.2
> ------------------------------------------------------------------------------
> Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
> Finally, a world-class log management solution at an even better
> price-free!
> Download using promo code Free_Logger_4_Dev2Dev. Offer expires
> February 28th, so secure your free ArcSight Logger TODAY!
> http://p.sf.net/sfu/arcsight-sfd2d
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
