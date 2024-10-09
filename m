Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445D3CEDD99
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:04:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B31643C3153
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 16:04:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 241A93C31F4
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 16:03:07 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9E7411B60EE4
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 16:03:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 798011F37E;
 Wed,  9 Oct 2024 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728482585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCDmWWebi3g5riEviSKnLuJ1sQ6bQhXVAFPA/DWTSI0=;
 b=1u525Oq0QTfvbvweAOp6ORFEyB2z1lHlvm/DRDioMbKnjYN0nDn0iq0kq3mAJgbb8CEMhP
 fM1+rUQ7bOyjHun838Vjc7HauublFpbBdNs4Lnzld3QeZbGvW3lHFHEiPq66dFfc8Q0GPb
 P1RfnQKJJSBB2ejiRxDLQUwZbkADlmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728482585;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCDmWWebi3g5riEviSKnLuJ1sQ6bQhXVAFPA/DWTSI0=;
 b=psRz/zoB+aYbiuYtvLDwjxDyKCc9eCxV9Qn7FRdPUSWfTnQf++eHibDTixdKIXIknBWB8Q
 Kd8JRCU0sH/49/CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728482585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCDmWWebi3g5riEviSKnLuJ1sQ6bQhXVAFPA/DWTSI0=;
 b=1u525Oq0QTfvbvweAOp6ORFEyB2z1lHlvm/DRDioMbKnjYN0nDn0iq0kq3mAJgbb8CEMhP
 fM1+rUQ7bOyjHun838Vjc7HauublFpbBdNs4Lnzld3QeZbGvW3lHFHEiPq66dFfc8Q0GPb
 P1RfnQKJJSBB2ejiRxDLQUwZbkADlmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728482585;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCDmWWebi3g5riEviSKnLuJ1sQ6bQhXVAFPA/DWTSI0=;
 b=psRz/zoB+aYbiuYtvLDwjxDyKCc9eCxV9Qn7FRdPUSWfTnQf++eHibDTixdKIXIknBWB8Q
 Kd8JRCU0sH/49/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D392413AAF;
 Wed,  9 Oct 2024 14:03:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sOzOJReNBmcIPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 14:03:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 16:02:42 +0200
MIME-Version: 1.0
Message-Id: <20241009-ioctl_ficlone01_fix-v5-3-943238be9923@suse.com>
References: <20241009-ioctl_ficlone01_fix-v5-0-943238be9923@suse.com>
In-Reply-To: <20241009-ioctl_ficlone01_fix-v5-0-943238be9923@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728482574; l=3339;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=rz/C4527EvRU6IJoAHfeVfx0dIS/IqQQqaTPxr8UlyE=;
 b=AQjl6/ad0HSzmA/HZ/tpAomsWbJc9tMYqxCaRcvaYDREzoRkgsUzro598ui6PZjQeyLD/idiU
 mHCI7FS7JGOCJnbqwltCLw3kpMCmrKHWh4sqH4KBIGvyEat2zQKeybz
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/3] Setup minimal kernel for ioctl_clone(range)
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
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
