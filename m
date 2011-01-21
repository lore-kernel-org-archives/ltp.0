Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PgCan-00006W-3P
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 08:43:37 +0000
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PgCam-0001J9-1Y
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 08:43:37 +0000
Received: by wwi18 with SMTP id 18so406528wwi.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Jan 2011 00:43:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D39456D.4040308@cn.fujitsu.com>
References: <4D39456D.4040308@cn.fujitsu.com>
Date: Fri, 21 Jan 2011 00:43:29 -0800
Message-ID: <AANLkTik7Zp+LZ8VcMGZMoHtdhcdKHkiqEOCN7s-nbE0c@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix error of wrong return code in cases
 rt_sigsuspend01, sched_getaffinity01, ftest06, sem02 and hugemmap03
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Jan 21, 2011 at 12:35 AM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> "return 1" should be replaced with "tst_exit()" in the following cases.

    Patch please?
Thanks,
-Garrett

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
