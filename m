From: naresh.kamboju@linaro.org <naresh.kamboju@linaro.org>
Date: Wed,  6 Sep 2017 17:00:34 +0530
Subject: [LTP] [PATCH] utimensat_tests.sh: returns EPERM on 4.4.27 and above
Message-ID: <1504697434-22974-1-git-send-email-naresh.kamboju@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Naresh Kamboju <naresh.kamboju@linaro.org>

Test utimensat failed on 4.4 kernel is due to expected error is
EACCES but got EPERM.

The below LTP patch setting up expected error as EACCES for 4.8.0 below kernel
b9157aee: utimensat: re-apply: fix immutable file retcodes for 4.8.0 and newer

Amending patch to check 4.4.27 instead of 4.8.0 according to below patch
tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
branch: v4.4.27
commit id: b3b4283
vfs: move permission checking into notify_change() for utimes(NULL)

Bug reported on this case,
LKFT: linux-stable-4.4: LTP utimensat01 failed-EXPECTED: EACCES but got EPERM
https://bugs.linaro.org/show_bug.cgi?id=3142

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 testcases/kernel/syscalls/utimensat/utimensat_tests.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
index 48154d6..a832433 100755
--- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
+++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
@@ -30,9 +30,9 @@ if tst_kvcmp -lt "2.6.22"; then
 	tst_brkm TCONF "System kernel version is less than 2.6.22,cannot execute test"
 fi
 
-# Starting with 4.8.0 operations on immutable files return EPERM instead of
+# Starting with 4.4.27 operations on immutable files return EPERM instead of
 # EACCES.
-if tst_kvcmp -lt "4.8.0"; then
+if tst_kvcmp -lt "4.4.27"; then
 	imaccess=EACCES
 else
 	imaccess=EPERM
-- 
2.7.4

