From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 29 Apr 2021 17:21:46 +0800
Subject: [LTP] [PATCH] openposix/mlock_8-1,
 munlock_10-1: document the introduced patch
Message-ID: <1619688106-2179-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The previous patch f52839ba25 ("openposix/mlock_8-1,munlock_10-1: document known aarch64 issue")
has documented the fix patch, I have verified the introdueced patch is 057d3389108ed
("mm: untag user pointers passed to memory syscalls"). So add it in comment and make testers known
 whether it is a regression test or a new bug when hitting the EINVAL error.

Also modify the kernel version scope of the problem.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../conformance/interfaces/mlock/8-1.c                     | 7 +++++--
 .../conformance/interfaces/munlock/10-1.c                  | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c
index b2cd21c95..d8722c7f6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c
@@ -13,10 +13,13 @@
  *
  * Assume that the value LONG_MAX is an invalid pointer.
  *
- * aarch64 linux versions v5.3 up to v5.6-rc1 may incorrectly report
- * EINVAL instead of ENOMEM, see:
+ * aarch64 linux versions v5.4-rc1 up to v5.6-rc3 may incorrectly report
+ * EINVAL instead of ENOMEM, the fix patch see:
  *   597399d0cb91 ("arm64: tags: Preserve tags for addresses translated via TTBR1")
  *   d0022c0ef29b ("arm64: memory: Add missing brackets to untagged_addr() macro")
+ *
+ * this bug was introduced because of the following commit, see:
+ *   057d3389108e ("mm: untag user pointers passed to memory syscalls")
  */
 
 #include <sys/mman.h>
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munlock/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munlock/10-1.c
index 93414df46..e1c13d5fc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munlock/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munlock/10-1.c
@@ -13,10 +13,13 @@
  *
  * Assume that the value LONG_MAX is an invalid pointer.
  *
- * aarch64 linux versions v5.3 up to v5.6-rc1 may incorrectly report
- * EINVAL instead of ENOMEM, see:
+ * aarch64 linux versions v5.4-rc1 up to v5.6-rc3 may incorrectly report
+ * EINVAL instead of ENOMEM, the fix patch see:
  *   597399d0cb91 ("arm64: tags: Preserve tags for addresses translated via TTBR1")
  *   d0022c0ef29b ("arm64: memory: Add missing brackets to untagged_addr() macro")
+ *
+ * this bug was introduced because of the following commit, see:
+ *   057d3389108e ("mm: untag user pointers passed to memory syscalls")
  */
 
 #include <sys/mman.h>
-- 
2.23.0

