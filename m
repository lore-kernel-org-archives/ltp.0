Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <filippo.arcidiacono@st.com>) id 1Ry3J7-0003I5-Jv
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 15:31:41 +0000
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127])
	by sog-mx-3.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ry3J1-0001Nk-E6
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 15:31:41 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD4FC15C
	for <ltp-list@lists.sourceforge.net>;
	Thu, 16 Feb 2012 15:31:26 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 727A52A95
	for <ltp-list@lists.sourceforge.net>;
	Thu, 16 Feb 2012 15:31:26 +0000 (GMT)
From: Filippo ARCIDIACONO <filippo.arcidiacono@st.com>
Date: Thu, 16 Feb 2012 16:31:19 +0100
Message-Id: <1329406279-5989-1-git-send-email-filippo.arcidiacono@st.com>
Subject: [LTP] [PATCH v3] getrusage03: add opportunity to reduce memory
	allocation's size
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

To use this test also in embedded systems it needs to reduce the memory
allocation to avoid the test failing when it check the ru_maxrss field
expecting a value close to the allocated one.
The ru_maxrss field contains the total amount of resident set memory
used, so this field doesn't take into account of the swapped memory.
Passing [num] parameter at command line the test is executed using the
input parameter as multiply factor instead of 10, that is the default
value when no argument is passed.

Signed-off-by: Filippo Arcidiacono <filippo.arcidiacono@st.com>
Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 testcases/kernel/syscalls/getrusage/getrusage03.c |   94 ++++++++++++++-------
 1 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index 3ec5284..26c1766 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -47,14 +47,23 @@ char *TCID = "getrusage03";
 int TST_TOTAL = 1;
 
 #define DELTA_MAX	10240
+#define FACTOR_MAX	20
 
 static struct rusage ru;
 static long maxrss_init;
-static int retval, status;
+static int retval, status, opt_factor;
 static pid_t pid;
+static char *factor_str;
+static long factor_nr = 10;
 
+option_t child_options[] = {
+	{ "m:", &opt_factor, &factor_str },
+	{ NULL, NULL,         NULL }
+};
+
+static void usage(void);
 static void inherit_fork(void);
-static void inherit_fork2(void);
+static void inherit_fork2(const int size);
 static void fork_malloc(void);
 static void grandchild_maxrss(void);
 static void zombie(void);
@@ -68,23 +77,30 @@ static void cleanup(void);
 
 int main(int argc, char *argv[])
 {
-	int lc;
+	int lc, size;
 	char *msg;
 
-	msg = parse_opts(argc, argv, NULL, NULL);
+	msg = parse_opts(argc, argv, child_options, usage);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
 
+	if (opt_factor)
+		factor_nr = SAFE_STRTOL(cleanup, factor_str, 1, FACTOR_MAX);
+
+	tst_resm(TINFO, "Using %ld as factor allocation memory!", factor_nr);
+
+	size = 10 * factor_nr;
+
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
 
-		tst_resm(TINFO, "allocate 100MB");
-		consume(100);
+		tst_resm(TINFO, "allocate %dMB", size);
+		consume(size);
 
 		inherit_fork();
-		inherit_fork2();
+		inherit_fork2(size);
 		fork_malloc();
 		grandchild_maxrss();
 		zombie();
@@ -95,6 +111,11 @@ int main(int argc, char *argv[])
 	tst_exit();
 }
 
+static void usage(void)
+{
+	printf("  -m n    use n as multiply factor, default value is 10\n");
+}
+
 /* Testcase #01: fork inherit
  * expect: initial.self ~= child.self */
 static void inherit_fork(void)
