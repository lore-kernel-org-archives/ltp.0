Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FAFC3600B
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 12:44:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 736503C9BC0
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 13:43:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55B0A3C100A
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 13:43:42 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A1113680430
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 13:43:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B1EA821157;
 Wed, 26 Mar 2025 12:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742993019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8hL/4tVOeDEc24vi6di3YmUodrJ5EtLQRrVoNvEs8pw=;
 b=oFWXc2CYG4YxFZgpfn5eGdOq+fNg+vnxDPDAO3D9KcU2CAfucOwHxvUiOlaGjA0XIQDM4v
 J45crROSy1u7j0q5oBv/SUmDZiYww9R5/+AJVye4fqgFApiiQnWP71IWwIKGsTBpsgQffG
 cw5a7NCg9UtEnTLusQ4mI5If4wZ3mZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742993019;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8hL/4tVOeDEc24vi6di3YmUodrJ5EtLQRrVoNvEs8pw=;
 b=Nrftp7zkgll2KrUKiKgO4UDK827RDVV6006bpP3mzz8PWB+80gLdj+ZdGEl0CijWjujAuY
 0shUZcVFBAM7p1Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oFWXc2CY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Nrftp7zk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742993019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8hL/4tVOeDEc24vi6di3YmUodrJ5EtLQRrVoNvEs8pw=;
 b=oFWXc2CYG4YxFZgpfn5eGdOq+fNg+vnxDPDAO3D9KcU2CAfucOwHxvUiOlaGjA0XIQDM4v
 J45crROSy1u7j0q5oBv/SUmDZiYww9R5/+AJVye4fqgFApiiQnWP71IWwIKGsTBpsgQffG
 cw5a7NCg9UtEnTLusQ4mI5If4wZ3mZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742993019;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8hL/4tVOeDEc24vi6di3YmUodrJ5EtLQRrVoNvEs8pw=;
 b=Nrftp7zkgll2KrUKiKgO4UDK827RDVV6006bpP3mzz8PWB+80gLdj+ZdGEl0CijWjujAuY
 0shUZcVFBAM7p1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 981DE13927;
 Wed, 26 Mar 2025 12:43:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YzQ6I3v242dnJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 26 Mar 2025 12:43:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 26 Mar 2025 13:42:51 +0100
MIME-Version: 1.0
Message-Id: <20250326-fix_ioctl_ficlone03_32bit_bcachefs-v1-1-554a0315ebf5@suse.com>
X-B4-Tracking: v=1; b=H4sIAEr242cC/x2NQQqAIBAAvxJ7TrCVPPSVCMltrYXQ0Igg+nvSc
 Q4z80DhLFxgaB7IfEmRFCt0bQO0zXFlJUtlQI29NmhVkNtJonN3QWhPkbVxBr2cztNMG4eikKn
 r/WJJk4UaOjJX65+M0/t+CYiXFHQAAAA=
X-Change-ID: 20250326-fix_ioctl_ficlone03_32bit_bcachefs-2ec15bd6c0c6
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742993019; l=1565;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=QldVlJGPn8oHEZGeN+IHyNfPy/B1o8e4xX4RHzPX7lY=;
 b=yglH2Pow+IaL7+rzjjW7Znl2dsoS/7W2MWQ2C73Abqa2R2HCr4kkJ3z8eRo2fZANpA708G+30
 fIHZrac7E9SC2wCqfa3qTuJwYzPLHUiNKQbSKYHZI7+L6foQZw9oz6g
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: B1EA821157
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ioctl_ficlone03: fix capabilities on immutable files
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

Make sure that capabilities requirements are satisfied when accessing
immutable files. On OpenSUSE Tumbleweed 32bit bcachefs fails with the
following error due to missing capabilities:

tst_test.c:1833: TINFO: === Testing on bcachefs ===
..
ioctl_ficlone03.c:74: TBROK: ioctl .. failed: ENOTTY (25)
ioctl_ficlone03.c:89: TWARN: ioctl ..  failed: ENOTTY (25)
ioctl_ficlone03.c:91: TWARN: ioctl ..  failed: ENOTTY (25)
ioctl_ficlone03.c:98: TWARN: close(-1) failed: EBADF (9)

Introduce CAP_LINUX_IMMUTABLE capability to make sure that test won't
fail on other systems as well.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
index 6a9d270d9fb56f3a263f0aed976f62c4576e6a5f..6716423d9c96d9fc1d433f28e0ae1511b912ae2c 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
@@ -122,5 +122,9 @@ static struct tst_test test = {
 	.bufs = (struct tst_buffers []) {
 		{&clone_range, .size = sizeof(struct file_clone_range)},
 		{},
-	}
+	},
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_LINUX_IMMUTABLE),
+		{}
+	},
 };

---
base-commit: 753bd13472d4be44eb70ff183b007fe9c5fffa07
change-id: 20250326-fix_ioctl_ficlone03_32bit_bcachefs-2ec15bd6c0c6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
