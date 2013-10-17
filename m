Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jshao@redhat.com>) id 1VWjsd-0002It-Bl
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 09:28:31 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VWjsc-0000Mr-BK
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 09:28:31 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9H9SOYU016370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Oct 2013 05:28:24 -0400
From: Monson Shao <jshao@redhat.com>
Date: Thu, 17 Oct 2013 17:26:45 +0800
Message-Id: <1382002005-15348-1-git-send-email-jshao@redhat.com>
Subject: [LTP] [PATCH] setns: add ns_name in TINFO
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

Make it clear which namespace is enabled and being tested.

before:
setns01     0  TINFO  :  ns_fds[0]=5, ns_types[0]=0x8000000
setns01     0  TINFO  :  ns_fds[1]=6, ns_types[1]=0x20000
setns01     0  TINFO  :  ns_fds[2]=7, ns_types[2]=0x40000000
setns01     0  TINFO  :  ns_fds[3]=8, ns_types[3]=0x20000000
setns01     0  TINFO  :  ns_fds[4]=9, ns_types[4]=0x4000000

after:
setns01     0  TINFO  :  ns_name=ipc, ns_fds[0]=5, ns_types[0]=0x8000000
setns01     0  TINFO  :  ns_name=mnt, ns_fds[1]=6, ns_types[1]=0x20000
setns01     0  TINFO  :  ns_name=net, ns_fds[2]=7, ns_types[2]=0x40000000
setns01     0  TINFO  :  ns_name=pid, ns_fds[3]=8, ns_types[3]=0x20000000
setns01     0  TINFO  :  ns_name=uts, ns_fds[4]=9, ns_types[4]=0x4000000

Signed-off-by: Monson Shao <jshao@redhat.com>
---
 testcases/kernel/syscalls/setns/setns.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setns/setns.h b/testcases/kernel/syscalls/setns/setns.h
index 23bdb2e..a05e673 100644
--- a/testcases/kernel/syscalls/setns/setns.h
+++ b/testcases/kernel/syscalls/setns/setns.h
@@ -53,8 +53,8 @@ static void init_ns_type(int clone_type, const char *proc_name)
 	if (fd != -1) {
 		ns_types[ns_total] = clone_type;
 		ns_fds[ns_total] = fd;
-		tst_resm(TINFO, "ns_fds[%d]=%d, ns_types[%d]=0x%x", ns_total,
-			fd, ns_total, clone_type);
+		tst_resm(TINFO, "ns_name=%s, ns_fds[%d]=%d, ns_types[%d]=0x%x",
+			 proc_name, ns_total, fd, ns_total, clone_type);
 		ns_total++;
 	}
 }
-- 
1.8.3.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
