Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25827C87FCB
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 01:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754531384; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=25ZCLhzBLE4PLk58JZGFurvNJJVNAncYfxXp55uIcIE=;
 b=piTMJWfE2cCsTiwCr1H6+pq2BIh9Kc/36Hwu95ahF6DFCqim9uZYWtwl87pGu3ZSUxcxd
 Clvv6sA73/da5DMqVHWkwFFCgi/l5Hel47Z5kmDGi6KuO59sh8cGvBBAm1D5vxg8tP5IaRG
 aGznDEjlo2dUkJEMQEvNv50fULBGN2A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49E313C6DE0
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 03:49:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E441E3C6DE0
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 03:49:23 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFA70140004E
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 03:49:22 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b788feab29so213036f8f.2
 for <ltp@lists.linux.it>; Wed, 06 Aug 2025 18:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754531362; x=1755136162; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1rGiK67nWATkVU1OlJXHJqE3TEUGXPUoT4eNSP2nfac=;
 b=UVd5Uou6pIq3PmFRCmafqe+FQtVolDRq+SqTbbeitYAHWb3qOuqucNEBPKCyXvO0V1
 PSIg7L2ersSXTrFTWs+Mzpa6f+0fa/i+kur3T4xs5ceqQWcjvEFAdMFAMw63kY3Rzccu
 Je6PfXxSZCogKjbHLa6ILqfZAh06UEFMtCqrD3apKPIDkdZ95HU7qcFcIxteypN/w7C8
 6h0sTW6ZBDuajeWhwEuV+hJUYeZFDFRQ3NbS/gabaxJZ7Ft38zbEb/BC0bvGLHttvA0v
 VSW9LtHwen1Gl7AExjeEdINB5+2R8jp5JJ7kJdvAs+3f/54iQceNNZffbiOfkL9XmuzJ
 IIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754531362; x=1755136162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1rGiK67nWATkVU1OlJXHJqE3TEUGXPUoT4eNSP2nfac=;
 b=UymrIMKr0JBiOQDbNjrjq9tZJ5cmsgfjcRde7tuIsMIsMwHZTON1XtWwhj/7gMfiFa
 GujhYx/qOEMI7AMHyAJt4j4PhgtR+U3PMWHcGGz0PX1yis3bQQ4eJr4KAZPNkMVg2JQl
 zBYBwZkubkEua1vLlealiDbXXH2Z6kscsK7D0p/eM3yvn02miUTkGMnoINFSq61j6v2d
 NSWaL9qbAXaqBaGxWbmE3rZqW84Nfmcm2YqoJKpiAIoLeZjs6V1y1iWIj4LLCoO08PTJ
 LkEPG4BSgGX0VCTTTsRhb1tEZYAxPHH6gAszmp8HmH1N5C4Xb9wnm043D6pXc/YfcTVQ
 g/5Q==
X-Gm-Message-State: AOJu0YwPyb15qCq9waMWCjd9KYwNeW8G1iZtuFbei5e9PydUv0YojhAu
 h2r3gjuqnAVQFF74Rk184j1fQRHAl/2vTyptGNTqt6y8KfhVfHl73HPDFPXn3qirzGyw37pgx8i
 sm4dHPg==
X-Gm-Gg: ASbGncveAu3opVonpsT/YQxdRX+F1EwOO6vnzx2bLERKlj5O8rdEZXb2Fmf7C/EyTdw
 Az9h+l7yp0EtRdmrGBEfeIwcO2Fdg7XiPngL3u4vXTut6Fy8pW2LRFu2aomVZhIva/hUuBchmyA
 0GajU33IW76G0+K4hJDu+5k6YuuFLEKVpJA2g1iwRz1pbbcINt01csEivwUdZEod8vxGMpzo+C2
 tQxiYasKLZR2ooYctdQNDONu27fkIxdqr5hleZAEFGyzkCTz1Y/4mCzbT7KmWQlocvhZ1TqeT8J
 SfGbiWqzigZmTCWbWIhmz/L9IT4BvWHwUaKw2ft9bP5uNfCEghKx5G0B9KLu9waMY7IzgMyim8X
 lXqKmw/KOOXI=
