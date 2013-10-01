Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VQt3H-0001lj-Fv
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 06:03:19 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VQt3D-0006y1-FB
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 06:03:19 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r91638f4004870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 1 Oct 2013 06:03:09 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r91637c1019933
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 1 Oct 2013 06:03:08 GMT
Received: from abhmt119.oracle.com (abhmt119.oracle.com [141.146.116.71])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r91637hs000572
	for <ltp-list@lists.sourceforge.net>; Tue, 1 Oct 2013 06:03:07 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  1 Oct 2013 10:02:59 +0400
Message-Id: <1380607379-12787-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20130930163452.GB5370@rei.suse.cz>
References: <20130930163452.GB5370@rei.suse.cz>
Subject: [LTP] [PATCH V2] tools: added tst_kvercmp2 binary
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
 tools/apicmds/ltpapicmd.c |   83 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 83 insertions(+), 5 deletions(-)

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
index e2b0061..1995098 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -45,8 +45,11 @@
  *               0   - on success
  *              -1  - on failure
  *
- * Description: Unlike the above commands tst_kvercmp has an unusual exit status
- *              tst_kvercmp - Compare running kernel to specified version
+ * Description: Unlike the above commands tst_kvercmp, tst_kvercmp2 have an unusual
+ *              exit status
+ *              tst_kvercmp  - Compare running kernel to specified version
+ *              tst_kvercmp2 - Compare running kernel to specified vanilla version
+ *                             or distribution specific version
  * Exit:
  *               2 - running newer kernel
  *               1 - running same age kernel
@@ -151,7 +154,8 @@ int main(int argc, char *argv[])
 	tst_total = getenv("TST_TOTAL");
 	tst_cntstr = getenv("TST_COUNT");
 	if (TCID == NULL || tst_total == NULL || tst_cntstr == NULL) {
-		if (strcmp(cmd_name, "tst_kvercmp") != 0) {
+		if ((strcmp(cmd_name, "tst_kvercmp") != 0)
+				&& (strcmp(cmd_name, "tst_kvercmp2") != 0)) {
 			fprintf(stderr,
 				"\nSet variables TCID, TST_TOTAL, and TST_COUNT before each test:\n"
 				"export TCID=<test name>\n"
@@ -265,6 +269,79 @@ int main(int argc, char *argv[])
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
+		if (argv[3] == NULL) {
+			fprintf(stderr, "Allocation for buf failed\n");
+			exit(3);
+		}
+
+		count = 0;
+		token1 = strtok_r(argv[3], " ", &saveptr1);
+		while ((token1 != NULL) && (count < 99)) {
+			vers[count].dist_name = strtok_r(token1, ":", &saveptr2);
+			vers[count].extra_ver = strtok_r(NULL, ":", &saveptr2);
+
+			if (vers[count].extra_ver == NULL) {
+				fprintf(stderr, "Incorrect KVERS format\n");
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
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
