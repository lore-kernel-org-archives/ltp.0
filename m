Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UDVt7-00088i-T3
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:09:17 +0000
Received: from mail-pa0-f52.google.com ([209.85.220.52])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UDVt3-00026s-4G
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:09:17 +0000
Received: by mail-pa0-f52.google.com with SMTP id fb1so277602pad.39
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Mar 2013 00:09:07 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Thu,  7 Mar 2013 15:38:33 +0800
Message-Id: <b1f36450d2c5fd46eabdcee4f268cf7a0a69017b.1362641893.git.caspar@casparzhang.com>
In-Reply-To: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
References: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
In-Reply-To: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
References: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.8.1.4"
Subject: [LTP] [PATCH 2/3] syscalls/madvise: code cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.8.1.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Just a code cleanup for syscalls/madvise01-04 cases.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/syscalls/madvise/madvise01.c |  77 +++--------------
 testcases/kernel/syscalls/madvise/madvise02.c | 117 ++++++++------------------
 testcases/kernel/syscalls/madvise/madvise03.c |  17 ++--
 testcases/kernel/syscalls/madvise/madvise04.c |   5 +-
 4 files changed, 58 insertions(+), 158 deletions(-)


--------------1.8.1.4
Content-Type: text/x-patch; name="0002-syscalls-madvise-code-cleanup.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-syscalls-madvise-code-cleanup.patch"

diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index fb6f8d9..1a29e6f 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -1,12 +1,7 @@
-/***************************************************************************
- *           madvise01 .c
- *
- *  Fri May 13 15:00:59 2004
- *  Copyright (c) International Business Machines  Corp., 2004
- *  Email : sumit@in.ibm.com
- ****************************************************************************/
-
 /*
+ *  Copyright (c) International Business Machines  Corp., 2004
+ *  Copyright (c) Linux Test Project, 2013
+ *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -22,68 +17,24 @@
  *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-/**********************************************************
- *    TEST CASES
- *
- *	1.) madvise(2) advices...(See Description)
- *
- *	INPUT SPECIFICATIONS
- *		The standard options for system call tests are accepted.
- *		(See the parse_opts(3) man page).
- *
- *	OUTPUT SPECIFICATIONS
- *		Output describing whether test cases passed or failed.
- *
- *	ENVIRONMENTAL NEEDS
- *		None
- *
- *	SPECIAL PROCEDURAL REQUIREMENTS
- *		None
- *
- *	DETAILED DESCRIPTION
- *		This is a test case for madvise(2) system call.
- *		It tests madvise(2) with combinations of advice values.
- *		No error should be returned.
- *
- *		Total 5 Test Cases :-
- *		(1) Test Case for MADV_NORMAL
- *		(2) Test Case for MADV_RANDOM
- *		(3) Test Case for MADV_SEQUENTIAL
- *		(4) Test Case for MADV_WILLNEED
- *		(5) Test Case for MADV_DONTNEED
- *
- *	Setup:
- *		Setup signal handling.
- *		Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *		Loop if the proper options are given.
- *		Execute system call
- *		Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *		Otherwise, Issue a PASS message.
- *
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
+/*
+ * This is a test case for madvise(2) system call.
+ * It tests madvise(2) with combinations of advice values.
+ * No error should be returned.
+ */
 
-#include <stdio.h>
-#include <string.h>
-#include <errno.h>
 #include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
 #include <sys/mman.h>
+#include <sys/stat.h>
+#include <errno.h>
 #include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
 
 #include "test.h"
 #include "usctest.h"
 
-/* Uncomment the following line in DEBUG mode */
-//#define MM_DEBUG 1
-
 static void setup(void);
 static void cleanup(void);
 static void check_and_print(char *advice);
@@ -118,7 +69,7 @@ int main(int argc, char *argv[])
 		fd = open(filename, O_RDWR | O_CREAT, 0664);
 		if (fd < 0)
 			tst_brkm(TBROK | TERRNO, cleanup, "open failed");
-#ifdef MM_DEBUG
+#ifdef DEBUG
 		tst_resm(TINFO, "filename = %s opened successfully", filename);
 #endif
 
diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index cf029e2..87d26c3 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -1,12 +1,7 @@
-/***************************************************************************
- *            madvise2.c
- *
- *  Fri May 14 17:23:19 2004
- *	Copyright (c) International Business Machines  Corp., 2004
- *  Email	sumit@in.ibm.com
- ****************************************************************************/
-
 /*
+ *  Copyright (c) International Business Machines  Corp., 2004
+ *  Copyright (c) Linux Test Project, 2013
+ *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -22,89 +17,49 @@
  *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-/**********************************************************
- *    TEST CASES
- *
- *	1.) madvise(2) error conditions...(See Description)
- *
- *	INPUT SPECIFICATIONS
- *		The standard options for system call tests are accepted.
- *		(See the parse_opts(3) man page).
- *
- *	OUTPUT SPECIFICATIONS
- *		Output describing whether test cases passed or failed.
- *
- *	ENVIRONMENTAL NEEDS
- *		None
- *
- *	SPECIAL PROCEDURAL REQUIREMENTS
- *		None
- *
- *	DETAILED DESCRIPTION
- *		This is a test for the madvise(2) system call. It is intended
- *		to provide a complete exposure of the system call. It tests
- *		madvise(2) for all error conditions to occur correctly.
- *
- *		(A) Test Case for EINVAL
- *		1. start is not page-aligned
- *		2. advice is not a valid value
- *		3. application is attempting to release
- *			   locked or shared pages (with MADV_DONTNEED)
- *
- *		(B) Test Case for ENOMEM
- *		4. addresses in the specified range are not currently mapped
- *			   or are outside the address space of the process
- *			b. Not enough memory - paging in failed
- *
- *		(C) Test Case for EBADF
- *		5. the map exists,
- *			   but the area maps something that isn't a file.
- *
- *		(D) Test Case for EAGAIN
- *		6. a kernel resource was temporarily unavailable.
- *
- *	Setup:
- *		Setup signal handling.
- *		Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *		Loop if the proper options are given.
- *		Execute system call
- *		Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *		Otherwise, Issue a PASS message.
- *
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
+/*
+ * This is a test for the madvise(2) system call. It is intended
+ * to provide a complete exposure of the system call. It tests
+ * madvise(2) for all error conditions to occur correctly.
+ *
+ * (A) Test Case for EINVAL
+ *  1. start is not page-aligned
+ *  2. advice is not a valid value
+ *  3. application is attempting to release
+ *     locked or shared pages (with MADV_DONTNEED)
+ *
+ * (B) Test Case for ENOMEM
+ *  4. addresses in the specified range are not currently mapped
+ *     or are outside the address space of the process
+ *  b. Not enough memory - paging in failed
+ *
+ * (C) Test Case for EBADF
+ *  5. the map exists,
+ *     but the area maps something that isn't a file.
+ */
 
-#include <stdio.h>
-#include <string.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/resource.h>
+#include <sys/stat.h>
+#include <sys/time.h>
 #include <errno.h>
-#include <sys/types.h>		/* For fstat */
-#include <sys/stat.h>		/* For fstat */
-#include <unistd.h>		/* For fstat & getpagesize() */
-#include <sys/mman.h>		/* For madvise */
 #include <fcntl.h>
-#include <sys/time.h>		/* For rlimit */
-#include <sys/resource.h>	/* For rlimit */
-
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
 #include "test.h"
 #include "usctest.h"
 
-/* Uncomment the following line in DEBUG mode */
-//#define MM_DEBUG 1
 #define MM_RLIMIT_RSS 5
 
+char *TCID = "madvise02";
+int TST_TOTAL = 7;
+
 static void setup(void);
 static void cleanup(void);
 static void check_and_print(int expected_errno);
 
-char *TCID = "madvise02";
-int TST_TOTAL = 7;
-
 int main(int argc, char *argv[])
 {
 	int lc, fd, pagesize;
@@ -135,7 +90,7 @@ int main(int argc, char *argv[])
 		fd = open(filename, O_RDWR | O_CREAT, 0664);
 		if (fd < 0)
 			tst_brkm(TBROK, cleanup, "open failed");
-#ifdef MM_DEBUG
+#ifdef DEBUG
 		tst_resm(TINFO, "filename = %s opened successfully", filename);
 #endif
 
@@ -153,7 +108,7 @@ int main(int argc, char *argv[])
 		file = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
 		if (file == MAP_FAILED)
 			tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
-#ifdef MM_DEBUG
+#ifdef DEBUG
 		tst_resm(TINFO, "The Page size is %d", pagesize);
 #endif
 
diff --git a/testcases/kernel/syscalls/madvise/madvise03.c b/testcases/kernel/syscalls/madvise/madvise03.c
index 916bfcf..aeae429 100644
--- a/testcases/kernel/syscalls/madvise/madvise03.c
+++ b/testcases/kernel/syscalls/madvise/madvise03.c
@@ -21,16 +21,16 @@
  * This is a test case for madvise(2) system call. No error should be returned.
  */
 
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/shm.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <unistd.h>
-#include <sys/shm.h>
-#include <sys/mman.h>
-#include <fcntl.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -39,9 +39,6 @@ char *TCID = "madvise03";
 
 #ifdef MADV_REMOVE
 
-/* Uncomment the following line in DEBUG mode */
-//#define MM_DEBUG 1
-
 int TST_TOTAL = 3;
 
 static void setup(void);
@@ -80,7 +77,7 @@ int main(int argc, char *argv[])
 		fd = open(filename, O_RDWR | O_CREAT, 0664);
 		if (fd < 0)
 			tst_brkm(TBROK, cleanup, "open failed");
-#ifdef MM_DEBUG
+#ifdef DEBUG
 		tst_resm(TINFO, "filename = %s opened successfully", filename);
 #endif
 
diff --git a/testcases/kernel/syscalls/madvise/madvise04.c b/testcases/kernel/syscalls/madvise/madvise04.c
index 5a376fc..4b55f5a 100644
--- a/testcases/kernel/syscalls/madvise/madvise04.c
+++ b/testcases/kernel/syscalls/madvise/madvise04.c
@@ -34,9 +34,6 @@ char *TCID = "madvise04";
 
 #ifdef MADV_DONTDUMP
 
-/* Uncomment the following line in DEBUG mode */
-//#define MM_DEBUG 1
-
 int TST_TOTAL = 2;
 
 #define BUFFER_SIZE  256
@@ -72,7 +69,7 @@ int main(int argc, char *argv[])
 		fd = open(filename, O_RDWR | O_CREAT, 0664);
 		if (fd < 0)
 			tst_brkm(TBROK, cleanup, "open failed");
-#ifdef MM_DEBUG
+#ifdef DEBUG
 		tst_resm(TINFO, "filename = %s opened successfully", filename);
 #endif
 

--------------1.8.1.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
--------------1.8.1.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.8.1.4--



