From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 1 Sep 2021 16:10:20 +0200
Subject: [LTP] [PATCH 1/2] syscalls/pread01: Convert to new API
In-Reply-To: <1629200697-14878-1-git-send-email-daisl.fnst@fujitsu.com>
References: <1629200697-14878-1-git-send-email-daisl.fnst@fujitsu.com>
Message-ID: <YS+JzGce6YVJ3N8T@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Dai,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

with similar notes mentioned at pwrite01 [1].
Thus posting just diff of proposed changes here.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/1629294657-28375-1-git-send-email-daisl.fnst@fujitsu.com/

diff --git testcases/kernel/syscalls/pread/pread01.c testcases/kernel/syscalls/pread/pread01.c
index fc773f45c..d11ca58f8 100644
--- testcases/kernel/syscalls/pread/pread01.c
+++ testcases/kernel/syscalls/pread/pread01.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2021
  * Copyright (c) International Business Machines  Corp., 2001
  * 07/2001 Ported by Wayne Boyer
  */
@@ -7,10 +8,9 @@
 /*\
  * [Description]
  *
- *  Verify the functionality of pread() by writing known data using pwrite()
- *  to the file at various specified offsets and later read from the file from
- *  various specified offsets, comparing the data read aganist the data
- *  written.
+ * Verify the functionality of pread() by writing known data using pwrite()
+ * to the file at various specified offsets and later read from the file from
+ * various specified offsets, comparing the data read against the data written.
  */
 
 #include <stdlib.h>
@@ -26,8 +26,8 @@
 #define NBUFS           4
 
 static int fildes;
-char *write_buf[NBUFS];
-char *read_buf[NBUFS];
+static char *write_buf[NBUFS];
+static char *read_buf[NBUFS];
 
 static void l_seek(int fdesc, off_t offset, int whence, off_t checkoff)
 {
@@ -59,21 +59,16 @@ static void compare_bufers(void)
 static void verify_pread(void)
 {
 	SAFE_PREAD(1, fildes, read_buf[2], K1, K2);
-
 	l_seek(fildes, 0, SEEK_CUR, K4);
-
 	l_seek(fildes, 0, SEEK_SET, 0);
 
 	SAFE_PREAD(1, fildes, read_buf[3], K1, K3);
-
 	l_seek(fildes, 0, SEEK_CUR, 0);
 
 	SAFE_READ(1, fildes, read_buf[0], K1);
-
 	l_seek(fildes, 0, SEEK_CUR, K1);
 
 	SAFE_PREAD(1, fildes, read_buf[1], K1, K1);
-
 	l_seek(fildes, 0, SEEK_CUR, K1);
 
 	compare_bufers();
