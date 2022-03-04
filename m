Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8A6C433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:19:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C31C23CA3ED
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:19:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C3E23CA3EE
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:41 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3FBF6140004B
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:41 +0100 (CET)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B876D3F5FB
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435920;
 bh=72ZPFxrJcZtMHXbPzCdArrxPavpNaaMuzIXQRp0fos8=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=rBJ+LAn5jsEHZa1IupydY1jd0g+BMWSMpBdY0nOhoeFYGpyODe5FX/1cn8nPLGYtz
 I04y43dpySyrzRm0htVqR/sSuzvzLnKgJOrDqeEpzzDpV+e3i2uik+XgjQEO6x/AK2
 klCDROI3gq6bwUnrybYNjdij4AccJsXa/iG+utp+DmjBfIPtInDHN9qzF2+RAg1pbe
 jlHeHkJ3Y6kf6lCyG5f0lwV9S/AX5teNLR9VDME4C+CNFDfXym67LifZsWCAbUE549
 cCOYFlhXFXG04CIM16vyFF+9LJ0MaWqTD/AnrQbIyheSzNDURWVf/M9P28iR9LS/dB
 WIjaZPm4PZVrQ==
Received: by mail-pg1-f200.google.com with SMTP id
 1-20020a630c41000000b00378d9d6bd91so5243746pgm.17
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=72ZPFxrJcZtMHXbPzCdArrxPavpNaaMuzIXQRp0fos8=;
 b=52+4vNGBtizpwRmdC+UZAzSGcFEUz3Lkl5sBun7NULXufwpCY1xgPEb+659qt7U82D
 G+QE5VrtPTn9PdNYgtb8Hkjn2vsLqKiQqkrvfiWaU9WCbTux6TSnwsT2RTrcv81awcfj
 +g90/zFxDxsmiE1GowSQrYlmTkh8KN1qBQDRtXPo112x/9M50C/ybpzqEJ6IIfG+pOQm
 BcGfDXzq/Os360c/jCCxiRvIwEFKbjaBtsrS9pAium0nLWNRKTqiuYDOlpKhCbk+xdsZ
 tXV3tl3MRkSYwaELcDAyIw83RQ+22rLBi21VGrzRYPrJhL9Oh1KxdiZ/EoKjGQAdy7kL
 Q9sQ==
X-Gm-Message-State: AOAM530XOAmXE/PmI2UQwfm5TNMnLzt9wfmP7wmjPu8W2xfHd2QEoCZX
 h7UEpGVLorwMyiu7HQ14medEiWvvJ+xkmmwzBOBjTjP8RESa/tIO9KO1p+Dvzq+e609ErUB4PHa
 BQmCXbTHYKRX+mNhJ9VqfvqzFgW0q
X-Received: by 2002:a05:6a00:22cc:b0:4e0:58dc:e489 with SMTP id
 f12-20020a056a0022cc00b004e058dce489mr1080065pfj.58.1646435919122; 
 Fri, 04 Mar 2022 15:18:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhMkd6yUui5JqiASf70Wns9bTyCCnRH67GQomwxaOhkTanM7B0utfxUQaL+53SoAMvX2Y0tA==
X-Received: by 2002:a05:6a00:22cc:b0:4e0:58dc:e489 with SMTP id
 f12-20020a056a0022cc00b004e058dce489mr1080048pfj.58.1646435918825; 
 Fri, 04 Mar 2022 15:18:38 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:38 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:17 -0800
Message-Id: <f0b0fe68ef5fa57e337917d07374af9047d522e5.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 07/16] testcases/lib: Implement tst_cgctl binary
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
