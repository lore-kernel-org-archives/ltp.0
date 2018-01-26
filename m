From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 26 Jan 2018 11:31:37 +0800
Subject: [LTP] [PATCH 1/4] lapi/syscalls: Add syscall numbers for _sysctl
Message-ID: <1516937500-16475-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
index 1f45839..2c8c589 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -257,3 +257,4 @@ kcmp 272
 getrandom 278
 memfd_create 279
 copy_file_range 285
+_sysctl 1078
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 1a13661..71a4b71 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -120,6 +120,7 @@ readv (__NR_SYSCALL_BASE+145)
 writev (__NR_SYSCALL_BASE+146)
 getsid (__NR_SYSCALL_BASE+147)
 fdatasync (__NR_SYSCALL_BASE+148)
+_sysctl (__NR_SYSCALL_BASE+149)
 mlock (__NR_SYSCALL_BASE+150)
 munlock (__NR_SYSCALL_BASE+151)
 mlockall (__NR_SYSCALL_BASE+152)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index bb7a694..92aee9f 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -1,3 +1,4 @@
+_sysctl 149
 openat 275
 mkdirat (__NR_openat + 1)
 mknodat (__NR_openat + 2)
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 9cbb139..0f96014 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -145,6 +145,7 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
+_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 1d5b21c..a3abc99 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -118,6 +118,7 @@ readv 1146
 writev 1147
 pread64 1148
 pwrite64 1149
+_sysctl 1150
 mmap 1151
 munmap 1152
 mlock 1153
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index f87192e..11ddca3 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -145,6 +145,7 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
+_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index f87192e..11ddca3 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -145,6 +145,7 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
+_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 2526f38..98c861f 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -107,6 +107,7 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
+_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 2526f38..98c861f 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -107,6 +107,7 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
+_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index b41b578..c605b14 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -145,6 +145,7 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
+_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 729768b..296d694 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -252,6 +252,7 @@ sched_get_priority_min 247
 sched_rr_get_interval 248
 nanosleep 249
 mremap 250
+_sysctl 251
 getsid 252
 fdatasync 253
 nfsservctl 254
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 9eb21ee..169347a 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -228,6 +228,7 @@ sched_get_priority_min 247
 sched_rr_get_interval 248
 nanosleep 249
 mremap 250
+_sysctl 251
 getsid 252
 fdatasync 253
 nfsservctl 254
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 29051d4..89db794 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -154,6 +154,7 @@ munlockall 152
 vhangup 153
 modify_ldt 154
 pivot_root 155
+_sysctl 156
 prctl 157
 arch_prctl 158
 adjtimex 159
-- 
1.8.3.1



