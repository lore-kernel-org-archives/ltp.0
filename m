Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WLt7j-0007ET-GH
	for ltp-list@lists.sourceforge.net; Fri, 07 Mar 2014 11:39:31 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WLt7i-0005ja-7m
	for ltp-list@lists.sourceforge.net; Fri, 07 Mar 2014 11:39:31 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s27BdN8b008033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Mar 2014 06:39:23 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s27BdMtu019923
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Mar 2014 06:39:22 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  7 Mar 2014 12:39:23 +0100
Message-Id: <cover.1394190599.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 0/2] do not pick free/unused port by chance
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

I'm rarely seeing tests like bind01, connect01, recv01,
recvfrom01, recvmsg01, send01, sendfile0X, sendmsg01
and sendto01 failing. All these are picking ports with
formula: (getpid() % 32768) + 11000, which occasionally
collides with test harness (beah) used in automated environment,
which is running on ports 12432/12434.

This series removes that formula and lets kernel pick random
free unused port instead. If test has no intention of binding
any server on that port, but still needs some unused port number
it can use newly added tst_get_unused_port() function.

Jan Stancek (2):
  add tst_get_unused_port()
  do not pick free/unused port by chance

 include/test.h                                  |    7 ++
 lib/tst_net.c                                   |   81 +++++++++++++++++++++++
 testcases/kernel/syscalls/bind/bind01.c         |    2 +-
 testcases/kernel/syscalls/connect/connect01.c   |   17 +++--
 testcases/kernel/syscalls/recv/recv01.c         |   15 +++--
 testcases/kernel/syscalls/recvfrom/recvfrom01.c |   15 +++--
 testcases/kernel/syscalls/recvmsg/recvmsg01.c   |   12 ++-
 testcases/kernel/syscalls/send/send01.c         |   15 +++--
 testcases/kernel/syscalls/sendfile/sendfile02.c |    6 ++-
 testcases/kernel/syscalls/sendfile/sendfile04.c |    6 ++-
 testcases/kernel/syscalls/sendfile/sendfile05.c |    6 ++-
 testcases/kernel/syscalls/sendfile/sendfile06.c |    6 ++-
 testcases/kernel/syscalls/sendmsg/sendmsg01.c   |   17 +++--
 testcases/kernel/syscalls/sendto/sendto01.c     |   15 +++--
 14 files changed, 173 insertions(+), 47 deletions(-)
 create mode 100644 lib/tst_net.c


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
