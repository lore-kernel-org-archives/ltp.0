From: Yixin Zhang <yixin.zhang@intel.com>
Date: Mon, 25 May 2020 18:22:42 +0800
Subject: [LTP] [PATCH ltp] testcases/kernel: fix "No newline at end of file"
 warning
Message-ID: <20200525102242.5656-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use below 1 line script to fix all files without a new line at EOF.

for dir in $(ls .); do \
  echo "dir: $dir"; \
  for f in $(find "$dir" -type f) ; do \
    echo "$f"; \
    if file "$f" | grep -qv 'ASCII'; then \
      continue; \
    fi; \
    if diff /dev/null "$f" | tail -1 | grep -q '^\\ No newline'; then \
      echo >> "$f"; \
    fi; \
  done; \
done

Use a $(ls .) at the most outer level to prevent modification of ".git"
folder.

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/device-drivers/pci/tpci_kernel/Makefile | 2 +-
 testcases/kernel/syscalls/clock_adjtime/Makefile         | 2 +-
 testcases/kernel/syscalls/clock_gettime/Makefile         | 2 +-
 testcases/kernel/syscalls/fgetxattr/Makefile             | 2 +-
 testcases/kernel/syscalls/fremovexattr/Makefile          | 2 +-
 testcases/kernel/syscalls/fsetxattr/Makefile             | 2 +-
 testcases/kernel/syscalls/membarrier/Makefile            | 2 +-
 testcases/kernel/syscalls/memfd_create/.gitignore        | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile b/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
index 02496afb8226..6e1284d6cf53 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
@@ -32,4 +32,4 @@ MAKE_TARGETS := ltp_tpci.ko
 include $(top_srcdir)/include/mk/module.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
-endif
\ No newline at end of file
+endif
diff --git a/testcases/kernel/syscalls/clock_adjtime/Makefile b/testcases/kernel/syscalls/clock_adjtime/Makefile
index 79f671f1c597..e49cb9b357a4 100644
--- a/testcases/kernel/syscalls/clock_adjtime/Makefile
+++ b/testcases/kernel/syscalls/clock_adjtime/Makefile
@@ -7,4 +7,4 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS+=-lrt
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/clock_gettime/Makefile b/testcases/kernel/syscalls/clock_gettime/Makefile
index 79f671f1c597..e49cb9b357a4 100644
--- a/testcases/kernel/syscalls/clock_gettime/Makefile
+++ b/testcases/kernel/syscalls/clock_gettime/Makefile
@@ -7,4 +7,4 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS+=-lrt
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fgetxattr/Makefile b/testcases/kernel/syscalls/fgetxattr/Makefile
index f71e4fc25a2e..e6674a6b216c 100644
--- a/testcases/kernel/syscalls/fgetxattr/Makefile
+++ b/testcases/kernel/syscalls/fgetxattr/Makefile
@@ -5,4 +5,4 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fremovexattr/Makefile b/testcases/kernel/syscalls/fremovexattr/Makefile
index f71e4fc25a2e..e6674a6b216c 100644
--- a/testcases/kernel/syscalls/fremovexattr/Makefile
+++ b/testcases/kernel/syscalls/fremovexattr/Makefile
@@ -5,4 +5,4 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fsetxattr/Makefile b/testcases/kernel/syscalls/fsetxattr/Makefile
index f71e4fc25a2e..e6674a6b216c 100644
--- a/testcases/kernel/syscalls/fsetxattr/Makefile
+++ b/testcases/kernel/syscalls/fsetxattr/Makefile
@@ -5,4 +5,4 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/membarrier/Makefile b/testcases/kernel/syscalls/membarrier/Makefile
index f71e4fc25a2e..e6674a6b216c 100644
--- a/testcases/kernel/syscalls/membarrier/Makefile
+++ b/testcases/kernel/syscalls/membarrier/Makefile
@@ -5,4 +5,4 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/memfd_create/.gitignore b/testcases/kernel/syscalls/memfd_create/.gitignore
index 71b898c34fd0..b79adfa65357 100644
--- a/testcases/kernel/syscalls/memfd_create/.gitignore
+++ b/testcases/kernel/syscalls/memfd_create/.gitignore
@@ -1,4 +1,4 @@
 /memfd_create01
 /memfd_create02
 /memfd_create03
-/memfd_create04
\ No newline at end of file
+/memfd_create04
-- 
2.17.1

