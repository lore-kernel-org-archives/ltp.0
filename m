From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 24 Jan 2020 15:18:26 +0530
Subject: [LTP] [PATCH V3 1/2] Add Syscall numbers for pidfd_open
Message-ID: <1dbcadb1781ba1f0584eb92c83aec5f66abb109c.1579858930.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V3:
- No changes

 include/lapi/syscalls/aarch64.in   | 1 +
 include/lapi/syscalls/arm.in       | 1 +
 include/lapi/syscalls/hppa.in      | 1 +
 include/lapi/syscalls/i386.in      | 1 +
 include/lapi/syscalls/ia64.in      | 1 +
 include/lapi/syscalls/powerpc.in   | 1 +
 include/lapi/syscalls/powerpc64.in | 1 +
 include/lapi/syscalls/s390.in      | 1 +
 include/lapi/syscalls/s390x.in     | 1 +
 include/lapi/syscalls/sh.in        | 1 +
 include/lapi/syscalls/sparc.in     | 1 +
 include/lapi/syscalls/sparc64.in   | 1 +
 include/lapi/syscalls/x86_64.in    | 1 +
 13 files changed, 13 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 0e00641bcf4d..19f3aa4475bd 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -270,4 +270,5 @@ pkey_mprotect 288
 pkey_alloc 289
 pkey_free 290
 pidfd_send_signal 424
+pidfd_open 434
 _sysctl 1078
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index a6a594c2e85d..979a0183d4f5 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -355,3 +355,4 @@ pkey_alloc (__NR_SYSCALL_BASE+395)
 pkey_free (__NR_SYSCALL_BASE+396)
 statx (__NR_SYSCALL_BASE+397)
 pidfd_send_signal (__NR_SYSCALL_BASE+424)
+pidfd_open (__NR_SYSCALL_BASE+434)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index d92f33f40a50..b0807ca6b69f 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -27,3 +27,4 @@ copy_file_range 346
 preadv2 347
 pwritev2 348
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index bad6e409fbdc..f19e24bd63c9 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -354,3 +354,4 @@ pkey_alloc 381
 pkey_free 382
 statx 383
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 0e6ba54a8f76..92cc881d933b 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -310,3 +310,4 @@ pkey_mprotect 1354
 pkey_alloc 1355
 pkey_free 1356
 pidfd_send_signal 1448
+pidfd_open 1458
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 91467f326ed2..f83f7d233e61 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -357,6 +357,7 @@ preadv2 380
 pwritev2 381
 statx 383
 pidfd_send_signal 424
+pidfd_open 434
 pkey_mprotect 386
 pkey_alloc 384
 pkey_free 385
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 91467f326ed2..f83f7d233e61 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -357,6 +357,7 @@ preadv2 380
 pwritev2 381
 statx 383
 pidfd_send_signal 424
+pidfd_open 434
 pkey_mprotect 386
 pkey_alloc 384
 pkey_free 385
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index dcf0a71482ef..f99aceb71a81 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -344,3 +344,4 @@ pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 2dce00f900a2..9666095b6bea 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -342,3 +342,4 @@ pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 996ebc956a9a..73549b46e6dd 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -371,3 +371,4 @@ copy_file_range 391
 preadv2 392
 pwritev2 393
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 65902e00aa23..6c610ba67308 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -349,3 +349,4 @@ pkey_mprotect 362
 pkey_alloc 363
 pkey_free 364
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index d303622b46df..d20e87926913 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -324,3 +324,4 @@ pkey_mprotect 362
 pkey_alloc 363
 pkey_free 364
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 3e9e19ae6af0..cba0080dd27a 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -321,3 +321,4 @@ pkey_alloc 330
 pkey_free 331
 statx 332
 pidfd_send_signal 424
+pidfd_open 434
-- 
2.21.0.rc0.269.g1a574e7a288b

