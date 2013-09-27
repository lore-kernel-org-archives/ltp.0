Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VPSN4-0008MI-E6
	for ltp-list@lists.sourceforge.net; Fri, 27 Sep 2013 07:21:50 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VPSN2-0001t1-MN
	for ltp-list@lists.sourceforge.net; Fri, 27 Sep 2013 07:21:50 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8R7LerW032625
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 27 Sep 2013 07:21:41 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8R7Ld0V019199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 27 Sep 2013 07:21:39 GMT
Received: from abhmt108.oracle.com (abhmt108.oracle.com [141.146.116.60])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8R7Ldvp002573
	for <ltp-list@lists.sourceforge.net>; Fri, 27 Sep 2013 07:21:39 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 27 Sep 2013 11:21:32 +0400
Message-Id: <1380266492-7199-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] tools: added tst_kvercmp2 binary
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
Cc: vasily.isaenko@oracle.com

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 tools/apicmds/.gitignore  |    1 +
 tools/apicmds/Makefile    |    4 +-
 tools/apicmds/ltpapicmd.c |   81 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/tools/apicmds/.gitignore b/tools/apicmds/.gitignore
index e895739..a6d73d3 100644
--- a/tools/apicmds/.gitignore
+++ b/tools/apicmds/.gitignore
@@ -3,6 +3,7 @@ tst_brkm
 tst_exit
 tst_flush
 tst_kvercmp
+tst_kvercmp2
 tst_ncpus
 tst_ncpus_max
 tst_res
diff --git a/tools/apicmds/Makefile b/tools/apicmds/Makefile
index faa49b5..3cadc3f 100644
--- a/tools/apicmds/Makefile
+++ b/tools/apicmds/Makefile
@@ -26,8 +26,8 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 CPPFLAGS		+= -D_GNU_SOURCE
 
-MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit flush kvercmp res resm \
-			     ncpus ncpus_max)
+MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit flush kvercmp kvercmp2 \
+				res resm ncpus ncpus_max)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index e2b0061..1e48a90 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -151,7 +151,8 @@ int main(int argc, char *argv[])
 	tst_total = getenv("TST_TOTAL");
 	tst_cntstr = getenv("TST_COUNT");
 	if (TCID == NULL || tst_total == NULL || tst_cntstr == NULL) {
-		if (strcmp(cmd_name, "tst_kvercmp") != 0) {
+		if ((strcmp(cmd_name, "tst_kvercmp") != 0)
+				&& (strcmp(cmd_name, "tst_kvercmp2") != 0)) {
 			fprintf(stderr,
 				"\nSet variables TCID, TST_TOTAL, and TST_COUNT before each test:\n"
 				"export TCID=<test name>\n"
@@ -265,6 +266,84 @@ int main(int argc, char *argv[])
 		else if (exit_value > 0)
 			exit_value = 2;
 		exit(exit_value);
+	} else if (strcmp(cmd_name, "tst_kvercmp2") == 0) {
+		int exit_value;
+
+		struct tst_kern_exv vers[100];
+		unsigned int count;
+
+		char *saveptr1 = NULL;
+		char *saveptr2 = NULL;
+		char *token1;
+		char *buf;
+
+		if (TCID == NULL)
+			TCID = "outoftest";
+		if (tst_cntstr == NULL)
+			tst_count = 0;
+
+		if (argc < 5) {
+			fprintf(stderr, "Usage: %s NUM NUM NUM KVERS\n"
+				"Compares to the running kernel version\n"
+				"based on vanilla kernel version NUM NUM NUM\n"
+				"or distribution specific kernel version KVERS\n\n"
+				"\tNUM - A positive integer.\n"
+				"\tThe first NUM is the kernel VERSION\n"
+				"\tThe second NUM is the kernel PATCHLEVEL\n"
+				"\tThe third NUM is the kernel SUBLEVEL\n\n"
+				"\tKVERS is a string of the form "
+				"\"DISTR1:VERS1 DISTR2:VERS2\",\n"
+				"\twhere DISTR1 is a distribution name\n"
+				"\tand VERS1 is the corresponding kernel version.\n"
+				"\tExample: \"RHEL6:2.6.39-400.208\"\n\n"
+				"\tIf running kernel matches a distribution in KVERS then\n"
+				"\tcomparison is performed based on version in KVERS,\n"
+				"\totherwise - based on NUM NUM NUM.\n\n"
+				"\tExit status is 0 if the running kernel is older.\n"
+				"\tExit status is 1 for kernels of the same age.\n"
+				"\tExit status is 2 if the running kernel is newer.\n",
+				cmd_name);
+			exit(3);
+		}
+
+		count = 0;
+
+		buf = strdup(argv[3]);
+		if (buf == NULL) {
+			fprintf(stderr, "Allocation for buf failed\n");
+			exit(3);
+		}
+
+		token1 = strtok_r(buf, " ", &saveptr1);
+		while ((token1 != NULL) && (count < 99)) {
+			vers[count].dist_name = strtok_r(token1, ":", &saveptr2);
+			vers[count].extra_ver = strtok_r(NULL, ":", &saveptr2);
+
+			if (vers[count].extra_ver == NULL) {
+				fprintf(stderr, "Incorrect KVERS format\n");
+				free(buf);
+				exit(3);
+			}
+
+			count++;
+
+			token1 = strtok_r(NULL, " ", &saveptr1);
+		}
+		vers[count].dist_name = NULL;
+		vers[count].extra_ver = NULL;
+
+		exit_value = tst_kvercmp2(atoi(argv[0]), atoi(argv[1]),
+					atoi(argv[2]), vers);
+
+		free(buf);
+
+		if (exit_value < 0)
+			exit_value = 0;
+		else if (exit_value == 0)
+			exit_value = 1;
+		else if (exit_value > 0)
+			exit_value = 2;
+		exit(exit_value);
 	} else if (strcmp(cmd_name, "tst_ncpus") == 0) {
 		printf("%li\n", tst_ncpus());
 	} else if (strcmp(cmd_name, "tst_ncpus_max") == 0) {
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
