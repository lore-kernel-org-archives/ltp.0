From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu,  5 Aug 2021 14:06:22 +0200
Subject: [LTP] [PATCH] Replace uppercase description tags
Message-ID: <20210805120622.81918-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

This lead to confusion at least twice now, let's just fix it

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 include/tst_cgroup.h                               | 2 +-
 lib/newlib_tests/tst_fuzzy_sync01.c                | 2 +-
 lib/newlib_tests/tst_fuzzy_sync02.c                | 2 +-
 testcases/kernel/containers/netns/netns_netlink.c  | 2 +-
 testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c | 2 +-
 testcases/kernel/syscalls/memcmp/memcmp01.c        | 2 +-
 testcases/kernel/syscalls/memcpy/memcpy01.c        | 2 +-
 testcases/kernel/syscalls/memset/memset01.c        | 2 +-
 testcases/kernel/syscalls/read/read03.c            | 2 +-
 testcases/kernel/syscalls/read/read04.c            | 2 +-
 testcases/kernel/syscalls/splice/splice02.c        | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index de72645bc..9e34321e4 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -5,7 +5,7 @@
  * Copyright (c) 2020-2021 SUSE LLC <rpalethorpe@suse.com>
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * The LTP CGroups API tries to present a consistent interface to the
  * many possible CGroup configurations a system could have.
diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
index 9b0d55a24..ae3ea4e09 100644
--- a/lib/newlib_tests/tst_fuzzy_sync01.c
+++ b/lib/newlib_tests/tst_fuzzy_sync01.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2021 Richard Palethorpe <rpalethorpe@suse.com>
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * This verifies Fuzzy Sync's basic ability to reproduce a particular
  * outcome to a data race when the critical sections are not aligned.
diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
index e6bd03392..51075f3c3 100644
--- a/lib/newlib_tests/tst_fuzzy_sync02.c
+++ b/lib/newlib_tests/tst_fuzzy_sync02.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2021 Richard Palethorpe <rpalethorpe@suse.com>
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * This verifies Fuzzy Sync's ability to reproduce a particular
  * outcome to a data race when multiple races are present.
diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
index 1e8e78fc5..50cfe2994 100644
--- a/testcases/kernel/containers/netns/netns_netlink.c
+++ b/testcases/kernel/containers/netns/netns_netlink.c
@@ -5,7 +5,7 @@
  */
 
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Tests a netlink interface inside a new network namespace.
  *
diff --git a/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c b/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
index adaa34a5e..90cf4fcb3 100644
--- a/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
+++ b/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
@@ -5,7 +5,7 @@
  */
 
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic mallinfo2() test.
  *
diff --git a/testcases/kernel/syscalls/memcmp/memcmp01.c b/testcases/kernel/syscalls/memcmp/memcmp01.c
index 0acf1522f..836cf4043 100644
--- a/testcases/kernel/syscalls/memcmp/memcmp01.c
+++ b/testcases/kernel/syscalls/memcmp/memcmp01.c
@@ -7,7 +7,7 @@
  */
 
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * The testcase for buffer comparison by check boundary conditions.
  */
diff --git a/testcases/kernel/syscalls/memcpy/memcpy01.c b/testcases/kernel/syscalls/memcpy/memcpy01.c
index 7acd88192..0b64d70e6 100644
--- a/testcases/kernel/syscalls/memcpy/memcpy01.c
+++ b/testcases/kernel/syscalls/memcpy/memcpy01.c
@@ -7,7 +7,7 @@
  */
 
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * The testcase for buffer copy by check boundary conditions.
  */
diff --git a/testcases/kernel/syscalls/memset/memset01.c b/testcases/kernel/syscalls/memset/memset01.c
index 4aa8a7607..17ae42c01 100644
--- a/testcases/kernel/syscalls/memset/memset01.c
+++ b/testcases/kernel/syscalls/memset/memset01.c
@@ -7,7 +7,7 @@
  */
 
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * The testcase for test setting of buffer by check boundary conditions.
  */
diff --git a/testcases/kernel/syscalls/read/read03.c b/testcases/kernel/syscalls/read/read03.c
index b34b66151..ee92a329e 100644
--- a/testcases/kernel/syscalls/read/read03.c
+++ b/testcases/kernel/syscalls/read/read03.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Testcase to check if read() successfully sets errno to EAGAIN when read from
  * a pipe (fifo, opened in O_NONBLOCK mode) without writing to it.
diff --git a/testcases/kernel/syscalls/read/read04.c b/testcases/kernel/syscalls/read/read04.c
index ad7ba16a5..47875c034 100644
--- a/testcases/kernel/syscalls/read/read04.c
+++ b/testcases/kernel/syscalls/read/read04.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Testcase to check if read() returns the number of bytes read correctly.
  */
diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
index 5d91e26cd..0397360eb 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -5,7 +5,7 @@
  */
 
 /*\
- * [DESCRIPTION]
+ * [Description]
  * Original reproducer for kernel fix
  * bf40d3435caf NFS: add support for splice writes
  * from v2.6.31-rc1.
-- 
2.25.1

