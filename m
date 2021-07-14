From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Jul 2021 21:08:40 +0300
Subject: [LTP] [PATCH] syscalls/fanotify: Fix running tests in a loop
Message-ID: <20210714180840.160798-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Both fanotify19 and fanotify18 leaked fds when run in a loop.
fanotify19 was not checking child process exit status correctly
which resulted in random failures.

Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify18.c | 5 ++++-
 testcases/kernel/syscalls/fanotify/fanotify19.c | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify18.c b/testcases/kernel/syscalls/fanotify/fanotify18.c
index 8a7eebba3..54a4b8ba0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify18.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify18.c
@@ -136,7 +136,7 @@ static void test_fanotify(unsigned int n)
 			(tc->mark_flags & DISALLOWED_MARK_FLAGS ||
 			 tc->mark_mask & FAN_ALL_PERM_EVENTS)) {
 			tst_res(TPASS, "Received result EPERM, as expected");
-			return;
+			goto out;
 		}
 
 		tst_brk(TBROK | TERRNO,
@@ -151,6 +151,9 @@ static void test_fanotify(unsigned int n)
 	tst_res(TPASS,
 		"fanotify_init() and fanotify_mark() returned successfully, "
 		"as expected");
+
+out:
+	SAFE_CLOSE(fd_notify);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify19.c b/testcases/kernel/syscalls/fanotify/fanotify19.c
index 60714408d..fac257bb4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify19.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify19.c
@@ -132,7 +132,7 @@ static void do_fork(void)
 
 	SAFE_WAITPID(child, &status, 0);
 
-	if (WIFEXITED(child) && WEXITSTATUS(child) != 0)
+	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
 		tst_brk(TBROK, "Child process terminated incorrectly. Aborting");
 }
 
@@ -255,6 +255,8 @@ static void test_fanotify(unsigned int n)
 			event = FAN_EVENT_NEXT(event, len);
 		}
 	}
+
+	SAFE_CLOSE(fd_notify);
 }
 
 static void setup(void)
-- 
2.32.0

