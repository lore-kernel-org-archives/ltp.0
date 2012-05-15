Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SUFKu-0007RU-Av
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 10:50:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SUFKq-0005x4-CT
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 10:50:36 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4FAoQYc017568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 15 May 2012 06:50:26 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Tue, 15 May 2012 18:47:37 +0800
Message-Id: <1337078857-6487-1-git-send-email-zliu@redhat.com>
Subject: [LTP] [PATCH] mm: fixed nodemask args in set_mempolicy()
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
To: LTP List <ltp-list@lists.sourceforge.net>

inside oom0[2|4], ksm0[2|4] cases, they are running under
numa system, and allocte memory in the second numa node,
set nodemask 2, which indicates all memory allocated in
node1, but when a numa system don't have node1, these cases
will failed, such like the box, available nodes: (0,2,4,7)

 [root@hp-magnycours-01 oom]# ./oom02
 oom02       0  TINFO  :  set overcommit_memory to 1
 oom02       0  TINFO  :  process mempolicy.
 oom02       0  TINFO  :  start normal OOM testing.
 oom02       0  TINFO  :  expected victim is 9112.
 oom02       1  TBROK  :  set_mempolicy: errno=EINVAL(22): Invalid argument
 oom02       2  TBROK  :  Remaining cases broken
 oom02       0  TINFO  :  set overcommit_memory to 0
 oom02       1  TFAIL  :  the victim unexpectedly failed: 512
 oom02       0  TINFO  :  start OOM testing for mlocked pages.
 ...

the patch fixed the above issue.

Also inside cpuset01 case, depend on the reproducer, mem hog thread
allocated memory on *all* nodes, but 'nmask += exp2f(i);' can't
do that, and the patch fixed it.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/cpuset/cpuset01.c |    2 +-
 testcases/kernel/mem/ksm/ksm02.c       |    3 ++-
 testcases/kernel/mem/ksm/ksm04.c       |    3 ++-
 testcases/kernel/mem/lib/mem.c         |    5 ++++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 09159f2..b20485f 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -108,7 +108,7 @@ static void testcpuset(void)
 		tst_brkm(TBROK|TERRNO, cleanup, "fork");
 	case 0:
 		for (i = 0; i < nnodes; i++)
-			nmask += exp2f(i);
+			nmask += 1 << nodes[i];
 		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
 		exit(mem_hog_cpuset(ncpus > 1 ? ncpus : 1));
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 3bfcaa6..92f1493 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -87,7 +87,7 @@ int main(int argc, char *argv[])
 	int lc;
 	char *msg;
 	int size = 128, num = 3, unit = 1;
-	unsigned long nmask = 2;
+	unsigned long nmask = 0;
 	long nodes[MAXNODES];
 
 	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
@@ -103,6 +103,7 @@ int main(int argc, char *argv[])
 		Tst_count = 0;
 		check_ksm_options(&size, &num, &unit);
 
+		nmask = 1 << nodes[1];
 		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
 			if (errno != ENOSYS)
 				tst_brkm(TBROK|TERRNO, cleanup,
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 8bbf067..8a31051 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -87,7 +87,7 @@ int main(int argc, char *argv[])
 	int lc;
 	char *msg;
 	int size = 128, num = 3, unit = 1;
-	unsigned long nmask = 2;
+	unsigned long nmask = 0;
 	long nodes[MAXNODES];
 
 	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
@@ -105,6 +105,7 @@ int main(int argc, char *argv[])
 
 		write_memcg();
 
+		nmask = 1 << nodes[1];
 		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
 			if (errno != ENOSYS)
 				tst_brkm(TBROK|TERRNO, cleanup,
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 7289812..b031184 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -66,7 +66,8 @@ void oom(int testcase, int mempolicy, int lite)
 	int status;
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
-	unsigned long nmask = 2;
+	unsigned long nmask = 0;
+	long nodes[MAXNODES];
 #endif
 
 	switch (pid = fork()) {
@@ -75,6 +76,8 @@ void oom(int testcase, int mempolicy, int lite)
 	case 0:
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
+		count_numa(nodes);
+		nmask += 1 << nodes[1];
 		if (mempolicy)
 			if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
 				tst_brkm(TBROK|TERRNO, cleanup,
-- 
1.7.10.1


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
