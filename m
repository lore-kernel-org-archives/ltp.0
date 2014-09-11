Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XS1dU-000585-8O
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 10:29:56 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XS1dS-0003EU-SZ
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 10:29:56 +0000
Received: from zmail22.collab.prod.int.phx2.redhat.com
	(zmail22.collab.prod.int.phx2.redhat.com [10.5.83.26])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s8BATmnA005099
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Sep 2014 06:29:48 -0400
Date: Thu, 11 Sep 2014 06:29:48 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <1372444900.31208810.1410431388605.JavaMail.zimbra@redhat.com>
In-Reply-To: <762122239.31207691.1410431182505.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 0/3] fix old commit about skipping tests on NFS
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

Fix old commit 5387ba03ce8eaddc7ec330ed03e579eed92596cc
Skip only one block in fcntl14 instead of the whole case.
splice/tee/utime pass on NFS now, so update the obsolete
info.

Xiong Zhou (3):
  fcntl14: dup code clean up
  fcntl14: only skip test block2 on NFS
  splice01/tee01/utime: test back on NFS

 testcases/kernel/syscalls/fcntl/fcntl14.c   | 85 +++++++++++++----------------
 testcases/kernel/syscalls/splice/splice01.c |  5 --
 testcases/kernel/syscalls/tee/tee01.c       |  5 --
 testcases/kernel/syscalls/utime/utime01.c   |  1 -
 testcases/kernel/syscalls/utime/utime02.c   |  1 -
 testcases/kernel/syscalls/utime/utime03.c   |  1 -
 6 files changed, 38 insertions(+), 60 deletions(-)

-- 
1.8.3.1


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
