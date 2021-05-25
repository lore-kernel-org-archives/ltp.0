From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 May 2021 16:58:31 +0200
Subject: [LTP] [PATCH 3/3] syscalls/fchown: Convert fchown03 to the new
 API
In-Reply-To: <20210506130950.110267-4-xieziyao@huawei.com>
References: <20210506130950.110267-1-xieziyao@huawei.com>
 <20210506130950.110267-4-xieziyao@huawei.com>
Message-ID: <YK0Qlxbtyfci5b2z@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

Merged with these changes below. Thanks!

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fchown/fchown03.c testcases/kernel/syscalls/fchown/fchown03.c
index a69ec86ae..752d9c394 100644
--- testcases/kernel/syscalls/fchown/fchown03.c
+++ testcases/kernel/syscalls/fchown/fchown03.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2001-2021
  * Copyright (c) International Business Machines  Corp., 2001
  * 07/2001 Ported by Wayne Boyer
  */
@@ -10,7 +11,7 @@
  * Verify that, fchown(2) succeeds to change the group of a file specified
  * by path when called by non-root user with the following constraints:
  *
- * - euid of the process is equal to the owner of the file;
+ * - euid of the process is equal to the owner of the file
  * - the intended gid is either egid, or one of the supplementary gids
  *   of the process.
  *
@@ -36,8 +37,7 @@ static struct passwd *ltpuser;
 static void check_owner(struct stat *s, uid_t exp_uid, gid_t exp_gid)
 {
 	if (s->st_uid != exp_uid || s->st_gid != exp_gid)
-		tst_res(TFAIL, "%s: wrong owner set to (uid=%d, gid=%d),"
-			       " expected (uid=%d, gid=%d)",
+		tst_res(TFAIL, "%s: wrong owner set to (uid=%d, gid=%d), expected (uid=%d, gid=%d)",
 			FILENAME, s->st_uid, s->st_gid, exp_uid, exp_gid);
 }
 
@@ -50,17 +50,18 @@ static void check_mode(struct stat *s, mode_t exp_mode)
 
 static void run(void)
 {
+	uid_t uid;
+	gid_t gid;
+	struct stat stat_buf;
+
 	SAFE_SETEUID(0);
 	SAFE_FCHOWN(fd, -1, 0);
 	SAFE_FCHMOD(fd, NEW_PERMS);
 	SAFE_SETEUID(ltpuser->pw_uid);
 
-	uid_t uid;
-	gid_t gid;
 	UID16_CHECK((uid = geteuid()), "fchown");
 	GID16_CHECK((gid = getegid()), "fchown");
 
-	struct stat stat_buf;
 	SAFE_STAT(FILENAME, &stat_buf);
 	check_owner(&stat_buf, uid, 0);
 	check_mode(&stat_buf, NEW_PERMS);
