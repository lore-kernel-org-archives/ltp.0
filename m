Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1Ppb3Q-0006dL-Sa
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 06:40:00 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Ppb3O-0002LY-2g
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 06:40:00 +0000
Message-ID: <4D5B7144.9000801@cn.fujitsu.com>
Date: Wed, 16 Feb 2011 14:40:04 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D58C631.7040508@cn.fujitsu.com>	<AANLkTinXKnOn7XBWJ=+Pc=5r6ObK68s8K2VNEwpuuvBA@mail.gmail.com>	<4D58F766.6040208@cn.fujitsu.com>
	<AANLkTikdB=poh8vt8PhoiJxUFz2Zimu9oORiyyMSeu-+@mail.gmail.com>
In-Reply-To: <AANLkTikdB=poh8vt8PhoiJxUFz2Zimu9oORiyyMSeu-+@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------030702050607040601000902"
Subject: Re: [LTP] [PATCH] setfsuid04.c: the child process should exit 0
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--------------030702050607040601000902
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

Hi Garrett,

Garrett Cooper said the following on 2011-2-15 22:42:
>>>     How about this version instead? There were issues with the
>>
>> The two "TEST_ERRNO" should be replaced with "errno" in this version,
>> If not, the version will fail.
> 
> Other than that I assume things are ok?

Sorry, the child process need exit when success in do_master_child().
I rewrite a new patch base on your version, please review.
Thinks.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/syscalls/setfsuid/setfsuid04.c |  105 +++++++++++------------
 1 files changed, 49 insertions(+), 56 deletions(-)

diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
index 9129892..ddbbcde 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid04.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
@@ -43,18 +43,21 @@
  * RESTRICTIONS
  * 	Must be run as root.
  */
-#include <errno.h>
 #include <sys/types.h>
+#ifdef __GLIBC__
+#include <sys/fsuid.h>
+#endif
 #include <sys/stat.h>
 #include <sys/wait.h>
+#include <errno.h>
 #include <fcntl.h>
+#include <pwd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
-#ifdef __GLIBC__
-#include <sys/fsuid.h>
-#endif
 #include "test.h"
 #include "usctest.h"
-#include <pwd.h>
 
 char *TCID = "setfsuid04";
 int TST_TOTAL = 1;
@@ -76,13 +79,9 @@ int main(int ac, char **av)
 	int status;
 
 	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	 }
 
-	/*
-	 * perform global setup for the test
-	 */
 	setup();
 
 	TEST_EXP_ENOS(exp_enos);
@@ -91,20 +90,16 @@ int main(int ac, char **av)
 	if (pid < 0)
 		tst_brkm(TBROK, cleanup, "Fork failed");
 
-	if (pid == 0) {
+	if (pid == 0)
 		do_master_child();
 
-	} else {
-		waitpid(pid, &status, 0);
-		if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
-			tst_resm(WEXITSTATUS(status),
-				 "son process exits with error");
-	}
+	if (waitpid(pid, &status, 0) == -1)
+		tst_resm(TBROK|TERRNO, "waitpid failed");
+	if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
+		tst_resm(TFAIL, "child process terminated abnormally");
 
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
 /*
@@ -123,27 +118,26 @@ void do_master_child()
 		Tst_count = 0;
 
 		if (setfsuid(ltpuser->pw_uid) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "setfsuid failed to set the euid to %d",
-				 ltpuser->pw_uid);
+			perror("setfsuid failed");
+			exit(1);
 		}
 
 		/* Test 1: Check the process with new uid cannot open the file
 		 *         with RDWR permissions.
 		 */
-		TEST(tst_fd = open(testfile, O_RDWR));
+		tst_fd = open(testfile, O_RDWR);
 
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
+		if (tst_fd != -1) {
+			printf("open succeeded unexpectedly\n");
 			close(tst_fd);
+			exit(1);
 		}
 
