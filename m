Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C292AC00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 17:17:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC6F93C97FA
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 19:17:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7EC53C97FA
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 19:17:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E6BE10009FD
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 19:17:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B44021F8C9;
 Thu, 18 Aug 2022 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660843049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g7zC0wXWk6mjRORPx66jd/nNGm7yZa5A8bQfx/IAamI=;
 b=fHCyAplFW5fB8d78+DMRpv9a3eZ0weM1qLkw3NZOaG0RXIgWEuAcf7fsK7yiYYVc7g5rJq
 v3nJiMfbx5zs4oLJwnf0ho6sV+1FUakfa/uyhau4fJyvlgo9vYpn6WsBcA1jbp6V/dRQun
 oS6V08//2fygDUUJ2/ewhKGxTe2HLMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660843049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g7zC0wXWk6mjRORPx66jd/nNGm7yZa5A8bQfx/IAamI=;
 b=J2iYD+qZOsiG8TLyTUKDyXQIAF40IZv8QxfVxDvZPPB3aew5Cqr3GX/W/ZrWxkmP/L4/70
 QkWvrdrZrJXTYKCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75BCB133B5;
 Thu, 18 Aug 2022 17:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SwePGil0/mJbQAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 18 Aug 2022 17:17:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 18 Aug 2022 19:17:24 +0200
Message-Id: <20220818171724.9182-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] bpf_prog0[5-7]: Run with
 kernel.unprivileged_bpf_disabled = 0
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To avoid forcing users to run this setup to avoid TCONF:

tst_capability.c:29: TINFO: Dropping CAP_BPF(39)
bpf_common.c:39: TCONF: Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled
bpf_common.c:41: TCONF: bpf() requires CAP_SYS_ADMIN or CAP_BPF on this system: EPERM (1)

Unfortunately this requires running as root.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/bpf/bpf_prog05.c | 5 +++++
 testcases/kernel/syscalls/bpf/bpf_prog06.c | 5 +++++
 testcases/kernel/syscalls/bpf/bpf_prog07.c | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/testcases/kernel/syscalls/bpf/bpf_prog05.c b/testcases/kernel/syscalls/bpf/bpf_prog05.c
index 2be5a2cc9..8197467d9 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
@@ -209,6 +209,11 @@ static struct tst_test test = {
 		{&msg, .size = sizeof(MSG)},
 		{}
 	},
+	.needs_root = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{"?/proc/sys/kernel/unprivileged_bpf_disabled", "0"},
+		{}
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "f6b1b3bf0d5f"},
 		{"linux-git", "468f6eafa6c4"},
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog06.c b/testcases/kernel/syscalls/bpf/bpf_prog06.c
index c38dd8239..6c4f96740 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog06.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog06.c
@@ -150,6 +150,11 @@ static struct tst_test test = {
 		{&msg, .size = sizeof(MSG)},
 		{}
 	},
+	.needs_root = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{"?/proc/sys/kernel/unprivileged_bpf_disabled", "0"},
+		{}
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "64620e0a1e71"},
 		{"CVE", "CVE-2021-4204"},
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog07.c b/testcases/kernel/syscalls/bpf/bpf_prog07.c
index 50ff6eed0..ae389e6ce 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog07.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog07.c
@@ -158,6 +158,11 @@ static struct tst_test test = {
 		{&msg, .size = sizeof(MSG)},
 		{}
 	},
+	.needs_root = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{"?/proc/sys/kernel/unprivileged_bpf_disabled", "0"},
+		{}
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "64620e0a1e71"},
 		{"CVE", "CVE-2022-23222"},
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
