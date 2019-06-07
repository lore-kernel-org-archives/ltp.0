From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Jun 2019 15:31:12 +0200
Subject: [LTP] [PATCH v3] syscalls/fstat{03,05}: rewrote testcases
In-Reply-To: <20190607091923.30683-1-camann@suse.com>
References: <20190607091923.30683-1-camann@suse.com>
Message-ID: <20190607133112.GA20202@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few changes, thanks.

* Made the check for return value more strict

* Changed the code so that we do not rely on test number but on expected
  errno in the segfault check, this makes the test more robust in a case
  we would add tests to the tcase structure. Also this makes the code
  more clear to the reader.

* Added code to make sure the child has exitted with 0 in normal case

diff --git a/testcases/kernel/syscalls/fstat/fstat03.c b/testcases/kernel/syscalls/fstat/fstat03.c
index 3d6790eb2..7d213dea9 100644
--- a/testcases/kernel/syscalls/fstat/fstat03.c
+++ b/testcases/kernel/syscalls/fstat/fstat03.c
@@ -42,7 +42,7 @@ static void check_fstat(unsigned int tc_num)
 	struct tcase *tc = &tcases[tc_num];
 
 	TEST(fstat(*tc->fd, tc->stat_buf));
-	if (TST_RET != 0) {
+	if (TST_RET == -1) {
 		if (tc->exp_err == TST_ERR) {
 			tst_res(TPASS,
 				 "fstat() fails with expected error %s",
@@ -70,8 +70,15 @@ static void run(unsigned int tc_num)
 	}
 	SAFE_WAITPID(pid, &status, 0);
 
-	if (tc_num == 1 && WTERMSIG(status) == SIGSEGV)
+	if (tcases[tc_num].exp_err == EFAULT && WTERMSIG(status) == SIGSEGV) {
 		tst_res(TPASS, "fstat() failed as expected with SIGSEGV");
+		return;
+	}
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
+		return;
+
+	tst_res(TBROK, "child %s", tst_strstatus(status));
 }
 
 static void setup(void)

-- 
Cyril Hrubis
chrubis@suse.cz
