From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 21 Jan 2021 15:09:18 +0100
Subject: [LTP] [PATCH COMMITTED] openposix/mlock_8-1,
 munlock_10-1: document known aarch64 issue
Message-ID: <f52839ba25fb23b277197b5e16215ac450744cf9.1611238142.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Values close to LONG_MAX are incorrectly handled by some aarch64
kernel versions, which return EINVAL instead of ENOMEM. Issue has
been fixed in v5.6:
  commit 597399d0cb91 ("arm64: tags: Preserve tags for addresses translated via TTBR1")
  commit d0022c0ef29b ("arm64: memory: Add missing brackets to untagged_addr() macro")

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../open_posix_testsuite/conformance/interfaces/mlock/8-1.c  | 5 +++++
 .../conformance/interfaces/munlock/10-1.c                    | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c
index d9569008b82b..b2cd21c957bc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c
@@ -12,6 +12,11 @@
  * valid mapped pages in the address space of the process.
  *
  * Assume that the value LONG_MAX is an invalid pointer.
+ *
+ * aarch64 linux versions v5.3 up to v5.6-rc1 may incorrectly report
+ * EINVAL instead of ENOMEM, see:
+ *   597399d0cb91 ("arm64: tags: Preserve tags for addresses translated via TTBR1")
+ *   d0022c0ef29b ("arm64: memory: Add missing brackets to untagged_addr() macro")
  */
 
 #include <sys/mman.h>
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munlock/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munlock/10-1.c
index cf870289b512..93414df46a98 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munlock/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munlock/10-1.c
@@ -12,6 +12,11 @@
  * valid mapped pages in the address space of the process.
  *
  * Assume that the value LONG_MAX is an invalid pointer.
+ *
+ * aarch64 linux versions v5.3 up to v5.6-rc1 may incorrectly report
+ * EINVAL instead of ENOMEM, see:
+ *   597399d0cb91 ("arm64: tags: Preserve tags for addresses translated via TTBR1")
+ *   d0022c0ef29b ("arm64: memory: Add missing brackets to untagged_addr() macro")
  */
 
 #include <sys/mman.h>
-- 
2.18.1

