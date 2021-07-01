From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu,  1 Jul 2021 15:14:26 +0200
Subject: [LTP] [PATCH v2 1/2] proc01: fix selinux attributes without
 libselinux-dev
Message-ID: <20210701131427.72574-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

SELinux can be enabled on the system which does not have development
selinux libraries.  Such case was already done for Smack and Apparmor
where we unconditionally accept their attribute failures.  Do the same
for SELinux to fix failures like:

    proc01      1  TFAIL  :  proc01.c:404: read failed: /proc/self/task/29986/attr/selinux/current: errno=EINVAL(22): Invalid argument
    proc01      2  TFAIL  :  proc01.c:404: read failed: /proc/self/task/29986/attr/selinux/prev: errno=EINVAL(22): Invalid argument
    proc01      3  TFAIL  :  proc01.c:404: read failed: /proc/self/task/29986/attr/selinux/exec: errno=EINVAL(22): Invalid argument
    proc01      4  TFAIL  :  proc01.c:404: read failed: /proc/self/task/29986/attr/selinux/fscreate: errno=EINVAL(22): Invalid argument
    proc01      5  TFAIL  :  proc01.c:404: read failed: /proc/self/task/29986/attr/selinux/keycreate: errno=EINVAL(22): Invalid argument
    proc01      6  TFAIL  :  proc01.c:404: read failed: /proc/self/task/29986/attr/selinux/sockcreate: errno=EINVAL(22): Invalid argument
    ...
    proc01      7  TFAIL  :  proc01.c:404: read failed: /proc/self/attr/selinux/current: errno=EINVAL(22): Invalid argument
    proc01      8  TFAIL  :  proc01.c:404: read failed: /proc/self/attr/selinux/prev: errno=EINVAL(22): Invalid argument
    proc01      9  TFAIL  :  proc01.c:404: read failed: /proc/self/attr/selinux/exec: errno=EINVAL(22): Invalid argument
    proc01     10  TFAIL  :  proc01.c:404: read failed: /proc/self/attr/selinux/fscreate: errno=EINVAL(22): Invalid argument
    proc01     11  TFAIL  :  proc01.c:404: read failed: /proc/self/attr/selinux/keycreate: errno=EINVAL(22): Invalid argument
    proc01     12  TFAIL  :  proc01.c:404: read failed: /proc/self/attr/selinux/sockcreate: errno=EINVAL(22): Invalid argument

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 testcases/kernel/fs/proc/proc01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 0fae6754f7f7..6ddb6682f38b 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -97,10 +97,12 @@ static const struct mapping known_issues[] = {
 	{"read", "/proc/self/mem", EIO},
 	{"read", "/proc/self/task/[0-9]*/mem", EIO},
 	{"read", "/proc/self/attr/*", EINVAL},
+	{"read", "/proc/self/attr/selinux/*", EINVAL},
 	{"read", "/proc/self/attr/smack/*", EINVAL},
 	{"read", "/proc/self/attr/apparmor/*", EINVAL},
 	{"read", "/proc/self/task/[0-9]*/attr/*", EINVAL},
 	{"read", "/proc/self/task/[0-9]*/attr/smack/*", EINVAL},
+	{"read", "/proc/self/task/[0-9]*/attr/selinux/*", EINVAL},
 	{"read", "/proc/self/task/[0-9]*/attr/apparmor/*", EINVAL},
 	{"read", "/proc/self/ns/*", EINVAL},
 	{"read", "/proc/self/task/[0-9]*/ns/*", EINVAL},
@@ -133,7 +135,9 @@ static const struct mapping known_issues[] = {
 #ifdef HAVE_LIBSELINUX_DEVEL
 static const char lsm_should_work[][PATH_MAX] = {
 	"/proc/self/attr/*",
+	"/proc/self/attr/selinux/*",
 	"/proc/self/task/[0-9]*/attr/*",
+	"/proc/self/task/[0-9]*/attr/selinux/*",
 	""
 };
 
-- 
2.27.0

