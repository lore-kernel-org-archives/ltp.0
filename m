Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U2hEL-0002As-QF
	for ltp-list@lists.sourceforge.net; Tue, 05 Feb 2013 12:02:29 +0000
Date: Tue, 5 Feb 2013 13:02:53 +0100
From: chrubis@suse.cz
Message-ID: <20130205120253.GD4130@rei>
References: <1360049585-6091-1-git-send-email-yanl.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1360049585-6091-1-git-send-email-yanl.fnst@cn.fujitsu.com>
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

Hi!
> The same issue as:
>     commit 352358cd9f69f6e8296cc201b14bae938287796e
>     Author: Jan Stancek <jstancek@redhat.com>
>     Date: Mon, 28 Jan 2013 11:36:48 +0100
>     aio_fsync/2-1.c: fix race at exit, check if write completed
> This patch waits for aio_fsync to complete and after that
> checks that previously queued write is also completed.
> 
> Signed-off-by: Yan Lei <yanl.fnst@cn.fujitsu.com>

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
