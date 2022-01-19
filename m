Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D34C433EF
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:45:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2FD73C96A8
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:45:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5392F3C96B9
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:32 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C45B9600944
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:31 +0100 (CET)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 48347407FC
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603471;
 bh=1AT44c14OCUtqPnKhq+49Xdqvl0KLglsyDavTB0JApE=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=K10uKCQyu0lomMGRLiteUww/jQEPqpeMfE3oKjGT/cUQ03SyIiUPUQujwAxZjwE3m
 PwXu71BH9vNLO41y/D705wXKqAYNwmoaaET7/QRw79i4JcY8GXTScIYInJlMMQJO6W
 f7Un4pDulMWlVrlKVr7uVN6+xe2ADv3LYTva4AVvARWNsw9BFSoqk7P3FvipZE2Q7r
 ybnxKGl89iPIWOAT5X1xDbX9qcpsd9YMgVwhjhZmRMpu+psJlSmKXzg1dWyrQQlq4V
 ctWsgBGfXOqrCG/F3GbV2zcWZ5m8Gu1eNe5i1Zf7xMCTmv0p5CYzpPwPmO+R3kHcqy
 gSeZ6HetpjRLw==
Received: by mail-lf1-f72.google.com with SMTP id
 d12-20020a196b0c000000b0042afa90ae9bso1742343lfa.12
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1AT44c14OCUtqPnKhq+49Xdqvl0KLglsyDavTB0JApE=;
 b=Cg3mAL02Zb4Fi6VjquYzqUM6z9kXWSb3/B0yxAmnb5Iw64cK32nbL3yxGGC5rRqouP
 wZ6BV4Y/zKs37x3xdsigKQbJ+2ppzzBGcF5BwdrK4fCx5MaDg/KHp1bX24tBHl0FbJFM
 KKVU3kyEYGHrGHeBcSaWeqPBPVuF9R44jbcm2dqn7XuMnyqlU9uZ3DdcSAJ01nqGJYNg
 wQpllmw8/CRHYEGI11qN6fPRNdr0z5CJVJBjVhrGcnGOmcc9v+L8TeA9ah7s+E6NCHTr
 vyYdguwLL2/YrehlkuED7V35dw64UA8g0SDBfW3Yv+hDLCn38hs+B+phDDpKFCxvL1Pm
 KdCQ==
X-Gm-Message-State: AOAM532c56Xh7Z2iBzfm27j0BGt2fFQWtzaBcMN6iaXSYkef1vmZVobe
 WXxl2Uwrf8KVKzFB8vUYGn9aKk+vN4UK2guDrsjYT+ISq1TgXcM+PZ84gZayRI+Vhaj07up9cox
 1K/YW+wYWNEVVXsgnOgHctnHmlq57
X-Received: by 2002:a05:6512:32c5:: with SMTP id
 f5mr4456614lfg.564.1642603467930; 
 Wed, 19 Jan 2022 06:44:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvsAD0rcJ3ZGWU/9xpDIeN97n5hfHezeu8uwDdlccB4sonX+11fc41rZ1beDiYX9R1cWwKiw==
X-Received: by 2002:a05:6512:32c5:: with SMTP id
 f5mr4456591lfg.564.1642603467728; 
 Wed, 19 Jan 2022 06:44:27 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:27 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:09 -0800
Message-Id: <631e84014f8c9ad23cc634f6de8770998833286a.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 07/16] testcases/lib: Implement tst_cgctl binary
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
 testcases/lib/Makefile    |  2 +-
 testcases/lib/tst_cgctl.c | 69 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 1 deletion(-)
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
index 000000000..a6cf88f41
--- /dev/null
+++ b/testcases/lib/tst_cgctl.c
@@ -0,0 +1,69 @@
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <unistd.h>
+#include "tst_cgroup.h"
+
+static int cgctl_require(const char *ctrl, int test_pid)
+{
+    struct tst_cgroup_opts opts;
+
+    memset(&opts, 0, sizeof(opts));
+    opts.test_pid = test_pid;
+
+    tst_cgroup_require(ctrl, &opts);
+    tst_cgroup_print_config();
+
+    return 0;
+}
+
+static int cgctl_cleanup(const char *config)
+{
+    tst_cgroup_scan();
+    tst_cgroup_load_config(config);
+    tst_cgroup_cleanup();
+
+    return 0;
+}
+
+static int cgctl_print(void)
+{
+    tst_cgroup_scan();
+    tst_cgroup_print_config();
+
+    return 0;
+}
+
+static int cgctl_process_cmd(int argc, char *argv[])
+{
+    int test_pid;
+    const char *cmd_name = argv[1];
+
+    if (!strcmp(cmd_name, "require")) {
+        test_pid = atoi(argv[3]);
+        if (!test_pid) {
+            fprintf(stderr, "tst_cgctl: Invalid test_pid '%s' given\n",
+                    argv[3]);
+            return 1;
+        }
+        return cgctl_require(argv[2], test_pid);
+    } else if (!strcmp(cmd_name, "cleanup")) {
+        return cgctl_cleanup(argv[2]);
+    } else if (!strcmp(cmd_name, "print")) {
+        return cgctl_print();
+    }
+
+    fprintf(stderr, "tst_cgctl: Unknown command '%s' given\n", cmd_name);
+    return 1;
+}
+
+int main(int argc, char *argv[])
+{
+    if (argc < 2 || argc > 4) {
+        fprintf(stderr, "tst_cgctl: Invalid number of arguements given");
+        return 1;
+    }
+
+    return cgctl_process_cmd(argc, argv);
+}
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
