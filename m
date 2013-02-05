Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1U2ga2-0007j3-DI
	for ltp-list@lists.sourceforge.net; Tue, 05 Feb 2013 11:20:50 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U2ga1-0000hy-6C
	for ltp-list@lists.sourceforge.net; Tue, 05 Feb 2013 11:20:50 +0000
Date: Tue, 5 Feb 2013 05:52:03 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1211467206.206361.1360061523796.JavaMail.root@redhat.com>
In-Reply-To: <1360049585-6091-1-git-send-email-yanl.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] fix race at exit by checking if write completed
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
To: Yan Lei <yanl.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Yan Lei" <yanl.fnst@cn.fujitsu.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "Yan Lei" <yanl.fnst@cn.fujitsu.com>
> Sent: Tuesday, 5 February, 2013 8:33:05 AM
> Subject: [LTP] [PATCH] fix race at exit by checking if write completed
> 
> The same issue as:
>     commit 352358cd9f69f6e8296cc201b14bae938287796e
>     Author: Jan Stancek <jstancek@redhat.com>
>     Date: Mon, 28 Jan 2013 11:36:48 +0100
>     aio_fsync/2-1.c: fix race at exit, check if write completed
> This patch waits for aio_fsync to complete and after that
> checks that previously queued write is also completed.
> 
> Signed-off-by: Yan Lei <yanl.fnst@cn.fujitsu.com>

I wonder why I missed that. Definitely same issue as in 2-1.

Acked-by: Jan Stancek <jstancek@redhat.com>

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
