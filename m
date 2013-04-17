Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lans.zhang2008@gmail.com>) id 1USORe-0004sn-D4
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 09:14:26 +0000
Received: from mail-ia0-f171.google.com ([209.85.210.171])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1USORb-00039S-69
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 09:14:26 +0000
Received: by mail-ia0-f171.google.com with SMTP id f27so1229239iae.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Apr 2013 02:14:17 -0700 (PDT)
Message-ID: <516E68ED.3040507@gmail.com>
Date: Wed, 17 Apr 2013 17:18:37 +0800
From: Lans Zhang <lans.zhang2008@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080309040206030908010207"
Subject: [LTP] [PATCH V3]  Fix short of nodemask array.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>, Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080309040206030908010207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes since V2:
remove unused parameter in set_node()

In kernel, if user specified more nodes, e.g, 512 nodes, than the
supported, e.g, 4 nodes, kernel will check if the non supported
part, e.g, 508 nodes, is all zeroed in node bitmap. Currently, we
are overrunning "nmask", whose length is shorter than MAXNODES,
and where the unsupported bits should be cleared to pass the check.

Signed-off-by: Lans Zhang <lans.zhang2008@gmail.com>
---
   testcases/kernel/mem/cpuset/cpuset01.c |   11 +++++++----
   testcases/kernel/mem/include/mem.h     |    6 ++++++
   testcases/kernel/mem/ksm/ksm02.c       |    6 +++---
   testcases/kernel/mem/ksm/ksm04.c       |    6 +++---
   testcases/kernel/mem/lib/mem.c         |    9 +++++----
   5 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 1069335..99fbb9c 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -93,7 +93,7 @@ static void testcpuset(void)
   {
   	int lc;
   	int child, i, status;
-	unsigned long nmask = 0;
+	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
   	char mems[BUFSIZ], buf[BUFSIZ];

   	read_cpuset_files(CPATH, "cpus", buf);
@@ -107,9 +107,12 @@ static void testcpuset(void)
   	case -1:
   		tst_brkm(TBROK | TERRNO, cleanup, "fork");
   	case 0:
-		for (i = 0; i < nnodes; i++)
-			nmask += 1 << nodes[i];
-		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
+		for (i = 0; i < nnodes; i++) {
+			if (nodes[i] >= MAXNODES)
+				continue;
+			set_node(nmask, nodes[i]);
+		}
+		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1)
   			tst_brkm(TBROK | TERRNO, cleanup, "set_mempolicy");
   		exit(mem_hog_cpuset(ncpus > 1 ? ncpus : 1));
   	}
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index c9e0540..9e96b31 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -14,6 +14,12 @@
   #define PATH_SYS_SYSTEM		"/sys/devices/system"
   #define PATH_SYSVM		"/proc/sys/vm/"
   #define PATH_MEMINFO		"/proc/meminfo"
+#define BITS_PER_LONG           (8 * sizeof(long))
+
+static inline void set_node(unsigned long *array, unsigned int node)
+{
+	array[node / BITS_PER_LONG] |= 1UL << (node % BITS_PER_LONG);
+}

   /* OOM */

diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 412b52e..6c96c74 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -87,7 +87,7 @@ int main(int argc, char *argv[])
   	int lc;
   	char *msg;
   	int size = 128, num = 3, unit = 1;
-	unsigned long nmask = 0;
+	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
   	unsigned int node;

   	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
@@ -95,7 +95,7 @@ int main(int argc, char *argv[])
   		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

   	node = get_a_numa_node(tst_exit);
-	nmask = 1 << node;
+	set_node(nmask, node);

   	setup();

@@ -103,7 +103,7 @@ int main(int argc, char *argv[])
   		tst_count = 0;
   		check_ksm_options(&size, &num, &unit);

-		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
+		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
   			if (errno != ENOSYS)
   				tst_brkm(TBROK | TERRNO, cleanup,
   					 "set_mempolicy");
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index e164b29..ed5e0b3 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -87,7 +87,7 @@ int main(int argc, char *argv[])
   	int lc;
   	char *msg;
   	int size = 128, num = 3, unit = 1;
-	unsigned long nmask = 0;
+	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
   	unsigned int node;

   	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
@@ -95,7 +95,7 @@ int main(int argc, char *argv[])
   		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

   	node = get_a_numa_node(tst_exit);
-	nmask = 1 << node;
+	set_node(nmask, node);

   	setup();

@@ -105,7 +105,7 @@ int main(int argc, char *argv[])

   		write_memcg();

-		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
+		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
   			if (errno != ENOSYS)
   				tst_brkm(TBROK | TERRNO, cleanup,
   					 "set_mempolicy");
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index f6aa351..da98552 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -95,7 +95,7 @@ static void set_global_mempolicy(int mempolicy)
   {
   #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
   	&& HAVE_MPOL_CONSTANTS
-	unsigned long nmask = 0;
+	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
   	unsigned int num_nodes, *nodes;
   	int ret;

@@ -112,7 +112,7 @@ static void set_global_mempolicy(int mempolicy)
   		switch(mempolicy) {
   		case MPOL_BIND:
   			/* bind the second node */
-			nmask = 1 << nodes[1];
+			set_node(nmask, nodes[1]);
   			break;
   		case MPOL_INTERLEAVE:
   		case MPOL_PREFERRED:
@@ -123,13 +123,14 @@ static void set_global_mempolicy(int mempolicy)
   				return;
   			} else {
   				/* Using the 2nd,3rd node */
-				nmask = (1 << nodes[1]) | (1 << nodes[2]);
+				set_node(nmask, nodes[1]);
+				set_node(nmask, nodes[2]);
   			}
   			break;
   		default:
   			tst_brkm(TBROK|TERRNO, cleanup, "Bad mempolicy mode");
   		}