@@ -123,17 +144,17 @@ static void inherit_fork(void)
 }
 
 /* Testcase #02: fork inherit (cont.)
- * expect: initial.children ~= 100MB, child.children = 0 */
-static void inherit_fork2(void)
+ * expect: initial.children ~= (10 * factor_nr)MB, child.children = 0 */
+static void inherit_fork2(const int size)
 {
 	tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
-	if (is_in_delta(ru.ru_maxrss - 102400))
-		tst_resm(TPASS, "initial.children ~= 100MB");
+	if (is_in_delta(ru.ru_maxrss - (10240 * factor_nr)))
+		tst_resm(TPASS, "initial.children ~= %dMB", size);
 	else
-		tst_resm(TFAIL, "initial.children !~= 100MB");
+		tst_resm(TFAIL, "initial.children !~= %dMB", size);
 
 	switch (pid = fork()) {
 	case -1:
@@ -153,9 +174,12 @@ static void inherit_fork2(void)
 }
 
 /* Testcase #03: fork + malloc
- * expect: initial.self + 50MB ~= child.self */
+ * expect: initial.self + (5 * factor_nr)MB ~= child.self */
 static void fork_malloc(void)
 {
+	char pass_msg[BUFSIZ], fail_msg[BUFSIZ];
+	const int size = 5 * factor_nr;
+
 	tst_resm(TINFO, "Testcase #03: fork + malloc");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
@@ -166,25 +190,29 @@ static void fork_malloc(void)
 		tst_brkm(TBROK|TERRNO, cleanup, "fork #3");
 	case 0:
 		maxrss_init = ru.ru_maxrss;
-		tst_resm(TINFO, "child allocate +50MB");
-		consume(50);
+		tst_resm(TINFO, "child allocate + %dMB", size);
+		consume(size);
 		SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
 		tst_resm(TINFO, "child.self = %ld", ru.ru_maxrss);
-		exit(is_in_delta(maxrss_init + 51200 - ru.ru_maxrss));
+		exit(is_in_delta(maxrss_init + (5120 * factor_nr) - ru.ru_maxrss));
 	default:
 		break;
 	}
 
 	if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
-	check_return(WEXITSTATUS(status), "initial.self + 50MB ~= child.self",
-		    "initial.self + 50MB !~= child.self");
+	sprintf(pass_msg, "initial.self + %dMB ~= child.self", size);
+	sprintf(fail_msg, "initial.self + %dMB !~= child.self", size);
+	check_return(WEXITSTATUS(status), pass_msg, fail_msg);
 }
 
 /* Testcase #04: grandchild maxrss
- * expect: post_wait.children ~= 300MB */
+ * expect: post_wait.children ~= (30 * factor_nr)MB */
 static void grandchild_maxrss(void)
 {
+	char cmd_system[BUFSIZ];
+	const int size = 30 * factor_nr;
+
 	tst_resm(TINFO, "Testcase #04: grandchild maxrss");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
@@ -194,7 +222,8 @@ static void grandchild_maxrss(void)
 	case -1:
 		tst_brkm(TBROK|TERRNO, cleanup, "fork #4");
 	case 0:
-		retval = system("getrusage03_child -g 300");
+		sprintf(cmd_system, "getrusage03_child -g %d", size);
+		retval = system(cmd_system);
 		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
 			tst_brkm(TBROK|TERRNO, cleanup, "system");
 		exit(0);
@@ -209,16 +238,19 @@ static void grandchild_maxrss(void)
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
-	if (is_in_delta(ru.ru_maxrss - 307200))
-		tst_resm(TPASS, "child.children ~= 300MB");
+	if (is_in_delta(ru.ru_maxrss - (30720 * factor_nr)))
+		tst_resm(TPASS, "child.children ~= %dMB", size);
 	else
-		tst_resm(TFAIL, "child.children !~= 300MB");
+		tst_resm(TFAIL, "child.children !~= %dMB", size);
 }
 
 /* Testcase #05: zombie
- * expect: initial ~= pre_wait, post_wait ~= 400MB */
+ * expect: initial ~= pre_wait, post_wait ~= (40 * factor_nr)MB */
 static void zombie(void)
 {
+	char cmd_system[BUFSIZ];
+	const int size = 40 * factor_nr;
+
 	tst_resm(TINFO, "Testcase #05: zombie");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
@@ -229,7 +261,8 @@ static void zombie(void)
 	case -1:
 		tst_brkm(TBROK, cleanup, "fork #5");
 	case 0:
-		retval = system("getrusage03_child -n 400");
+		sprintf(cmd_system, "getrusage03_child -n %d", size);
+		retval = system(cmd_system);
 		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
 			tst_brkm(TBROK|TERRNO, cleanup, "system");
 		exit(0);
@@ -252,16 +285,18 @@ static void zombie(void)
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
-	if (is_in_delta(ru.ru_maxrss - 409600))
-		tst_resm(TPASS, "post_wait.children ~= 400MB");
+	if (is_in_delta(ru.ru_maxrss - (40960 * factor_nr)))
+		tst_resm(TPASS, "post_wait.children ~= %dMB", size);
 	else
-		tst_resm(TFAIL, "post_wait.children !~= 400MB");
+		tst_resm(TFAIL, "post_wait.children !~= %dMB", size);
 }
 
 /* Testcase #06: SIG_IGN
  * expect: initial ~= after_zombie */
 static void sig_ign(void)
 {
+	char cmd_system[BUFSIZ];
+
 	tst_resm(TINFO, "Testcase #06: SIG_IGN");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
@@ -273,7 +308,8 @@ static void sig_ign(void)
 	case -1:
 		tst_brkm(TBROK, cleanup, "fork #6");
 	case 0:
-		retval = system("getrusage03_child -n 500");
+		sprintf(cmd_system, "getrusage03_child -n %ld", 50 * factor_nr);
+		retval = system(cmd_system);
 		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
 			tst_brkm(TBROK|TERRNO, cleanup, "system");
 		exit(0);
-- 
1.5.5.6


------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
