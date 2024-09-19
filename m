Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F867CE8D7D
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 12:19:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A256F3C2F74
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 14:19:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8AB93C02CD
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 14:19:17 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 98DB260005C
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 14:19:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96E4A20907;
 Thu, 19 Sep 2024 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726748355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aST7JWCYk8AdEGCzpYiAGuBtX/1WIAFGBABOIG0vbJ0=;
 b=M3saoFXax/7dO1aWszTi/6SdI99q20uvlsw4FA46FL0/qIEJApx6XT4Q3qATkb59OWPLlg
 fDBUZyAe4HrVHMZ/PPEDAblpgY7Kzc1GZ92bP1v1DgA5SObxUw1FAO4wfpkfjaZzAn/WPT
 p+REYuioNS96LCSPAv8DmmzpaSey8tM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726748355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aST7JWCYk8AdEGCzpYiAGuBtX/1WIAFGBABOIG0vbJ0=;
 b=9jDWdktnVQPzRgxMpweBDYlAC5GL0S62Ik4cfD8voLOLsB2HWoxFgiAhxhpF5MXm50J4pW
 OUNytzj1ju34FzAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726748355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aST7JWCYk8AdEGCzpYiAGuBtX/1WIAFGBABOIG0vbJ0=;
 b=M3saoFXax/7dO1aWszTi/6SdI99q20uvlsw4FA46FL0/qIEJApx6XT4Q3qATkb59OWPLlg
 fDBUZyAe4HrVHMZ/PPEDAblpgY7Kzc1GZ92bP1v1DgA5SObxUw1FAO4wfpkfjaZzAn/WPT
 p+REYuioNS96LCSPAv8DmmzpaSey8tM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726748355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aST7JWCYk8AdEGCzpYiAGuBtX/1WIAFGBABOIG0vbJ0=;
 b=9jDWdktnVQPzRgxMpweBDYlAC5GL0S62Ik4cfD8voLOLsB2HWoxFgiAhxhpF5MXm50J4pW
 OUNytzj1ju34FzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66D5413A5F;
 Thu, 19 Sep 2024 12:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lrRvE8MW7GYnKAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 19 Sep 2024 12:19:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 19 Sep 2024 14:19:08 +0200
Message-ID: <20240919121909.15025-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Ignore generated modules.livepatch in git repo
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

modules.livepatch files are generated during the build and they are not
needed inside the git repo. Ignore them so they are not added by
accident inside the git repository.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/commands/insmod/.gitignore                       | 1 +
 testcases/commands/lsmod/.gitignore                        | 1 +
 testcases/kernel/device-drivers/pci/tpci_kernel/.gitignore | 1 +
 testcases/kernel/device-drivers/uaccess/.gitignore         | 1 +
 testcases/kernel/firmware/fw_load_kernel/.gitignore        | 1 +
 testcases/kernel/syscalls/delete_module/.gitignore         | 1 +
 testcases/kernel/syscalls/finit_module/.gitignore          | 1 +
 testcases/kernel/syscalls/init_module/.gitignore           | 1 +
 8 files changed, 8 insertions(+)

diff --git a/testcases/commands/insmod/.gitignore b/testcases/commands/insmod/.gitignore
index 0e19fb3fd..e568d92b6 100644
--- a/testcases/commands/insmod/.gitignore
+++ b/testcases/commands/insmod/.gitignore
@@ -7,3 +7,4 @@
 .built-in.a.cmd
 Module.symvers
 modules.order
+modules.livepatch
diff --git a/testcases/commands/lsmod/.gitignore b/testcases/commands/lsmod/.gitignore
index 0e19fb3fd..e568d92b6 100644
--- a/testcases/commands/lsmod/.gitignore
+++ b/testcases/commands/lsmod/.gitignore
@@ -7,3 +7,4 @@
 .built-in.a.cmd
 Module.symvers
 modules.order
+modules.livepatch
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/.gitignore b/testcases/kernel/device-drivers/pci/tpci_kernel/.gitignore
index 3e100ad5e..ed4712e3a 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/.gitignore
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/.gitignore
@@ -5,3 +5,4 @@
 /.*.ko
 /.*.cmd
 /Module.symvers
+modules.livepatch
diff --git a/testcases/kernel/device-drivers/uaccess/.gitignore b/testcases/kernel/device-drivers/uaccess/.gitignore
index cf59b68df..c42a3fbe5 100644
--- a/testcases/kernel/device-drivers/uaccess/.gitignore
+++ b/testcases/kernel/device-drivers/uaccess/.gitignore
@@ -6,3 +6,4 @@
 /.*.ko
 /.*.cmd
 /Module.symvers
+modules.livepatch
diff --git a/testcases/kernel/firmware/fw_load_kernel/.gitignore b/testcases/kernel/firmware/fw_load_kernel/.gitignore
index 180072a72..6fc82952c 100644
--- a/testcases/kernel/firmware/fw_load_kernel/.gitignore
+++ b/testcases/kernel/firmware/fw_load_kernel/.gitignore
@@ -4,3 +4,4 @@
 /Module.symvers
 /ltp_fw_load.mod.c
 /.tmp_versions/
+modules.livepatch
diff --git a/testcases/kernel/syscalls/delete_module/.gitignore b/testcases/kernel/syscalls/delete_module/.gitignore
index 1a774a6d5..161aac4a2 100644
--- a/testcases/kernel/syscalls/delete_module/.gitignore
+++ b/testcases/kernel/syscalls/delete_module/.gitignore
@@ -10,3 +10,4 @@
 /.built-in.a.cmd
 /Module.symvers
 /modules.order
+modules.livepatch
diff --git a/testcases/kernel/syscalls/finit_module/.gitignore b/testcases/kernel/syscalls/finit_module/.gitignore
index 5fcafdb37..59026b25c 100644
--- a/testcases/kernel/syscalls/finit_module/.gitignore
+++ b/testcases/kernel/syscalls/finit_module/.gitignore
@@ -1,3 +1,4 @@
 /finit_module01
 /finit_module02
 /*.ko
+modules.livepatch
diff --git a/testcases/kernel/syscalls/init_module/.gitignore b/testcases/kernel/syscalls/init_module/.gitignore
index 23baeb651..437c79d94 100644
--- a/testcases/kernel/syscalls/init_module/.gitignore
+++ b/testcases/kernel/syscalls/init_module/.gitignore
@@ -9,3 +9,4 @@
 /.built-in.a.cmd
 /Module.symvers
 /modules.order
+modules.livepatch
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
