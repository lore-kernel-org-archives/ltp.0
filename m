Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E5DC87FD3
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 04:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754627504; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=tZJg6kujpY7pSFzupjOctR+vDhuNmejpLWXEMDfpXrE=;
 b=gM2gqvFWmaU2CoxcIbJd2LOjcchguGVZmViqWkmKSJHeqS+W/TQf8dMEeNowfXTYy+X9u
 zBcdpRJkh4Pql13xHhua05GNeWMt1KRGO1c2TB9BchM22h+Bi3KJEopjqq2FKkZdA3jc0Oh
 wYo3ahs8r5anGaf43lrLc4JJoE9jQ6Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 652103CA137
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 06:31:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC61E3C23EC
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 06:31:05 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 218466008A2
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 06:31:04 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b8d0f1fb49so991831f8f.2
 for <ltp@lists.linux.it>; Thu, 07 Aug 2025 21:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754627463; x=1755232263; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t14H47WkuvMjlA7Q/vS0Q9khToxMmn3bdIS2K/qyy0Q=;
 b=O+wQ/eUK5Ei9frImNHjFaDw+2W8a6f7bQ5cE5bM53qmYMdFJ2eWTSEsjLidc917BrA
 aIKxkaXVVOCyUhWX24/kIspEudi4gsz1kQHBKDz/V57ITL+mgCxANMkOuEP5nsiJtetD
 HaAAKRriVJbTmtcO8Zhc+LYhSKERKFAKyVH7nS9yJB4ftORRolytJjgkjhpNnk5NSYro
 LwoMKKBoi3uGtWv5b5YQzG8BFeB6uQf41/JMroj7lSn7HnuLR3IeAuEZPqwLDK1I9irt
 3TkOfnmnHDFtEUFhFpcN2zBKA+NyFYv5Z4T0wGJfZgjmMmM9JuND2bDcizxGIbkyfZhL
 7HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754627463; x=1755232263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t14H47WkuvMjlA7Q/vS0Q9khToxMmn3bdIS2K/qyy0Q=;
 b=jvZ0//lBqBcBoR1UZCrouuVjwFPFqvwR17KjwU+XGqD5bmcToxohEckvLnP0OjDQ8a
 5gyZIDyILETBnKfaN6V8HqcUylppA1jnxCKb4jUomMOOX0p0h7KLUu8NwKDOmv8QX5it
 asUGNq/GRIt9xWjiVvSI2B4fef+P5b508Pd4+4FjvD66RNOgiviWtSi6B0kOMJNcFztj
 0oUaF001uZOWJakVntYIa30/8p9O7AWv8rlrMODfdRsJSkVBeqkxeWMsQeIKHLh4VO8r
 6gfWNqpXLaH0NzBRAZ7E8oPiw9J2G08hxUVEsJfaScFMfXLoqvkDgE/ep1EZxroqUu46
 8jNg==
X-Gm-Message-State: AOJu0YyhftPCPr7mrP9Rl5DWLCj114G/HhGLswXND3sErPV3rQmlC/x6
 JgD3E/nStx3xwaw3O218UymGD/3tzb+BG7KIvMHd7LEh3rRU5jf33s2k9y4tH0Pg96DFQUM1wey
 a3/matA==
X-Gm-Gg: ASbGnctbIwGwvEhU7jTJm4LK2UIBegxiBeFmI7gUGO/c7wnNqN+VVybwS/TIQX18Brp
 S/xjJb1YcKhNab1DneKJAmTvPH3uKhxjNu1vHVXS311iikvtb0BhJfh7zeuY21lD+b0m9U0u6hZ
 SYxEFXvChqzolA3U+64ZHa2AIHgmr+HhjXQnVR+TZd07iTFfrDUt85mC95tCYP09KT4DrMZnh25
 6LzKiV7XTMbuSlg67DMfZz6cuIOXgtRsA9NdR5ccDxQi2uGo6d6EF7f/Bmm4c3MRigqxvPScj+N
 c2kH9GWf3HSXxspJq2dR4h9YymKWeUmZlg3WhOao1qwAqH7+BHsdsMArstNVG7zwzAEj9dzbpyf
 h/2dT9UDzyEY=
X-Google-Smtp-Source: AGHT+IG9aWFyRsqS5ytkASTymX2zB1delbONIJo4JkyLuS1ckrDvD1mkub+eMs+/cbFYdQKimaFCLQ==
X-Received: by 2002:a05:6000:220c:b0:3a6:d93e:5282 with SMTP id
 ffacd0b85a97d-3b900b56117mr967241f8f.59.1754627463252; 
 Thu, 07 Aug 2025 21:31:03 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-241afb7037asm200205985ad.0.2025.08.07.21.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 21:31:02 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri,  8 Aug 2025 12:30:24 -0400
Message-ID: <20250808163045.2033518-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250807134900.517339-1-wegao@suse.com>
References: <20250807134900.517339-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ioctl11.c: New case check PROCMAP_QUERY ioctl()
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
index 000000000..86dc56bbe
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl11.c
@@ -0,0 +1,183 @@
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
+};
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
+	.bufs = (struct tst_buffers []) {
+		{&q, .size = sizeof(*q)},
+		{}
+	}
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
