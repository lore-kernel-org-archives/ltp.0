Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jshao@redhat.com>) id 1Tnmfq-0003Bx-9N
	for ltp-list@lists.sourceforge.net; Wed, 26 Dec 2012 08:49:14 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tnmfp-0000eD-KX
	for ltp-list@lists.sourceforge.net; Wed, 26 Dec 2012 08:49:14 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qBQ8n6jX003728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Dec 2012 03:49:08 -0500
From: Monson Shao <jshao@redhat.com>
Date: Wed, 26 Dec 2012 16:48:36 +0800
Message-Id: <1356511717-31058-2-git-send-email-jshao@redhat.com>
In-Reply-To: <1356420393-4253-1-git-send-email-jshao@redhat.com>
References: <1356420393-4253-1-git-send-email-jshao@redhat.com>
Subject: [LTP] [PATCHv2 2/3] pidns16: modified test results
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

The test should result TFAIL if child is signalled from unexpected pid,
instead of TBROK. The same as TPASS/TINFO .

Signed-off-by: Monson Shao <jshao@redhat.com>
---
 testcases/kernel/containers/pidns/pidns16.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
index 04a1641..debc8d2 100644
--- a/testcases/kernel/containers/pidns/pidns16.c
+++ b/testcases/kernel/containers/pidns/pidns16.c
@@ -53,7 +53,7 @@
 #define PARENT_PID	0
 
 char *TCID = "pidns16";
-int TST_TOTAL = 1;
+int TST_TOTAL = 3;
 pid_t globalpid;
 
 /*
@@ -87,10 +87,10 @@ void child_signal_handler(int sig, siginfo_t * si, void *unused)
 	}
 
 	if (si->si_pid == expected_pid)
-		tst_resm(TINFO, "child is signalled from expected pid %d",
+		tst_resm(TPASS, "child is signalled from expected pid %d",
 			 expected_pid);
 	else
-		tst_resm(TBROK, "child is signalled from unexpected pid %d,"
+		tst_resm(TFAIL, "child is signalled from unexpected pid %d,"
 			 " expecting pid %d", si->si_pid, expected_pid);
 
 	c++;
-- 
1.7.11.7


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
