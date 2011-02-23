Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1PsBM2-0006Mm-J2
	for ltp-list@lists.sourceforge.net; Wed, 23 Feb 2011 09:49:54 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PsBLz-00083u-Hk
	for ltp-list@lists.sourceforge.net; Wed, 23 Feb 2011 09:49:54 +0000
Message-ID: <4D64D84D.3050205@cn.fujitsu.com>
Date: Wed, 23 Feb 2011 17:50:05 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D58C631.7040508@cn.fujitsu.com>	<AANLkTinXKnOn7XBWJ=+Pc=5r6ObK68s8K2VNEwpuuvBA@mail.gmail.com>	<4D58F766.6040208@cn.fujitsu.com>	<AANLkTikdB=poh8vt8PhoiJxUFz2Zimu9oORiyyMSeu-+@mail.gmail.com>	<4D5B7144.9000801@cn.fujitsu.com>	<AANLkTim23RXT05JSZHwY0Bhnki4qz2T3vNen35gKFn1=@mail.gmail.com>
	<4D5B7C44.6080005@cn.fujitsu.com>
In-Reply-To: <4D5B7C44.6080005@cn.fujitsu.com>
Content-Type: multipart/mixed; boundary="------------080205080904050906090200"
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


--------------080205080904050906090200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

Hi Garrett,

Peng Haitao said the following on 2011-2-16 15:27:
>>     This is what the code currently looks like. I assume the same
>> needs to be done for the other set*suid syscall testcases?
> 
> setresuid and setreuid also need to be fixed at least.
> Thanks.
> 

 The following patch fix the cases of setresuid and setreuid.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/syscalls/setresuid/setresuid04.c |   71 +++++++++------------
 testcases/kernel/syscalls/setreuid/setreuid07.c   |   71 +++++++++------------
 2 files changed, 62 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/syscalls/setresuid/setresuid04.c b/testcases/kernel/syscalls/setresuid/setresuid04.c
index 13c7a8f..eef0d11 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid04.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
@@ -74,13 +74,8 @@ int main(int ac, char **av)
 	int status;
 
 	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	 }
-
-	/*
-	 * perform global setup for the test
-	 */
 	setup();
 
 	TEST_EXP_ENOS(exp_enos);
@@ -89,20 +84,16 @@ int main(int ac, char **av)
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
@@ -121,9 +112,8 @@ void do_master_child()
 		Tst_count = 0;
 
 		if (setresuid(0, ltpuser->pw_uid, 0) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "setresuid failed to set the euid to %d",
-				 ltpuser->pw_uid);
+			perror("setfsuid failed");
+			exit(1);
 		}
 
 		/* Test 1: Check the process with new uid cannot open the file
@@ -132,16 +122,16 @@ void do_master_child()
 		TEST(tst_fd = open(testfile, O_RDWR));
 
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
+			printf("open succeeded unexpectedly\n");
 			close(tst_fd);
+			exit(1);
 		}
 
 		if (TEST_ERRNO == EACCES) {
-			tst_resm(TPASS, "open returned errno EACCES");
+			printf("open failed with EACCES as expected\n");
 		} else {
-			tst_resm(TFAIL, "open returned unexpected errno - %d",
-				 TEST_ERRNO);
-			continue;
+			perror("open failed unexpectedly");
+			exit(1);
 		}
 
 		/* Test 2: Check a son process cannot open the file
@@ -158,23 +148,26 @@ void do_master_child()
 			TEST(tst_fd2 = open(testfile, O_RDWR));
 
 			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
+				printf("call succeeded unexpectedly\n");
 				close(tst_fd2);
+				exit(1);
 			}
 
 			TEST_ERROR_LOG(TEST_ERRNO);
 
 			if (TEST_ERRNO == EACCES) {
-				tst_resm(TPASS, "open returned errno EACCES");
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
+			if(waitpid(pid, &status, 0) == -1) {
+				perror("waitpid failed");
+				exit(1);
+			}
 			if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
 				exit(WEXITSTATUS(status));
 		}
@@ -184,21 +177,21 @@ void do_master_child()
 		 */
 		Tst_count++;
 		if (setresuid(0, 0, 0) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "setresuid failed to set the euid to 0");
+			perror("setfsuid failed");
+			exit(1);
 		}
 
 		TEST(tst_fd = open(testfile, O_RDWR));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "open returned unexpected errno %d",
-				 TEST_ERRNO);
-			continue;
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
@@ -206,9 +199,7 @@ void do_master_child()
  */
 void setup(void)
 {
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);
 
 	ltpuser = getpwnam(nobody_uid);
 
