Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PgDqf-00064A-Nh
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 10:04:05 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PgDqe-00032g-Gh
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 10:04:05 +0000
Date: Fri, 21 Jan 2011 05:03:57 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <590037838.101398.1295604237018.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <AANLkTim08bh_cHvz6EzMR4FGwNnqns9SCYgAO++kdDaf@mail.gmail.com>
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


> Is there a requirement that documents this behavior?
Garrett, there is one in the kernel doc,
http://lxr.linux.no/#linux+v2.6.37/Documentation/cgroups/cpusets.txt

"Note that for legacy reasons, the "cpuset" filesystem exists as a
wrapper around the cgroup filesystem.

The command

mount -t cpuset X /dev/cpuset

is equivalent to

mount -t cgroup -ocpuset,noprefix X /dev/cpuset"

However, I found this is not always case. In addition, there is an
direct implementation without cgroup, and I can't find any doc about
the behaviours of the prefix.

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
