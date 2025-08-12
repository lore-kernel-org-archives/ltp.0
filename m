Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7FEC87FCB
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 06:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754979312; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=7hvFjwo4rCQ/DvU75qml7BgfBG0fo+b1Ujiad1IRyUA=;
 b=Fc1QszUSDVzzbdKY4PrwUDUDwTcLtEox5WvH89+ZAR/BPW7NmM0qq34p+923cvdaAkgeY
 oL5oyJ+L8zoZyv++RiEM+f16P62SKh+AeyUBlygj3aJqlP7Gv5YMNPgk1EUBkwnMHHi3Cin
 DUIHRgHm/fwKloe6qvmIshiH+iTRp+E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15A903CB1B0
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 08:15:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EA0E3C856B
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 08:14:51 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A68E51400072
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 08:14:50 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-af93150f7c2so775712366b.3
 for <ltp@lists.linux.it>; Mon, 11 Aug 2025 23:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754979290; x=1755584090; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpLQNS9vpQKRoXIf+LoWOvrHwoMVFz0rViRpM5yisI4=;
 b=fHpo4D6wVh5QypGNQsmqrVXG7NSuPx518AKrowmgxvzwQ8wApKEcCpPmK9ep7elQSN
 hYGDX6PqmwYWAGBO5jUQ/tvgx5IzL6IqeUct6EK+Y+8OkdIs3CBQwaCp0pIAkZFvXaLc
 zxtEiyWOqqTmiAOkimHFVk1n8BlPEPfvA8hV9Ac9ftgN0okigl8SqaM4IgYzOMxexKDl
 pswR/c/nOXIokWGq/MJWxcymNtQF3GgNNZDjFuBKc4GjtesvoZavpsJqi7zFxX5FwffY
 Dwsa0RoolWXit4oJFrO+zKHbQuL7keFDLj9XrLScFf4aVqMctdXVOyT1UBsxk4qb9Fct
 5t8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979290; x=1755584090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpLQNS9vpQKRoXIf+LoWOvrHwoMVFz0rViRpM5yisI4=;
 b=Xsp6irim/AHIYdE/zxm3sheL62L9XWv8zoKpCqWfUDWJrrOKg8weKUI/fa/RPT4Wjn
 VZgDQP/O/Arj8BFA9YuatURmrXIf7cMYYWFE5uUU57u4WEexnQ1lkBMKklM4JKXwc6k8
 A+HSg/VXbIIKcTf3MSLzF+p9EVKAWYw3yBp9HymOI4xNWt/PrjhYf+N1YnvV2Ug0Pv+U
 VO4njtZ4/FyObSPe/8b9/LXnEhmStz+zG0dPy5dn29WCziZQSgIMloAp3My1kDBj5JYn
 2V5pmRu5BvjFUF7Xa0BhfwMm9WOQw/9JsToAjWsCisCLdX1wreHk3Cpt0qwl/rxCDjsN
 tDXg==
X-Gm-Message-State: AOJu0YzPTv4ei9RcH0gQOwAQMH9JRCPIIEOiwHUn5zSbunibVzQrpFXU
 rWMJ86gjFuXzFUA+qd/kZTvp45om2W4cwobX9PaYej6ief0vke3u2Ye320IuFDuK2HPmwawUzRX
 3UXk=
X-Gm-Gg: ASbGncsKeHkPP6oet3OO+2nodgeP9Jr2ElLcp30HxqXT7ucsK1WgfWT7sHlv7JOlHvb
 DVCDyZhOjmpKTSwXMabqh6ryrTA1T/onDLVt5vvCmAQq0Pl3Mef8nt9uQ6K0/F9Ag3DdHFxXj56
 ZCngtKDvhHqht9hrSd0BiLcKSnFilXuimUs4SZZBJmIwEde10ai4oPIJdr1OEZVXIhO1fEPIhZQ
 FiRElbwAHwCzySZG2MQVD1r9YtHW0XfkN52J7EKs5yxz0BAwnVMFTPPafsTFLUqUd9eiv1I9fqd
 Ty780RasuuV46WnaZq0OBn52laSqAOEUoK2H4POWsc6xeJbxGwvAKCm8Budu8kouMSl2yxOE/Hd
 lKvQSRRjqCbQ=
