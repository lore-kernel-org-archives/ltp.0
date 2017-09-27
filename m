From: naresh.kamboju@linaro.org <naresh.kamboju@linaro.org>
Date: Wed, 27 Sep 2017 15:47:24 -0700
Subject: [LTP] [PATCH v2] utimensat_tests.sh: returns EPERM above 4.4.27 and
	below 4.5.0
Message-ID: <1506552444-2399-1-git-send-email-naresh.kamboju@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Naresh Kamboju <naresh.kamboju@linaro.org>

Test utimensat failed on 4.4 is due to expected error is EACCES but got EPERM.

With the reference to backported patch changing the test code to set error code
EPERM when kernel version is above 4.4.27 and below 4.5.0

The patch backported on 4.4 details
tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
branch: v4.4.27
commit id: b3b4283
vfs: move permission checking into notify_change() for utimes(NULL)

Bug reported on this case,
LKFT: linux-stable-4.4: LTP utimensat01 failed-EXPECTED: EACCES but got EPERM
https://bugs.linaro.org/show_bug.cgi?id=3142

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 testcases/kernel/syscalls/utimensat/utimensat_tests.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
index 48154d6..46a0cc6 100755
--- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
+++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
@@ -32,7 +32,11 @@ fi
 
 # Starting with 4.8.0 operations on immutable files return EPERM instead of
 # EACCES.
-if tst_kvcmp -lt "4.8.0"; then
+# This patch has also been merged to stable 4.4 with
+# b3b4283 ("vfs: move permission checking into notify_change() for utimes(NULL)")
+if tst_kvcmp -ge "4.4.27" -a -lt "4.5.0"; then
+	imaccess=EPERM
+elif tst_kvcmp -lt "4.4.27"; then
 	imaccess=EACCES
 else
 	imaccess=EPERM
-- 
2.7.4

