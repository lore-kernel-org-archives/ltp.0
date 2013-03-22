Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UJ37k-0001nU-JZ
	for ltp-list@lists.sourceforge.net; Fri, 22 Mar 2013 14:39:16 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UJ37f-0006GU-Kd
	for ltp-list@lists.sourceforge.net; Fri, 22 Mar 2013 14:39:16 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r2MEd5P3007714
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Mar 2013 10:39:05 -0400
Date: Fri, 22 Mar 2013 10:39:05 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <625873548.22757137.1363963145611.JavaMail.root@redhat.com>
In-Reply-To: <e7c2f015e6e46d1eb1aad28001b8794fe7a91a44.1363949441.git.jstancek@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] sched_stress: fix matrix inversion routine
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
To: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 22 March, 2013 11:58:12 AM
> Subject: [LTP] [PATCH] sched_stress: fix matrix inversion routine
> 
> Fix code to not go out of bounds of "matrix_1" array
> and to do what it's supposed to - calculate inversion matrix.
> 

Just to close the loop, this has been committed.

Regards,
Jan

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
