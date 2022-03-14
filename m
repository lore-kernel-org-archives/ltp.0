Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18415C433F5
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 13:03:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CD983CA7E8
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 14:03:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E5AA3CA7CC
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 14:02:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 641A21A0079E
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 14:02:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46BFC218FE;
 Mon, 14 Mar 2022 13:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647262972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dbykFSqQAOntThDdk5qVI9YG4u1qZq1ikrOY/1V6UMo=;
 b=t/sACzoZHbyVe1oZ3pZ4LWW1DgF88iQrJmuY6YdUvT1s4+zSU66LrlbDEX/hHZ/d3BHW0I
 CX4HBMU4iCmYKICWigS1bwMcKINTOAY0XvKhgnx+FM2gRKGNM0ZLHh7uHFzwvH/6taDL7Y
 N9tsLVu8cZQzDzi3Bo1mokAiI5cLZqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647262972;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dbykFSqQAOntThDdk5qVI9YG4u1qZq1ikrOY/1V6UMo=;
 b=VrqMzaHAVQWVChpG2YM4T9YVGt+LFDi7xXWfMgfNZ5YaMTlgMBJUlECfanmZP8J1nK+k0v
 k6z5SSBqK/KYrHDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1107713ADA;
 Mon, 14 Mar 2022 13:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z3lEAvw8L2K+UQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 14 Mar 2022 13:02:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 14 Mar 2022 14:02:48 +0100
Message-Id: <20220314130248.22869-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] quotactl: Check for missing quota_v2 module
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

openSUSE JeOS allowed installation without quota_v2 (they were in
kernel-default, but by default kernel-default-base with smaller subset
of kernel modules is installed).

Therefore check for the module for all tests which require CONFIG_QFMT_V2
config.

Fixes: https://bugzilla.opensuse.org/show_bug.cgi?id=1196585

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/quotactl/quotactl01.c | 4 ++++
 testcases/kernel/syscalls/quotactl/quotactl04.c | 4 ++++
 testcases/kernel/syscalls/quotactl/quotactl06.c | 4 ++++
 testcases/kernel/syscalls/quotactl/quotactl08.c | 4 ++++
 testcases/kernel/syscalls/quotactl/quotactl09.c | 4 ++++
 5 files changed, 20 insertions(+)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 561e5030fe..f06e18edca 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -217,6 +217,10 @@ static struct tst_test test = {
 		"CONFIG_QFMT_V2",
 		NULL
 	},
+	.needs_drivers = (const char *const []) {
+		"quota_v2",
+		NULL
+	},
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index 55da282705..bb2d899f0e 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -166,6 +166,10 @@ static struct tst_test test = {
 		"CONFIG_QFMT_V2",
 		NULL
 	},
+	.needs_drivers = (const char *const []) {
+		"quota_v2",
+		NULL
+	},
 	.min_kver = "4.10", /* commit 689c958cbe6b (ext4: add project quota support) */
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 87715237f5..8c75c87b06 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -220,6 +220,10 @@ static struct tst_test test = {
 		"CONFIG_QFMT_V2",
 		NULL
 	},
+	.needs_drivers = (const char *const []) {
+		"quota_v2",
+		NULL
+	},
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_quotactl,
 	.dev_fs_type = "ext4",
diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
index 3793867f23..ae6e582be0 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl08.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
@@ -212,6 +212,10 @@ static struct tst_test test = {
 		"CONFIG_QFMT_V2",
 		NULL
 	},
+	.needs_drivers = (const char *const []) {
+		"quota_v2",
+		NULL
+	},
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
 	.mntpoint = MNTPOINT,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
index 8b959909ca..12d331b1a0 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl09.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -174,6 +174,10 @@ static struct tst_test test = {
 		"CONFIG_QFMT_V2",
 		NULL
 	},
+	.needs_drivers = (const char *const []) {
+		"quota_v2",
+		NULL
+	},
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_quotactl,
 	.dev_fs_opts = (const char *const[]){"-O quota", NULL},
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
