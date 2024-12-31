Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FD7E7718B
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 11:56:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E5EC3ED921
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 12:56:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F9003EC821
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 12:56:17 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CDFCD61F8E9
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 12:56:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2EB321F37C;
 Tue, 31 Dec 2024 11:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735646175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xVno2kUW8KovXSLbze8phjoyVWyE9eWx8KqPAyMoPTM=;
 b=Hgdk3T6DKCB4amCEJ02QMmF7eRsELjqh7TejJVBJ0dK3YA81yfstZS3PjstGmq3U7R4z21
 Zuwfy+vqt/G8fyDdMe7uD2Xy3Cn6WFEqJIFDw6EP9gcHcFIBLu2xZ3aik1vzMVOPJshE3J
 ORCVE1Vt5EbY42Y+ySDCx0LodKsdMZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735646175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xVno2kUW8KovXSLbze8phjoyVWyE9eWx8KqPAyMoPTM=;
 b=Jli9RSqJs+mOTNXJsIsdPu1vaWksiLQSa+b7TJNSvYKJvbFiL0dq/BKzBulLRfdfEivBjp
 AvrifcgGt+TuW+Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Hgdk3T6D;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Jli9RSqJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735646175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xVno2kUW8KovXSLbze8phjoyVWyE9eWx8KqPAyMoPTM=;
 b=Hgdk3T6DKCB4amCEJ02QMmF7eRsELjqh7TejJVBJ0dK3YA81yfstZS3PjstGmq3U7R4z21
 Zuwfy+vqt/G8fyDdMe7uD2Xy3Cn6WFEqJIFDw6EP9gcHcFIBLu2xZ3aik1vzMVOPJshE3J
 ORCVE1Vt5EbY42Y+ySDCx0LodKsdMZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735646175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xVno2kUW8KovXSLbze8phjoyVWyE9eWx8KqPAyMoPTM=;
 b=Jli9RSqJs+mOTNXJsIsdPu1vaWksiLQSa+b7TJNSvYKJvbFiL0dq/BKzBulLRfdfEivBjp
 AvrifcgGt+TuW+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0BA213A30;
 Tue, 31 Dec 2024 11:56:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PqOOOd7bc2cxKQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 31 Dec 2024 11:56:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 31 Dec 2024 12:56:05 +0100
Message-ID: <20241231115607.56105-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2EB321F37C
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] module signature enforcement helpers
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
Cc: Po-Hsu Lin <po-hsu.lin@canonical.com>,
 "Ricardo B . Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Changes v1->v2:
* tpci.c: move tst_check_module_signature_enforced() after tst_sig(FORK, DEF_HANDLER, cleanup);
* finit_module01.c: restore sig_enforce()

Petr Vorel (2):
  lib: Add helpers for module signature enforcement
  device-drivers: *module: Use helpers for module signature enforcement

 include/old/old_module.h                      | 33 +++++++++++++++++++
 include/tst_module.h                          | 17 ++++++++++
 lib/tst_module.c                              | 24 ++++++++++++++
 .../kernel/device-drivers/acpi/ltp_acpi.c     | 11 +------
 .../block/block_dev_user/block_dev.c          |  9 +----
 .../device-drivers/pci/tpci_user/tpci.c       | 11 +------
 .../kernel/device-drivers/uaccess/uaccess.c   | 11 +------
 .../kernel/firmware/fw_load_user/fw_load.c    | 10 +-----
 .../syscalls/delete_module/delete_module01.c  |  9 +----
 .../syscalls/delete_module/delete_module03.c  |  9 +----
 .../syscalls/finit_module/finit_module01.c    |  9 +----
 .../syscalls/finit_module/finit_module02.c    |  7 +---
 .../syscalls/init_module/init_module01.c      |  8 +----
 .../syscalls/init_module/init_module02.c      |  7 +---
 14 files changed, 85 insertions(+), 90 deletions(-)

-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
