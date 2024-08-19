Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479EDC3DA4A
	for <ltp@archiver.kernel.org>; Mon, 19 Aug 2024 04:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724042971; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=GNJ5Qw/IPpWvVLeeCXKOnAdEniGf0ytn73giMdyCI50=;
 b=kCypMS/04xuZDT8vnPbJ2Ue132kJtE5etFd1okffhCT7u1iDc+946+F1ckIoj9yO7aPk3
 4gBUr/ofkoq+BUM5kokCfiKLcaPLGixzPcJBgX+E8CBELIOEDyx7VKi3CqdR6sD7EDJbhuA
 CIOSv16Fkj1BMBYXYjJZ0ktDnfJ1oRg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C75D3D3200
	for <ltp@archiver.kernel.org>; Mon, 19 Aug 2024 06:49:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D114E3D31F3
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 06:49:10 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 88A3D600769
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 06:49:09 +0200 (CEST)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7a83a968ddso450491966b.0
 for <ltp@lists.linux.it>; Sun, 18 Aug 2024 21:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1724042948; x=1724647748; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wS2FOnVT9hxx8AbOqLRbomoUh7EcKPo8YpdnhJoqTZI=;
 b=eO5+aW5fpZkD/ylV3g1bJW5QsPhyplK6V4YR5oKuql9HhycSiTpEd29GrKyUkzZRD1
 BDTdKmv9Dm3BPZNMrzzL1qReC5p3SfYtl6EvK3DUDU7eAoakTL7EMCUQJ50vSGBdzo/C
 SEjqeoqPshkk1m1z6/2sp9m+wwG22nJHCZtPuXwQrIoA8OLATxXjdxcH6CUh02dk/9LQ
 1HRxs+663RJQH7P0Z3mj5yz+7ejK65qj6/HZqwrQLXc/L0niIQQ9pxNgc32LkfbUw+8H
 nlEiYuY2XkWj1sY98pe61dhtDuMkQRuwBNnQj8AcILd2rRgiJki3wYSRM2UkjkcHtnDD
 UI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724042948; x=1724647748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wS2FOnVT9hxx8AbOqLRbomoUh7EcKPo8YpdnhJoqTZI=;
 b=WMiP37gtm2kYkNqZJc9VIZcmBISIzjz2r6lk5sOITxhN9GFV2TbtKVuyOx6EPOyW8L
 nwqFvirIo8t4VYpHOdFmFxrYGIn6VxMX9ezSedzArDYJyEBYmqNgyjViN1kHItrqjYr5
 77WeIPqRtTi4b1WOkUyMpYsamEQ+DVKG4SgpPucE8y43Rl8B5kdf5K/YwZ9lYIJCms+O
 fdvfNrV8NMkHS3hCgJ8dlbMGsm/WGgJ3XUyauZJboALHJAvbOCAwaJo6Jp+B96/dCtLE
 f/WLQ7FY3XmFwDa2y5GFds4wRP3j1RRo6VT+aAUt1YuzKC5bmZsjF+UUo9feIjtxdf+X
 fUhg==
X-Gm-Message-State: AOJu0Yx6ud7l4JResqEmPbEsw+V19lsN6eG/qtR0BxbZd+To+ESQMAfu
 U64ULFWioq5BCogM6D4dX3kmW9iCZoN+sBg1RdSnJw+JVExACOylUj6EcFx6M7R/GJf80VxuKW1
 Agg==
X-Google-Smtp-Source: AGHT+IGErWdufQrlXSMjoKokANow3npUWY6J2/w4yhImBQFMxkdxLRWM2hPD1Qfwx8PNHPuTYFlxwQ==
X-Received: by 2002:a17:907:3d90:b0:a7d:a29e:5c41 with SMTP id
 a640c23a62f3a-a839293eb68mr643938566b.40.1724042948125; 
 Sun, 18 Aug 2024 21:49:08 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838393456fsm593616466b.142.2024.08.18.21.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 21:49:07 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 19 Aug 2024 00:49:01 -0400
