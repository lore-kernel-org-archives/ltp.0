From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Jan 2021 13:33:08 +0100
Subject: [LTP] [PATCH v2 1/1] fs/proc01.c: Whitelist attr and task files for
 apparmor and smack
Message-ID: <20210119123308.24578-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Xinpeng Liu <liuxp11@chinatelecom.cn>

We are already whitelisting LSM files (/proc/self/attr/* and
/proc/self/task/[0-9]*/attr/*) since 2009. That's probably due the
default value for {g,s}etprocattr LSM_HOOK is -EINVAL when LSM module
not enabled.

Both AppArmor and SMACK allow to read only
/proc/self/attr/apparmor/current, the rest return EINVAL.

While reading /proc/self/attr/apparmor/current (for AppArmor) and
/proc/self/attr/current (for both AppArmor and SELinux) mostly work
(e.g. value contains unconfined), in some cases it's not working (e.g.
AppArmor module loaded, but filesystem is not mounted). Thus keep it
also disabled.

Ubuntu 20.10 (AppArmor and SMACK enabled):
proc01      1  TFAIL  :  proc01.c:396: read failed: /proc/self/task/61595/attr/smack/current: errno=EINVAL(22): Invalid argument
proc01      2  TFAIL  :  proc01.c:396: read failed: /proc/self/task/61595/attr/apparmor/prev: errno=EINVAL(22): Invalid argument
proc01      3  TFAIL  :  proc01.c:396: read failed: /proc/self/task/61595/attr/apparmor/exec: errno=EINVAL(22): Invalid argument
proc01      4  TFAIL  :  proc01.c:396: read failed: /proc/self/attr/smack/current: errno=EINVAL(22): Invalid argument
proc01      5  TFAIL  :  proc01.c:396: read failed: /proc/self/attr/apparmor/prev: errno=EINVAL(22): Invalid argument
proc01      6  TFAIL  :  proc01.c:396: read failed: /proc/self/attr/apparmor/exec: errno=EINVAL(22): Invalid argument

openSUSE (kernel 5.10.7, AppArmor enabled):
proc01      1  TFAIL  :  proc01.c:396: read failed: /proc/self/task/6367/attr/apparmor/prev: errno=EINVAL(22): Invalid argument
proc01      2  TFAIL  :  proc01.c:396: read failed: /proc/self/task/6367/attr/apparmor/exec: errno=EINVAL(22): Invalid argument
proc01      3  TFAIL  :  proc01.c:396: read failed: /proc/self/attr/apparmor/prev: errno=EINVAL(22): Invalid argument
proc01      4  TFAIL  :  proc01.c:396: read failed: /proc/self/attr/apparmor/exec: errno=EINVAL(22): Invalid argument

+ While at it, fix a comparison warning.

Reviewed-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Reviewed-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Xinpeng Liu <liuxp11@chinatelecom.cn>
[ pvorel: rewritten commit message ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Liu, Jan,

as we agreed with Cyril that this is a valid fix, I dared to do the
investigation and send v2 with improved commit message.

Kind regards,
Petr

 testcases/kernel/fs/proc/proc01.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 96843695c..96441d153 100644
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
2.30.0

