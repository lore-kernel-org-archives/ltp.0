Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UGAwP-0005Hb-Sb
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:23:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UGAwO-0007OG-Hd
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:23:41 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2EGNYGl017670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Mar 2013 12:23:35 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Fri, 15 Mar 2013 00:21:38 +0800
Message-Id: <30031c6918889add1194add03066bdb8c4c63b42.1363246555.git.zliu@redhat.com>
In-Reply-To: <440365316588480d26f3c7c12fb4366e58d87848.1363246555.git.zliu@redhat.com>
References: <cover.1363246555.git.zliu@redhat.com>
	<054d2c7ca1e3c6e4794c0f42f927b555a4273da7.1363246555.git.zliu@redhat.com>
	<1af53e534fc05433ed20488c27d35bbc519af730.1363246555.git.zliu@redhat.com>
	<440365316588480d26f3c7c12fb4366e58d87848.1363246555.git.zliu@redhat.com>
In-Reply-To: <cover.1363246555.git.zliu@redhat.com>
References: <cover.1363246555.git.zliu@redhat.com>
Subject: [LTP] [PATCH 4/5] lib/mem: updated testoom() and oom() funcs
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

the 'numa' parameter inside testoom() and 'mempolicy' inside oom()
were useless, so removed them.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/include/mem.h |  4 ++--
 testcases/kernel/mem/lib/mem.c     | 13 +++++--------
 testcases/kernel/mem/oom/oom01.c   |  6 +++---
 testcases/kernel/mem/oom/oom02.c   |  6 +++---
 testcases/kernel/mem/oom/oom03.c   | 10 +++++-----
 testcases/kernel/mem/oom/oom04.c   |  4 ++--
 6 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index de51838..2fd675b 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -27,8 +27,8 @@
 extern int ISNUMA;
 
 long overcommit;
-void oom(int testcase, int mempolicy, int lite);
-void testoom(int mempolicy, int lite, int numa);
+void oom(int testcase, int lite);
+void testoom(int mempolicy, int lite);
 
 /* KSM */
 
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index e99dae7..438735a 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -62,7 +62,7 @@ static void _test_alloc(int testcase, int lite)
 				return;
 }
 
-void oom(int testcase, int mempolicy, int lite)
+void oom(int testcase, int lite)
 {
 	pid_t pid;
 	int status;
@@ -92,7 +92,7 @@ void oom(int testcase, int mempolicy, int lite)
 	}
 }
 
-void testoom(int mempolicy, int lite, int numa)
+void testoom(int mempolicy, int lite)
 {
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
@@ -133,20 +133,17 @@ void testoom(int mempolicy, int lite, int numa)
 	}
 #endif
 
-	if (numa && !mempolicy)
-		write_cpusets(get_a_numa_node(cleanup));
-
 	tst_resm(TINFO, "start normal OOM testing.");
-	oom(NORMAL, mempolicy, lite);
+	oom(NORMAL, lite);
 
 	tst_resm(TINFO, "start OOM testing for mlocked pages.");
-	oom(MLOCK, mempolicy, lite);
+	oom(MLOCK, lite);
 
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 
 	tst_resm(TINFO, "start OOM testing for KSM pages.");
-	oom(KSM, mempolicy, lite);
+	oom(KSM, lite);
 }
 
 /* KSM */
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 0401e31..43a5319 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -61,13 +61,13 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 
 		set_sys_tune("overcommit_memory", 2, 1);
-		oom(OVERCOMMIT, 0, 0);
+		oom(OVERCOMMIT, 0);
 
 		set_sys_tune("overcommit_memory", 0, 1);
-		oom(OVERCOMMIT, 0, 0);
+		oom(OVERCOMMIT, 0);
 
 		set_sys_tune("overcommit_memory", 1, 1);
-		testoom(0, 0, 0);
+		testoom(0, 0);
 	}
 	cleanup();
 	tst_exit();
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 31ec73f..7566404 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -65,13 +65,13 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 
 		tst_resm(TINFO, "OOM on MPOL_BIND mempolicy...");
-		testoom(MPOL_BIND, 0, 1);
+		testoom(MPOL_BIND, 0);
 
 		tst_resm(TINFO, "OOM on MPOL_INTERLEAVE mempolicy...");
-		testoom(MPOL_INTERLEAVE, 0, 1);
+		testoom(MPOL_INTERLEAVE, 0);
 
 		tst_resm(TINFO, "OOM on MPOL_PREFERRED mempolicy...");
-		testoom(MPOL_PREFERRED, 0, 1);
+		testoom(MPOL_PREFERRED, 0);
 	}
 	cleanup();
 	tst_exit();
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 4365c2b..86eff41 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -68,7 +68,7 @@ int main(int argc, char *argv[])
 
 		snprintf(mem, BUFSIZ, "%ld", TESTMEM);
 		write_file(MEMCG_PATH_NEW "/memory.limit_in_bytes", mem);
-		testoom(0, 0, 0);
+		testoom(0, 0);
 
 		if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
 			if (errno == ENOENT)
@@ -78,15 +78,15 @@ int main(int argc, char *argv[])
 				tst_brkm(TBROK | TERRNO, cleanup, "access");
 		} else {
 			write_file(MEMCG_SW_LIMIT, mem);
-			testoom(0, 1, 0);
+			testoom(0, 1);
 		}
 
 		/* OOM for MEMCG with mempolicy */
 		if (ISNUMA) {
 			tst_resm(TINFO, "OOM on MEMCG & mempolicy...");
-			testoom(MPOL_BIND, 0, 1);
-			testoom(MPOL_INTERLEAVE, 0, 1);
-			testoom(MPOL_PREFERRED, 0, 1);
+			testoom(MPOL_BIND, 0);
+			testoom(MPOL_INTERLEAVE, 0);
+			testoom(MPOL_PREFERRED, 0);
 		}
 	}
 	cleanup();
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 6acc783..9423d60 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -65,7 +65,7 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 
 		tst_resm(TINFO, "OOM on CPUSET...");
-		testoom(0, 0, 0);
+		testoom(0, 0);
 
 		if (ISNUMA) {
 			/*
@@ -76,7 +76,7 @@ int main(int argc, char *argv[])
 			write_cpuset_files(CPATH_NEW,
 					   "memory_migrate", "1");
 			tst_resm(TINFO, "OOM on CPUSET with mem migrate:");
-			testoom(0, 0, 0);
+			testoom(0, 0);
 		}
 	}
 	cleanup();
-- 
1.7.11.7


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