Message-Id: <20240819044901.17380-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240801104004.15514-1-wegao@suse.com>
References: <20240801104004.15514-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cpuset02: Reimplementing the test6 of
 cpuset_memory_testset.sh as a separate C testcase
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/mm                                    |   1 +
 .../cpuset_memory_test/cpuset_memory_test.c   |  15 +-
 testcases/kernel/mem/.gitignore               |   1 +
 testcases/kernel/mem/cpuset/cpuset02.c        | 152 ++++++++++++++++++
 4 files changed, 163 insertions(+), 6 deletions(-)
 create mode 100644 testcases/kernel/mem/cpuset/cpuset02.c

diff --git a/runtest/mm b/runtest/mm
index 6a8cd0b9d..845874c41 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -75,6 +75,7 @@ ksm06_2 ksm06 -n 8000
 ksm07 ksm07
 
 cpuset01 cpuset01
+cpuset02 cpuset02
 
 oom01 oom01
 oom02 oom02
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
index 9912d8d6a..4e9e40ea2 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
@@ -56,10 +56,9 @@ static int opt_check; /* check node when munmap memory (only for mmap_anon()) */
 static int opt_thread;
 
 static int key_id;			/* used with opt_shm */
+static char hugepagefile[100] = "/hugetlb/hugepagefile";
 static unsigned long memsize;
 
-#define FILE_HUGEPAGE	"/hugetlb/hugepagefile"
-
 #define MMAP_ANON	(SCHAR_MAX + 1)
 #define MMAP_FILE	(SCHAR_MAX + 2)
 #define MMAP_LOCK1	(SCHAR_MAX + 3)
@@ -80,6 +79,7 @@ const struct option long_opts[] = {
 	{"thread", 0, NULL, THREAD},
 	{"size", 1, NULL, 's'},
 	{"key", 1, NULL, 'k'},
+	{"hugepage-file", 1, NULL, 'f'},
 	{NULL, 0, NULL, 0},
 };
 
