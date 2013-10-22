Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYfS0-0003GK-5y
	for ltp-list@lists.sourceforge.net; Tue, 22 Oct 2013 17:09:00 +0000
Date: Tue, 22 Oct 2013 19:08:44 +0200
From: chrubis@suse.cz
Message-ID: <20131022170843.GA7753@rei>
References: <1382340317-8510-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <1382340317-8510-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] 16-bit fixes for setreuid, setregid
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> This series contains fixes for 16-bit version of syscalls for
> setreuid, setregid system calls.
> 
> And some cleanup also.

Pushed (with a few minor fixes by myself, see attached patch), thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="setere.diff"

diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
index 5674070..e67a7df 100644
--- a/testcases/kernel/syscalls/setregid/setregid02.c
+++ b/testcases/kernel/syscalls/setregid/setregid02.c
@@ -72,7 +72,7 @@ struct test_data_t {
 		    "After setregid(bin, root),"}, {
 	&inval_user, &neg_one, EINVAL, &nobody, &nobody,
 		    "After setregid(invalid group, -1),"}, {
-&neg_one, &inval_user, EINVAL, &nobody, &nobody,
+	&neg_one, &inval_user, EINVAL, &nobody, &nobody,
 		    "After setregid(-1, invalid group),"},};
 
 int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
@@ -194,6 +194,5 @@ void gid_verify(struct group *rg, struct group *eg, char *when)
 			 rg->gr_gid, eg->gr_gid);
 	} else {
 		tst_resm(TPASS, "real or effective gid was modified as expected");
-
 	}
 }
diff --git a/testcases/kernel/syscalls/setregid/setregid03.c b/testcases/kernel/syscalls/setregid/setregid03.c
index 932371b..1cbdd52 100644
--- a/testcases/kernel/syscalls/setregid/setregid03.c
+++ b/testcases/kernel/syscalls/setregid/setregid03.c
@@ -108,9 +108,9 @@ int main(int ac, char **av)
 		if (SETREGID(cleanup, sys.gr_gid, bin.gr_gid) == -1)
 			tst_brkm(TBROK, NULL, "Initial setregid failed");
 
-		if (seteuid(nobody.pw_uid) == -1) {
+		if (seteuid(nobody.pw_uid) == -1)
 			tst_brkm(TBROK, NULL, "Initial seteuid failed");
-		}
+
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, NULL, "fork failed");
 		} else if (pid == 0) {	/* child */
diff --git a/testcases/kernel/syscalls/setreuid/setreuid01.c b/testcases/kernel/syscalls/setreuid/setreuid01.c
index 45d38cb..18b5ed0 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid01.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid01.c
@@ -46,8 +46,8 @@
 #include "usctest.h"
 #include "compat_16.h"
 
-static void setup();
-static void cleanup();
+static void setup(void);
+static void cleanup(void);
 
 TCID_DEFINE(setreuid01);
 int TST_TOTAL = 5;
@@ -182,7 +182,6 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
diff --git a/testcases/kernel/syscalls/setreuid/setreuid02.c b/testcases/kernel/syscalls/setreuid/setreuid02.c
index 050df17..1263996 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid02.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid02.c
@@ -70,11 +70,9 @@ int main(int ac, char **av)
 	int lc;
 	char *msg;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	}
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -140,7 +138,6 @@ static void setup(void)
 static void cleanup(void)
 {
 	TEST_CLEANUP;
-
 }
 
 static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
diff --git a/testcases/kernel/syscalls/setreuid/setreuid03.c b/testcases/kernel/syscalls/setreuid/setreuid03.c
index 24e52d5..1074e79 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid03.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid03.c
@@ -95,11 +95,9 @@ int main(int ac, char **av)
 	int lc;
 	char *msg;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	}
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -188,7 +186,6 @@ static void setup(void)
 static void cleanup(void)
 {
 	TEST_CLEANUP;
-
 }
 
 static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
diff --git a/testcases/kernel/syscalls/setreuid/setreuid04.c b/testcases/kernel/syscalls/setreuid/setreuid04.c
index d949a4b..3010fc5 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid04.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid04.c
@@ -70,11 +70,9 @@ int main(int ac, char **av)
 	int lc;
 	char *msg;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	}
-
 	setup();
 
 	flag = 0;
diff --git a/testcases/kernel/syscalls/setreuid/setreuid05.c b/testcases/kernel/syscalls/setreuid/setreuid05.c
index c46fcd9..a379ab7 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid05.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid05.c
@@ -91,11 +91,9 @@ int main(int argc, char **argv)
 	int lc;
 	char *msg;
 
-	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	}
-
 	setup();
 
 	pass = 0;
@@ -204,7 +202,6 @@ static void setup(void)
 static void cleanup(void)
 {
 	TEST_CLEANUP;
-
 }
 
 static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
diff --git a/testcases/kernel/syscalls/setreuid/setreuid06.c b/testcases/kernel/syscalls/setreuid/setreuid06.c
index 823d10b..e4bc207 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid06.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid06.c
@@ -48,13 +48,11 @@ static void cleanup(void);
 
 int main(int argc, char **argv)
 {
-
 	int lc;
 	char *msg;
 
-	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--wRRV7LY7NUeQGEoC--

