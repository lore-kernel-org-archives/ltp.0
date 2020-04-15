From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 13:26:27 +0200
Subject: [LTP] [PATCH v2 1/9] Remove use of TCID in new API tests
In-Reply-To: <20200415112635.14144-1-pvorel@suse.cz>
References: <20200415112635.14144-1-pvorel@suse.cz>
Message-ID: <20200415112635.14144-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a preparation for build with -fno-common

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.
Sorry for quashing it in a single commit.

 testcases/kernel/mem/tunable/overcommit_memory.c        | 4 ++--
 testcases/kernel/security/integrity/ima/src/ima_mmap.c  | 3 ++-
 testcases/kernel/syscalls/memfd_create/memfd_create01.c | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 345764dfe..f77939908 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) Linux Test Project, 2012-2020
  * Copyright (C) 2012-2017  Red Hat, Inc.
  *
  * This program is free software;  you can redistribute it and/or modify
@@ -101,8 +102,7 @@ static void setup(void)
 
 	if (access(PATH_SYSVM "overcommit_memory", F_OK) == -1 ||
 	    access(PATH_SYSVM "overcommit_ratio", F_OK) == -1)
-		tst_brk(TCONF, "The system "
-			 "can't support to test %s", TCID);
+		tst_brk(TCONF, "system doesn't support overcommit_memory");
 
 	if (R_opt)
 		overcommit_ratio = SAFE_STRTOL(R_opt, 0, LONG_MAX);
diff --git a/testcases/kernel/security/integrity/ima/src/ima_mmap.c b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
index 0875aaeaf..c831be829 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2010-2020
  * Copyright (c) International Business Machines Corp., 2009
  *
  * Authors:
@@ -33,7 +34,7 @@ static void cleanup(void)
 static void run(void)
 {
 	if (!filename)
-		tst_brk(TBROK, "Usage: %s -f filename", TCID);
+		tst_brk(TBROK, "missing filename (-f filename)");
 
 	fd = SAFE_OPEN(filename, O_CREAT | O_RDWR, S_IRWXU);
 
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create01.c b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
index fdd37f64b..e0db69dff 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create01.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2017-2020
  * Copyright (C) 2017  Red Hat, Inc.
  */
 
@@ -241,7 +242,7 @@ static void verify_memfd_create(unsigned int n)
 
 	tst_res(TINFO, "%s", tc->desc);
 
-	fd = CHECK_MFD_NEW(TCID, MFD_DEF_SIZE, tc->flags);
+	fd = CHECK_MFD_NEW("ltp_memfd_create01", MFD_DEF_SIZE, tc->flags);
 
 	tc->func(fd);
 
-- 
2.26.0

