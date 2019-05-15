From: Christian Amann <camann@suse.com>
Date: Wed, 15 May 2019 14:01:13 +0200
Subject: [LTP] [PATCH v1 1/4] Add Syscall numbers for pidfd_send_signal
Message-ID: <20190515120116.11589-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Christian Amann <camann@suse.com>
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
index 177dd0115..ce6080894 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -265,4 +265,5 @@ mlock2 284
 copy_file_range 285
 preadv2 286
 pwritev2 287
+pidfd_send_signal 424
 _sysctl 1078
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index f4adedb2c..33168889f 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -350,3 +350,4 @@ copy_file_range (__NR_SYSCALL_BASE+391)
 preadv2 (__NR_SYSCALL_BASE+392)
 pwritev2 (__NR_SYSCALL_BASE+393)
 statx (__NR_SYSCALL_BASE+397)
+pidfd_send_signal (__NR_SYSCALL_BASE+424)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index a0dd2307f..4cdd109fb 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -25,3 +25,4 @@ mlock2 345
 copy_file_range 346
 preadv2 347
 pwritev2 348
+pidfd_send_signal 424
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index af5254f77..3355b9127 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -348,3 +348,4 @@ copy_file_range 377
 preadv2 378
 pwritev2 379
 statx 383
+pidfd_send_signal 424
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index c0aeed08b..9ac81e91e 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -305,3 +305,4 @@ mlock2 1346
 copy_file_range 1347
 preadv2 1348
 pwritev2 1349
+pidfd_send_signal 1448
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 6b6be58a7..488d6dfa9 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -355,3 +355,4 @@ copy_file_range 379
 preadv2 380
 pwritev2 381
 statx 383
+pidfd_send_signal 424
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 6b6be58a7..488d6dfa9 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -355,3 +355,4 @@ copy_file_range 379
 preadv2 380
 pwritev2 381
 statx 383
+pidfd_send_signal 424
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 2a2ffe223..69b49eac0 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -338,3 +338,4 @@ mlock2 374
 copy_file_range 375
 preadv2 376
 pwritev2 377
+pidfd_send_signal 424
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 4c36ce17c..685c16f68 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -337,3 +337,4 @@ mlock2 374
 copy_file_range 375
 preadv2 376
 pwritev2 377
+pidfd_send_signal 424
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index a942fb506..132492922 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -369,3 +369,4 @@ mlock2 390
 copy_file_range 391
 preadv2 392
 pwritev2 393
+pidfd_send_signal 424
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 20dc37b01..e74b48170 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -343,3 +343,4 @@ mlock2 356
 copy_file_range 357
 preadv2 358
 pwritev2 359
+pidfd_send_signal 424
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index c100b8e3e..577aa9b35 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -319,3 +319,4 @@ mlock2 356
 copy_file_range 357
 preadv2 358
 pwritev2 359
+pidfd_send_signal 424
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 87849e5c0..99d387277 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -315,3 +315,4 @@ copy_file_range 326
 preadv2 327
 pwritev2 328
 statx 332
+pidfd_send_signal 424
-- 
2.16.4

