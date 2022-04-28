Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768A7C433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:42:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85D0E3CA752
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:42:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACD1B3CA749
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:45 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CF9D81400BD8
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:44 +0200 (CEST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2652A3F1A2
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178443;
 bh=72ZPFxrJcZtMHXbPzCdArrxPavpNaaMuzIXQRp0fos8=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=Ad//wUvUgMy6gMIdBBB1hlIFeaBWp0iWx652doMTHx4CY0MiFZ9kml1uXQRZK1dnj
 uaBiCvRLxQ5Ar/LyCp9MJjn/x6iiqsXHzgwHI0zt5imUvO/ZQv8AgJzUE7QjhL9RHa
 99q3d9kdIvVOXPSVzfyatEGw47nWvukllm9iWU/c+QU06dX6dI1Dj6ukUUCAuAMpNN
 3f3y4+mCsxbCTHmQqQuzDuVyaH9wgY0vWtQRxnGVtvbyynZAHjRy/EHfEuhKe8BDpo
 Nya93jprTjbdkLYI1T+LyigaYIQbkbX9qEFANt8qowm2B/chZxMoWynlz0ZLYqIv8J
 mPd2lAC5NAORQ==
Received: by mail-pj1-f71.google.com with SMTP id
 q91-20020a17090a756400b001d951f4846cso5753591pjk.8
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=72ZPFxrJcZtMHXbPzCdArrxPavpNaaMuzIXQRp0fos8=;
 b=PHF2LI8KaxOX71Pc749dmW6NLRqEHO43fWlAhrKXowX+ob6n2hYgKbWAiYKSBcSKlS
 CIPFOsV2bGixI2IG9FSU9nymI1z1qMpQqjz8C9M+GCewwJjyCUZVbfdLCiCrW5/zdZQ4
 R+u/MdcGMehVt7CsMsFxcyTRDuUvtRzGk9FO0dRRkaGQdMX22uxcGUV5roj2vePlzITt
 wxNOG0dLchjs9Zd5bsAEQ5Tdp4tc4LkpkKm1MoLvh0picttGxUabssC4UVZpEyuulN/e
 K6zqBZ8HENlXaKRmNzI8sagjkZZtADl4K7pVMF4UZ0CYTDktSmzHq+lIo0SYAFJr6S/I
 jNrQ==
X-Gm-Message-State: AOAM533lHQNBXOsevcxRNhQEep7S4u98Sszvwe+6Yq5eEdtON7jRoo9K
 hYNgilouv87S7NBAHxmAepW6OqZTcIfQ6WVoJEUboivuKaPweztQRdkbPFVtfY0lbxD/5nz4NiL
 DQRs9DpDtSVupS2rXOtSiTbXh9eX4
X-Received: by 2002:a17:90b:388c:b0:1d9:49e7:98d0 with SMTP id
 mu12-20020a17090b388c00b001d949e798d0mr56581pjb.224.1651178441453; 
 Thu, 28 Apr 2022 13:40:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyeiaeo9ZlUunuCjKH7wbAJpPcbJEpT5xdHS5570MhGixG6P1/XHU7CyYV+kMUjLmE7g2npQ==
X-Received: by 2002:a17:90b:388c:b0:1d9:49e7:98d0 with SMTP id
 mu12-20020a17090b388c00b001d949e798d0mr56551pjb.224.1651178441212; 
 Thu, 28 Apr 2022 13:40:41 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:40 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:34 -0700
Message-Id: <0284f1828a9d98b1b767769fb0582e62bd489e8c.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 09/19] testcases/lib: Implement tst_cgctl binary
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Implement a binary utility that creates an interface to make calls to
the cgroup C API.

This will effectively allow shell scripts to make calls to the cgroup C
api.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: Add license identifier and copyright.
Reformat with tabs instead of spaces.
Add help format message and help function.
Add error gotos to streamline error messaging.

 testcases/lib/Makefile    |  2 +-
 testcases/lib/tst_cgctl.c | 87 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 testcases/lib/tst_cgctl.c

diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index f2de0c832..f4f8c8524 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -12,6 +12,6 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
 			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
 			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
-			   tst_check_kconfigs
+			   tst_check_kconfigs tst_cgctl
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_cgctl.c b/testcases/lib/tst_cgctl.c
new file mode 100644
index 000000000..4f4fe8542
--- /dev/null
+++ b/testcases/lib/tst_cgctl.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Canonical Ltd.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <unistd.h>
+#include "tst_cgroup.h"
+
+#define USAGE "Usage: tst_cgctl require [controller] [test_pid]\n\
+	\t cleanup [config (output of tst_cg_print_config)]\n\
+	\t print\n\
+	\t help\n"
+
+static int cgctl_require(const char *ctrl, int test_pid)
+{
+	struct tst_cg_opts opts;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.test_pid = test_pid;
+
+	tst_cg_require(ctrl, &opts);
+	tst_cg_print_config();
+
+	return 0;
+}
+
+static int cgctl_cleanup(const char *const config)
+{
+	tst_cg_scan();
+	tst_cg_load_config(config);
+	tst_cg_cleanup();
+
+	return 0;
+}
+
+static int cgctl_print(void)
+{
+	tst_cg_scan();
+	tst_cg_print_config();
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int test_pid;
+	const char *cmd_name = argv[1];
+
+	if (argc < 2)
+		goto error;
+
+	if (!strcmp(cmd_name, "require")) {
+		if (argc != 4)
+			goto arg_num_error;
+		test_pid = atoi(argv[3]);
+		if (!test_pid) {
+			fprintf(stderr, "tst_cgctl: Invalid test_pid '%s' given\n",
+				argv[3]);
+			goto error;
+		}
+		return cgctl_require(argv[2], test_pid);
+	} else if (!strcmp(cmd_name, "cleanup")) {
+		if (argc != 3)
+			goto arg_num_error;
+		return cgctl_cleanup(argv[2]);
+	} else if (!strcmp(cmd_name, "print")) {
+		return cgctl_print();
+	} else if (!strcmp(cmd_name, "help")) {
+		printf(USAGE);
+		return 0;
+	}
+
+	fprintf(stderr, "tst_cgctl: Unknown command '%s' given\n", cmd_name);
+	goto error;
+
+arg_num_error:
+	fprintf(stderr,
+		"tst_cgctl: Invalid number of arguments given for command '%s'\n",
+		cmd_name);
+error:
+	fprintf(stderr, USAGE);
+	return 1;
+}
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
