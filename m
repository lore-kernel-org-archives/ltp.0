From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 May 2021 16:56:08 +0200
Subject: [LTP] [PATCH 1/3] syscalls/fchown: Convert fchown01 to the new
 API
In-Reply-To: <20210506130950.110267-2-xieziyao@huawei.com>
References: <20210506130950.110267-1-xieziyao@huawei.com>
 <20210506130950.110267-2-xieziyao@huawei.com>
Message-ID: <YK0QCD3CTXDpPcN1@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

merged with these changes, thanks!

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fchown/fchown01.c testcases/kernel/syscalls/fchown/fchown01.c
index 32fc53d6c..77913ce32 100644
--- testcases/kernel/syscalls/fchown/fchown01.c
+++ testcases/kernel/syscalls/fchown/fchown01.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2006-2021
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- * AUTHOR: William Roske
- * CO-PILOT: Dave Fenner
+ * Author: William Roske
+ * Ported to LTP: Dave Fenner
  */
 
 /*\
@@ -22,7 +23,8 @@
 #define MODE 0700
 
 static int fd;
-static int uid, gid;
+static uid_t uid;
+static gid_t gid;
 
 static void run(void)
 {