-		if (set_mempolicy(mempolicy, &nmask, MAXNODES) == -1)
+		if (set_mempolicy(mempolicy, nmask, MAXNODES) == -1)
   			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
   	}
   #endif
-- 
1.7.8.110.g4cb5d



--------------080309040206030908010207
Content-Type: text/x-patch;
 name="V3-Fix-short-of-nodemask-array.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="V3-Fix-short-of-nodemask-array.patch"

From 962888087cdd2c9e369073964152fa0e5b982056 Mon Sep 17 00:00:00 2001
From: Lans Zhang <jia.zhang@windriver.com>
Date: Wed, 17 Apr 2013 16:35:27 +0800
Subject: [PATCH] Fix short of nodemask array.

In kernel, if user specified more nodes, e.g, 512 nodes, than the
supported, e.g, 4 nodes, kernel will check if the non supported
part, e.g, 508 nodes, is all zeroed in node bitmap. Currently, we
are overrunning "nmask", whose length is shorter than MAXNODES,
and where the unsupported bits should be cleared to pass the check.

Signed-off-by: Lans Zhang <lans.zhang2008@gmail.com>
---
 testcases/kernel/mem/cpuset/cpuset01.c |   11 +++++++----
 testcases/kernel/mem/include/mem.h     |    6 ++++++
 testcases/kernel/mem/ksm/ksm02.c       |    6 +++---
 testcases/kernel/mem/ksm/ksm04.c       |    6 +++---
 testcases/kernel/mem/lib/mem.c         |    9 +++++----
 5 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 1069335..99fbb9c 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -93,7 +93,7 @@ static void testcpuset(void)
 {
 	int lc;
 	int child, i, status;
-	unsigned long nmask = 0;
+	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	char mems[BUFSIZ], buf[BUFSIZ];
 
 	read_cpuset_files(CPATH, "cpus", buf);
@@ -107,9 +107,12 @@ static void testcpuset(void)
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, "fork");
 	case 0:
-		for (i = 0; i < nnodes; i++)
-			nmask += 1 << nodes[i];
-		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
+		for (i = 0; i < nnodes; i++) {
+			if (nodes[i] >= MAXNODES)
+				continue;
+			set_node(nmask, nodes[i]);
+		}
+		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "set_mempolicy");
 		exit(mem_hog_cpuset(ncpus > 1 ? ncpus : 1));
 	}
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index c9e0540..9e96b31 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -14,6 +14,12 @@
 #define PATH_SYS_SYSTEM		"/sys/devices/system"
 #define PATH_SYSVM		"/proc/sys/vm/"
 #define PATH_MEMINFO		"/proc/meminfo"
+#define BITS_PER_LONG           (8 * sizeof(long))
+
+static inline void set_node(unsigned long *array, unsigned int node)
+{
+	array[node / BITS_PER_LONG] |= 1UL << (node % BITS_PER_LONG);
+}
 
 /* OOM */
 
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 412b52e..6c96c74 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -87,7 +87,7 @@ int main(int argc, char *argv[])
 	int lc;
 	char *msg;
 	int size = 128, num = 3, unit = 1;
-	unsigned long nmask = 0;
+	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	unsigned int node;
 
 	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
@@ -95,7 +95,7 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	node = get_a_numa_node(tst_exit);
-	nmask = 1 << node;
+	set_node(nmask, node);
 
 	setup();
 
@@ -103,7 +103,7 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 		check_ksm_options(&size, &num, &unit);
 
-		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
+		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
 			if (errno != ENOSYS)
 				tst_brkm(TBROK | TERRNO, cleanup,
 					 "set_mempolicy");
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index e164b29..ed5e0b3 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -87,7 +87,7 @@ int main(int argc, char *argv[])
 	int lc;
 	char *msg;
 	int size = 128, num = 3, unit = 1;
-	unsigned long nmask = 0;
+	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	unsigned int node;
 
 	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
@@ -95,7 +95,7 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	node = get_a_numa_node(tst_exit);
-	nmask = 1 << node;
+	set_node(nmask, node);
 
 	setup();
 
@@ -105,7 +105,7 @@ int main(int argc, char *argv[])
 
 		write_memcg();
 
-		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
+		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
 			if (errno != ENOSYS)
 				tst_brkm(TBROK | TERRNO, cleanup,
 					 "set_mempolicy");
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index f6aa351..da98552 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -95,7 +95,7 @@ static void set_global_mempolicy(int mempolicy)
 {
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
-	unsigned long nmask = 0;
+	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	unsigned int num_nodes, *nodes;
 	int ret;
 
@@ -112,7 +112,7 @@ static void set_global_mempolicy(int mempolicy)
 		switch(mempolicy) {
 		case MPOL_BIND:
 			/* bind the second node */
-			nmask = 1 << nodes[1];
+			set_node(nmask, nodes[1]);
 			break;
 		case MPOL_INTERLEAVE:
 		case MPOL_PREFERRED:
@@ -123,13 +123,14 @@ static void set_global_mempolicy(int mempolicy)
 				return;
 			} else {
 				/* Using the 2nd,3rd node */
-				nmask = (1 << nodes[1]) | (1 << nodes[2]);
+				set_node(nmask, nodes[1]);
+				set_node(nmask, nodes[2]);
 			}
 			break;
 		default:
 			tst_brkm(TBROK|TERRNO, cleanup, "Bad mempolicy mode");
 		}
-		if (set_mempolicy(mempolicy, &nmask, MAXNODES) == -1)
+		if (set_mempolicy(mempolicy, nmask, MAXNODES) == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
 	}
 #endif
-- 
1.7.8.110.g4cb5d



--------------080309040206030908010207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
--------------080309040206030908010207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080309040206030908010207--

