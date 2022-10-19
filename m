Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CF1C433FE
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 15:48:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BBB93CB11A
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 17:48:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A15483CB141
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 17:48:14 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C55B210001BB
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 17:48:13 +0200 (CEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JFh7rI004620
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 15:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7LIIx55vR41bbyRFD8/3hpK7Xc9e6DXXhl6X7/0kD70=;
 b=WGFKhHM6Hrnl0X4ZGH8vpfAxBCs3fQQEMqRQHyjn6N4kbNUjRmFyo/7/tBlsVL7QxdtP
 Op3wDPvEC1PxaftLprFMZOuyWQS6HxehCMizz2lTqln8EfjpZJnXiFd8EQ148SVtOIXY
 Yi24spYfgrRXtUNtNhIf/DxT+eZ+Va6V1HEYpjL6YeHifsRYMHqdYh+1QduTAbu8oZvX
 23u7wqq+pvif5EIY5fkrGvdFitsyucqnBjs1TwlWrkzXlVHf7C7vV6UwZJKaGCp2d112
 XOrcj/u95W/k+KRib9dGoepl7DFd+QfSonathK6rfbOrB7mEUTvLO7y6CHisGBHLO+FO lw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kam4bg6wn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 15:48:11 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JFZMSA024981
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 15:48:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04fra.de.ibm.com with ESMTP id 3k7mg95j99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 15:48:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29JFh5jm41681218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Oct 2022 15:43:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79E6311C052;
 Wed, 19 Oct 2022 15:48:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B1AD11C050;
 Wed, 19 Oct 2022 15:48:02 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.20.142])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 19 Oct 2022 15:48:01 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 19 Oct 2022 21:17:52 +0530
Message-Id: <20221019154754.75624-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221019154754.75624-1-tsahu@linux.ibm.com>
References: <20221019154754.75624-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ALubwhLOXnT0-WThV4jwkju2ZhU-of3h
X-Proofpoint-ORIG-GUID: ALubwhLOXnT0-WThV4jwkju2ZhU-of3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_09,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190087
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] Hugetlb: Migrating libhugetlbfs brk_near_huge
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
Certain kernels have a bug where brk() does not perform the same
checks that a MAP_FIXED mmap() will, allowing brk() to create a
normal page VMA in a hugepage only address region. This can lead
to oopses or other badness.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 156 ++++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.c    |  75 +++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   5 +
 5 files changed, 238 insertions(+)
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
index 000000000..bd33d9816
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ *
+ * [Description]
+ *
+ * brk() near hugepage:
+ * Certain kernels have a bug where brk() does not perform the same
+ * checks that a MAP_FIXED mmap() will, allowing brk() to create a
+ * normal page VMA in a hugepage only address region. This can lead
+ * to oopses or other badness.
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
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+static long hpage_size;
+
+static int arch_has_slice_support(void)
+{
+#ifdef __powerpc64__
+	char mmu_type[16];
+	FILE *fp;
+	int ret;
+
+	fp = SAFE_POPEN("cat /proc/cpuinfo | grep MMU | awk '{ print $3}'", "r");
+	ret = fscanf(fp, "%s", mmu_type);
+	pclose(fp);
+
+	if (ret < 0)
+		tst_brk(TBROK, "Failed to determine MMU type");
+
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
+	brk0 = sbrk(0);
+	tst_res(TINFO, "Initial break at %p", brk0);
+
+	hugemap_addr = next_chunk(brk0) + hpage_size;
+
+	p = SAFE_MMAP(hugemap_addr, hpage_size, PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_FIXED, fd, 0);
+	if (p != hugemap_addr) {
+		tst_res(TFAIL, "mmap() at unexpected address %p instead of %p\n", p,
+		     hugemap_addr);
+		goto cleanup;
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
+		tst_res(TINFO, "New break at %p", newbrk);
+		memset(brk0, 0, newbrk-brk0);
+		tst_res(TPASS, "memory is accessible, hence successful brk() is "
+				"an acceptable response");
+	}
+cleanup:
+	SAFE_MUNMAP(p, hpage_size);
+	err = brk(brk0);
+	if (err == -1)
+		tst_brk(TBROK, "Failed to set break at the original position");
+}
+
+static void setup(void)
+{
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+	SAFE_UMOUNT(Hopt);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
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