-		if (TEST_ERRNO == EACCES) {
-			tst_resm(TPASS, "open returned errno EACCES");
-		} else {
-			tst_resm(TFAIL, "open returned unexpected errno - %d",
-				 TEST_ERRNO);
-			continue;
+		if (errno == EACCES)
+			printf("open failed with EACCES as expected\n");
+		else {
+			perror("open failed unexpectedly");
+			exit(1);
 		}
 
 		/* Test 2: Check a son process cannot open the file
@@ -157,27 +151,28 @@ void do_master_child()
 			int tst_fd2;
 
 			/* Test to open the file in son process */
-			TEST(tst_fd2 = open(testfile, O_RDWR));
+			tst_fd2 = open(testfile, O_RDWR);
 
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
+			if (tst_fd2 != -1) {
+				printf("call succeeded unexpectedly\n");
 				close(tst_fd2);
+				exit(1);
 			}
 
-			TEST_ERROR_LOG(TEST_ERRNO);
-
-			if (TEST_ERRNO == EACCES) {
-				tst_resm(TPASS, "open returned errno EACCES");
+			if (errno == EACCES) {
+				printf("open failed with EACCES as expected\n");
+				exit(0);
 			} else {
-				tst_resm(TFAIL,
-					 "open returned unexpected errno - %d",
-					 TEST_ERRNO);
+				printf("open failed unexpectedly\n");
+				exit(1);
 			}
-			continue;
 		} else {
 			/* Wait for son completion */
-			waitpid(pid, &status, 0);
-			if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
+			if (waitpid(pid, &status, 0) == -1) {
+				perror("waitpid failed");
+				exit(1);
+			}
+			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 				exit(WEXITSTATUS(status));
 		}
 
@@ -186,21 +181,21 @@ void do_master_child()
 		 */
 		Tst_count++;
 		if (setfsuid(0) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "setfsuid failed to set the euid to 0");
+			perror("setfsuid failed");
+			exit(1);
 		}
 
-		TEST(tst_fd = open(testfile, O_RDWR));
+		tst_fd = open(testfile, O_RDWR);
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "open returned unexpected errno %d",
-				 TEST_ERRNO);
-			continue;
+		if (tst_fd == -1) {
+			perror("open failed unexpectedly");
+			exit(1);
 		} else {
-			tst_resm(TPASS, "open call succeeded");
+			printf("open call succeeded\n");
 			close(tst_fd);
 		}
 	}
+	exit(0);
 }
 
 /*
@@ -208,9 +203,7 @@ void do_master_child()
  */
 void setup(void)
 {
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);
 
 	ltpuser = getpwnam(nobody_uid);
 
@@ -244,4 +237,4 @@ void cleanup(void)
 
 	tst_rmdir();
 
-}
\ No newline at end of file
+}
-- 
1.7.3.1

-- 
Best Regards,
Peng Haitao

--------------030702050607040601000902
Content-Type: text/plain;
	name="0001-setfsuid04.c-the-child-process-should-exit-0.patch"
Content-Disposition: attachment;
	filename="0001-setfsuid04.c-the-child-process-should-exit-0.patch"
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>=0A---=0A testcases/kerne=
l/syscalls/setfsuid/setfsuid04.c |  105 +++++++++++------------=0A 1 files =
changed, 49 insertions(+), 56 deletions(-)=0A=0Adiff --git a/testcases/kern=
el/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setf=
suid04.c=0Aindex 9129892..ddbbcde 100644=0A--- a/testcases/kernel/syscalls/=
setfsuid/setfsuid04.c=0A+++ b/testcases/kernel/syscalls/setfsuid/setfsuid04=
.c=0A@@ -43,18 +43,21 @@=0A  * RESTRICTIONS=0A  * 	Must be run as root.=0A =
 */=0A-#include <errno.h>=0A #include <sys/types.h>=0A+#ifdef =5F=5FGLIBC=