X-Google-Smtp-Source: AGHT+IF8LzPaeKtYNqp+nlMulMSLrs4WALWJDxbiyWstgAuCV52dty9TdNJ7NWS/w1OKz2VtnZJ7DQ==
X-Received: by 2002:a5d:5849:0:b0:3b7:82a3:fe0d with SMTP id
 ffacd0b85a97d-3b8f41c7de3mr4071083f8f.32.1754531361918; 
 Wed, 06 Aug 2025 18:49:21 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b428f4c8639sm567183a12.43.2025.08.06.18.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 18:49:21 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  7 Aug 2025 09:48:58 -0400
Message-ID: <20250807134900.517339-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] iocl11.c: New case check PROCMAP_QUERY ioctl()
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
 testcases/kernel/syscalls/ioctl/ioctl11.c  | 183 +++++++++++++++++++++
 3 files changed, 185 insertions(+)
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
index 000000000..aef2105cc
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl11.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Wei Gao <wegao@suse.com>
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
+ */
+
+#include "config.h"
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <errno.h>
+#include <fnmatch.h>
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include <sys/sysmacros.h>
+#include <linux/fs.h>
+#include "lapi/ioctl.h"
+
+#define PROC_MAP_PATH "/proc/self/maps"
+
+struct procmap_query *q;
+static int fd = -1;
+static char buf[PATH_MAX];
+static char small_buf[1];
+
+static void setup_normal(void);
+static void setup_big_size(void);
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
+		.setup = setup_normal
+	},
+	{
+		.exp_errno = E2BIG,
+		.setup = setup_big_size
+	},
+	{
+		.query_flags = -1,
+		.exp_errno = EINVAL,
+		.setup = setup_normal
+	},
+	{
+		.vma_name_size = sizeof(buf),
+		.exp_errno = EINVAL,
+		.setup = setup_normal
+	},
+	{
+		.vma_name_addr = (uint64_t)(unsigned long)buf,
+		.exp_errno = EINVAL,
+		.setup = setup_normal
+	},
+	{
+		.build_id_size = sizeof(buf),
+		.exp_errno = EINVAL,
+		.setup = setup_normal
+	},
+	{
+		.build_id_addr = (uint64_t)(unsigned long)buf,
+		.exp_errno = EINVAL,
+		.setup = setup_normal
+	},
+	{
+		.vma_name_addr = (uint64_t)(unsigned long)small_buf,
+		.vma_name_size = sizeof(small_buf),
+		.exp_errno = ENAMETOOLONG,
+		.setup = setup_normal
+	},
+	{
+		.build_id_addr = (uint64_t)(unsigned long)small_buf,
+		.build_id_size = sizeof(small_buf),
+		.exp_errno = ENAMETOOLONG,
+		.setup = setup_normal
+	},
+};
+
+static unsigned long get_vm_start(void)
+{
+	FILE *fp = SAFE_FOPEN(PROC_MAP_PATH, "r");
+	char line[1024];
+	unsigned long start_addr = 0;
+
+	if (fgets(line, sizeof(line), fp) != NULL) {
+		if (sscanf(line, "%lx-", &start_addr) != 1)
+			tst_brk(TFAIL, "parse maps file /proc/self/maps failed");
+		return start_addr;
+	}
+
+	SAFE_FCLOSE(fp);
+	tst_brk(TFAIL, "parse maps file /proc/self/maps failed");
+}
+
+static void setup_normal(void)
+{
+	q->size = sizeof(*q);
+	q->query_addr = (uint64_t)get_vm_start();
+	q->query_flags = 0;
+}
+
+static void setup_big_size(void)
+{
+	setup_normal();
+	q->size = getpagesize() + 1;
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	memset(q, 0, sizeof(*q));
+
+	tc->setup();
+
+	if (tc->size != 0)
+		q->size = tc->size;
+	if (tc->query_flags != 0)
+		q->query_flags = tc->query_flags;
+	if (tc->vma_name_addr != 0)
+		q->vma_name_addr = tc->vma_name_addr;
+	if (tc->vma_name_size != 0)
+		q->vma_name_size = tc->vma_name_size;
+	if (tc->build_id_addr != 0)
+		q->build_id_addr = tc->build_id_addr;
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
+	if (tst_kvercmp(6, 11, 0) < 0) {
+		TEST(ioctl(fd, PROCMAP_QUERY, q));
+
+		if ((TST_RET == -1) && (TST_ERR == ENOTTY))
+			tst_brk(TCONF,
+				"This system does not provide support for ioctl(PROCMAP_QUERY)");
+	}
+
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
+	.bufs = (struct tst_buffers []) {
+		{&q, .size = sizeof(*q)},
+		{}
+	}
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
