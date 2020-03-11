From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 11 Mar 2020 18:15:11 +0800
Subject: [LTP] [PATCH 2/3] hugetlb: use .request_hugepages api
In-Reply-To: <1583921712-9008-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1583921712-9008-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1583921712-9008-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also, adjust options position to align with test options.
Replace GPL with SPDX-License-Identifier.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap01.c  | 33 ++++++------------
 .../kernel/mem/hugetlb/hugemmap/hugemmap02.c  | 33 ++++++------------
 .../kernel/mem/hugetlb/hugemmap/hugemmap04.c  | 33 ++++++------------
 .../kernel/mem/hugetlb/hugemmap/hugemmap06.c  | 30 ++--------------
 .../mem/hugetlb/hugeshmat/hugeshmat01.c       | 33 ++++++------------
 .../mem/hugetlb/hugeshmat/hugeshmat02.c       | 33 ++++++------------
 .../mem/hugetlb/hugeshmat/hugeshmat03.c       | 33 ++++++------------
 .../mem/hugetlb/hugeshmat/hugeshmat04.c       | 23 ++++---------
 .../mem/hugetlb/hugeshmat/hugeshmat05.c       | 25 +++-----------
 .../mem/hugetlb/hugeshmctl/hugeshmctl01.c     | 20 +++++------
 .../mem/hugetlb/hugeshmctl/hugeshmctl02.c     | 20 +++++------
 .../mem/hugetlb/hugeshmctl/hugeshmctl03.c     | 20 +++++------
 .../mem/hugetlb/hugeshmdt/hugeshmdt01.c       | 33 ++++++------------
 .../mem/hugetlb/hugeshmget/hugeshmget01.c     | 33 ++++++------------
 .../mem/hugetlb/hugeshmget/hugeshmget02.c     | 33 ++++++------------
 .../mem/hugetlb/hugeshmget/hugeshmget03.c     | 34 ++++++-------------
 .../mem/hugetlb/hugeshmget/hugeshmget05.c     | 34 +++++++------------
 17 files changed, 163 insertions(+), 340 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index a6ffab77b..eecbe93f8 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  * Copyright (c) Linux Test Project, 2004-2017
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * Test Name: hugemmap01
  *
  * Test Description:
