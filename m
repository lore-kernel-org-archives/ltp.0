Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4437FCEF15B
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 11:56:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1DDA3C19F5
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 13:56:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5D423C14A2
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 13:55:45 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2C49D14044DE
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 13:55:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBD0121CFD
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728388543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMSsn1yxeU1V3opM5NCvb2nglm9ghM+TDY6AjsztQhM=;
 b=TsN/GkueOWGVMTr4KgmZulWvkoO1MG7IxVgw8vQrKp0xPFmTSFDpyGu0lzf7deHq9qRXuy
 bGxcafE4rkb7Dv9KxeR8iK/LpTgL81VUmVVgnayYQumy7jR07+vRkE5nevteom+XPpdfBW
 WVSm2QPSXlNVJk1nT/Xk0vJdMkk7fm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728388543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMSsn1yxeU1V3opM5NCvb2nglm9ghM+TDY6AjsztQhM=;
 b=VHEeSm67gKFfhJBHG36b7IigR8B/eZO+VLOYP9fg3ZnBFHv+fqBY3xkYS03vzwi8B65T+0
 1DBOH6EDfkV8H2AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="TsN/Gkue";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VHEeSm67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728388543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMSsn1yxeU1V3opM5NCvb2nglm9ghM+TDY6AjsztQhM=;
 b=TsN/GkueOWGVMTr4KgmZulWvkoO1MG7IxVgw8vQrKp0xPFmTSFDpyGu0lzf7deHq9qRXuy
 bGxcafE4rkb7Dv9KxeR8iK/LpTgL81VUmVVgnayYQumy7jR07+vRkE5nevteom+XPpdfBW
 WVSm2QPSXlNVJk1nT/Xk0vJdMkk7fm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728388543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMSsn1yxeU1V3opM5NCvb2nglm9ghM+TDY6AjsztQhM=;
 b=VHEeSm67gKFfhJBHG36b7IigR8B/eZO+VLOYP9fg3ZnBFHv+fqBY3xkYS03vzwi8B65T+0
 1DBOH6EDfkV8H2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A442413A6E
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AK2jIr8dBWf4aQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 08 Oct 2024 11:55:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 13:55:40 +0200
MIME-Version: 1.0
Message-Id: <20241008-ioctl_ficlone01_fix-v4-3-eae3adac33c9@suse.com>
References: <20241008-ioctl_ficlone01_fix-v4-0-eae3adac33c9@suse.com>
In-Reply-To: <20241008-ioctl_ficlone01_fix-v4-0-eae3adac33c9@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728388542; l=3294;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=DIOX8VRE+mqbeKKXYe13LMptKXcYnmQtcAgX9Z4plfs=;
 b=3nraoz3VK/Lt6My1M59XoEkMkt8vVqKOYxrWgvS+SqVeGr2vQI+jDiISUXblxYYIW/JgcmoYV
 5W/Mej73+7MC3FOG81/rolZaM8l5CszO+JtCpKcMXT+C1Z+mNmFSzih
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: DBD0121CFD
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/3] Setup minimal kernel for ioctl_clone(range)
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
