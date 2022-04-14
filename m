Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B15C433F5
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 14:54:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52BD43CA60B
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 16:54:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E9F63CA5E8
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:03 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E718860042F
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:02 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id lc2so10495805ejb.12
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 07:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QIYXIPcyhXSoqUqAwpMmcryDmlUa2EJW5Be+laPC28U=;
 b=VanwMQ/N0rN5SNHv8gPlxds5imENtgF+hshwVSeSCkjxU1JSCKnTJJOJWbeJWGat1c
 JO7SXezY0y8aX3hZhfLWY04UuArE5QXyyHsPWrp0Tw5Nbmiph7amHCoo8jlzEl4uHuVd
 Tfe4uxuR64E/hGQgEqXH4Dmn5a4bZl06OX4EtWACWMh7ntxi6tkR9e5QEs34USvUPEQD
 Z/bWkG7dGmR1Q31n8Q+KmkPXzm4JFwJqzxqxu+2QS/ei4VRKEXxeNnoQ8QX3/s9nOdZm
 bjMXB0mnjPq1NkSS7rW2RlRnPDU0wNES8Teffnqwv6HerfyF3oToKOX/DuemDU7TiDXV
 cGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QIYXIPcyhXSoqUqAwpMmcryDmlUa2EJW5Be+laPC28U=;
 b=11JZ5U31qHPv8+tQDJBEjwi0tIAqS3Bb6867I0twfBJtVNjbfvgi+SrCTSKClxtV5p
 VrztW5MF0A8D9c68C+zATmHA4l9XqmiG7XseT2p3Ps2MGsY36lGVizIDh40y5t5lTAFB
 E4C1vnNhtzhgPrN31R2vCeoJon64JKjih/EC57XnuxcafWSgWrdXHgkjHVPu0CTlQi+z
 CnQs/erDsPSPf8CpQzavtkkdJqIApg5s3DF3jfLwIzU7tmlRwSJFM3HYfk+nLeEwJiYL
 vm/b4Om8lTrxj1HGIjjAHDy9N00WL446WrlpetMPLjTZgCJOzokESfpD3YXK3InCXbdU
 e40Q==
X-Gm-Message-State: AOAM530lNmoe7sIS9fHHZFSSkmt5FUSjERGIF9T44pX6K6GidnAf48wS
 /PuHXNV1Hkc3TRM+0w4AtiM=
X-Google-Smtp-Source: ABdhPJxVu5YGNdpZ65X37d0FnrfGc4NAVarIluM20/8/giUCxGxINLeR+mHP+UD4S4fCvO30yJJGpQ==
X-Received: by 2002:a17:906:fa8f:b0:6e4:de0d:45f with SMTP id
 lt15-20020a170906fa8f00b006e4de0d045fmr2662702ejb.235.1649948042376; 
 Thu, 14 Apr 2022 07:54:02 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
 by smtp.gmail.com with ESMTPSA id
 kb28-20020a1709070f9c00b006d5d8bf1b72sm695026ejc.78.2022.04.14.07.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Apr 2022 07:54:01 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Apr 2022 17:53:52 +0300
Message-Id: <20220414145357.3184012-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414145357.3184012-1-amir73il@gmail.com>
References: <20220414145357.3184012-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] syscalls/fcntl: New test for DN_RENAME (dnotify)
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Check that signal is delivered for directory watching for DN_RENAME
only when rename is within the same directory.
Even if both old and new directories are watches, DN_RENAME is not
generated on cross parent rename.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 runtest/syscalls                           |   2 +
 testcases/kernel/syscalls/fcntl/.gitignore |   2 +
 testcases/kernel/syscalls/fcntl/fcntl39.c  | 114 +++++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl39.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c30383ee5..d43d6983b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -334,6 +334,8 @@ fcntl37 fcntl37
 fcntl37_64 fcntl37_64
 fcntl38 fcntl38
 fcntl38_64 fcntl38_64
+fcntl39 fcntl39
+fcntl39_64 fcntl39_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/fcntl/.gitignore b/testcases/kernel/syscalls/fcntl/.gitignore
index ede0c97b8..48b36ec34 100644
--- a/testcases/kernel/syscalls/fcntl/.gitignore
+++ b/testcases/kernel/syscalls/fcntl/.gitignore
@@ -74,3 +74,5 @@
 /fcntl37_64
 /fcntl38
 /fcntl38_64