X-Google-Smtp-Source: AGHT+IEGnWVofhtch8bwm1uC1ld4XkF8vQM4JH72BkLYrHKJbjTNaqCqijnNt4PVrhxvVl+VB58ZiQ==
X-Received: by 2002:a17:907:9496:b0:af9:3116:e0f6 with SMTP id
 a640c23a62f3a-afa1e21545cmr181292666b.53.1754979289658; 
 Mon, 11 Aug 2025 23:14:49 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-af91a21c10asm2166893466b.116.2025.08.11.23.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 23:14:49 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 12 Aug 2025 06:14:19 +0000
Message-ID: <20250812061435.21209-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808163045.2033518-1-wegao@suse.com>
References: <20250808163045.2033518-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] ioctl11.c: New case check PROCMAP_QUERY ioctl()
 errnos
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
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore |   1 +
 testcases/kernel/syscalls/ioctl/ioctl11.c  | 214 +++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6a17a34f8..8bc7f60d2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -588,6 +588,7 @@ ioctl07      ioctl07
 ioctl08      ioctl08
 ioctl09      ioctl09
 ioctl10      ioctl10
+ioctl11      ioctl11
 
 ioctl_loop01 ioctl_loop01
 ioctl_loop02 ioctl_loop02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index dac4583fa..54685e916 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -8,6 +8,7 @@
 /ioctl08
 /ioctl09
 /ioctl10
+/ioctl11
 /ioctl_loop01
 /ioctl_loop02
 /ioctl_loop03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl11.c b/testcases/kernel/syscalls/ioctl/ioctl11.c
