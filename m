From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Sep 2018 17:56:02 +0300
Subject: [LTP] [PATCH] syscalls/fanotify03: Cleanup backup file descriptor
Message-ID: <20180911145602.18106-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Cyril,

As requested by Richard, here is the fanotify03 minor fix separated from
whitespace cleanup.
If you wish to take the whitespace cleanup patch you can find it here:
https://github.com/amir73il/ltp/commits/fanotify_sb

Thanks,
Amir.

 testcases/kernel/syscalls/fanotify/fanotify03.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 50401157b..966366a72 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -57,6 +57,7 @@
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
 static volatile int fd_notify;
+static int fd_notify_backup = -1;
 
 static pid_t child_pid;
 
@@ -140,7 +141,7 @@ static void check_child(void)
 
 void test01(void)
 {
-	int tst_count, fd_notify_backup = -1;
+	int tst_count;
 
 	int ret, len = 0, i = 0, test_num = 0;
 
@@ -262,6 +263,8 @@ static void cleanup(void)
 {
 	if (fd_notify > 0)
 		SAFE_CLOSE(fd_notify);
+	if (fd_notify_backup > 0)
+		SAFE_CLOSE(fd_notify_backup);
 }
 
 static struct tst_test test = {
-- 
2.17.1

