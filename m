From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 17 Jan 2020 16:45:09 +0530
Subject: [LTP] [PATCH 1/2] Add Syscall numbers for pidfd_open
Message-ID: <b4f5242fdca1659b2f71e1b3290fd32194e7340a.1579259595.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
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
index 00e99f2b99b8..29538ba50d3b 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -354,3 +354,4 @@ pkey_alloc (__NR_SYSCALL_BASE+395)
 pkey_free (__NR_SYSCALL_BASE+396)
 statx (__NR_SYSCALL_BASE+397)
 pidfd_send_signal (__NR_SYSCALL_BASE+424)
+pidfd_open (__NR_SYSCALL_BASE+434)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 4cdd109fb50e..b578d886516d 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -26,3 +26,4 @@ copy_file_range 346
 preadv2 347
 pwritev2 348
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 87ab4693343e..696563ebba48 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -353,3 +353,4 @@ pkey_alloc 381
 pkey_free 382
 statx 383
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index cf9f73e8529b..11b236c7c507 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -309,3 +309,4 @@ pkey_mprotect 1354
 pkey_alloc 1355
 pkey_free 1356
 pidfd_send_signal 1448
+pidfd_open 1458
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 660165d7a37b..293d86ba54c4 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -356,6 +356,7 @@ preadv2 380
 pwritev2 381
 statx 383
 pidfd_send_signal 424
+pidfd_open 434
 pkey_mprotect 386
 pkey_alloc 384
 pkey_free 385
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 660165d7a37b..293d86ba54c4 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -356,6 +356,7 @@ preadv2 380
 pwritev2 381
 statx 383
 pidfd_send_signal 424
+pidfd_open 434
 pkey_mprotect 386
 pkey_alloc 384
 pkey_free 385
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index d3f7eb1f60f7..4f4b2dbed5ef 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -343,3 +343,4 @@ pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 7d632d1dc0bb..673538a7217e 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -341,3 +341,4 @@ pkey_mprotect 384
 pkey_alloc 385
 pkey_free 386
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 132492922659..ef877fa9c25f 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -370,3 +370,4 @@ copy_file_range 391
 preadv2 392
 pwritev2 393
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 94a672428973..2b33c4983088 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -348,3 +348,4 @@ pkey_mprotect 362
 pkey_alloc 363
 pkey_free 364
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index d17dce5cd9a3..a6157adef7b3 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -323,3 +323,4 @@ pkey_mprotect 362
 pkey_alloc 363
 pkey_free 364
 pidfd_send_signal 424
+pidfd_open 434
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index b1cbd4f2fb04..8bd6b66d3bef 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -320,3 +320,4 @@ pkey_alloc 330
 pkey_free 331
 statx 332
 pidfd_send_signal 424
+pidfd_open 434
-- 
2.21.0.rc0.269.g1a574e7a288b

