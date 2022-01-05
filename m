Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356C0C433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 10:01:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 362C93C90EE
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 11:01:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB84B3C90E8
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:18 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1568C10008FD
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:17 +0100 (CET)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6EFBD3F225
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 10:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641376817;
 bh=P9mGlDP6FDUJTwCWfdkfmToNbPFtTFQ3vVbuMfVjUbM=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=DPC1nxbpRMNTJsIUoE/fXNs/w84AGlN1aB8gIq9SjanfJJ0+seULz3pSAnvoek6Pf
 3xEDvQCVHA0BqWY22TU9W+xT5nSfNk8oM7Svj+CO9oH7OMGN9WiuD+arH5MMtpDJ8x
 g7/9ZMe8eCNVOHwce1BFYwes8qkIlFNIc2qBEcH8QRoB99poQayGkNiRcStm9JR1Md
 2U4OucYR9U+z7OXxmTj8Ml23kxNJdBKK87S62tEthqiIP4TBvJLwpxunQns9lbMf2K
 bTsAb/T7aG7icUP57267pMkVKH8KhEl0Yd5cLy4ow/S31dnNu2d9NPFSxFnr1Mk75m
 q4ExywYJazWOQ==
Received: by mail-lf1-f72.google.com with SMTP id
 b5-20020a196445000000b0042659f2a17cso8202024lfj.23
 for <ltp@lists.linux.it>; Wed, 05 Jan 2022 02:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P9mGlDP6FDUJTwCWfdkfmToNbPFtTFQ3vVbuMfVjUbM=;
 b=qZJzm5ZgZho+3FgPaExGu0v0G4UqUmK8XNI7c9ZJwmYZL3HXYVjEfXn9ViKHYTqs4J
 5SvqBztXyPwixQOaGjHoeLo26FYS8lZx5hMC/lhUOgygSkfyLbk7GloIfWUcihGiasXB
 FhJaysm7ijNCVOv/pi927K62pkV6o9aLzgFPx7w05zcxJg8HUR80TTRid2jOqqYtkoEA
 pcEHQ7k+tcqdQ51XUhaZuI6VpDvU3dWluxlN7EBB/Z7mmiAuqrIx2WkFjc7MG2b/N58k
 wsWOI43DTvClOddxWTvKo8ZN7nesp9Er6HLkXEgC9cKyd/X6eQ4UEJftZd248xKN66AK
 GVmQ==
X-Gm-Message-State: AOAM531DYHKXA1afesiaNX+i3mgfrY5tR8cx1/vWxZFgCzNVE1nR3L/h
 gzOiO3rIEFn/xVA+nsPN/hX0N8UaW9jyUcjYizv8XGyR0JJDO6uYTU3bi+efxL3q11txgya5CVa
 1Hafnrhh3PCboe2fNJSDeueZnHTNz
X-Received: by 2002:a05:6512:11c9:: with SMTP id
 h9mr32656091lfr.33.1641376816521; 
 Wed, 05 Jan 2022 02:00:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw54KrCACcKmuwZg6PaeNpMXVjfqUs9XGzutQMapXbF/AvTSC5H/M/js5vrRm4W5xfyjh8f+g==
X-Received: by 2002:a05:6512:11c9:: with SMTP id
 h9mr32656078lfr.33.1641376816309; 
 Wed, 05 Jan 2022 02:00:16 -0800 (PST)
Received: from lukenow-XPS-13-9380.home (159-205-75-251.adsl.inetia.pl.
 [159.205.75.251])
 by smtp.gmail.com with ESMTPSA id z25sm4152527lfq.20.2022.01.05.02.00.15
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jan 2022 02:00:16 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Wed,  5 Jan 2022 02:00:06 -0800
Message-Id: <91b9d5928cd129ebb21430a60e715113a6a6f6b7.1641376050.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/6] tools: Implement tst_cgctl binary utility
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
 tools/cgroup/Makefile    |  7 ++++
 tools/cgroup/tst_cgctl.c | 69 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 tools/cgroup/Makefile
 create mode 100644 tools/cgroup/tst_cgctl.c

diff --git a/tools/cgroup/Makefile b/tools/cgroup/Makefile
new file mode 100644
index 000000000..81810bf4d
--- /dev/null
+++ b/tools/cgroup/Makefile
@@ -0,0 +1,7 @@
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+MAKE_TARGETS	:= tst_cgctl
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
diff --git a/tools/cgroup/tst_cgctl.c b/tools/cgroup/tst_cgctl.c
new file mode 100644
index 000000000..ef20e7485
--- /dev/null
+++ b/tools/cgroup/tst_cgctl.c
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
\ No newline at end of file
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
