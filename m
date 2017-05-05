From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri,  5 May 2017 13:44:32 +0300
Subject: [LTP] [PATCH] setpriority01: check in cleanup that user was created
In-Reply-To: <1894056224.3391041.1493953866962@mail.yahoo.com>
References: <1894056224.3391041.1493953866962@mail.yahoo.com>
Message-ID: <1493981072-23999-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---

Could you try this patch?

 .../kernel/syscalls/setpriority/setpriority01.c    |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/setpriority/setpriority01.c b/testcases/kernel/syscalls/setpriority/setpriority01.c
index 70e8264..df02bce 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority01.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority01.c
@@ -31,7 +31,7 @@
 #include "tst_test.h"
 
 static const char *username = "ltp_setpriority01";
-static int pid, uid;
+static int pid, uid, user_added;
 
 static struct tcase {
 	int which;
@@ -120,6 +120,7 @@ static void setup(void)
 		tst_brk(TCONF, "/etc/passwd is not accessible");
 
 	tst_run_cmd(cmd_useradd, NULL, NULL, 0);
+	user_added = 1;
 
 	ltpuser = SAFE_GETPWNAM(username);
 	uid = ltpuser->pw_uid;
@@ -127,6 +128,9 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	if (!user_added)
+		return;
+
 	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
 
 	if (tst_run_cmd(cmd_userdel, NULL, NULL, 1))
-- 
1.7.1

