Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Wn3ho-0006NE-M9
	for ltp-list@lists.sourceforge.net; Wed, 21 May 2014 10:25:04 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wn3hl-0000aC-UN
	for ltp-list@lists.sourceforge.net; Wed, 21 May 2014 10:25:04 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4LAOsH8022153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 21 May 2014 10:24:55 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4LAOsnd015152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 21 May 2014 10:24:54 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4LAOsDI004184
	for <ltp-list@lists.sourceforge.net>; Wed, 21 May 2014 10:24:54 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 21 May 2014 14:24:45 +0400
Message-Id: <1400667887-5188-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140520144246.GA30023@rei.suse.cz>
References: <20140520144246.GA30023@rei.suse.cz>
Subject: [LTP] [PATCH 1/3] rt_sigaction, rt_sigprocmask,
	rt_sigsuspend: cleanup
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
 .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |   88 +++-----------
 .../kernel/syscalls/rt_sigaction/rt_sigaction02.c  |   85 +++-----------
 .../kernel/syscalls/rt_sigaction/rt_sigaction03.c  |  105 ++++-------------
 .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |  112 +++++-------------
 .../syscalls/rt_sigprocmask/rt_sigprocmask02.c     |   89 +++------------
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |  125 +++++--------------
 6 files changed, 132 insertions(+), 472 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index 8f18394..5ca3ba4 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -12,36 +12,22 @@
 /* the GNU General Public License for more details.                           */
 /*                                                                            */
 /* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
+/* along with this program;  if not, write to the Free Software Foundation,   */
+/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
 /*                                                                            */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
+
 /******************************************************************************/
-/*                                                                            */
-/* File:        rt_sigaction01.c                                              */
-/*                                                                            */
 /* Description: This tests the rt_sigaction() syscall                         */
 /*		rt_sigaction alters an action taken by a process on receipt   */
 /* 		of a particular signal. The action is specified by the        */
 /*		sigaction structure. The previous action on the signal is     */
 /*		saved in oact.sigsetsize should indicate the size of a        */
 /*		sigset_t type.                       			      */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* rt_sigaction01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                        */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   rt_sigaction01                                             */
-/* History:     Porting from Crackerjack to LTP is done by                    */
-/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -57,75 +43,35 @@
 #include "ltp_signal.h"
 
 char *TCID = "rt_sigaction01";
-int testno;
+static int testno;
 int TST_TOTAL = 1;
 
-/* Extern Global Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    cleanup                                                       */
-/*                                                                            */
-/* Description: Performs all one time clean up for this test on successful    */
-/*              completion,  premature exit or  failure. Closes all temporary */
-/*              files, removes all temporary directories exits the test with  */
-/*              appropriate return code by calling tst_exit() function.       */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*              On success - Exits calling tst_exit(). With '0' return code.  */
-/*                                                                            */
-/******************************************************************************/
-void cleanup(void)
+static void cleanup(void)
 {
-
 	TEST_CLEANUP;
 	tst_rmdir();
-
 }
 
-/* Local  Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    setup                                                         */
-/*                                                                            */
-/* Description: Performs all one time setup for this test. This function is   */
-/*              typically used to capture signals, create temporary dirs      */
-/*              and temporary files that may be used in the course of this    */
-/*              test.                                                         */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits by calling cleanup().                      */
-/*              On success - returns 0.                                       */
-/*                                                                            */
-/******************************************************************************/
-void setup(void)
+static void setup(void)
 {
-	/* Capture signals if any */
-	/* Create temporary directories */
 	TEST_PAUSE;
 	tst_tmpdir();
 }
 
-int test_flags[] =
+static int test_flags[] =
     { SA_RESETHAND | SA_SIGINFO, SA_RESETHAND, SA_RESETHAND | SA_SIGINFO,
 SA_RESETHAND | SA_SIGINFO, SA_NOMASK };
 char *test_flags_list[] =
     { "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND", "SA_RESETHAND|SA_SIGINFO",
 "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK" };
 
