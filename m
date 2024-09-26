Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10526CCF9E9
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 06:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727331604; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=cAlwosRnLBdP9GS5UHDZUn0Z2ZcPsy5b151nvLOSnQc=;
 b=dxSp6BdZ7hObO5cydXcHsboSt4FR5X/UHoqqtogB2gHR9h2u71dy31Qiy7H2JrYGvS6G2
 rmj+l5Hdxbpy36X6JxKf8KjBP+O2Fud3dvBm1vEtuH/krQ5SZLqTzb+6AaUJqExWq8XOHMI
 evDvSpuTBKPQFowp5T1O1eP7eXfZBpQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CC7A3C4E2D
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 08:20:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 296303C4DF5
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 08:19:43 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4D96F14104FC
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 08:19:43 +0200 (CEST)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso846335e87.2
 for <ltp@lists.linux.it>; Wed, 25 Sep 2024 23:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727331582; x=1727936382; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Brm7onrHfXV4dh/SfEZgIN9u3a1abUintvznuAeKhbA=;
 b=IS44LeabHRtKs9F7uainSljjMb73VVxjJtBhVvLY2IWZl7ow/QCnE5bKovePl0Zsop
 J4heRaBAjEyOuD553evf2YnjUYOSqJ8f8E02jDin9htmheHkScET/1u7RfuV/iMLpvf7
 rGexCN0ptr8EXDPoiPie1+3VpLz8u1VfZbTN8HClGz9QKGE5DzE7w5B+SNiV3ZUZxWDp
 7tEIGpnBtZ+ld5iCYvI+0kM6Fti5TLH2C2DhScIwXN1m71T3uXeL3BnW89eTp/Qi9yBh
 PAYinPA5DzTVee2FcBv7GexijNXe6elX5nlodsyLioqPFzV2l3czW5rslOO5tf/vTHpV
 YDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727331582; x=1727936382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Brm7onrHfXV4dh/SfEZgIN9u3a1abUintvznuAeKhbA=;
 b=BCjWe5gysAK2XwDIkHZ8fy5eTezC7QpPxBZqgYZbuBydIXghfNRVxgj3WQK0lOjnC8
 vf4jpAx+gbMDYqsTD6Z7YUF4EEnnQV8LG4iNUoYbpNmGlAF07RlPCc4n3VmWS7U4TIzz
 C1pgdXj6xvfZyYYcoaXDAsKtd0BNUwCL0hycP2w1zHvx88LdyxQAKuAAZMfVjL2OrQqF
 d8o7mqlrKa5/SAWq5BrXCiI5m+jges08Zr6i0G+sbe+FqBH47YLW8xBs35qGOZlTdmMJ
 yjrwkPoTkNmbGTW69yXLTYHiqN8+m34rZksgcQHx+Ne1aCOFAOZmS0ELh6reK4aAPwlr
 d6ew==
X-Gm-Message-State: AOJu0YyJj6zfZE4TohriBkvvJzRRjKCIushpniK5HTdjau1sT78rdWh4
 fDMCXfKsP5h8Z4tHIv+c4Oxha2JgYh2zrn9RkUjCpJru8+dWBsgCRH5pKEiykp+1Oj3OS3JVLs0
 =
X-Google-Smtp-Source: AGHT+IFufHBb0O/hA4LGJQu6SBS2wXFDLt4cnXgNvKDLQm88LDRnWq0gPdhBKLJbPA13kfLDohf91g==
X-Received: by 2002:a05:6512:31c3:b0:535:6925:7a82 with SMTP id
 2adb3069b0e04-5387755cf04mr4595657e87.41.1727331582152; 
 Wed, 25 Sep 2024 23:19:42 -0700 (PDT)
Received: from localhost ([223.72.87.57]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f4fa95sm307044266b.54.2024.09.25.23.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 23:19:41 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 26 Sep 2024 02:19:36 -0400
Message-Id: <20240926061936.21499-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240819044901.17380-1-wegao@suse.com>
References: <20240819044901.17380-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] cpuset02: Reimplementing the test6 of
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
 testcases/kernel/mem/cpuset/cpuset02.c        | 147 ++++++++++++++++++
 4 files changed, 158 insertions(+), 6 deletions(-)
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
index d88484fa1..0845297cb 100644
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
index 000000000..05ed5c791
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset02.c
@@ -0,0 +1,147 @@
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
+		"--mmap-file",
+		"--hugepage",
+		"-s",
+		str_hpage_size,
+		"-f",
+		tmp_path,
+		NULL,
+	};
+
+	int fd = SAFE_OPEN("memory_result", O_WRONLY | O_CREAT | O_TRUNC, 0644);
+
+	SAFE_DUP2(fd, STDOUT_FILENO);
+	pid = tst_run_script("cpuset_memory_test", argv);
+	close(fd);
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
+	.runs_script = 1,
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
