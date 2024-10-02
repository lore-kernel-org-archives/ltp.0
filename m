Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216E7CF31B7
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 12:23:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6972E3C5A62
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 14:23:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 866003C5A13
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 14:22:48 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E6C26140F6C0
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 14:22:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 20D371FD57
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727871767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMSsn1yxeU1V3opM5NCvb2nglm9ghM+TDY6AjsztQhM=;
 b=UkYLeYgVGtTy2LkljjpeGhLFTum2JbxOioxiLy3DoHRlFpDUZ4JFF5q8R7ub+GaexI5dhw
 vrg/DXh2Xpatjq30JMwmi6iOzaHq6kseISSFOXXvzNc7Bw3kwh/LjFnXw6697eIyHZuwqt
 B0bJJrG73UWp72WPwf3cOwKSdDWrQUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727871767;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMSsn1yxeU1V3opM5NCvb2nglm9ghM+TDY6AjsztQhM=;
 b=pqIG4MaP7WIvzJ/dkUKinmHLlJy7tDXrrI2D72axPiHI1/qk4To1FeQXLOn1gOlOqLASBO
 PjrDRytYymmkmSCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UkYLeYgV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pqIG4MaP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727871767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMSsn1yxeU1V3opM5NCvb2nglm9ghM+TDY6AjsztQhM=;
 b=UkYLeYgVGtTy2LkljjpeGhLFTum2JbxOioxiLy3DoHRlFpDUZ4JFF5q8R7ub+GaexI5dhw
 vrg/DXh2Xpatjq30JMwmi6iOzaHq6kseISSFOXXvzNc7Bw3kwh/LjFnXw6697eIyHZuwqt
 B0bJJrG73UWp72WPwf3cOwKSdDWrQUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727871767;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMSsn1yxeU1V3opM5NCvb2nglm9ghM+TDY6AjsztQhM=;
 b=pqIG4MaP7WIvzJ/dkUKinmHLlJy7tDXrrI2D72axPiHI1/qk4To1FeQXLOn1gOlOqLASBO
 PjrDRytYymmkmSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C6DA13974
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 12:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0OY9ARc7/WbICAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 02 Oct 2024 12:22:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Oct 2024 14:22:46 +0200
MIME-Version: 1.0
Message-Id: <20241002-ioctl_ficlone01_fix-v3-3-7e077918dfd4@suse.com>
References: <20241002-ioctl_ficlone01_fix-v3-0-7e077918dfd4@suse.com>
In-Reply-To: <20241002-ioctl_ficlone01_fix-v3-0-7e077918dfd4@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727871766; l=3294;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=DIOX8VRE+mqbeKKXYe13LMptKXcYnmQtcAgX9Z4plfs=;
 b=/q8+g/tKEMKm2mmlZA2JuNxBOEGCyyi8EF19QDbvI1A/OVAFKBoq6pTtJZQ6Yi0domq0rg3re
 ae2MfDrRuUKBCvTTf9BQGwDDHv6fWzbn3n1pynYjF2sf3GZ62nWx+qO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 20D371FD57
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] Setup minimal kernel for ioctl_clone(range)
 tests
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Some linux kernels don't support copy-on-write feature for the
filesystems we are going to use during ioctl_ficlone and
ioctl_ficlonerange tests. For this reason, fix the minimal kernel
version required in order to skip test when it's needed.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c      | 4 +++-
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c      | 4 +++-
 testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c | 4 +++-
 testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c | 4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
index f5407f789..2574bb6a2 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
@@ -112,10 +112,12 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.filesystems = (struct tst_fs []) {
-		{.type = "bcachefs"},
 		{.type = "btrfs"},
+		{.type = "bcachefs"},
 		{
 			.type = "xfs",
+			.min_kver = "4.16",
+			.mkfs_ver = "mkfs.xfs >= 1.5.0",
 			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
 		},
 		{}
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
index 3cc386c59..f12c4e7fd 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
@@ -110,10 +110,12 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.filesystems = (struct tst_fs []) {
-		{.type = "bcachefs"},
 		{.type = "btrfs"},
+		{.type = "bcachefs"},
 		{
 			.type = "xfs",
+			.min_kver = "4.16",
+			.mkfs_ver = "mkfs.xfs >= 1.5.0",
 			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
 		},
 		{}
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
index e352c513b..8fd1d299a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
@@ -145,10 +145,12 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.filesystems = (struct tst_fs []) {
-		{.type = "bcachefs"},
 		{.type = "btrfs"},
+		{.type = "bcachefs"},
 		{
 			.type = "xfs",
+			.min_kver = "4.16",
+			.mkfs_ver = "mkfs.xfs >= 1.5.0",
 			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
 		},
 		{}
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
index ad36df162..eb941c3fc 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
@@ -82,10 +82,12 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.filesystems = (struct tst_fs []) {
-		{.type = "bcachefs"},
 		{.type = "btrfs"},
+		{.type = "bcachefs"},
 		{
 			.type = "xfs",
+			.min_kver = "4.16",
+			.mkfs_ver = "mkfs.xfs >= 1.5.0",
 			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
 		},
 		{}

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
