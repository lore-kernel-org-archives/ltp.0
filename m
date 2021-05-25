From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 May 2021 16:57:33 +0200
Subject: [LTP] [PATCH 2/3] syscalls/fchown: Convert fchown02 to the new
 API
In-Reply-To: <20210506130950.110267-3-xieziyao@huawei.com>
References: <20210506130950.110267-1-xieziyao@huawei.com>
 <20210506130950.110267-3-xieziyao@huawei.com>
Message-ID: <YK0QXeP8740nQJ7e@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

thanks! Merged with these changes (NOTE: "for (unsigned int i = 0" breaks on
older compilers, which are represented with CentOS in our travis).

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fchown/fchown02.c testcases/kernel/syscalls/fchown/fchown02.c
index a99962911..d541f0450 100644
--- testcases/kernel/syscalls/fchown/fchown02.c
+++ testcases/kernel/syscalls/fchown/fchown02.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2003-2021
+ * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) International Business Machines  Corp., 2001
  * 07/2001 Ported by Wayne Boyer
- * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
  */
 
 /*\
@@ -43,6 +44,7 @@ struct test_case_t {
 
 static void run(unsigned int i)
 {
+	struct stat stat_buf;
 	uid_t uid;
 	gid_t gid;
 
@@ -53,7 +55,6 @@ static void run(unsigned int i)
 
 	TST_EXP_PASS(FCHOWN(*tc[i].fd, uid, gid));
 
-	struct stat stat_buf;
 	SAFE_STAT(tc[i].filename, &stat_buf);
 
 	if (stat_buf.st_uid != uid || stat_buf.st_gid != gid)
@@ -67,13 +68,17 @@ static void run(unsigned int i)
 
 static void setup(void)
 {
-	for (unsigned int i = 0; i < ARRAY_SIZE(tc); ++i)
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tc); i++)
 		*tc[i].fd = SAFE_OPEN(tc[i].filename, O_RDWR | O_CREAT, FILE_MODE);
 }
 
 static void cleanup(void)
 {
-	for (unsigned int i = 0; i < ARRAY_SIZE(tc); ++i)
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tc); i++)
 		SAFE_CLOSE(*tc[i].fd);
 }
 
