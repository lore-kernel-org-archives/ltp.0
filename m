Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VQyFc-0005ab-SU
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 11:36:24 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VQyFU-00023j-IJ
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 11:36:24 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r91Ba9o1002039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 1 Oct 2013 11:36:10 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r91Ba9Yt011482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 1 Oct 2013 11:36:09 GMT
Received: from abhmt114.oracle.com (abhmt114.oracle.com [141.146.116.66])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r91Ba8q4019116
	for <ltp-list@lists.sourceforge.net>; Tue, 1 Oct 2013 11:36:09 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  1 Oct 2013 15:35:59 +0400
Message-Id: <1380627359-18513-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <524A665C.7040202@oracle.com>
References: <524A665C.7040202@oracle.com>
Subject: [LTP] [PATCH V3 2/2] ltpapicmd.c: split main into separate functions
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
 tools/apicmds/ltpapicmd.c |  339 +++++++++++++++++++++++++--------------------
 1 files changed, 189 insertions(+), 150 deletions(-)

diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index f74ffca..5e5e359 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -79,6 +79,12 @@
 char *TCID;			/* Name of the testcase */
 int TST_TOTAL;			/* Total number of testcases */
 
+static char *cmd_name;		/* name by which this program is invoked tst_brk etc */
+static char *arg_fmt;		/* message string printed along with test type */
+static char *tst_total;		/* total number of tests in the file. */
+static char *tst_cntstr;	/* sets the value of tst_count with this value */
+
+
 /*
  * Function:    ident_ttype - Return test result type.
  *
@@ -111,6 +117,183 @@ int ident_ttype(char *tstype)
 		return -1;
 }
 
+void apicmd_brk(int argc, char *argv[])
+{
+	int trestype;
+	char *file_name;
+
+	if (argc < 5) {
+		fprintf(stderr, "Usage: %s TTYPE FNAME FUNC STRING\n"
+			"\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
+			"and TRETR.\n"
+			"\tFNAME  - Print contents of this file after the message\n"
+			"\tFUNC   - Cleanup function (ignored), but MUST be provided\n"
+			"\tSTRING - Message explaining the test result\n",
+			cmd_name);
+		exit(1);
+	}
+	trestype = ident_ttype((argv++)[0]);
+	file_name = (argv++)[0];
+	argv++;
+	strcpy(arg_fmt, *argv);
+	tst_brk(trestype, file_name, NULL, arg_fmt);
+}
+
+void apicmd_res(int argc, char *argv[])
+{
+	int trestype;
+	char *file_name;
+
+	if (argc < 4) {
+		fprintf(stderr, "Usage: %s TTYPE FNAME STRING\n"
+			"\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
+			"and  TRETR.\n"
+			"\tFNAME  - Print contents of this file after the message\n"
+			"\tSTRING - Message explaining the test result\n",
+			cmd_name);
+		exit(1);
+	}
+	trestype = ident_ttype((argv++)[0]);
+	file_name = (argv++)[0];
+	strcpy(arg_fmt, *argv);
+	tst_res(trestype, file_name, arg_fmt);
+}
+
+void apicmd_brkm(int argc, char *argv[])
+{
+	int trestype;
+
+	if (argc < 4) {
+		fprintf(stderr, "Usage: %s TTYPE FUNC STRING\n"
+			"\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
+			"and TRETR.\n"
+			"\tFUNC   - Cleanup function (ignored), but MUST be provided\n"
+			"\tSTRING - Message explaining the test result\n",
+			cmd_name);
+		exit(1);
+	}
+	trestype = ident_ttype((argv++)[0]);
+	argv++;
+	strcpy(arg_fmt, *argv);
+	tst_brkm(trestype, NULL, arg_fmt);
+}
+
+void apicmd_resm(int argc, char *argv[])
+{
+	int trestype;
+
+	if (argc < 3) {
+		fprintf(stderr, "Usage: %s TTYPE STRING\n"
+			"\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
+			"and TRETR.\n"
+			"\tSTRING - Message explaining the test result\n",
+			cmd_name);
+		exit(1);
+	}
+	trestype = ident_ttype((argv++)[0]);
+	strcpy(arg_fmt, *argv);
+	tst_resm(trestype, arg_fmt);
+}
+
+void apicmd_kvercmp(int argc, char *argv[])
+{
+	int exit_value;
+
+	if (argc < 4) {
+		fprintf(stderr, "Usage: %s NUM NUM NUM\n"
+			"Compares to the running kernel version.\n\n"
+			"\tNUM - A positive integer.\n"
+			"\tThe first NUM is the kernel VERSION\n"
+			"\tThe second NUM is the kernel PATCHLEVEL\n"
+			"\tThe third NUM is the kernel SUBLEVEL\n\n"
+			"\tExit status is 0 if the running kernel is older than the\n"
+			"\t\tkernel specified by NUM NUM NUM.\n"
+			"\tExit status is 1 for kernels of the same age.\n"
+			"\tExit status is 2 if the running kernel is newer.\n",
+			cmd_name);
+		exit(1);
+	}
+	exit_value = tst_kvercmp(atoi(argv[0]), atoi(argv[1]),
+				atoi(argv[2]));
+	if (exit_value < 0)
+		exit_value = 0;
+	else if (exit_value == 0)
+		exit_value = 1;
+	else if (exit_value > 0)
+		exit_value = 2;
+	exit(exit_value);
+}
+
+void apicmd_kvercmp2(int argc, char *argv[])
+{
+	int exit_value;
+
+	struct tst_kern_exv vers[100];
+	unsigned int count;
+
+	char *saveptr1 = NULL;
+	char *saveptr2 = NULL;
+	char *token1;
+
+	if (TCID == NULL)
+		TCID = "outoftest";
+	if (tst_cntstr == NULL)
+		tst_count = 0;
+
+	if (argc < 5) {
+		fprintf(stderr, "Usage: %s NUM NUM NUM KVERS\n"
+			"Compares to the running kernel version\n"
+			"based on vanilla kernel version NUM NUM NUM\n"
+			"or distribution specific kernel version KVERS\n\n"
+			"\tNUM - A positive integer.\n"
+			"\tThe first NUM is the kernel VERSION\n"
+			"\tThe second NUM is the kernel PATCHLEVEL\n"
+			"\tThe third NUM is the kernel SUBLEVEL\n\n"
+			"\tKVERS is a string of the form "
+			"\"DISTR1:VERS1 DISTR2:VERS2\",\n"
+			"\twhere DISTR1 is a distribution name\n"
+			"\tand VERS1 is the corresponding kernel version.\n"
+			"\tExample: \"RHEL6:2.6.39-400.208\"\n\n"
+			"\tIf running kernel matches a distribution in KVERS then\n"
+			"\tcomparison is performed based on version in KVERS,\n"
+			"\totherwise - based on NUM NUM NUM.\n\n"
+			"\tExit status is 0 if the running kernel is older.\n"
+			"\tExit status is 1 for kernels of the same age.\n"
+			"\tExit status is 2 if the running kernel is newer.\n",
+			cmd_name);
+		exit(3);
+	}
+
+	count = 0;
+	token1 = strtok_r(argv[3], " ", &saveptr1);
+	while ((token1 != NULL) && (count < 99)) {
+		vers[count].dist_name = strtok_r(token1, ":", &saveptr2);
+		vers[count].extra_ver = strtok_r(NULL, ":", &saveptr2);
+
+		if (vers[count].extra_ver == NULL) {
+			fprintf(stderr, "Incorrect KVERS format\n");
+			exit(3);
+		}
+
+		count++;
+
+		token1 = strtok_r(NULL, " ", &saveptr1);
+	}
+	vers[count].dist_name = NULL;
+	vers[count].extra_ver = NULL;
+
+	exit_value = tst_kvercmp2(atoi(argv[0]), atoi(argv[1]),
+				atoi(argv[2]), vers);
+
+	if (exit_value < 0)
+		exit_value = 0;
+	else if (exit_value == 0)
+		exit_value = 1;
+	else if (exit_value > 0)
+		exit_value = 2;
+	exit(exit_value);
+}
+
 /*
  * Function:    main - entry point of this program
  *
@@ -138,13 +321,6 @@ int ident_ttype(char *tstype)
  */
 int main(int argc, char *argv[])
 {
-	int trestype;		/* test result type TFAIL, TPASS, TINFO etc */
-	char *arg_fmt;		/* message string printed along with test type */
-	char *cmd_name;		/* name by which this program is invoked tst_brk etc */
-	char *tst_total;	/* total number of tests in the file. */
-	char *tst_cntstr;	/* sets the value of tst_count with this value */
-	char *file_name;	/* contents of this file are printed; see tst_res() */
-
 	arg_fmt = SAFE_MALLOC(NULL, 1024);
 	cmd_name = SAFE_MALLOC(NULL, 1024);
 
@@ -184,158 +360,21 @@ int main(int argc, char *argv[])
 	}
 
 	if (strcmp(cmd_name, "tst_brk") == 0) {
-		if (argc < 5) {
-			fprintf(stderr, "Usage: %s TTYPE FNAME FUNC STRING\n"
-				"\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
-				"and TRETR.\n"
-				"\tFNAME  - Print contents of this file after the message\n"
-				"\tFUNC   - Cleanup function (ignored), but MUST be provided\n"
-				"\tSTRING - Message explaining the test result\n",
-				cmd_name);
-			exit(1);
-		}
-		trestype = ident_ttype((argv++)[0]);
-		file_name = (argv++)[0];
-		argv++;
-		strcpy(arg_fmt, *argv);
-		tst_brk(trestype, file_name, NULL, arg_fmt);
+		apicmd_brk(argc, argv);
 	} else if (strcmp(cmd_name, "tst_res") == 0) {
-		if (argc < 4) {
-			fprintf(stderr, "Usage: %s TTYPE FNAME STRING\n"
-				"\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
-				"and  TRETR.\n"
-				"\tFNAME  - Print contents of this file after the message\n"
-				"\tSTRING - Message explaining the test result\n",
-				cmd_name);
-			exit(1);
-		}
-		trestype = ident_ttype((argv++)[0]);
-		file_name = (argv++)[0];
-		strcpy(arg_fmt, *argv);
-		tst_res(trestype, file_name, arg_fmt);
+		apicmd_res(argc, argv);
 	} else if (strcmp(cmd_name, "tst_brkm") == 0) {
-		if (argc < 4) {
-			fprintf(stderr, "Usage: %s TTYPE FUNC STRING\n"
-				"\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
-				"and TRETR.\n"
-				"\tFUNC   - Cleanup function (ignored), but MUST be provided\n"
-				"\tSTRING - Message explaining the test result\n",
-				cmd_name);
-			exit(1);
-		}
-		trestype = ident_ttype((argv++)[0]);
-		argv++;
-		strcpy(arg_fmt, *argv);
-		tst_brkm(trestype, NULL, arg_fmt);
+		apicmd_brkm(argc, argv);
 	} else if (strcmp(cmd_name, "tst_resm") == 0) {
-		if (argc < 3) {
-			fprintf(stderr, "Usage: %s TTYPE STRING\n"
-				"\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
-				"and TRETR.\n"
-				"\tSTRING - Message explaining the test result\n",
-				cmd_name);
-			exit(1);
-		}
-		trestype = ident_ttype((argv++)[0]);
-		strcpy(arg_fmt, *argv);
-		tst_resm(trestype, arg_fmt);
+		apicmd_resm(argc, argv);
 	} else if (strcmp(cmd_name, "tst_exit") == 0) {
 		tst_exit();
 	} else if (strcmp(cmd_name, "tst_flush") == 0) {
 		tst_flush();
 	} else if (strcmp(cmd_name, "tst_kvercmp") == 0) {
-		int exit_value;
-
-		if (argc < 4) {
-			fprintf(stderr, "Usage: %s NUM NUM NUM\n"
-				"Compares to the running kernel version.\n\n"
-				"\tNUM - A positive integer.\n"
-				"\tThe first NUM is the kernel VERSION\n"
-				"\tThe second NUM is the kernel PATCHLEVEL\n"
-				"\tThe third NUM is the kernel SUBLEVEL\n\n"
-				"\tExit status is 0 if the running kernel is older than the\n"
-				"\t\tkernel specified by NUM NUM NUM.\n"
-				"\tExit status is 1 for kernels of the same age.\n"
-				"\tExit status is 2 if the running kernel is newer.\n",
-				cmd_name);
-			exit(1);
-		}
-		exit_value = tst_kvercmp(atoi(argv[0]), atoi(argv[1]),
-					 atoi(argv[2]));
-		if (exit_value < 0)
-			exit_value = 0;
-		else if (exit_value == 0)
-			exit_value = 1;
-		else if (exit_value > 0)
-			exit_value = 2;
-		exit(exit_value);
+		apicmd_kvercmp(argc, argv);
 	} else if (strcmp(cmd_name, "tst_kvercmp2") == 0) {
-		int exit_value;
-
-		struct tst_kern_exv vers[100];
-		unsigned int count;
-
-		char *saveptr1 = NULL;
-		char *saveptr2 = NULL;
-		char *token1;
-
-		if (TCID == NULL)
-			TCID = "outoftest";
-		if (tst_cntstr == NULL)
-			tst_count = 0;
-
-		if (argc < 5) {
-			fprintf(stderr, "Usage: %s NUM NUM NUM KVERS\n"
-				"Compares to the running kernel version\n"
-				"based on vanilla kernel version NUM NUM NUM\n"
-				"or distribution specific kernel version KVERS\n\n"
-				"\tNUM - A positive integer.\n"
-				"\tThe first NUM is the kernel VERSION\n"
-				"\tThe second NUM is the kernel PATCHLEVEL\n"
-				"\tThe third NUM is the kernel SUBLEVEL\n\n"
-				"\tKVERS is a string of the form "
-				"\"DISTR1:VERS1 DISTR2:VERS2\",\n"
-				"\twhere DISTR1 is a distribution name\n"
-				"\tand VERS1 is the corresponding kernel version.\n"
-				"\tExample: \"RHEL6:2.6.39-400.208\"\n\n"
-				"\tIf running kernel matches a distribution in KVERS then\n"
-				"\tcomparison is performed based on version in KVERS,\n"
-				"\totherwise - based on NUM NUM NUM.\n\n"
-				"\tExit status is 0 if the running kernel is older.\n"
-				"\tExit status is 1 for kernels of the same age.\n"
-				"\tExit status is 2 if the running kernel is newer.\n",
-				cmd_name);
-			exit(3);
-		}
-
-		count = 0;
-		token1 = strtok_r(argv[3], " ", &saveptr1);
-		while ((token1 != NULL) && (count < 99)) {
-			vers[count].dist_name = strtok_r(token1, ":", &saveptr2);
-			vers[count].extra_ver = strtok_r(NULL, ":", &saveptr2);
-
-			if (vers[count].extra_ver == NULL) {
-				fprintf(stderr, "Incorrect KVERS format\n");
-				exit(3);
-			}
-
-			count++;
-
-			token1 = strtok_r(NULL, " ", &saveptr1);
-		}
-		vers[count].dist_name = NULL;
-		vers[count].extra_ver = NULL;
-
-		exit_value = tst_kvercmp2(atoi(argv[0]), atoi(argv[1]),
-					atoi(argv[2]), vers);
-
-		if (exit_value < 0)
-			exit_value = 0;
-		else if (exit_value == 0)
-			exit_value = 1;
-		else if (exit_value > 0)
-			exit_value = 2;
-		exit(exit_value);
+		apicmd_kvercmp2(argc, argv);
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
