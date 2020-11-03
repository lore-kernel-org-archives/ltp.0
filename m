From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Nov 2020 20:13:21 +0100
Subject: [LTP] [PATCH v2 05/11] syscalls: Add a few documentation comments
In-Reply-To: <20201103191327.11081-1-pvorel@suse.cz>
References: <20201103191327.11081-1-pvorel@suse.cz>
Message-ID: <20201103191327.11081-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cyril Hrubis <metan@ucw.cz>

So that it shows up in the resulting json file.

Signed-off-by: Cyril Hrubis <metan@ucw.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/abort/abort01.c   | 16 ++++++++++------
 testcases/kernel/syscalls/accept/accept01.c |  8 +++++---
 testcases/kernel/syscalls/accept/accept02.c |  7 +++++--
 testcases/kernel/syscalls/acct/acct01.c     |  5 +++++
 testcases/kernel/syscalls/acct/acct02.c     |  6 ++++--
 5 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/abort/abort01.c b/testcases/kernel/syscalls/abort/abort01.c
index 9505a5eec..b93324b34 100644
--- a/testcases/kernel/syscalls/abort/abort01.c
+++ b/testcases/kernel/syscalls/abort/abort01.c
@@ -5,14 +5,18 @@
  *   01/02/2003	Port to LTP	avenkat@us.ibm.com
  *   11/11/2002: Ported to LTP Suite by Ananda
  *   06/30/2001	Port to Linux	nsharoff@us.ibm.com
- *
- * ALGORITHM
- *	Fork child.  Have child abort, check return status.
- *
- * RESTRICTIONS
- *      The ulimit for core file size must be greater than 0.
  */
 
+/*\
+ * [DESCRIPTION]
+ *  Checks that process which called abort() gets killed by SIGIOT and dumps core.
+ *
+ * [ALGORITHM]
+ *  - Fork child.
+ *  - Child calls abort.
+ *  - Parent checks return status.
+\*/
+
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index 4e30906f2..01d6db84c 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -3,11 +3,13 @@
 /*
  *   Copyright (c) International Business Machines  Corp., 2001
  *   07/2001 Ported by Wayne Boyer
- *
- *   Description:
- *     Verify that accept() returns the proper errno for various failure cases
  */
 
+/*\
+ * [DESCRIPTION]
+ * Verify that accept() returns the proper errno for various failure cases.
+\*/
+
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
index 37ab8b64f..7fb6a494a 100644
--- a/testcases/kernel/syscalls/accept/accept02.c
+++ b/testcases/kernel/syscalls/accept/accept02.c
@@ -3,7 +3,10 @@
  * Copyright (c) 2019 SUSE LLC
  * Author: Christian Amann <camann@suse.com>
  */
-/* Test for CVE-2017-8890
+/*\
+ * [DESCRIPTION]
+ *
+ * Test for CVE-2017-8890
  *
  * In Kernels up to 4.10.15 missing commit 657831ff the multicast
  * group information of a socket gets copied over to a newly created
@@ -16,7 +19,7 @@
  *
  * For more information about this CVE see:
  * https://www.suse.com/security/cve/CVE-2017-8890/
- */
+\*/
 
 #include <errno.h>
 #include <sys/socket.h>
diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index c161d2a2c..60e81bfad 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -7,6 +7,11 @@
 /* 12/03/2002	Port to LTP     robbiew@us.ibm.com */
 /* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
 
+/*\
+ * [DOCUMENTATION]
+ *  Verify that acct() returns proper errno on failure.
+\*/
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index 8ee1bfcf8..e718e7df4 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -3,7 +3,9 @@
  *  Copyright (c) SUSE LLC, 2019
  *  Author: Christian Amann <camann@suse.com>
  */
-/*
+/*\
+ * [DOCUMENTATION]
+ *
  * This tests if the kernel writes correct data to the
  * process accounting file.
  *
@@ -19,7 +21,7 @@
  *
  * This is also accidental regression test for:
  * 4d9570158b626 kernel/acct.c: fix the acct->needcheck check in check_free_space()
- */
+\*/
 
 #include <sys/stat.h>
 #include <errno.h>
-- 
2.29.1

