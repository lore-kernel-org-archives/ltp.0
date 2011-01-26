Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PhzrS-0001xh-Sq
	for ltp-list@lists.sourceforge.net; Wed, 26 Jan 2011 07:32:14 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PhzrQ-0001HV-G7
	for ltp-list@lists.sourceforge.net; Wed, 26 Jan 2011 07:32:14 +0000
Received: by wyb40 with SMTP id 40so633955wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 25 Jan 2011 23:32:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1803283961.139211.1295922164654.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1524114322.122004.1295852492822.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1803283961.139211.1295922164654.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 25 Jan 2011 23:32:04 -0800
Message-ID: <AANLkTinamb_Q0MnLp_VuKND=biy0Y168YxQNqNLf=5xS@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix the -I option and enable a larger numble to I
	option
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
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Jan 24, 2011 at 6:22 PM, Zhouping Liu <zliu@redhat.com> wrote:
> Hi,Garrett,
>
> could you please review the patch, and give me your comments.
> any suggestions are welcome.

    Wow, someone really lacked foresight when producing this API.
    Yes, there's a problem, but I disagree with your solution (in
particular because long long isn't necessarily going to remain 64-bit
in the future). I think that a fixed size type applied to all of these
affect areas would be better (uint64_t -- the POSIX defined unsigned
64-bit integer [1]).
Thanks,
-Garrett

1. http://www.opengroup.org/onlinepubs/000095399/basedefs/stdint.h.html

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