@@ -40,8 +29,8 @@
 #include "hugetlb.h"
 
 static struct tst_option options[] = {
-	{"H:", &Hopt,   "-H   /..  Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"H:", &Hopt,   "-H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -50,7 +39,6 @@ static int  fildes;
 static long beforetest;
 static long aftertest;
 static long hugepagesmapped;
-static long hugepages = 128;
 static char TEMPFILE[MAXPATHLEN];
 
 static void test_hugemmap(void)
@@ -89,17 +77,17 @@ static void test_hugemmap(void)
 
 void setup(void)
 {
-	save_nr_hugepages();
-
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
 }
@@ -107,8 +95,6 @@ void setup(void)
 void cleanup(void)
 {
 	unlink(TEMPFILE);
-	restore_nr_hugepages();
-
 	umount(Hopt);
 }
 
@@ -119,4 +105,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugemmap,
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 26314d125..4a4b5680e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  * Copyright (c) Linux Test Project, 2004-2017
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * Test Name: hugemmap02
  *
  * Test Description: There is both a low hugepage region (at 2-3G for use by
@@ -46,8 +35,8 @@
 #define LOW_ADDR2      0x90000000
 
 static struct tst_option options[] = {
-	{"H:", &Hopt,   "-H   /..  Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"H:", &Hopt,   "-H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -60,7 +49,6 @@ static unsigned long low_addr2 = LOW_ADDR2;
 static unsigned long *addrlist[5];
 static int fildes;
 static int nfildes;
-static long hugepages = 128;
 
 static void test_hugemmap(void)
 {
@@ -136,17 +124,17 @@ static void test_hugemmap(void)
 
 static void setup(void)
 {
-	save_nr_hugepages();
-
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 1, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
 }
@@ -154,8 +142,6 @@ static void setup(void)
 static void cleanup(void)
 {
 	unlink(TEMPFILE);
-	restore_nr_hugepages();
-
 	umount(Hopt);
 }
 
@@ -166,4 +152,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugemmap,
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 35bae015b..0202ae841 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  * Copyright (c) Linux Test Project, 2004-2017
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * Test Name: hugemmap04
  *
  * Test Description:
@@ -42,8 +31,8 @@
 #include "hugetlb.h"
 
 static struct tst_option options[] = {
-	{"H:", &Hopt,   "-H   /..  Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"H:", &Hopt,   "-H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -56,7 +45,6 @@ static long freepages;
 static long beforetest;
 static long aftertest;
 static long hugepagesmapped;
-static long hugepages = 128;
 
 static void test_hugemmap(void)
 {
@@ -107,17 +95,17 @@ static void test_hugemmap(void)
 
 void setup(void)
 {
-	save_nr_hugepages();
-
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing!");
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
 }
@@ -125,8 +113,6 @@ void setup(void)
 void cleanup(void)
 {
 	unlink(TEMPFILE);
-	restore_nr_hugepages();
-
 	umount(Hopt);
 }
 
@@ -137,4 +123,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugemmap,
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index d66183479..93f9af7f3 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015-2017 Red Hat, Inc.
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * DESCRIPTION
  *
  *   There is a race condition if we map a same file on different processes.
@@ -39,7 +28,6 @@
 #include "lapi/mmap.h"
 
 static long hpage_size;
-static long hugepages;
 
 struct mp {
 	char *addr;
@@ -51,21 +39,9 @@ struct mp {
 
 static void setup(void)
 {
-	save_nr_hugepages();
-
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
-
-	hugepages = (ARSZ + 1) * LOOP;
-
-	if (hugepages * SAFE_READ_MEMINFO("Hugepagesize:") > SAFE_READ_MEMINFO("MemTotal:"))
+	if (tst_hugepages != test.request_hugepages)
 		tst_brk(TCONF, "System RAM is not enough to test.");
-
-	set_sys_tune("nr_hugepages", hugepages, 1);
-}
-
-static void cleanup(void)
-{
-	restore_nr_hugepages();
 }
 
 static void *thr(void *arg)
@@ -146,7 +122,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.test = do_mmap,
 	.setup = setup,
-	.cleanup = cleanup,
+	.request_hugepages = (ARSZ + 1) * LOOP,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "f522c3ac00a4"},
 		{"linux-git", "9119a41e9091"},
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 712398e27..0e6e64d3d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  * Copyright (c) Linux Test Project, 2001-2017
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * DESCRIPTION
  *	hugeshmat01 - test that shmat() works correctly
  *
@@ -47,10 +36,8 @@ static size_t shm_size;
 static int shm_id_1 = -1;
 static void *addr;
 
-static long hugepages = 128;
-
 static struct tst_option options[] = {
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -167,15 +154,17 @@ static void setup(void)
 {
 	long hpage_size;
 
-	save_nr_hugepages();
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
+
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	shm_size = hpage_size * hugepages / 2;
+	shm_size = hpage_size * tst_hugepages / 2;
 	update_shm_size(&shm_size);
 	shmkey = getipckey();
 	shm_id_1 = shmget(shmkey++, shm_size,
@@ -188,7 +177,6 @@ static void setup(void)
 static void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
@@ -199,4 +187,5 @@ static struct tst_test test = {
 	.test = verify_hugeshmat,
 	.setup = setup,
 	.cleanup = cleanup,
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 945de584d..cfc18a795 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  * Copyright (c) Linux Test Project, 2004-2017
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * DESCRIPTION
  *	hugeshmat02 - check for EINVAL and EACCES errors with hugetlb
  *
@@ -50,10 +39,8 @@ static int shm_id_1 = -1;
 static int shm_id_2 = -1;
 static void *addr;
 
-static long hugepages = 128;
-
 static struct tst_option options[] = {
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -92,15 +79,17 @@ void setup(void)
 {
 	long hpage_size;
 
-	save_nr_hugepages();
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
+
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	shm_size = hpage_size * hugepages / 2;
+	shm_size = hpage_size * tst_hugepages / 2;
 	update_shm_size(&shm_size);
 	shmkey = getipckey();
 
@@ -115,7 +104,6 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_2);
-	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
@@ -126,4 +114,5 @@ static struct tst_test test = {
 	.test = verify_hugeshmat,
 	.setup = setup,
 	.cleanup = cleanup,
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 34fea5cd7..ea784da70 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  * Copyright (c) Linux Test Project, 2004-2017
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * DESCRIPTION
  *	hugeshmat03 - test for EACCES error
  *
@@ -50,10 +39,8 @@ static void *addr;
 static uid_t ltp_uid;
 static char *ltp_user = "nobody";
 
-static long hugepages = 128;
-
 static struct tst_option options[] = {
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -87,15 +74,17 @@ static void setup(void)
 {
 	long hpage_size;
 
-	save_nr_hugepages();
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
+
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	shm_size = hpage_size * hugepages / 2;
+	shm_size = hpage_size * tst_hugepages / 2;
 	update_shm_size(&shm_size);
 	shmkey = getipckey();
 	shm_id_1 = shmget(shmkey, shm_size,
@@ -109,7 +98,6 @@ static void setup(void)
 static void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
@@ -120,4 +108,5 @@ static struct tst_test test = {
 	.test_all = verify_hugeshmat,
 	.setup = setup,
 	.cleanup = cleanup,
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index c76e4167f..080849671 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -1,23 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Linux Test Project, 2014-2017
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * DESCRIPTION
  *	hugeshmat04 - test for hugepage leak inspection.
  *
  *	It is a regression test for shared hugepage leak, when over 1GB
- *	shered memory was alocated in hugepage, the hugepage is not released
+ *	shared memory was alocated in hugepage, the hugepage is not released
  *	though process finished.
  *
  *	You need more than 2GB memory in test job
@@ -85,7 +74,7 @@ static void setup(void)
 {
 	long mem_total, hpage_size, orig_hugepages;
 
-	orig_hugepages = save_nr_hugepages();
+	orig_hugepages = get_sys_tune("nr_hugepages");
 	mem_total = SAFE_READ_MEMINFO("MemTotal:");
 	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &orig_shmmax);
 	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", (long)SIZE);
@@ -100,12 +89,13 @@ static void setup(void)
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
 	hugepages = orig_hugepages + SIZE / hpage_size;
-	set_sys_tune("nr_hugepages", hugepages, 1);
+	tst_request_hugepages(hugepages);
+	if (tst_hugepages != (unsigned long)hugepages)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 }
 
 static void cleanup(void)
 {
-	restore_nr_hugepages();
 	if (orig_shmmax != -1)
 		SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", orig_shmmax);
 }
@@ -118,4 +108,5 @@ static struct tst_test test = {
 	.test = test_hugeshmat,
 	.setup = setup,
 	.cleanup = cleanup,
+	.request_hugepages = 1,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
index 587110ad3..a30e1e3c3 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
@@ -1,18 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015-2017 Red Hat, Inc.
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * DESCRIPTION
  *	shmget()/shmat() fails to allocate huge pages shared memory segment
  *	with EINVAL if its size is not in the range [ N*HUGE_PAGE_SIZE - 4095,
@@ -40,23 +30,16 @@
 
 static long page_size;
 static long hpage_size;
-static long hugepages;
 
 #define N 4
 
 void setup(void)
 {
-	save_nr_hugepages();
 	page_size = getpagesize();
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	hugepages = N + 1;
-	set_sys_tune("nr_hugepages", hugepages, 1);
-}
-
-void cleanup(void)
-{
-	restore_nr_hugepages();
+	if (tst_hugepages != test.request_hugepages)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 }
 
 void shm_test(int size)
@@ -108,7 +91,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.test_all = test_hugeshmat,
 	.setup = setup,
-	.cleanup = cleanup,
+	.request_hugepages = N + 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "091d0d55b286"},
 		{"linux-git", "af73e4d9506d"},
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 2e35b5d8f..84321d94c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -53,10 +53,8 @@ static void func_set(void);
 static void func_rmid(void);
 static void *set_shmat(void);
 
-static long hugepages = 128;
-
 static struct tst_option options[] = {
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -290,15 +288,17 @@ void setup(void)
 {
 	long hpage_size;
 
-	save_nr_hugepages();
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
+
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	shm_size = hpage_size * hugepages / 2;
+	shm_size = hpage_size * tst_hugepages / 2;
 	update_shm_size(&shm_size);
 	shmkey = getipckey();
 }
@@ -306,7 +306,6 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
@@ -318,4 +317,5 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = test_hugeshmctl,
 	.needs_checkpoints = 1,
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index fe3a74607..9d835394c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -34,10 +34,8 @@ static int shm_id_2 = -1;
 static int shm_id_3 = -1;
 static struct shmid_ds buf;
 
-static long hugepages = 128;
-
 static struct tst_option options[] = {
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -79,15 +77,17 @@ static void setup(void)
 {
 	long hpage_size;
 
-	save_nr_hugepages();
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
+
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	shm_size = hpage_size * (hugepages / 2);
+	shm_size = hpage_size * (tst_hugepages / 2);
 	update_shm_size(&shm_size);
 	shmkey = getipckey();
 
@@ -107,7 +107,6 @@ static void cleanup(void)
 {
 	rm_shm(shm_id_1);
 	rm_shm(shm_id_2);
-	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
@@ -118,4 +117,5 @@ static struct tst_test test = {
 	.options = options,
 	.setup = setup,
 	.cleanup = cleanup,
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index a8191ec5b..739b57f95 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -44,10 +44,8 @@ static struct shmid_ds buf;
 static uid_t ltp_uid;
 static char *ltp_user = "nobody";
 
-static long hugepages = 128;
-
 static struct tst_option options[] = {
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -108,15 +106,17 @@ void setup(void)
 {
 	long hpage_size;
 
-	save_nr_hugepages();
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
+
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	shm_size = hpage_size * hugepages / 2;
+	shm_size = hpage_size * tst_hugepages / 2;
 	update_shm_size(&shm_size);
 	shmkey = getipckey();
 	shm_id_1 = shmget(shmkey, shm_size,
@@ -131,7 +131,6 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
@@ -142,4 +141,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmctl,
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 171868aeb..f0947e703 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  * Copyright (c) Linux Test Project, 2004-2017
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * DESCRIPTION
  *	hugeshmdt01 - check that largr shared memory is detached correctly
  *
@@ -42,7 +31,6 @@
 #include <setjmp.h>
 #include <limits.h>
 #include "hugetlb.h"
-#include "hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
@@ -51,9 +39,8 @@ static int *shared;
 static int pass;
 static sigjmp_buf env;
 
-static long hugepages = 128;
 static struct tst_option options[] = {
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -132,15 +119,17 @@ void setup(void)
 {
 	long hpage_size;
 
-	save_nr_hugepages();
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
+
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	shm_size = hpage_size * hugepages / 2;
+	shm_size = hpage_size * tst_hugepages / 2;
 	update_shm_size(&shm_size);
 	shmkey = getipckey();
 
@@ -162,7 +151,6 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
@@ -171,4 +159,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = hugeshmdt_test,
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 1636260ce..d77f4ae97 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  * Copyright (c) Linux Test Project, 2004-2017
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * DESCRIPTION
  *	hugeshmget01 - test that shmget() correctly creates a large
  *			shared memory segment
@@ -25,14 +14,12 @@
 
 #include <limits.h>
 #include "hugetlb.h"
-#include "hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
 
-static long hugepages = 128;
 static struct tst_option options[] = {
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -67,15 +54,17 @@ static void setup(void)
 {
 	long hpage_size;
 
-	save_nr_hugepages();
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
+
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	shm_size = hpage_size * hugepages / 2;
+	shm_size = hpage_size * tst_hugepages / 2;
 	update_shm_size(&shm_size);
 	shmkey = getipckey();
 
@@ -88,7 +77,6 @@ static void setup(void)
 static void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
@@ -97,4 +85,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmget,
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index e8de3251f..ad81c979c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -1,19 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  * Copyright (c) Linux Test Project, 2004-2017
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * DESCRIPTION
  *	hugeshmget02 - check for ENOENT, EEXIST and EINVAL errors
  *
@@ -24,16 +14,13 @@
 #include <limits.h>
 #include "hugetlb.h"
 
-#include "hugetlb.h"
-
 static size_t shm_size;
 static int shm_id_1 = -1;
 static int shm_nonexistent_key = -1;
 static key_t shmkey2;
 
-static long hugepages = 128;
 static struct tst_option options[] = {
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -85,15 +72,17 @@ void setup(void)
 {
 	long hpage_size;
 
-	save_nr_hugepages();
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
+
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	shm_size = hpage_size * hugepages / 2;
+	shm_size = hpage_size * tst_hugepages / 2;
 	update_shm_size(&shm_size);
 
 	shmkey = getipckey();
@@ -107,7 +96,6 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
@@ -117,4 +105,5 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = test_hugeshmget,
 	.tcnt = ARRAY_SIZE(tcases),
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index f2ecc465d..e08ed9f42 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-late
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  * Copyright (c) Linux Test Project, 2004-2017
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * DESCRIPTION
  *	hugeshmget03 - test for ENOSPC error
  *
@@ -24,7 +13,6 @@
 
 #include <limits.h>
 #include "hugetlb.h"
-#include "hugetlb.h"
 
 /*
  * The MAXIDS value is somewhat arbitrary and may need to be increased
@@ -38,10 +26,9 @@ static int shm_id_1 = -1;
 static int num_shms;
 static int shm_id_arr[MAXIDS];
 
-static long hugepages = 128;
 static long orig_shmmni = -1;
 static struct tst_option options[] = {
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -64,15 +51,16 @@ static void setup(void)
 {
 	long hpage_size;
 
-	save_nr_hugepages();
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
+
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
 	SAFE_FILE_SCANF(PATH_SHMMNI, "%ld", &orig_shmmni);
-
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
-	SAFE_FILE_PRINTF(PATH_SHMMNI, "%ld", hugepages / 2);
+	SAFE_FILE_PRINTF(PATH_SHMMNI, "%ld", tst_hugepages / 2);
 
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	shm_size = hpage_size;
@@ -107,7 +95,6 @@ static void cleanup(void)
 
 	if (orig_shmmni != -1)
 		FILE_PRINTF(PATH_SHMMNI, "%ld", orig_shmmni);
-	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
@@ -116,4 +103,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmget,
+	.request_hugepages = 128,
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 824293fb8..4c175d59a 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-late
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  * Copyright (c) Linux Test Project, 2004-2017
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- */
-
-/*
  * DESCRIPTION
  *	hugeshmget05 - test for EACCES error
  *
@@ -26,16 +15,14 @@
 #include <sys/wait.h>
 #include <limits.h>
 #include "hugetlb.h"
-#include "hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
 static uid_t ltp_uid;
 static char *ltp_user = "nobody";
 
-static long hugepages = 128;
 static struct tst_option options[] = {
-	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
+	{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
@@ -49,6 +36,7 @@ static void test_hugeshmget(void)
 	switch (pid = fork()) {
 	case -1:
 		tst_brk(TBROK | TERRNO, "fork");
+		break;
 	case 0:
 		/* set the user ID of the child to the non root user */
 		SAFE_SETUID(ltp_uid);
@@ -78,15 +66,17 @@ void setup(void)
 {
 	long hpage_size;
 
-	save_nr_hugepages();
-	if (nr_opt)
-		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	if (nr_opt) {
+		tst_hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+		tst_request_hugepages(tst_hugepages);
+	}
+
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
 
-	limit_hugepages(&hugepages);
-	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	shm_size = hpage_size * hugepages / 2;
+	shm_size = hpage_size * tst_hugepages / 2;
 	update_shm_size(&shm_size);
 	shmkey = getipckey();
 	shm_id_1 = shmget(shmkey, shm_size,
@@ -101,7 +91,6 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
@@ -110,4 +99,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmget,
+	.request_hugepages = 128,
 };
-- 
2.18.0