@@ -92,7 +92,7 @@ void process_options(int argc, char *argv[])
 	char *end;
 
 	while (1) {
-		c = getopt_long(argc, argv, "s:k:", long_opts, NULL);
+		c = getopt_long(argc, argv, "s:k:f:", long_opts, NULL);
 		if (c == -1)
 			break;
 
@@ -105,6 +105,9 @@ void process_options(int argc, char *argv[])
 		case 'k':
 			key_id = atoi(optarg);
 			break;
+		case 'f':
+			strncpy(hugepagefile, optarg, sizeof(hugepagefile) - 1);
+			break;
 		case MMAP_ANON:
 			opt_mmap_anon = 1;
 			break;
@@ -179,7 +182,7 @@ void mmap_file(int flag_allocated)
 
 	if (!flag_allocated) {
 		if (opt_hugepage) {
-			fd_hugepage = open(FILE_HUGEPAGE,
+			fd_hugepage = open(hugepagefile,
 					   O_CREAT | O_RDWR, 0755);
 			if (fd_hugepage < 0)
 				err(1, "open hugepage file failed");
@@ -191,7 +194,7 @@ void mmap_file(int flag_allocated)
 			 MAP_SHARED, fd_tmp, 0);
 		if (p == MAP_FAILED) {
 			if (opt_hugepage)
-				unlink(FILE_HUGEPAGE);
+				unlink(hugepagefile);
 			err(1, "mmap(file) failed");
 		}
 		touch_memory_and_echo_node(p, memsize);
@@ -201,7 +204,7 @@ void mmap_file(int flag_allocated)
 
 		if (opt_hugepage) {
 			close(fd_hugepage);
-			unlink(FILE_HUGEPAGE);
+			unlink(hugepagefile);
 		}
 	}
 }
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index c96fe8bfc..f01953b5c 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -1,4 +1,5 @@
 /cpuset/cpuset01
+/cpuset/cpuset02
 /hugetlb/hugefallocate/hugefallocate01
 /hugetlb/hugefallocate/hugefallocate02
 /hugetlb/hugefork/hugefork01
diff --git a/testcases/kernel/mem/cpuset/cpuset02.c b/testcases/kernel/mem/cpuset/cpuset02.c
new file mode 100644
index 000000000..801c23d34
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset02.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED  Miao Xie <miaox@cn.fujitsu.com>
+ * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This is reimplementing the test6 of cpuset_memory_testset.sh
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
+#include "tst_test.h"
+
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+#if HAVE_NUMAIF_H
+#include <numaif.h>
+#endif
+
+#include "tst_safe_stdio.h"
+#include "mem.h"
+#include "numa_helper.h"
+
+#define MNTPOINT "hugetlbfs/"
+#define CPUSET "cpuset_mnt"
+
+#ifdef HAVE_NUMA_V2
+
+static long hpage_size;
+static int ncpus;
+static int *nodes;
+static int nnodes;
+
+static void count_cpus_mems(void)
+{
+	while (path_exist(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+		ncpus++;
+	if (get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &nnodes, &nodes) < 0)
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes_arr");
+	if (nnodes <= 1)
+		tst_brk(TCONF, "requires a NUMA system.");
+}
+
+static void run_test(void)
+{
+	char path[256];
+	char tmp_path[256];
+
+	snprintf(path, sizeof(path), "./%s/0", CPUSET);
+	if (access(path, F_OK) != 0)
+		SAFE_MKDIR(path, 0777);
+	snprintf(tmp_path, sizeof(tmp_path), "./%s/cpuset.cpus", path);
+	SAFE_FILE_PRINTF(tmp_path, "%s", "0");
+	snprintf(tmp_path, sizeof(tmp_path), "./%s/cpuset.mems", path);
+	SAFE_FILE_PRINTF(tmp_path, "%s", "0");
+	snprintf(tmp_path, sizeof(tmp_path), "./%s/cpuset.sched_load_balance", path);
+	SAFE_FILE_PRINTF(tmp_path, "%s", "0");
+	SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%d", 2 * nnodes);
+
+	int pid;
+	char str_hpage_size[20];
+
+	snprintf(str_hpage_size, sizeof(str_hpage_size), "%ld", hpage_size);
+	snprintf(tmp_path, sizeof(tmp_path), "%shugepagefile", MNTPOINT);
+
+	char *argv[10] = {
+		"cpuset_memory_test",
+		"--mmap-file",
+		"--hugepage",
+		"-s",
+		str_hpage_size,
+		"-f",
+		tmp_path,
+		NULL,
+	};
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		int fd = SAFE_OPEN("memory_result", O_WRONLY | O_CREAT | O_TRUNC, 0644);
+
+		SAFE_DUP2(fd, STDOUT_FILENO);
+		close(fd);
+		execvpe("cpuset_memory_test", argv, NULL);
+		tst_brk(TBROK | TERRNO, "execvpe(%s, ...) failed!", argv[0]);
+		exit(0);
+	}
+
+	sleep(1);
+	snprintf(tmp_path, sizeof(tmp_path), "./%s/tasks", path);
+	SAFE_FILE_PRINTF(tmp_path, "%d", pid);
+	kill(pid, SIGUSR1);
+	sleep(1);
+	kill(pid, SIGUSR1);
+	sleep(1);
+	kill(pid, SIGINT);
+	SAFE_WAITPID(pid, NULL, 0);
+
+	char node[20];
+	FILE *file;
+
+	file  = SAFE_FOPEN("memory_result", "r");
+
+	if (fgets(node, sizeof(node), file) == NULL)
+		tst_res(TFAIL, "read memory_result failed");
+
+	fclose(file);
+
+	TST_EXP_PASS(strncmp(node, "0", 1));
+}
+
+static void setup(void)
+{
+	count_cpus_mems();
+
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+	SAFE_MKDIR(CPUSET, 0777);
+	SAFE_MOUNT("cpuset", CPUSET, "cgroup", 0, "cpuset");
+}
+
+static void cleanup(void)
+{
+	SAFE_UMOUNT(CPUSET);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.setup = setup,
+	.forks_child = 1,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {3, TST_NEEDS},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/vm/nr_hugepages", NULL, TST_SR_TBROK},
+		{}
+	},
+};
+
+#else
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+#endif
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
