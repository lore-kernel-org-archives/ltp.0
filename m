Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PgDm2-0001OQ-7x
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 09:59:18 +0000
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PgDm1-00080M-6z
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 09:59:18 +0000
Received: by wwi18 with SMTP id 18so468699wwi.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Jan 2011 01:59:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <323415307.101341.1295603866637.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1435824546.101326.1295603761218.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<323415307.101341.1295603866637.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Fri, 21 Jan 2011 01:59:10 -0800
Message-ID: <AANLkTim08bh_cHvz6EzMR4FGwNnqns9SCYgAO++kdDaf@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Fri, Jan 21, 2011 at 1:57 AM, CAI Qian <caiqian@redhat.com> wrote:
> This is the correct patch attached.
>
> ----- Original Message -----
>> It can be difficult to predict if cpuset files have prefix or not,
>> so only to fail after checked both.

    Is there a requirement that documents this behavior?
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
