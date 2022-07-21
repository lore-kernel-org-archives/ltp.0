Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F34C43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:55:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E44993C9AD4
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:55:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27A893C9A4C
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:21 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 64D5D1400DAB
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:20 +0200 (CEST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2724A3F12C
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436799;
 bh=93Svz9OuEHITZg4e6byXGZMczAB3kcFwcknlgI+7Qvk=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=A/jWCoxeyhONHs7nuJq0xKgru3tApghjPI7ZvyjKiwuz5/2wk2xJqelSbomOw9gEN
 Zllpdapx6HdACOu2fymHvCWLo9r63K9hbG1jRYGOvINvkWxY4YB5bUHhU3/CB9VBH3
 quBgCsi5g+oa+5iU6sNfcdXOlG8bktanzyZiggH9xVpPe+4VYMxaCBy1mwEwQLzyId
 OEiiPIpvxxPepXEE+6Tam5/+AxZwqO5TeMevxqQtR5767+E9QfsUmEj2F/1IA2so2F
 WV5FKOvJXn1/Mft5YC1fMhvFpOE1ukHu3Sxpey3witRGP7nRzB8hfGgVynYqWQCqcW
 66zKQKtsqCAJA==
Received: by mail-pj1-f69.google.com with SMTP id
 o21-20020a17090a9f9500b001f0574225faso3261524pjp.6
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=93Svz9OuEHITZg4e6byXGZMczAB3kcFwcknlgI+7Qvk=;
 b=OwoXeciMA/tclEvA56V8r7Yl/4O9B0eJuRUtMWs3llNxD50YJbq5Zo3/G2ehprdjZm
 /tpWJj9DoKOUMTPV8MT890VwbPO61w/j3C4mUGeFhVGKchLDSzf7jStb//Ap+DELARFy
 wnZTqWRWw5qSKx3ZuTFYNL4e3sNk/MWG99dbbSQufVbXbt4S7P91t01mSDbxJdmeb895
 HPbDybbWKFlbvI80gycA3xOV9qLJQ0F35soDOrgluoCto1lEqs4I8EKxC70c+qDb4EOi
 OqcM00ysEWVozPWL06kEupfwXWFZJH73f3UVkQLAQ0WOW02S3dQZwve3mrDnM8VqFS4E
 1yfA==
X-Gm-Message-State: AJIora/u4TMNXPvKF6HCQx38iHSdMXIev1VxndAeo2xZDan5O4ogyBev
 A4XW8qrl9aYxNMn+ltqw0YvW1x2xTZSzbUDXgwkUTOdhyzdCJP1Sp0TLsxOm5aRX2YbblGFqT1a
 jvnGu2XtkIrCwHPnyfozzOg6+4+Hz
X-Received: by 2002:a63:a748:0:b0:40c:9a36:ff9a with SMTP id
 w8-20020a63a748000000b0040c9a36ff9amr169055pgo.545.1658436798438; 
 Thu, 21 Jul 2022 13:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uRrwlUEtQxvNqNG+LmX7g2jPV4nEYtIe0xDWXh5atfAybkPtA4mb8u65MjxhYeUl3pO+K3yw==
X-Received: by 2002:a63:a748:0:b0:40c:9a36:ff9a with SMTP id
 w8-20020a63a748000000b0040c9a36ff9amr169041pgo.545.1658436798166; 
 Thu, 21 Jul 2022 13:53:18 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:17 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:19 -0700
Message-Id: <d9b6784f8e3fa3e4d9486bc54a2e230a313edd84.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 09/18] testcases/lib: Implement tst_cgctl binary
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
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
