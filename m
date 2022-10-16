Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0729FC433FE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 12:58:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BA533CAFC1
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 14:58:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2C73CAECE
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:58:40 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3873E6000F8
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:58:38 +0200 (CEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G90aZV021678
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QAu+8Ax7WZMBSuqs7QUeOjYve9IZu6KTG0Gyts14JW0=;
 b=pO0wn5yEuDi3w3NlFQOD2vY6c/mNt7n4WXCHf/hlNJACz+xMt0BywTU5QZj45BbB1XIc
 2T5c7sPjvJteNM8nZ1HjrCScOxg5bmk2mxf/nyxG3Qu1jsWNH3Fwh7TlifeIKDturS8h
 MgcejjbRpIzHYsBZ41NdBJtMsV4b2HQ3pZZaUgBUY+gyMpJoB8+ixgvoyvq5AVjJR4m9
 WnBqYpnjQzj7Vu+bFh63js10ayfowca2TTT7wqu+iwFwgUhaOOQ/c07ZMaxdQG2xbTy4
 +14knncaHlcMXQiPokd6jCS4DbyVn8EcVEeuXfPP71mm+Tla09Q26DtCSrk8vTRIwDpU uw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86g54jmg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpBf9009998
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:35 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3k7mg91kjy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29GCx4FW39846326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D52711C04C;
 Sun, 16 Oct 2022 12:58:32 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B1A911C04A;
 Sun, 16 Oct 2022 12:58:30 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:58:29 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:03 +0530
Message-Id: <20221016125731.249078-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LUWxGmVn8dDSvE87pUR7cbTnqS-cYbjg
X-Proofpoint-ORIG-GUID: LUWxGmVn8dDSvE87pUR7cbTnqS-cYbjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 01/29] Hugetlb: Migrating libhugetlbfs brk_near_huge
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/brk_near_huge.c test

Test Description:
Certain kernels have a bug where brk() does not perform the same checks
that a MAP_FIXED mmap() will, allowing brk() to create a normal page VMA in
a hugepage only address region. This can lead to oopses or other badness.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 163 ++++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.c    |  75 ++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   5 +
 5 files changed, 245 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index f719217ab..f7ff81cb3 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -3,6 +3,7 @@ hugemmap02 hugemmap02
 hugemmap04 hugemmap04
 hugemmap05 hugemmap05
 hugemmap06 hugemmap06
+hugemmap07 hugemmap07
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index ff2910533..df5256ec8 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -4,6 +4,7 @@
 /hugetlb/hugemmap/hugemmap04
 /hugetlb/hugemmap/hugemmap05
 /hugetlb/hugemmap/hugemmap06
+/hugetlb/hugemmap/hugemmap07
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
new file mode 100644
index 000000000..06fd0b86c
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: brk near hugepage
+ *
+ * Test Description: Certain kernels have a bug where brk() does not perform
+ * the same checks that a MAP_FIXED mmap() will, allowing brk() to create a
+ * normal page VMA in a hugepage only address region. This can lead to oopses
+ * or other badness.
+ *
+ * HISTORY
+ *  Written by David Gibson & Adam Litke
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+
+#include "hugetlb.h"
+#include "tst_safe_stdio.h"
+
+static char *verbose;
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+static long hpage_size;
+
+static int arch_has_slice_support(void)
+{
+#ifdef __powerpc64__
+	char mmu_type[16];
+	FILE *fp;
+
+	fp = SAFE_POPEN("cat /proc/cpuinfo | grep MMU | awk '{ print $3}'", "r");
+	if (fscanf(fp, "%s", mmu_type) < 0)
+		tst_brk(TBROK, "Failed to determine MMU type");
+
+	pclose(fp);
+	return strcmp(mmu_type, "Hash") == 0;
+#elif defined(__powerpc__) && !defined(PPC_NO_SEGMENTS)
+	return 1;
+#else
+	return 0;
+#endif
+}
+
+#ifdef __powerpc64__
+static void *next_chunk(void *addr)
+{
+	if (!arch_has_slice_support())
+		return PALIGN(addr, SAFE_READ_MEMINFO("Hugepagesize:")*1024);
+
+	if ((unsigned long)addr < 0x100000000UL)
+		/* 256M segments below 4G */
+		return PALIGN(addr, 0x10000000UL);
+	/* 1TB segments above */
+	return PALIGN(addr, 0x10000000000UL);
+}
+#elif defined(__powerpc__) && !defined(PPC_NO_SEGMENTS)
+static void *next_chunk(void *addr)
+{
+	return PALIGN(addr, 0x10000000UL);
+}
+#elif defined(__ia64__)
+static void *next_chunk(void *addr)
+{
+	return PALIGN(addr, 0x8000000000000000UL);
+}
+#else
+static void *next_chunk(void *addr)
+{
+	return PALIGN(addr, SAFE_READ_MEMINFO("Hugepagesize:")*1024);
+}
+#endif
+
+static void run_test(void)
+{
+	void *brk0, *hugemap_addr, *newbrk;
+	char *p;
+	int err;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	brk0 = sbrk(0);
+	if (verbose)
+		tst_res(TINFO, "Initial break at %p", brk0);
+
+	hugemap_addr = next_chunk(brk0) + hpage_size;
+
+	p = SAFE_MMAP(hugemap_addr, hpage_size, PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_FIXED, fd, 0);
+	if (p != hugemap_addr) {
+		tst_res(TFAIL, "mmap() at unexpected address %p instead of %p\n", p,
+		     hugemap_addr);
+		goto fail;
+	}
+
+	err = test_addr_huge((void *)p);
+	if (err != 1) {
+		tst_res(TFAIL, "Mapped address is not hugepage");
+		goto fail;
+	}
+
+	newbrk = next_chunk(brk0) + getpagesize();
+	err = brk((void *)newbrk);
+	if (err == -1) {
+		/* Failing the brk() is an acceptable kernel response */
+		tst_res(TPASS, "Failing the brk is an acceptable response");
+	} else {
+		/* Suceeding the brk() is acceptable iff the new memory is
+		 * properly accesible and we don't have a kernel blow up when
+		 * we touch it.
+		 */
+		memset(brk0, 0, newbrk-brk0);
+		tst_res(TPASS, "Succeding brk is acceptable, as memset confirms that "
+				"new memory is properly accessible without kernel blow up");
+	}
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+	return;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing the test");
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 1)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+	umount2(Hopt, MNT_DETACH);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{"v", &verbose, "Turns on verbose mode"},
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_REQUEST},
+};
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 1204f21d2..d215c69dd 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -29,15 +29,19 @@
  *	getipckey()
  *	getuserid()
  *	rm_shm()
