From: Xinpeng Liu <liuxp11@chinatelecom.cn>
Date: Fri, 15 Jan 2021 08:53:51 +0800
Subject: [LTP] [PATCH] fs/proc01.c:add known issues
Message-ID: <1610672031-5044-1-git-send-email-liuxp11@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test in ubuntu20.10,there are several failure tests.

proc01      1  TFAIL  :  proc01.c:396: read failed:
/proc/self/task/61595/attr/smack/current: errno=EINVAL(22): Invalid argument
proc01      2  TFAIL  :  proc01.c:396: read failed:
/proc/self/task/61595/attr/apparmor/prev: errno=EINVAL(22): Invalid argument
proc01      3  TFAIL  :  proc01.c:396: read failed:
/proc/self/task/61595/attr/apparmor/exec: errno=EINVAL(22): Invalid argument
proc01      4  TFAIL  :  proc01.c:396: read failed:
/proc/self/attr/smack/current: errno=EINVAL(22): Invalid argument
proc01      5  TFAIL  :  proc01.c:396: read failed:
/proc/self/attr/apparmor/prev: errno=EINVAL(22): Invalid argument
proc01      6  TFAIL  :  proc01.c:396: read failed:
/proc/self/attr/apparmor/exec: errno=EINVAL(22): Invalid argument

Signed-off-by: Xinpeng Liu <liuxp11@chinatelecom.cn>
---
 testcases/kernel/fs/proc/proc01.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 9684369..96441d1 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -63,7 +63,7 @@ static char *opt_maxmbytesstr;
 static char *procpath = "/proc";
 static const char selfpath[] = "/proc/self";
 size_t buffsize = 1024;
-static long long maxbytes;
+static unsigned long long maxbytes;
 
 unsigned long long total_read;
 unsigned int total_obj;
@@ -97,7 +97,11 @@ static const struct mapping known_issues[] = {
 	{"read", "/proc/self/mem", EIO},
 	{"read", "/proc/self/task/[0-9]*/mem", EIO},
 	{"read", "/proc/self/attr/*", EINVAL},
+	{"read", "/proc/self/attr/smack/*", EINVAL},
+	{"read", "/proc/self/attr/apparmor/*", EINVAL},
 	{"read", "/proc/self/task/[0-9]*/attr/*", EINVAL},
+	{"read", "/proc/self/task/[0-9]*/attr/smack/*", EINVAL},
+	{"read", "/proc/self/task/[0-9]*/attr/apparmor/*", EINVAL},
 	{"read", "/proc/self/ns/*", EINVAL},
 	{"read", "/proc/self/task/[0-9]*/ns/*", EINVAL},
 	{"read", "/proc/ppc64/rtas/error_log", EINVAL},
-- 
1.8.3.1

