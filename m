Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1DCD41C14
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 10:07:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27D103CF425
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 11:07:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA4D43C9288
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 11:07:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6D06F6008EF
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 11:07:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 808233372C;
 Thu, 11 Dec 2025 10:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765447646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mhEBjGR/3MoVs+D9aOIAxgItoJFIL82WAmWF5FEuy20=;
 b=jWtEHUrEOur38ItPsTaeqzG4ffA1KdHbp86+mQimQNRqn8NyYBwqZuy2ceR79/NE+psFo2
 phEjJ4FMm9IGKgZBtYZCJx/RO0Yu5p1D9oTfM8ZDWjeAvd4hciBo0TQZkA7mDwcU4M0SH4
 yePZGE8sH0Rn7NlBZI/1pknS47wUiHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765447646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mhEBjGR/3MoVs+D9aOIAxgItoJFIL82WAmWF5FEuy20=;
 b=LX6mzFvLauCSiXikP3wWyK3GiMGiP/uUvk9/62dNTeqY4ckTi6biZs3teMyb53y0nFVRso
 S9CSt97c14Cb5pCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kJLFLllS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2an7zv2m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765447645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mhEBjGR/3MoVs+D9aOIAxgItoJFIL82WAmWF5FEuy20=;
 b=kJLFLllS7xwKe5y4S8SyGKnAW2fxuDyiJuJFjyZAPbDTOtvzUYK1hwYdkV8akeA3Zx2oVf
 uSh5cj+UwRE9iguPlN1uX1sZrbq9pv/cTEJecEMlQFQ8xdK4rGjuPzZlVrl/gRFDVcQ8of
 T/rBz/zFtlXPBqKRJnFA3CwBACV5rjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765447645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mhEBjGR/3MoVs+D9aOIAxgItoJFIL82WAmWF5FEuy20=;
 b=2an7zv2mpzmxSehZdUT/+9V4tOY4tRP1xcmES2MVZUR9En4jZYUTyW4gCKcVIEHSy6jYrm
 fpoG7wZRjZvPPNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5679C3EA63;
 Thu, 11 Dec 2025 10:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MhcpEt2XOmluHwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Dec 2025 10:07:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Dec 2025 11:07:24 +0100
MIME-Version: 1.0
Message-Id: <20251211-modules_livepatch_gitignore-v1-1-610cdbaf3b4e@suse.com>
X-B4-Tracking: v=1; b=H4sIANuXOmkC/x3MTQqDMBAG0KvIrBvIBBpbryJF/PkaB2wiiUpBc
 neDy7d5JyVEQaKmOinikCTBF/CjonHuvYOSqZiMNk82zOoXpn1B6hY5sPbbOHdONnE+RCjWVus
 abF/Dm8qwRnzlf+/tJ+cLpCCKCW0AAAA=
X-Change-ID: 20251211-modules_livepatch_gitignore-106007e168b9
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765447645; l=1474;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=P7pLqJsz6TMf9ZpE3Z7ldLVTnM8pM4/jAiDsnpfkfV4=;
 b=4imDEUh37ePDZ4U5ziBffghOXiMC1FVVfl+OqdZr2YeuPV2SLMaNJW6s7jAnjDDeEYofjRCLd
 pqxoMnZuMc2ADnLvjTlAvgiuPNZbNv+JZBLxisCql1u7FJjOhNInVTV
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 808233372C
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Git ignore modules.livepatch files after build
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

Add modules.livepatch to .gitignore inside the following folders:

- testcases/kernel/device-drivers/acpi/
- testcases/kernel/device-drivers/block/block_dev_kernel/

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/device-drivers/acpi/.gitignore                   | 1 +
 testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore | 1 +
 2 files changed, 2 insertions(+)

diff --git a/testcases/kernel/device-drivers/acpi/.gitignore b/testcases/kernel/device-drivers/acpi/.gitignore
index 6aa2c1298e40df44c54f4955c950bd61d0eac6bc..02c163396ed10828f5748ecf013903e675314297 100644
--- a/testcases/kernel/device-drivers/acpi/.gitignore
+++ b/testcases/kernel/device-drivers/acpi/.gitignore
@@ -6,3 +6,4 @@
 /.*.ko
 /.*.cmd
 /Module.symvers
+/modules.livepatch
diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore b/testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore
index 3beebe109ebc2d669428232184323a3ac61fa5cc..012657ac41becb1f92857a9f1492cdc59a05a7a3 100644
--- a/testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore
@@ -5,3 +5,4 @@
 /.*.ko
 /.*.cmd
 /Module.symvers
+/modules.livepatch

---
base-commit: 63259ec17cd33a5033c1a65af7b541834c85f4d5
change-id: 20251211-modules_livepatch_gitignore-106007e168b9

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
