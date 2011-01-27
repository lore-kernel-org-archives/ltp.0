Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PiPYM-0008SR-1Y
	for ltp-list@lists.sourceforge.net; Thu, 27 Jan 2011 10:58:14 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.74) id 1PiPYK-00064k-Vy
	for ltp-list@lists.sourceforge.net; Thu, 27 Jan 2011 10:58:14 +0000
Received: by wyb40 with SMTP id 40so1892022wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 27 Jan 2011 02:58:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D414061.1060502@cn.fujitsu.com>
References: <4D414061.1060502@cn.fujitsu.com>
Date: Thu, 27 Jan 2011 02:58:06 -0800
Message-ID: <AANLkTikaLWGpzra+FhKHVxaP538Hm8s+VwNt8Bg3hLyA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] sched_getscheduler01.c: fix error of wrong return
	code
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

On Thu, Jan 27, 2011 at 1:52 AM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> "return -1" should be replaced with "tst_exit()".

Committed -- thanks!
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