new file mode 100644
index 000000000..68e5cc275
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl11.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test PROCMAP_QUERY ioctl() errnos:
+ *
+ * - EINVAL if q->size is too small
+ * - E2BIG if q->size is larger than page size
+ * - EINVAL on invalid q->flags
+ * - EINVAL if only one of q->vma_name_size and q->vma_name_addr is set
+ * - EINVAL if only one of q->build_id_size and q->build_id_addr is set
+ * - ENAMETOOLONG if build_id_size or name_buf_size is too small
+ * - ESRCH if attempt to get memory map of a process that did exit and was waited for
+ *
+ *   [1] https://kernelnewbies.org/Linux_6.11#Memory_management
+ *   [2] https://kernelnewbies.org/Linux_6.11#Binary_interface_for_.2Fproc.2F.3Cpid.3E.2Fmaps
+ *   [3] https://lore.kernel.org/all/20240627170900.1672542-1-andrii@kernel.org/
+ *       ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")
+ */
+
+#include <errno.h>
+#include <linux/fs.h>
+#include "config.h"
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "lapi/ioctl.h"
+
+#define PROC_MAP_PATH "/proc/self/maps"
+
+static struct procmap_query *q;
+static int fd = -1;
+static char buf[PATH_MAX];
+static char small_buf[1];
+static unsigned long vm_start_addr;
+
+static void setup_normal(void);
+static void setup_big_size(void);
+static void fork_child_setup(void);
+
+static struct tcase {
+	uint64_t size;
+	uint64_t query_addr;
+	uint64_t query_flags;
+	uint64_t vma_name_addr;
+	uint32_t vma_name_size;
+	uint64_t build_id_addr;
+	uint32_t build_id_size;
+	int exp_errno;
+	void (*setup)(void);
+} tcases[] = {
+	{
+		.size = 1,
+		.exp_errno = EINVAL,
+	},
+	{
+		.exp_errno = E2BIG,
+		.setup = setup_big_size
+	},
+	{
+		.query_flags = -1,
+		.exp_errno = EINVAL,
+	},
+	{
+		.vma_name_size = sizeof(buf),
+		.exp_errno = EINVAL,
+	},
+	{
+		.vma_name_addr = (uint64_t)(unsigned long)buf,
+		.exp_errno = EINVAL,
+	},
+	{
+		.build_id_size = sizeof(buf),
+		.exp_errno = EINVAL,
+	},
+	{
+		.build_id_addr = (uint64_t)(unsigned long)buf,
+		.exp_errno = EINVAL,
+	},
+	{
+		.vma_name_addr = (uint64_t)(unsigned long)small_buf,
+		.vma_name_size = sizeof(small_buf),
+		.exp_errno = ENAMETOOLONG,
+	},
+	{
+		.build_id_addr = (uint64_t)(unsigned long)small_buf,
+		.build_id_size = sizeof(small_buf),
+		.exp_errno = ENAMETOOLONG,
+	},
+	{
+		.exp_errno = ESRCH,
+		.setup = fork_child_setup
+	},
+};
+
+static void fork_child_setup(void)
+{
+	int pid = SAFE_FORK();
+
+	if (pid == 0) {
+		TST_CHECKPOINT_WAKE(0);
+		TST_CHECKPOINT_WAIT(1);
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+
+	char proc_path[PATH_MAX];
+
+	snprintf(proc_path, PATH_MAX, "/proc/%d/maps", pid);
+	fd = SAFE_OPEN(proc_path, O_RDONLY);
+
+	TST_CHECKPOINT_WAKE(1);
+	SAFE_WAITPID(pid, NULL, 0);
+}
+
+static void get_vm_start(void)
+{
+	FILE *fp = SAFE_FOPEN(PROC_MAP_PATH, "r");
+	char line[1024];
+
+	if (fgets(line, sizeof(line), fp) != NULL) {
+		if (sscanf(line, "%lx-", &vm_start_addr) != 1)
+			tst_brk(TFAIL, "maps not found in %s", PROC_MAP_PATH);
+	} else {
+		tst_brk(TFAIL, "maps not found in %s", PROC_MAP_PATH);
+	}
+
+	SAFE_FCLOSE(fp);
+}
+
+static void setup_normal(void)
+{
+	fd = SAFE_OPEN(PROC_MAP_PATH, O_RDONLY);
+
+	q->size = sizeof(*q);
+	q->query_addr = (uint64_t)vm_start_addr;
+	q->query_flags = 0;
+}
+
+static void setup_big_size(void)
+{
+	q->size = getpagesize() + 1;
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	memset(q, 0, sizeof(*q));
+
+	setup_normal();
+	if (tc->setup)
+		tc->setup();
+
+	if (tc->size != 0)
+		q->size = tc->size;
+
+	if (tc->query_flags != 0)
+		q->query_flags = tc->query_flags;
+
+	if (tc->vma_name_addr != 0)
+		q->vma_name_addr = tc->vma_name_addr;
+
+	if (tc->vma_name_size != 0)
+		q->vma_name_size = tc->vma_name_size;
+
+	if (tc->build_id_addr != 0)
+		q->build_id_addr = tc->build_id_addr;
+
+	if (tc->build_id_size != 0)
+		q->build_id_size = tc->build_id_size;
+
+	TST_EXP_FAIL(ioctl(fd, PROCMAP_QUERY, q), tc->exp_errno);
+}
+
+static void setup(void)
+{
+	struct procmap_query q = {};
+
+	fd = SAFE_OPEN(PROC_MAP_PATH, O_RDONLY);
+
+	if (tst_kvercmp(6, 11, 0) < 0)
+		return;
+
+	TEST(ioctl(fd, PROCMAP_QUERY, q));
+	if ((TST_RET == -1) && (TST_ERR == ENOTTY))
+		tst_brk(TCONF,
+				"This system does not provide support for ioctl(PROCMAP_QUERY)");
+
+	get_vm_start();
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.cleanup = cleanup,
+	.needs_checkpoints = 1,
+	.forks_child = 1,
+	.bufs = (struct tst_buffers []) {
+		{&q, .size = sizeof(*q)},
+		{}
+	}
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