+/fcntl39
+/fcntl39_64
diff --git a/testcases/kernel/syscalls/fcntl/fcntl39.c b/testcases/kernel/syscalls/fcntl/fcntl39.c
new file mode 100644
index 000000000..0fef20764
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl39.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 CTERA Networks. All Rights Reserved.
+ *
+ * Started by Amir Goldstein <amir73il@gmail.com>
+ *
+ * DESCRIPTION
+ *     Check that dnotify DN_RENAME event is reported only on rename
+ *     inside same parent
+ */
+
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+
+#define	TEST_DIR	"test_dir"
+#define	TEST_DIR2	"test_dir2"
+#define	TEST_FILE	"test_file"
+
+#define TEST_SIG SIGRTMIN+1
+
+static int parent_fd, subdir_fd;
+static int got_parent_event, got_subdir_event;
+
+static void dnotify_handler(int sig, siginfo_t *si, void *data __attribute__((unused)))
+{
+	if (si->si_fd == parent_fd)
+		got_parent_event = 1;
+	else if (si->si_fd == subdir_fd)
+		got_subdir_event = 1;
+	else
+		tst_brk(TBROK, "Got unexpected signal %d with si_fd %d", sig, si->si_fd);
+}
+
+static void setup_dnotify(int fd)
+{
+	struct sigaction act;
+
+	act.sa_sigaction = dnotify_handler;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags = SA_SIGINFO;
+	sigaction(TEST_SIG, &act, NULL);
+
+	TEST(fcntl(fd, F_SETSIG, TEST_SIG));
+	if (TST_RET != 0) {
+		tst_brk(TBROK, "F_SETSIG failed errno = %d : %s",
+			TST_ERR, strerror(TST_ERR));
+	}
+	TEST(fcntl(fd, F_NOTIFY, DN_RENAME|DN_MULTISHOT));
+	if (TST_RET != 0) {
+		tst_brk(TBROK, "F_NOTIFY failed errno = %d : %s",
+			TST_ERR, strerror(TST_ERR));
+	}
+}
+
+static void verify_dnotify(void)
+{
+	parent_fd = SAFE_OPEN(".", O_RDONLY);
+	subdir_fd = SAFE_OPEN(TEST_DIR, O_RDONLY);
+	/* Watch renames inside ".", but not in and out of "." */
+	setup_dnotify(parent_fd);
+	/* Also watch for renames inside subdir, but not in and out of subdir */
+	setup_dnotify(subdir_fd);
+	/* Rename file from "." to subdir should not generate DN_RENAME on either */
+	tst_res(TINFO, "Testing no DN_RENAME on rename from parent to subdir");
+	SAFE_RENAME(TEST_FILE, TEST_DIR "/" TEST_FILE);
+	if (got_parent_event)
+		tst_res(TFAIL, "Got unexpected event on parent");
+	else
+		tst_res(TPASS, "No event on parent as expected");
+	if (got_subdir_event)
+		tst_res(TFAIL, "Got unexpected event on subdir");
+	else
+		tst_res(TPASS, "No event on subdir as expected");
+	/* Rename subdir itself should generate DN_RENAME on ".", but not on itself */
+	tst_res(TINFO, "Testing DN_RENAME on rename of subdir itself");
+	SAFE_RENAME(TEST_DIR, TEST_DIR2);
+	if (got_parent_event)
+		tst_res(TPASS, "Got event on parent as expected");
+	else
+		tst_res(TFAIL, "Missing event on parent");
+	if (got_subdir_event)
+		tst_res(TFAIL, "Got unexpected event on subdir");
+	else
+		tst_res(TPASS, "No event on subdir as expected");
+
+	SAFE_CLOSE(parent_fd);
+	SAFE_CLOSE(subdir_fd);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(TEST_DIR, 00700);
+	SAFE_TOUCH(TEST_FILE, 0666, NULL);
+}
+
+static void cleanup(void)
+{
+	if (parent_fd > 0)
+		SAFE_CLOSE(parent_fd);
+	if (subdir_fd > 0)
+		SAFE_CLOSE(subdir_fd);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_dnotify,
+	.needs_kconfigs = (const char *[]) { "CONFIG_DNOTIFY=y", NULL },
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
