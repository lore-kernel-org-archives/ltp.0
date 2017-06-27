From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Jun 2017 15:19:10 +0200
Subject: [LTP] [COMMITTED] [PATCH] mmapstress01: Fix buffer overflow
Message-ID: <20170627131910.18750-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcase was causing buffer overflow on temporary file creation if
the path to $PWD was long enough (limit was 64 characters).

Moreover the test was using absolute path to create files in $PWD, which
is not allowed in LTP, while it is even using tst_tmpdir()/tst_rmdir()
to create unique test temporary directory.

So the fix to the problem is to remove the code that constructs the path
and change file to be created in $PWD which points to the temporary
directory created by the test library.

Fixes #170.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/mmapstress/mmapstress01.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 81566f261..d2df6122b 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -131,7 +131,6 @@ unsigned randloops = 0;
 unsigned dosync = 0;
 unsigned do_offset = 0;
 unsigned pattern = 0;
-char filename[64];
 
 int main(int argc, char *argv[])
 {
@@ -159,6 +158,7 @@ int main(int argc, char *argv[])
 #else /* LARGE_FILE */
 	off_t bytes_left;
 #endif /* LARGE_FILE */
+	const char *filename = "mmapstress01.out";
 
 	progname = *argv;
 	tst_tmpdir();
@@ -228,8 +228,7 @@ int main(int argc, char *argv[])
 	}
 
 	(void)time(&t);
-	//(void)printf("%s: Started %s", argv[0], ctime(&t)); LTP Port
-	(void)sprintf(filename, "%sout.%d", progname, getpid());
+
 	seed = initrand();
 	pattern = seed & 0xff;
 
-- 
2.13.0