-void handler(int sig)
+static void handler(int sig)
 {
 	tst_resm(TINFO, "Signal Handler Called with signal number %d\n", sig);
 	return;
 }
 
-int set_handler(int sig, int sig_to_mask, int mask_flags)
+static int set_handler(int sig, int sig_to_mask, int mask_flags)
 {
 #ifdef __x86_64__
 	struct kernel_sigaction sa, oldaction;
@@ -141,18 +87,18 @@ int set_handler(int sig, int sig_to_mask, int mask_flags)
 	sigaddset(&sa.sa_mask, sig);
 
 	return ltp_syscall(__NR_rt_sigaction, sig, &sa, &oldaction, SIGSETSIZE);
-
 }
 
 int main(int ac, char **av)
 {
-	int signal, flag;
+	unsigned int flag;
+	int signal;
 	int lc;
 	char *msg;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 
@@ -162,7 +108,7 @@ int main(int ac, char **av)
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
-			for (signal = SIGRTMIN; signal <= (SIGRTMAX); signal++) {	//signal for 34 to 65
+			for (signal = SIGRTMIN; signal <= SIGRTMAX; signal++) {
 
 #ifdef __x86_64__
 				sig_initial(signal);
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
index 61137df..5822a79 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -12,32 +12,18 @@
 /* the GNU General Public License for more details.                           */
 /*                                                                            */
 /* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
+/* along with this program;  if not, write to the Free Software Foundation,   */
+/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
 /*                                                                            */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
+
 /******************************************************************************/
-/*                                                                            */
-/* File:        rt_sigaction02.c                                              */
-/*                                                                            */
 /* Description: This tests the rt_sigaction() syscall                         */
 /*		rt_sigaction Expected EFAULT error check                      */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* rt_sigaction02 [-c n] [-e][-i n] [-I x] [-p x] [-t]                        */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   rt_sigaction02                                             */
-/* History:     Porting from Crackerjack to LTP is done by                    */
-/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -54,70 +40,31 @@
 #define INVAL_STRUCT -1
 
 char *TCID = "rt_sigaction02";
-int testno;
+static int testno;
 int TST_TOTAL = 1;
 
-/* Extern Global Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    cleanup                                                       */
-/*                                                                            */
-/* Description: Performs all one time clean up for this test on successful    */
-/*              completion,  premature exit or  failure. Closes all temporary */
-/*              files, removes all temporary directories exits the test with  */
-/*              appropriate return code by calling tst_exit() function.       */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*              On success - Exits calling tst_exit(). With '0' return code.  */
-/*                                                                            */
-/******************************************************************************/
 void cleanup(void)
 {
-
 	TEST_CLEANUP;
 	tst_rmdir();
 
 	tst_exit();
 }
 
-/* Local  Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    setup                                                         */
-/*                                                                            */
-/* Description: Performs all one time setup for this test. This function is   */
-/*              typically used to capture signals, create temporary dirs      */
-/*              and temporary files that may be used in the course of this    */
-/*              test.                                                         */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits by calling cleanup().                      */
-/*              On success - returns 0.                                       */
-/*                                                                            */
-/******************************************************************************/
 void setup(void)
 {
-	/* Capture signals if any */
-	/* Create temporary directories */
 	TEST_PAUSE;
 	tst_tmpdir();
 }
 
-int test_flags[] =
+static int test_flags[] =
     { SA_RESETHAND | SA_SIGINFO, SA_RESETHAND, SA_RESETHAND | SA_SIGINFO,
 SA_RESETHAND | SA_SIGINFO, SA_NOMASK };
 char *test_flags_list[] =
     { "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND", "SA_RESETHAND|SA_SIGINFO",
 "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK" };
 
-struct test_case_t {
+static struct test_case_t {
 	int exp_errno;
 	char *errdesc;
 } test_cases[] = {
@@ -127,23 +74,24 @@ struct test_case_t {
 
 int main(int ac, char **av)
 {
-	int signal, flag;
+	unsigned int flag;
+	int signal;
 	int lc;
 	char *msg;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-		tst_exit();
-	}
 
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
+			for (signal = SIGRTMIN; signal <= SIGRTMAX; signal++) {
+				tst_resm(TINFO, "Signal %d", signal);
 
-			for (signal = SIGRTMIN; signal <= (SIGRTMAX); signal++) {	//signal for 34 to 65
-				for (flag = 0; flag < 5; flag++) {
+				for (flag = 0; flag < (sizeof(test_flags) / sizeof(test_flags[0])); flag++) {
 
 					/*                                                              *
 					 * long sys_rt_sigaction (int sig, const struct sigaction *act, *
@@ -178,7 +126,6 @@ int main(int ac, char **av)
 							 test_flags_list[flag]);
 					}
 				}
-				printf("\n");
 			}
 
 		}
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index 12c3b84..8920138 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -12,32 +12,18 @@
 /* the GNU General Public License for more details.                           */
 /*                                                                            */
 /* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
+/* along with this program;  if not, write to the Free Software Foundation,   */
+/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
 /*                                                                            */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
+
 /******************************************************************************/
-/*                                                                            */
-/* File:        rt_sigaction03.c                                              */
-/*                                                                            */
 /* Description: This tests the rt_sigaction() syscall                         */
 /*		rt_sigaction Expected EINVAL error check                      */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* rt_sigaction03 [-c n] [-e][-i n] [-I x] [-p x] [-t]                        */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   rt_sigaction03                                             */
-/* History:     Porting from Crackerjack to LTP is done by                    */
-/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -54,70 +40,29 @@
 #define INVAL_SIGSETSIZE -1
 
 char *TCID = "rt_sigaction03";
-int testno;
+static int testno;
 int TST_TOTAL = 1;
 
-/* Extern Global Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    cleanup                                                       */
-/*                                                                            */
-/* Description: Performs all one time clean up for this test on successful    */
-/*              completion,  premature exit or  failure. Closes all temporary */
-/*              files, removes all temporary directories exits the test with  */
-/*              appropriate return code by calling tst_exit() function.       */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*              On success - Exits calling tst_exit(). With '0' return code.  */
-/*                                                                            */
-/******************************************************************************/
-void cleanup(void)
+static void cleanup(void)
 {
-
 	TEST_CLEANUP;
 	tst_rmdir();
-
-	tst_exit();
 }
 
-/* Local  Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    setup                                                         */
-/*                                                                            */
-/* Description: Performs all one time setup for this test. This function is   */
-/*              typically used to capture signals, create temporary dirs      */
-/*              and temporary files that may be used in the course of this    */
-/*              test.                                                         */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits by calling cleanup().                      */
-/*              On success - returns 0.                                       */
-/*                                                                            */
-/******************************************************************************/
-void setup(void)
+static void setup(void)
 {
-	/* Capture signals if any */
-	/* Create temporary directories */
 	TEST_PAUSE;
 	tst_tmpdir();
 }
 
-int test_flags[] =
+static int test_flags[] =
     { SA_RESETHAND | SA_SIGINFO, SA_RESETHAND, SA_RESETHAND | SA_SIGINFO,
 SA_RESETHAND | SA_SIGINFO, SA_NOMASK };
 char *test_flags_list[] =
     { "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND", "SA_RESETHAND|SA_SIGINFO",
 "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK" };
 
-struct test_case_t {
+static struct test_case_t {
 	int exp_errno;
 	char *errdesc;
 } test_cases[] = {
@@ -125,13 +70,13 @@ struct test_case_t {
 	EINVAL, "EINVAL"}
 };
 
-void handler(int sig)
+static void handler(int sig)
 {
 	tst_resm(TINFO, "Signal Handler Called with signal number %d\n", sig);
 	return;
 }
 
-int set_handler(int sig, int sig_to_mask, int mask_flags)
+static int set_handler(int sig, int sig_to_mask, int mask_flags)
 {
 	struct sigaction sa, oldaction;
 
@@ -147,25 +92,20 @@ int set_handler(int sig, int sig_to_mask, int mask_flags)
 	 * sigsetsize was not equivalent to the size of a sigset_t type *
 	 */
 
-	TEST(ltp_syscall
-	     (__NR_rt_sigaction, sig, &sa, &oldaction, INVAL_SIGSETSIZE));
-	if (TEST_RETURN == 0) {
-		return 0;
-	} else {
-		return TEST_RETURN;
-	}
+	return ltp_syscall(__NR_rt_sigaction, sig, &sa, &oldaction,
+			INVAL_SIGSETSIZE);
 }
 
 int main(int ac, char **av)
 {
-	int signal, flag;
+	unsigned int flag;
+	int signal;
 	int lc;
 	char *msg;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-		tst_exit();
-	}
 
 	setup();
 
@@ -173,8 +113,10 @@ int main(int ac, char **av)
 		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
-			for (signal = SIGRTMIN; signal <= (SIGRTMAX); signal++) {	//signal for 34 to 65
-				for (flag = 0; flag < 5; flag++) {
+			for (signal = SIGRTMIN; signal <= (SIGRTMAX); signal++) {
+				tst_resm(TINFO, "Signal %d", signal);
+
+				for (flag = 0; flag < (sizeof(test_flags) / sizeof(test_flags[0])); flag++) {
 					TEST(set_handler
 					     (signal, 0, test_flags[flag]));
 					if ((TEST_RETURN == -1)
@@ -200,7 +142,6 @@ int main(int ac, char **av)
 							 test_flags_list[flag]);
 					}
 				}
-				printf("\n");
 			}
 
 		}
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index 1dbed72..f13edbf 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -12,14 +12,14 @@
 /* the GNU General Public License for more details.                           */
 /*                                                                            */
 /* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 59 Temple Place, Suite TEST_SIG0, Boston, MA 02111-1307 USA    */
+/* along with this program;  if not, write to the Free Software Foundation,   */
+/* Inc., 59 Temple Place, Suite TEST_SIG0, Boston, MA 02111-1307 USA          */
 /*                                                                            */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak <maknayak@in.ibm.com>                       */
 /******************************************************************************/
+
 /******************************************************************************/
-/*                                                                            */
-/* File:        rt_sigprocmask01.c                                              */
-/*                                                                            */
 /* Description: This tests the rt_sigprocmask() syscall                       */
 /*		rt_sigprocmask changes the list of currently blocked signals. */
 /*		The set value stores the signal mask of the pending signals.  */
@@ -37,22 +37,8 @@
 /*		SIG_SETMASK						      */
 /*		    The set of blocked signals is set to the set argument.    */
 /*		    sigsetsize should indicate the size of a sigset_t type.   */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* rt_sigprocmask01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                      */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   rt_sigprocmask01                                              */
-/* History:     Porting from Crackerjack to LTP is done by                    */
-/*              Manas Kumar Nayak <maknayak@in.ibm.com>                       */
 /******************************************************************************/
+
 #include <stdio.h>
 #include <signal.h>
 #include <errno.h>
@@ -64,65 +50,25 @@
 #include "ltp_signal.h"
 
 char *TCID = "rt_sigprocmask01";
-int testno;
+static int testno;
 int TST_TOTAL = 8;
 
+static int sig_count;
+
 #define TEST_SIG SIGRTMIN+1
 
-/* Extern Global Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    cleanup                                                       */
-/*                                                                            */
-/* Description: Performs all one time clean up for this test on successful    */
-/*              completion,  premature exit or  failure. Closes all temporary */
-/*              files, removes all temporary directories exits the test with  */
-/*              appropriate return code by calling tst_exit() function.       */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*              On success - Exits calling tst_exit(). With '0' return code.  */
-/*                                                                            */
-/******************************************************************************/
-void cleanup(void)
+static void cleanup(void)
 {
-
 	TEST_CLEANUP;
 	tst_rmdir();
-
 }
 
-/* Local  Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    setup                                                         */
-/*                                                                            */
-/* Description: Performs all one time setup for this test. This function is   */
-/*              typically used to capture signals, create temporary dirs      */
-/*              and temporary files that may be used in the course of this    */
-/*              test.                                                         */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits by calling cleanup().                      */
-/*              On success - returns 0.                                       */
-/*                                                                            */
-/******************************************************************************/
-void setup(void)
+static void setup(void)
 {
-	/* Capture signals if any */
-	/* Create temporary directories */
 	TEST_PAUSE;
 	tst_tmpdir();
 }
 
-int sig_count = 0;
-
 void sig_handler(int sig)
 {
 	sig_count++;
@@ -146,9 +92,9 @@ int main(int ac, char **av)
 	int lc;
 	char *msg;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 
@@ -156,35 +102,34 @@ int main(int ac, char **av)
 		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
-			if (sigemptyset(&set) < 0) {
+			if (sigemptyset(&set) < 0)
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 "sigemptyset call failed");
-			}
-			if (sigaddset(&set, TEST_SIG) < 0) {
+
+			if (sigaddset(&set, TEST_SIG) < 0)
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 "sigaddset call failed");
-			}
 
 			/* call rt_sigaction() */
 			TEST(ltp_syscall(__NR_rt_sigaction, TEST_SIG, &act,
 				&oact, SIGSETSIZE));
-			if (TEST_RETURN < 0) {
+			if (TEST_RETURN < 0)
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 "rt_sigaction call failed");
-			}
+
 			/* call rt_sigprocmask() to block signal#TEST_SIG */
 			TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set,
 				     &oset, SIGSETSIZE));
-			if (TEST_RETURN == -1) {
+			if (TEST_RETURN == -1)
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 "rt_sigprocmask call failed");
-			}
+
 			/* Make sure that the masked process is indeed
 			 * masked. */
-			if (kill(getpid(), TEST_SIG) < 0) {
+			if (kill(getpid(), TEST_SIG) < 0)
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 "call to kill() failed");
-			}
+
 			if (sig_count) {
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 "rt_sigprocmask() failed to change "
@@ -193,26 +138,26 @@ int main(int ac, char **av)
 				/* call rt_sigpending() */
 				TEST(ltp_syscall(__NR_rt_sigpending, &oset,
 					     SIGSETSIZE));
-				if (TEST_RETURN == -1) {
+				if (TEST_RETURN == -1)
 					tst_brkm(TFAIL | TTERRNO, cleanup,
 						 "rt_sigpending call failed");
-				}
+
 				TEST(sigismember(&oset, TEST_SIG));
-				if (TEST_RETURN == 0) {
+				if (TEST_RETURN == 0)
 					tst_brkm(TFAIL | TTERRNO,
 						 cleanup,
 						 "sigismember call failed");
-				}
+
 				/* call rt_sigprocmask() to unblock
 				 * signal#TEST_SIG */
 				TEST(ltp_syscall(__NR_rt_sigprocmask,
 					     SIG_UNBLOCK, &set, &oset,
 					     SIGSETSIZE));
-				if (TEST_RETURN == -1) {
+				if (TEST_RETURN == -1)
 					tst_brkm(TFAIL | TTERRNO,
 						 cleanup,
 						 "rt_sigprocmask call failed");
-				}
+
 				if (sig_count) {
 					tst_resm(TPASS,
 						 "rt_sigprocmask "
@@ -224,7 +169,6 @@ int main(int ac, char **av)
 						 "rt_sigprocmask "
 						 "functionality failed");
 				}
-
 			}
 
 		}
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
index 32f406b..124592c 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
@@ -12,14 +12,14 @@
 /* the GNU General Public License for more details.                           */
 /*                                                                            */
 /* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
+/* along with this program;  if not, write to the Free Software Foundation,   */
+/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
 /*                                                                            */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
+
 /******************************************************************************/
-/*                                                                            */
-/* File:        rt_sigprocmask02.c                                              */
-/*                                                                            */
 /* Description: This tests the rt_sigprocmask() syscall                       */
 /*		rt_sigprocmask changes the list of currently blocked signals. */
 /*		The set value stores the signal mask of the pending signals.  */
@@ -49,23 +49,8 @@
 /* 			    invalid. 					      */
 /* 			-EFAULT						      */
 /* 			    An invalid set, act, or oact was specified.       */
-/*                                                                            */
-/*									      */
-/* Usage:  <for command-line>                                                 */
-/* rt_sigprocmask02 [-c n] [-e][-i n] [-I x] [-p x] [-t]                      */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   rt_sigprocmask02                                              */
-/* History:     Porting from Crackerjack to LTP is done by                    */
-/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
+
 #include <stdio.h>
 #include <signal.h>
 #include <errno.h>
@@ -78,61 +63,21 @@
 char *TCID = "rt_sigprocmask02";
 int TST_TOTAL = 2;
 
-/* Extern Global Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    cleanup                                                       */
-/*                                                                            */
-/* Description: Performs all one time clean up for this test on successful    */
-/*              completion,  premature exit or  failure. Closes all temporary */
-/*              files, removes all temporary directories exits the test with  */
-/*              appropriate return code by calling tst_exit() function.       */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*              On success - Exits calling tst_exit(). With '0' return code.  */
-/*                                                                            */
-/******************************************************************************/
-void cleanup(void)
+static void cleanup(void)
 {
-
 	TEST_CLEANUP;
 	tst_rmdir();
-
 }
 
-/* Local  Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    setup                                                         */
-/*                                                                            */
-/* Description: Performs all one time setup for this test. This function is   */
-/*              typically used to capture signals, create temporary dirs      */
-/*              and temporary files that may be used in the course of this    */
-/*              test.                                                         */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits by calling cleanup().                      */
-/*              On success - returns 0.                                       */
-/*                                                                            */
-/******************************************************************************/
-void setup(void)
+static void setup(void)
 {
-	/* Capture signals if any */
-	/* Create temporary directories */
 	TEST_PAUSE;
 	tst_tmpdir();
 }
 
-sigset_t set;
+static sigset_t set;
 
-struct test_case_t {
+static struct test_case_t {
 	sigset_t *ss;
 	int sssize;
 	int exp_errno;
@@ -150,21 +95,18 @@ int main(int ac, char **av)
 	sigset_t s;
 	char *msg;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-		tst_exit();
-	}
 
 	setup();
 
 	tst_count = 0;
 
 	TEST(sigfillset(&s));
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "Call to sigfillset() failed.");
-		cleanup();
-		tst_exit();
-	}
+	if (TEST_RETURN == -1)
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			"Call to sigfillset() failed.");
 
 	for (i = 0; i < test_count; i++) {
 		TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_BLOCK,
@@ -183,5 +125,4 @@ int main(int ac, char **av)
 
 	cleanup();
 	tst_exit();
-
 }
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index d14cdf8..6ee41d0 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -1,42 +1,27 @@
-/********************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007				   	*/
-/*									    	*/
-/* This program is free software;  you can redistribute it and/or modify      	*/
-/* it under the terms of the GNU General Public License as published by       	*/
-/* the Free Software Foundation; either version 2 of the License, or	  	*/
-/* (at your option) any later version.						*/
-/*									    	*/
-/* This program is distributed in the hope that it will be useful,	    	*/
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of	    	*/
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		  	*/
-/* the GNU General Public License for more details.			   	*/
-/*									    	*/
-/* You should have received a copy of the GNU General Public License	  	*/
-/* along with this program;  if not, write to the Free Software	       	*/
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    	*/
-/*									    	*/
-/******************************************************************************	*/
-/******************************************************************************	*/
-/*									    	*/
-/* File:	rt_sigsuspend01.c					   	*/
-/*									    	*/
-/* Description: This tests the rt_sigsuspend() syscall.		      	*/
-/*									       	*/
-/* Usage:  <for command-line>						 	*/
-/* rt_sigsuspend01 [-c n] [-e][-i n] [-I x] [-p x] [-t]		     	*/
-/*      where,  -c n : Run n copies concurrently.			     	*/
-/*	      -e   : Turn on errno logging.				 	*/
-/*	      -i n : Execute test n times.				  	*/
-/*	      -I x : Execute test for x seconds.			    	*/
-/*	      -P x : Pause for x seconds between iterations.			*/
-/*	      -t   : Turn on syscall timing.					*/
-/*									    	*/
-/* Total Tests: 2							     	*/
-/*									    	*/
-/* Test Name:   rt_sigsuspend01					     	*/
-/* History:     Porting from Crackerjack to LTP is done by		    	*/
-/*	      Manas Kumar Nayak maknayak@in.ibm.com>				*/
-/********************************************************************************/
+/******************************************************************************/
+/* Copyright (c) Crackerjack Project., 2007                                   */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software Foundation,   */
+/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
+/*                                                                            */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
+/******************************************************************************/
+
+/******************************************************************************/
+/* Description: This tests the rt_sigsuspend() syscall.                       */
+/******************************************************************************/
 
 #include <stdio.h>
 #include <signal.h>
@@ -49,75 +34,33 @@
 #include "ltp_signal.h"
 
 char *TCID = "rt_sigsuspend01";
-int testno;
 int TST_TOTAL = 1;
 
-/* Extern Global Functions */
-/******************************************************************************/
-/*									    */
-/* Function:    cleanup						       */
-/*									    */
-/* Description: Performs all one time clean up for this test on successful    */
-/*	      completion,  premature exit or  failure. Closes all temporary */
-/*	      files, removes all temporary directories exits the test with  */
-/*	      appropriate return code by calling tst_exit() function.       */
-/*									    */
-/* Input:       None.							 */
-/*									    */
-/* Output:      None.							 */
-/*									    */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*	      On success - Exits calling tst_exit(). With '0' return code.  */
-/*									    */
-/******************************************************************************/
-void cleanup(void)
+static void cleanup(void)
 {
-
 	TEST_CLEANUP;
 	tst_rmdir();
-
 }
 
-/* Local  Functions */
-/******************************************************************************/
-/*									    */
-/* Function:    setup							 */
-/*									    */
-/* Description: Performs all one time setup for this test. This function is   */
-/*	      typically used to capture signals, create temporary dirs      */
-/*	      and temporary files that may be used in the course of this    */
-/*	      test.							 */
-/*									    */
-/* Input:       None.							 */
-/*									    */
-/* Output:      None.							 */
-/*									    */
-/* Return:      On failure - Exits by calling cleanup().		      */
-/*	      On success - returns 0.				       */
-/*									    */
-/******************************************************************************/
-void setup(void)
+static void setup(void)
 {
-	/* Capture signals if any */
-	/* Create temporary directories */
 	TEST_PAUSE;
 	tst_tmpdir();
 }
 
-void sig_handler(int sig)
+static void sig_handler(int sig)
 {
 }
 
 int main(int ac, char **av)
 {
-
 	sigset_t set, set1, set2;
 	int lc;
 	char *msg;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 
@@ -125,9 +68,8 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		if (sigemptyset(&set) < 0) {
+		if (sigemptyset(&set) < 0)
 			tst_brkm(TFAIL | TERRNO, cleanup, "sigemptyset failed");
-		}
 #ifdef __x86_64__
 		struct kernel_sigaction act, oact;
 		sig_initial(SIGALRM);
@@ -145,16 +87,15 @@ int main(int ac, char **av)
 
 		TEST(ltp_syscall(__NR_rt_sigaction, SIGALRM, &act, &oact,
 			     SIGSETSIZE));
-		if (TEST_RETURN == -1) {
+		if (TEST_RETURN == -1)
 			tst_brkm(TFAIL | TTERRNO, cleanup,
 				 "rt_sigaction failed");
-		}
+
 		TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0,
 			     &set1, SIGSETSIZE));
-		if (TEST_RETURN == -1) {
+		if (TEST_RETURN == -1)
 			tst_brkm(TFAIL | TTERRNO, cleanup,
 				 "rt_sigprocmask failed");
-		}
 
 		TEST(alarm(5));
 		int result;
-- 
1.7.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