@@ -242,4 +233,4 @@ void cleanup(void)
 
 	tst_rmdir();
 
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/setreuid/setreuid07.c b/testcases/kernel/syscalls/setreuid/setreuid07.c
index 19025cd..69bb25f 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid07.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid07.c
@@ -73,13 +73,8 @@ int main(int ac, char **av)
 	int status;
 
 	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	 }
-
-	/*
-	 * perform global setup for the test
-	 */
 	setup();
 
 	TEST_EXP_ENOS(exp_enos);
@@ -88,20 +83,16 @@ int main(int ac, char **av)
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
@@ -120,9 +111,8 @@ void do_master_child()
 		Tst_count = 0;
 
 		if (setreuid(0, ltpuser->pw_uid) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "setreuid failed to set the euid to %d",
-				 ltpuser->pw_uid);
+			perror("setfsuid failed");
+			exit(1);
 		}
 
 		/* Test 1: Check the process with new uid cannot open the file
@@ -131,16 +121,16 @@ void do_master_child()
 		TEST(tst_fd = open(testfile, O_RDWR));
 
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
+			printf("open succeeded unexpectedly\n");
 			close(tst_fd);
+			exit(1);
 		}
 
 		if (TEST_ERRNO == EACCES) {
-			tst_resm(TPASS, "open returned errno EACCES");
+			printf("open failed with EACCES as expected\n");
 		} else {
-			tst_resm(TFAIL, "open returned unexpected errno - %d",
-				 TEST_ERRNO);
-			continue;
+			perror("open failed unexpectedly");
+			exit(1);
 		}
 
 		/* Test 2: Check a son process cannot open the file
@@ -157,23 +147,26 @@ void do_master_child()
 			TEST(tst_fd2 = open(testfile, O_RDWR));
 
 			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
+				printf("call succeeded unexpectedly\n");
 				close(tst_fd2);
+				exit(1);
 			}
 
 			TEST_ERROR_LOG(TEST_ERRNO);
 
 			if (TEST_ERRNO == EACCES) {
-				tst_resm(TPASS, "open returned errno EACCES");
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
+			if (waitpid(pid, &status, 0) == -1) {
+				perror("waitpid failed");
+				exit(1);
+			}
 			if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
 				exit(WEXITSTATUS(status));
 		}
@@ -183,21 +176,21 @@ void do_master_child()
 		 */
 		Tst_count++;
 		if (setreuid(0, 0) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "setreuid failed to set the euid to 0");
+			perror("setfsuid failed");
+			exit(1);
 		}
 
 		TEST(tst_fd = open(testfile, O_RDWR));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "open returned unexpected errno %d",
-				 TEST_ERRNO);
-			continue;
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
@@ -205,9 +198,7 @@ void do_master_child()
  */
 void setup(void)
 {
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);
 
 	ltpuser = getpwnam(nobody_uid);
 
@@ -241,4 +232,4 @@ void cleanup(void)
 
 	tst_rmdir();
 
-}
\ No newline at end of file
+}
-- 
1.7.1

-- 
Best Regards,
Peng Haitao

--------------080205080904050906090200
Content-Type: text/plain;
 name="0001-the-child-process-should-exit-0.patch"
Content-Disposition: attachment;
	filename="0001-the-child-process-should-exit-0.patch"
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>=0A---=0A testcases/kerne=
l/syscalls/setresuid/setresuid04.c |   71 +++++++++------------=0A testcase=
s/kernel/syscalls/setreuid/setreuid07.c   |   71 +++++++++------------=0A 2=
 files changed, 62 insertions(+), 80 deletions(-)=0A=0Adiff --git a/testcas=
