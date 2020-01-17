From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Jan 2020 12:37:15 +0100
Subject: [LTP] [PATCH 3/3] lapi/syscalls: Add syncfs
In-Reply-To: <20200117113715.22786-1-pvorel@suse.cz>
References: <20200117113715.22786-1-pvorel@suse.cz>
Message-ID: <20200117113715.22786-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

for old distros, which don't define it. Added for all architectures
(including very old ones), as the dependency is in the library itself.

This was needed on SLES 11 (kernel 2.6.32).

Fixes: 74aeb88c9 ("tst_device: use raw syscall in the tst_device.h")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
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
 12 files changed, 12 insertions(+)

diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 00e99f2b9..a6a594c2e 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -334,6 +334,7 @@ accept4 (__NR_SYSCALL_BASE+366)
 fanotify_init (__NR_SYSCALL_BASE+367)
 fanotify_mark (__NR_SYSCALL_BASE+368)
 prlimit64 (__NR_SYSCALL_BASE+369)
+syncfs (__NR_SYSCALL_BASE+373)
 process_vm_readv (__NR_SYSCALL_BASE+376)
 process_vm_writev (__NR_SYSCALL_BASE+377)
 kcmp (__NR_SYSCALL_BASE+378)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 4cdd109fb..d92f33f40 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -16,6 +16,7 @@ faccessat (__NR_openat + 12)
 splice 291
 tee 293
 vmsplice 294
+syncfs 327
 process_vm_readv 330
 process_vm_writev 331
 memfd_create 340
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 87ab46933..bad6e409f 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -332,6 +332,7 @@ recvmmsg 337
 fanotify_init 338
 fanotify_mark 339
 prlimit64 340
+syncfs 344
 process_vm_readv 347
 process_vm_writev 348
 kcmp 349
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index cf9f73e85..0e6ba54a8 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -293,6 +293,7 @@ recvmmsg 1322
 fanotify_init 1323
 fanotify_mark 1324
 prlimit64 1325
+syncfs 1329
 process_vm_readv 1332
 process_vm_writev 1333
 renameat2 1338
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 660165d7a..91467f326 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -339,6 +339,7 @@ recvmsg 342
 recvmmsg 343
 accept4 344
 syscalls 345
+syncfs 348
 process_vm_readv  351
 process_vm_writev 352
 kcmp 354
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 660165d7a..91467f326 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -339,6 +339,7 @@ recvmsg 342
 recvmmsg 343
 accept4 344
 syscalls 345
+syncfs 348
 process_vm_readv  351
 process_vm_writev 352
 kcmp 354
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index d3f7eb1f6..dcf0a7148 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -323,6 +323,7 @@ setgid 214
 setfsuid 215
 setfsgid 216
 newfstatat 293
+syncfs 338
 process_vm_readv 340
 process_vm_writev 341
 kcmp 343
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 7d632d1dc..2dce00f90 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -322,6 +322,7 @@ setgid 214
 setfsuid 215
 setfsgid 216
 newfstatat 293
+syncfs 338
 process_vm_readv 340
 process_vm_writev 341
 kcmp 343
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 132492922..996ebc956 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -360,6 +360,7 @@ accept4 366
 fanotify_init 367
 fanotify_mark 368
 prlimit64 369
+syncfs 373
 process_vm_readv 376
 process_vm_writev 377
 kcmp 378
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 94a672428..65902e00a 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -330,6 +330,7 @@ recvmmsg 328
 fanotify_init 329
 fanotify_mark 330
 prlimit64 331
+syncfs 335
 process_vm_readv 338
 process_vm_writev 339
 kcmp 341
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index d17dce5cd..d303622b4 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -306,6 +306,7 @@ recvmmsg 328
 fanotify_init 329
 fanotify_mark 330
 prlimit64 331
+syncfs 335
 process_vm_readv 338
 process_vm_writev 339
 kcmp 341
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index b1cbd4f2f..3e9e19ae6 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -299,6 +299,7 @@ recvmmsg 299
 fanotify_init 300
 fanotify_mark 301
 prlimit64 302
+syncfs 306
 process_vm_readv 310
 process_vm_writev 311
 kcmp 312
-- 
2.24.1