+ *	read_maps()
+ *	test_addr_huge()
  */
 
 #define TST_NO_DEFAULT_MAIN
+#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/ipc.h>
 #include <sys/shm.h>
 #include <sys/time.h>
 #include <pwd.h>
 #include "hugetlb.h"
+#include "tst_safe_stdio.h"
 
 key_t shmkey;
 
@@ -111,3 +115,74 @@ void rm_shm(int shm_id)
 		tst_res(TINFO, "id = %d", shm_id);
 	}
 }
+
+#define MAPS_BUF_SZ 4096
+#define HUGETLBFS_MAGIC 0x958458f6
+
+int read_maps(unsigned long addr, char *buf)
+{
+	FILE *f;
+	char line[MAPS_BUF_SZ];
+	char *tmp;
+
+	f = SAFE_FOPEN("/proc/self/maps", "r");
+
+	while (1) {
+		unsigned long start, end, off, ino;
+		int ret;
+
+		tmp = fgets(line, MAPS_BUF_SZ, f);
+		if (!tmp)
+			break;
+
+		buf[0] = '\0';
+		ret = sscanf(line, "%lx-%lx %*s %lx %*s %ld %255s",
+			     &start, &end, &off, &ino,
+			     buf);
+		if ((ret < 4) || (ret > 5)) {
+			tst_res(TWARN, "Couldn't parse /proc/self/maps line: %s\n",
+			      line);
+			SAFE_FCLOSE(f);
+			return -1;
+		}
+
+		if ((start <= addr) && (addr < end)) {
+			SAFE_FCLOSE(f);
+			return 1;
+		}
+	}
+
+	SAFE_FCLOSE(f);
+	return 0;
+}
+
+int test_addr_huge(void *p)
+{
+	char name[256];
+	char *dirend;
+	int ret;
+	struct statfs64 sb;
+
+	ret = read_maps((unsigned long)p, name);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
+		tst_res(TWARN, "Couldn't find address %p in /proc/self/maps\n", p);
+		return -1;
+	}
+
+	/* looks like a filename? */
+	if (name[0] != '/')
+		return 0;
+
+	/* Truncate the filename portion */
+	dirend = strrchr(name, '/');
+	if (dirend && dirend > name)
+		*dirend = '\0';
+
+	ret = statfs64(name, &sb);
+	if (ret)
+		return -1;
+
+	return (sb.f_type == HUGETLBFS_MAGIC);
+}
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index f75109f3e..c522314eb 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -20,6 +20,9 @@
 #include "old_tmpdir.h"
 #include "mem.h"
 
+#define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
+#define PALIGN(p, a) ((void *)ALIGN((unsigned long)(p), (a)))
+
 #define SHM_RD	0400
 #define SHM_WR	0200
 #define SHM_RW	(SHM_RD|SHM_WR)
@@ -39,5 +42,7 @@ extern key_t shmkey;			/* an IPC key generated by ftok() */
 int getipckey(void);
 int getuserid(char *user);
 void rm_shm(int shm_id);
+int test_addr_huge(void *p);
+int read_maps(unsigned long addr, char *buf);
 
 #endif /* hugetlb.h */
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
