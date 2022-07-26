Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9E6C00144
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 22:14:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 240D33C1C3B
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 00:14:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B52D3C1ADE
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:09 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AE6AC10005B4
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:08 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 37DAF3F14B
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658873648;
 bh=sH5K3oAQ/567wS6owWEwDYhTAKYaPG5lAbHsrg05TQ4=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=guYnTTpnW+OFmFz0EBuMYVoiBDnwNe/RDpkVGJDSFD8YyZw4kyLHVBrwxAdyNOHCC
 z81yJC6+OcVmVu8dabkm8T+XTTxrDS3ppq+4PqTfXEvDobVpDC6PW/yfpa5A366PBz
 5TKBDDfKzYXdSjnGTOanijDmWteV75s+XHWxtwBxAaptqTqlX/dtTzI+jNWZXhF9C7
 nd9J5iKxYbW5WpDBn4wFWY3Uo7FdV2V3rvMxcrzYO3Z/3voOM3HIMFpSo5KENrLEtT
 hLEMEhl1kej08NngfcjC0by+LpRGeR7yhEOEtp31t/GxmsrnIzDBT9oEw7wlUFZWRU
 alF6Z7OyCM3rQ==
Received: by mail-pl1-f197.google.com with SMTP id
 c15-20020a170902d48f00b0016c01db365cso9100605plg.20
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
 bh=sH5K3oAQ/567wS6owWEwDYhTAKYaPG5lAbHsrg05TQ4=;
 b=EiXyGJGGjLk92vJvEGrSYFXtezwVQJSPodhq5g6utTmBIvG9Xhj7BYVdvkduz5d6Vo
 +8+gNgV+IlpTFDoRS4Kw/8JRAu+v2OxAfIatDSXQ65tvT4aaCuAITJ5S2VSsCpuNHeI5
 Dq9OBmvmqzCA9GPFdXz/T1ZM/zk0mLNESZjCx2wn9yxwRTJPDQFHmP8O/XFMYCE2X7kL
 s55tYSBUWbb3nmDyBm9ZeaDE0kxjhimEp6rdWNMVY+2xRJRmObMgt42GKjwGn7awMEGJ
 YB0CQc4Ze3BFjQvXBXWnjib4Dbc8G0mOu3P4V465KA6seRChyeSwTPvlS7EIjOhBKJ22
 CRAA==
X-Gm-Message-State: AJIora9Y/RZM2qNTjTFR/qgRmhaer7CuBse3MyuybmT2y0re8+9sIq+j
 usDevn4OAuvK+53chlgMXn/wrIVYgW7w2oVAd6TfLHpWUWueI3rdbiXNhrWGuZjduXGtay7Ze6n
 QrSLT4N4nNbBff29nQmM+CWelND70
X-Received: by 2002:a63:5504:0:b0:416:2152:431a with SMTP id
 j4-20020a635504000000b004162152431amr16676416pgb.97.1658873646630; 
 Tue, 26 Jul 2022 15:14:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1unCVwx2L4RKnno2WJUZK+jd6h7rZe11nSnOW/xqbAt5hORv5rRyg6qGvwMADSGuf2ouphH5A==
X-Received: by 2002:a63:5504:0:b0:416:2152:431a with SMTP id
 j4-20020a635504000000b004162152431amr16676407pgb.97.1658873646408; 
 Tue, 26 Jul 2022 15:14:06 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 a13-20020a1709027e4d00b0015e9f45c1f4sm12069308pln.186.2022.07.26.15.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jul 2022 15:14:05 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Tue, 26 Jul 2022 15:13:17 -0700
Message-Id: <5e6668a49ad97716816dba94b024970e7b60b12c.1658872195.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 01/10] testcases/lib: Implement tst_cgctl binary
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
v2->v6: Added cgctl_usage() and replaced define string usage with
	function.

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
index 000000000..8ef615a56
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
+static void cgctl_usage(void)
+{
+	fprintf(stderr, "Usage: tst_cgctl require [controller] [test_pid]\n\tcleanup [config (output of tst_cg_print_config)]\n\tprint\n\t help\n");
+}
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
+		cgctl_usage();
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
+	cgctl_usage();
+	return 1;
+}
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
