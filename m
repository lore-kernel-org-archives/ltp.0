Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PilCO-0003rC-Ne
	for ltp-list@lists.sourceforge.net; Fri, 28 Jan 2011 10:05:00 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.74) id 1PilCN-0001v2-HT
	for ltp-list@lists.sourceforge.net; Fri, 28 Jan 2011 10:05:00 +0000
Received: by wwi18 with SMTP id 18so2943902wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 28 Jan 2011 02:04:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D4266E2.9070001@cn.fujitsu.com>
References: <4D4266E2.9070001@cn.fujitsu.com>
Date: Fri, 28 Jan 2011 02:04:53 -0800
Message-ID: <AANLkTinTGN5CVhk4kVCrbYZm5za-Fv5EOzd2dRaHO-ES@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] sigrelse01.c: cleanup() should be called only once
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

On Thu, Jan 27, 2011 at 10:49 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> cleanup() call the function tst_rmdir() to remove the temporary
> directory, so cleanup() should be called only once.

    I did some style cleanup, but I'm concerned that the signal
handler code setup might not function as expected because it used to
build off of choose_sig. Please verify whether or not things work for
you now.
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
