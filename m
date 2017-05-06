From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Sat, 6 May 2017 03:14:46 +0000 (UTC)
Subject: [LTP] [PATCH] setpriority01: check in cleanup that user was
 created
In-Reply-To: <1493981072-23999-1-git-send-email-alexey.kodanev@oracle.com>
References: <1894056224.3391041.1493953866962@mail.yahoo.com>
 <1493981072-23999-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1526561217.4364992.1494040486979@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Alexey,
Sorry I tried on a remote machine yesterday and forget to get $? value, but I guess it already worked. Could you help to push it? I'll ping you if I found any issues on Monday.
Many thanks,
Hoang

root@mx6q:~# ./setpriority01

tst_test.c:847: INFO: Timeout per run is 0h 05m 00s

setpriority01.c:120: CONF: /etc/passwd is not accessible

 

Summary:

passed   0

failed   0

skipped  0

warnings 0
Sent from Yahoo Mail on Android 
 
  On Fri, May 5, 2017 at 17:38, Alexey Kodanev<alexey.kodanev@oracle.com> wrote:   Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---

Could you try this patch?

 .../kernel/syscalls/setpriority/setpriority01.c    |    6 +++++-
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
+    user_added = 1;
 
     ltpuser = SAFE_GETPWNAM(username);
     uid = ltpuser->pw_uid;
@@ -127,6 +128,9 @@ static void setup(void)
 
 static void cleanup(void)
 {
+    if (!user_added)
+        return;
+
     const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
 
     if (tst_run_cmd(cmd_userdel, NULL, NULL, 1))
-- 
1.7.1

  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170506/e52a28e6/attachment-0001.html>