es/kernel/syscalls/setresuid/setresuid04.c b/testcases/kernel/syscalls/setr=
esuid/setresuid04.c=0Aindex 13c7a8f..eef0d11 100644=0A--- a/testcases/kerne=
l/syscalls/setresuid/setresuid04.c=0A+++ b/testcases/kernel/syscalls/setres=
uid/setresuid04.c=0A@@ -74,13 +74,8 @@ int main(int ac, char **av)=0A 	int =
status;=0A =0A 	/* parse standard options */=0A-	if ((msg =3D parse=5Fopts(=
ac, av, NULL, NULL)) !=3D NULL) {=0A+	if ((msg =3D parse=5Fopts(ac, av, NUL=
L, NULL)) !=3D NULL)=0A 		tst=5Fbrkm(TBROK, NULL, "OPTION PARSING ERROR - %=
s", msg);=0A-	 }=0A-=0A-	/*=0A-	 * perform global setup for the test=0A-	 *=
/=0A 	setup();=0A =0A 	TEST=5FEXP=5FENOS(exp=5Fenos);=0A@@ -89,20 +84,16 @@=
 int main(int ac, char **av)=0A 	if (pid < 0)=0A 		tst=5Fbrkm(TBROK, cleanu=
p, "Fork failed");=0A =0A-	if (pid =3D=3D 0) {=0A+	if (pid =3D=3D 0)=0A 		d=
o=5Fmaster=5Fchild();=0A =0A-	} else {=0A-		waitpid(pid, &status, 0);=0A-		=
if (!WIFEXITED(status) || (WEXITSTATUS(status) !=3D 0))=0A-			tst=5Fresm(WE=
XITSTATUS(status),=0A-				 "son process exits with error");=0A-	}=0A+	if (w=
aitpid(pid, &status, 0) =3D=3D -1)=0A+		tst=5Fresm(TBROK|TERRNO, "waitpid f=
ailed");=0A+	if (!WIFEXITED(status) || (WEXITSTATUS(status) !=3D 0))=0A+		t=
st=5Fresm(TFAIL, "child process terminated abnormally");=0A =0A 	cleanup();=
=0A 	tst=5Fexit();=0A-	tst=5Fexit();=0A-=0A }=0A =0A /*=0A@@ -121,9 +112,8 =
@@ void do=5Fmaster=5Fchild()=0A 		Tst=5Fcount =3D 0;=0A =0A 		if (setresui=
d(0, ltpuser->pw=5Fuid, 0) =3D=3D -1) {=0A-			tst=5Fbrkm(TBROK, cleanup,=0A=
-				 "setresuid failed to set the euid to %d",=0A-				 ltpuser->pw=5Fuid);=
=0A+			perror("setfsuid failed");=0A+			exit(1);=0A 		}=0A =0A 		/* Test 1:=
 Check the process with new uid cannot open the file=0A@@ -132,16 +122,16 @=
@ void do=5Fmaster=5Fchild()=0A 		TEST(tst=5Ffd =3D open(testfile, O=5FRDWR=
));=0A =0A 		if (TEST=5FRETURN !=3D -1) {=0A-			tst=5Fresm(TFAIL, "call suc=
ceeded unexpectedly");=0A+			printf("open succeeded unexpectedly\n");=0A 		=
	close(tst=5Ffd);=0A+			exit(1);=0A 		}=0A =0A 		if (TEST=5FERRNO =3D=3D EA=
CCES) {=0A-			tst=5Fresm(TPASS, "open returned errno EACCES");=0A+			printf=
("open failed with EACCES as expected\n");=0A 		} else {=0A-			tst=5Fresm(T=
FAIL, "open returned unexpected errno - %d",=0A-				 TEST=5FERRNO);=0A-			c=
ontinue;=0A+			perror("open failed unexpectedly");=0A+			exit(1);=0A 		}=0A=
 =0A 		/* Test 2: Check a son process cannot open the file=0A@@ -158,23 +14=
8,26 @@ void do=5Fmaster=5Fchild()=0A 			TEST(tst=5Ffd2 =3D open(testfile, =
O=5FRDWR));=0A =0A 			if (TEST=5FRETURN !=3D -1) {=0A-				tst=5Fresm(TFAIL,=
 "call succeeded unexpectedly");=0A+				printf("call succeeded unexpectedly=
\n");=0A 				close(tst=5Ffd2);=0A+				exit(1);=0A 			}=0A =0A 			TEST=5FERR=
OR=5FLOG(TEST=5FERRNO);=0A =0A 			if (TEST=5FERRNO =3D=3D EACCES) {=0A-				=
tst=5Fresm(TPASS, "open returned errno EACCES");=0A+				printf("open failed=
 with EACCES as expected\n");=0A+				exit(0);=0A 			} else {=0A-				tst=5Fr=
esm(TFAIL,=0A-					 "open returned unexpected errno - %d",=0A-					 TEST=5F=
ERRNO);=0A+				printf("open failed unexpectedly\n");=0A+				exit(1);=0A 			=
}=0A-			continue;=0A 		} else {=0A 			/* Wait for son completion */=0A-			w=
aitpid(pid, &status, 0);=0A+			if(waitpid(pid, &status, 0) =3D=3D -1) {=0A+=
				perror("waitpid failed");=0A+				exit(1);=0A+			}=0A 			if (!WIFEXITED(=
status) || (WEXITSTATUS(status) !=3D 0))=0A 				exit(WEXITSTATUS(status));=
=0A 		}=0A@@ -184,21 +177,21 @@ void do=5Fmaster=5Fchild()=0A 		 */=0A 		Ts=
t=5Fcount++;=0A 		if (setresuid(0, 0, 0) =3D=3D -1) {=0A-			tst=5Fbrkm(TBRO=
K, cleanup,=0A-				 "setresuid failed to set the euid to 0");=0A+			perror(=
"setfsuid failed");=0A+			exit(1);=0A 		}=0A =0A 		TEST(tst=5Ffd =3D open(t=
estfile, O=5FRDWR));=0A =0A 		if (TEST=5FRETURN =3D=3D -1) {=0A-			tst=5Fre=
sm(TFAIL, "open returned unexpected errno %d",=0A-				 TEST=5FERRNO);=0A-		=
	continue;=0A+			perror("open failed unexpectedly");=0A+			exit(1);=0A 		} =
else {=0A-			tst=5Fresm(TPASS, "open call succeeded");=0A+			printf("open c=
all succeeded\n");=0A 			close(tst=5Ffd);=0A 		}=0A 	}=0A+	exit(0);=0A }=0A=
 =0A /*=0A@@ -206,9 +199,7 @@ void do=5Fmaster=5Fchild()=0A  */=0A void set=
up(void)=0A {=0A-	if (geteuid() !=3D 0) {=0A-		tst=5Fbrkm(TBROK, NULL, "Tes=
t must be run as root");=0A-	}=0A+	tst=5Frequire=5Froot(NULL);=0A =0A 	ltpu=
ser =3D getpwnam(nobody=5Fuid);=0A =0A@@ -242,4 +233,4 @@ void cleanup(void=
)=0A =0A 	tst=5Frmdir();=0A =0A-}=0A\ No newline at end of file=0A+}=0Adiff=
 --git a/testcases/kernel/syscalls/setreuid/setreuid07.c b/testcases/kernel=
/syscalls/setreuid/setreuid07.c=0Aindex 19025cd..69bb25f 100644=0A--- a/tes=
tcases/kernel/syscalls/setreuid/setreuid07.c=0A+++ b/testcases/kernel/sysca=
lls/setreuid/setreuid07.c=0A@@ -73,13 +73,8 @@ int main(int ac, char **av)=
=0A 	int status;=0A =0A 	/* parse standard options */=0A-	if ((msg =3D pars=
e=5Fopts(ac, av, NULL, NULL)) !=3D NULL) {=0A+	if ((msg =3D parse=5Fopts(ac=
, av, NULL, NULL)) !=3D NULL)=0A 		tst=5Fbrkm(TBROK, NULL, "OPTION PARSING =
ERROR - %s", msg);=0A-	 }=0A-=0A-	/*=0A-	 * perform global setup for the te=
st=0A-	 */=0A 	setup();=0A =0A 	TEST=5FEXP=5FENOS(exp=5Fenos);=0A@@ -88,20 =
+83,16 @@ int main(int ac, char **av)=0A 	if (pid < 0)=0A 		tst=5Fbrkm(TBRO=
K, cleanup, "Fork failed");=0A =0A-	if (pid =3D=3D 0) {=0A+	if (pid =3D=3D =
0)=0A 		do=5Fmaster=5Fchild();=0A =0A-	} else {=0A-		waitpid(pid, &status, =
0);=0A-		if (!WIFEXITED(status) || (WEXITSTATUS(status) !=3D 0))=0A-			tst=
=5Fresm(WEXITSTATUS(status),=0A-				 "son process exits with error");=0A-	}=
=0A+	if (waitpid(pid, &status, 0) =3D=3D -1)=0A+		tst=5Fresm(TBROK|TERRNO, =
"waitpid failed");=0A+	if (!WIFEXITED(status) || (WEXITSTATUS(status) !=3D =
0))=0A+		tst=5Fresm(TFAIL, "child process terminated abnormally");=0A =0A 	=
cleanup();=0A 	tst=5Fexit();=0A-	tst=5Fexit();=0A-=0A }=0A =0A /*=0A@@ -120=
,9 +111,8 @@ void do=5Fmaster=5Fchild()=0A 		Tst=5Fcount =3D 0;=0A =0A 		if=
 (setreuid(0, ltpuser->pw=5Fuid) =3D=3D -1) {=0A-			tst=5Fbrkm(TBROK, clean=
up,=0A-				 "setreuid failed to set the euid to %d",=0A-				 ltpuser->pw=5F=
uid);=0A+			perror("setfsuid failed");=0A+			exit(1);=0A 		}=0A =0A 		/* Te=
st 1: Check the process with new uid cannot open the file=0A@@ -131,16 +121=
,16 @@ void do=5Fmaster=5Fchild()=0A 		TEST(tst=5Ffd =3D open(testfile, O=
=5FRDWR));=0A =0A 		if (TEST=5FRETURN !=3D -1) {=0A-			tst=5Fresm(TFAIL, "c=
all succeeded unexpectedly");=0A+			printf("open succeeded unexpectedly\n")=
;=0A 			close(tst=5Ffd);=0A+			exit(1);=0A 		}=0A =0A 		if (TEST=5FERRNO =
=3D=3D EACCES) {=0A-			tst=5Fresm(TPASS, "open returned errno EACCES");=0A+=
			printf("open failed with EACCES as expected\n");=0A 		} else {=0A-			tst=
=5Fresm(TFAIL, "open returned unexpected errno - %d",=0A-				 TEST=5FERRNO)=
;=0A-			continue;=0A+			perror("open failed unexpectedly");=0A+			exit(1);=
=0A 		}=0A =0A 		/* Test 2: Check a son process cannot open the file=0A@@ -=
157,23 +147,26 @@ void do=5Fmaster=5Fchild()=0A 			TEST(tst=5Ffd2 =3D open(=
testfile, O=5FRDWR));=0A =0A 			if (TEST=5FRETURN !=3D -1) {=0A-				tst=5Fr=
esm(TFAIL, "call succeeded unexpectedly");=0A+				printf("call succeeded un=
expectedly\n");=0A 				close(tst=5Ffd2);=0A+				exit(1);=0A 			}=0A =0A 			=
TEST=5FERROR=5FLOG(TEST=5FERRNO);=0A =0A 			if (TEST=5FERRNO =3D=3D EACCES)=
 {=0A-				tst=5Fresm(TPASS, "open returned errno EACCES");=0A+				printf("o=
pen failed with EACCES as expected\n");=0A+				exit(0);=0A 			} else {=0A-	=
			tst=5Fresm(TFAIL,=0A-					 "open returned unexpected errno - %d",=0A-			=
		 TEST=5FERRNO);=0A+				printf("open failed unexpectedly\n");=0A+				exit(=
1);=0A 			}=0A-			continue;=0A 		} else {=0A 			/* Wait for son completion =
*/=0A-			waitpid(pid, &status, 0);=0A+			if (waitpid(pid, &status, 0) =3D=
=3D -1) {=0A+				perror("waitpid failed");=0A+				exit(1);=0A+			}=0A 			if=
 (!WIFEXITED(status) || (WEXITSTATUS(status) !=3D 0))=0A 				exit(WEXITSTAT=
US(status));=0A 		}=0A@@ -183,21 +176,21 @@ void do=5Fmaster=5Fchild()=0A 	=
	 */=0A 		Tst=5Fcount++;=0A 		if (setreuid(0, 0) =3D=3D -1) {=0A-			tst=5Fb=
rkm(TBROK, cleanup,=0A-				 "setreuid failed to set the euid to 0");=0A+			=
perror("setfsuid failed");=0A+			exit(1);=0A 		}=0A =0A 		TEST(tst=5Ffd =3D=
 open(testfile, O=5FRDWR));=0A =0A 		if (TEST=5FRETURN =3D=3D -1) {=0A-			t=
st=5Fresm(TFAIL, "open returned unexpected errno %d",=0A-				 TEST=5FERRNO)=
;=0A-			continue;=0A+			perror("open failed unexpectedly");=0A+			exit(1);=
=0A 		} else {=0A-			tst=5Fresm(TPASS, "open call succeeded");=0A+			printf=
("open call succeeded\n");=0A 			close(tst=5Ffd);=0A 		}=0A 	}=0A+	exit(0);=
=0A }=0A =0A /*=0A@@ -205,9 +198,7 @@ void do=5Fmaster=5Fchild()=0A  */=0A =
void setup(void)=0A {=0A-	if (geteuid() !=3D 0) {=0A-		tst=5Fbrkm(TBROK, NU=
LL, "Test must be run as root");=0A-	}=0A+	tst=5Frequire=5Froot(NULL);=0A =
=0A 	ltpuser =3D getpwnam(nobody=5Fuid);=0A =0A@@ -241,4 +232,4 @@ void cle=
anup(void)=0A =0A 	tst=5Frmdir();=0A =0A-}=0A\ No newline at end of file=0A=
+}=0A-- =0A1.7.1=0A=0A=

--------------080205080904050906090200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Free Software Download: Index, Search & Analyze Logs and other IT data in 
Real-Time with Splunk. Collect, index and harness all the fast moving IT data 
generated by your applications, servers and devices whether physical, virtual
or in the cloud. Deliver compliance at lower cost and gain new business 
insights. http://p.sf.net/sfu/splunk-dev2dev 
--------------080205080904050906090200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080205080904050906090200--