=5F=5F=0A+#include <sys/fsuid.h>=0A+#endif=0A #include <sys/stat.h>=0A #inc=
lude <sys/wait.h>=0A+#include <errno.h>=0A #include <fcntl.h>=0A+#include <=
pwd.h>=0A+#include <stdio.h>=0A+#include <stdlib.h>=0A+#include <string.h>=
=0A #include <unistd.h>=0A-#ifdef =5F=5FGLIBC=5F=5F=0A-#include <sys/fsuid.=
h>=0A-#endif=0A #include "test.h"=0A #include "usctest.h"=0A-#include <pwd.=
h>=0A =0A char *TCID =3D "setfsuid04";=0A int TST=5FTOTAL =3D 1;=0A@@ -76,1=
3 +79,9 @@ int main(int ac, char **av)=0A 	int status;=0A =0A 	/* parse sta=
ndard options */=0A-	if ((msg =3D parse=5Fopts(ac, av, NULL, NULL)) !=3D NU=
LL) {=0A+	if ((msg =3D parse=5Fopts(ac, av, NULL, NULL)) !=3D NULL)=0A 		ts=
t=5Fbrkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);=0A-	 }=0A =0A-	/*=
=0A-	 * perform global setup for the test=0A-	 */=0A 	setup();=0A =0A 	TEST=
=5FEXP=5FENOS(exp=5Fenos);=0A@@ -91,20 +90,16 @@ int main(int ac, char **av=
)=0A 	if (pid < 0)=0A 		tst=5Fbrkm(TBROK, cleanup, "Fork failed");=0A =0A-	=
if (pid =3D=3D 0) {=0A+	if (pid =3D=3D 0)=0A 		do=5Fmaster=5Fchild();=0A =
=0A-	} else {=0A-		waitpid(pid, &status, 0);=0A-		if (!WIFEXITED(status) ||=
 (WEXITSTATUS(status) !=3D 0))=0A-			tst=5Fresm(WEXITSTATUS(status),=0A-			=
	 "son process exits with error");=0A-	}=0A+	if (waitpid(pid, &status, 0) =
=3D=3D -1)=0A+		tst=5Fresm(TBROK|TERRNO, "waitpid failed");=0A+	if (!WIFEXI=
TED(status) || (WEXITSTATUS(status) !=3D 0))=0A+		tst=5Fresm(TFAIL, "child =
process terminated abnormally");=0A =0A 	cleanup();=0A 	tst=5Fexit();=0A-	t=
st=5Fexit();=0A-=0A }=0A =0A /*=0A@@ -123,27 +118,26 @@ void do=5Fmaster=5F=
child()=0A 		Tst=5Fcount =3D 0;=0A =0A 		if (setfsuid(ltpuser->pw=5Fuid) =
=3D=3D -1) {=0A-			tst=5Fbrkm(TBROK, cleanup,=0A-				 "setfsuid failed to s=
et the euid to %d",=0A-				 ltpuser->pw=5Fuid);=0A+			perror("setfsuid fail=
ed");=0A+			exit(1);=0A 		}=0A =0A 		/* Test 1: Check the process with new =
uid cannot open the file=0A 		 *         with RDWR permissions.=0A 		 */=0A=
-		TEST(tst=5Ffd =3D open(testfile, O=5FRDWR));=0A+		tst=5Ffd =3D open(test=
file, O=5FRDWR);=0A =0A-		if (TEST=5FRETURN !=3D -1) {=0A-			tst=5Fresm(TFA=
IL, "call succeeded unexpectedly");=0A+		if (tst=5Ffd !=3D -1) {=0A+			prin=
tf("open succeeded unexpectedly\n");=0A 			close(tst=5Ffd);=0A+			exit(1);=
=0A 		}=0A =0A-		if (TEST=5FERRNO =3D=3D EACCES) {=0A-			tst=5Fresm(TPASS, =
"open returned errno EACCES");=0A-		} else {=0A-			tst=5Fresm(TFAIL, "open =
returned unexpected errno - %d",=0A-				 TEST=5FERRNO);=0A-			continue;=0A+=
		if (errno =3D=3D EACCES)=0A+			printf("open failed with EACCES as expecte=
d\n");=0A+		else {=0A+			perror("open failed unexpectedly");=0A+			exit(1);=
=0A 		}=0A =0A 		/* Test 2: Check a son process cannot open the file=0A@@ -=
157,27 +151,28 @@ void do=5Fmaster=5Fchild()=0A 			int tst=5Ffd2;=0A =0A 		=
	/* Test to open the file in son process */=0A-			TEST(tst=5Ffd2 =3D open(t=
estfile, O=5FRDWR));=0A+			tst=5Ffd2 =3D open(testfile, O=5FRDWR);=0A =0A-	=
		if (TEST=5FRETURN !=3D -1) {=0A-				tst=5Fresm(TFAIL, "call succeeded une=
xpectedly");=0A+			if (tst=5Ffd2 !=3D -1) {=0A+				printf("call succeeded u=
nexpectedly\n");=0A 				close(tst=5Ffd2);=0A+				exit(1);=0A 			}=0A =0A-		=
	TEST=5FERROR=5FLOG(TEST=5FERRNO);=0A-=0A-			if (TEST=5FERRNO =3D=3D EACCES=
) {=0A-				tst=5Fresm(TPASS, "open returned errno EACCES");=0A+			if (errno=
 =3D=3D EACCES) {=0A+				printf("open failed with EACCES as expected\n");=
=0A+				exit(0);=0A 			} else {=0A-				tst=5Fresm(TFAIL,=0A-					 "open ret=
urned unexpected errno - %d",=0A-					 TEST=5FERRNO);=0A+				printf("open f=
ailed unexpectedly\n");=0A+				exit(1);=0A 			}=0A-			continue;=0A 		} else=
 {=0A 			/* Wait for son completion */=0A-			waitpid(pid, &status, 0);=0A-	=
		if (!WIFEXITED(status) || (WEXITSTATUS(status) !=3D 0))=0A+			if (waitpid=
(pid, &status, 0) =3D=3D -1) {=0A+				perror("waitpid failed");=0A+				exit=
(1);=0A+			}=0A+			if (!WIFEXITED(status) || WEXITSTATUS(status) !=3D 0)=0A=
 				exit(WEXITSTATUS(status));=0A 		}=0A =0A@@ -186,21 +181,21 @@ void do=
=5Fmaster=5Fchild()=0A 		 */=0A 		Tst=5Fcount++;=0A 		if (setfsuid(0) =3D=
=3D -1) {=0A-			tst=5Fbrkm(TBROK, cleanup,=0A-				 "setfsuid failed to set =
the euid to 0");=0A+			perror("setfsuid failed");=0A+			exit(1);=0A 		}=0A =
=0A-		TEST(tst=5Ffd =3D open(testfile, O=5FRDWR));=0A+		tst=5Ffd =3D open(t=
estfile, O=5FRDWR);=0A =0A-		if (TEST=5FRETURN =3D=3D -1) {=0A-			tst=5Fres=
m(TFAIL, "open returned unexpected errno %d",=0A-				 TEST=5FERRNO);=0A-			=
continue;=0A+		if (tst=5Ffd =3D=3D -1) {=0A+			perror("open failed unexpect=
edly");=0A+			exit(1);=0A 		} else {=0A-			tst=5Fresm(TPASS, "open call suc=
ceeded");=0A+			printf("open call succeeded\n");=0A 			close(tst=5Ffd);=0A =
		}=0A 	}=0A+	exit(0);=0A }=0A =0A /*=0A@@ -208,9 +203,7 @@ void do=5Fmaste=
r=5Fchild()=0A  */=0A void setup(void)=0A {=0A-	if (geteuid() !=3D 0) {=0A-=
		tst=5Fbrkm(TBROK, NULL, "Test must be run as root");=0A-	}=0A+	tst=5Frequ=
ire=5Froot(NULL);=0A =0A 	ltpuser =3D getpwnam(nobody=5Fuid);=0A =0A@@ -244=
,4 +237,4 @@ void cleanup(void)=0A =0A 	tst=5Frmdir();=0A =0A-}=0A\ No newl=
ine at end of file=0A+}=0A-- =0A1.7.3.1=0A=0A=

--------------030702050607040601000902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
--------------030702050607040601000902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030702050607040601000902--


