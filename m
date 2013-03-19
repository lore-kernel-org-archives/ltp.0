Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UHnSM-0002sK-G6
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 03:43:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UHnS6-0001ki-Ju
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 03:43:22 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2J3h1ht028991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Mar 2013 23:43:01 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Tue, 19 Mar 2013 11:40:53 +0800
Message-Id: <b686bc8023d3be91d4202ec8554a1280406a70cb.1363664213.git.zliu@redhat.com>
In-Reply-To: <f18d772317c38415040ac76e38e1082dbc6892ec.1363664213.git.zliu@redhat.com>
References: <cover.1363664213.git.zliu@redhat.com>
	<610d014b3e51b301d3f2adca6e8b068e62aba626.1363664213.git.zliu@redhat.com>
	<ebfb6ab9d3fba5067be674e22118c4cd4cea4ba8.1363664213.git.zliu@redhat.com>
	<60167c77dc6892bb5a1ae232782cffc107368db8.1363664213.git.zliu@redhat.com>
	<f18d772317c38415040ac76e38e1082dbc6892ec.1363664213.git.zliu@redhat.com>
In-Reply-To: <cover.1363664213.git.zliu@redhat.com>
References: <cover.1363664213.git.zliu@redhat.com>
Subject: [LTP] [PATCH v4 5/7] lib/mem: updated testoom() and oom() funcs
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
index 1233493..fdf558e 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -25,8 +25,8 @@
 #define KSM			4
 
 long overcommit;
-void oom(int testcase, int mempolicy, int lite);
-void testoom(int mempolicy, int lite, int numa);
+void oom(int testcase, int lite);
+void testoom(int mempolicy, int lite);
 
 /* KSM */
 
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 0b8974c..2c2ab5d 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -61,7 +61,7 @@ static void _test_alloc(int testcase, int lite)
 				return;
 }
 
-void oom(int testcase, int mempolicy, int lite)
+void oom(int testcase, int lite)
 {
 	pid_t pid;
 	int status;
@@ -91,7 +91,7 @@ void oom(int testcase, int mempolicy, int lite)
 	}
 }
 
-void testoom(int mempolicy, int lite, int numa)
+void testoom(int mempolicy, int lite)
 {
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
@@ -134,20 +134,17 @@ void testoom(int mempolicy, int lite, int numa)
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
index 3bc8567..1fd199b 100644
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
index 43ad595..124e95f 100644
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
 		if (is_numa(cleanup)) {
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
index 1ad7334..4d3f2f4 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -65,7 +65,7 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 
 		tst_resm(TINFO, "OOM on CPUSET...");
-		testoom(0, 0, 0);
+		testoom(0, 0);
 
 		if (is_numa(cleanup)) {
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
