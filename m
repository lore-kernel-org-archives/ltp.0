Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF320C7115A
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 12:46:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 337C53CC2A4
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 14:46:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B10E13CC21F
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 14:45:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 228ED1A00922
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 14:45:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 925D0211CA;
 Tue, 17 Jun 2025 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750164337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXv8kbHCEufZgfRYDtgpwLt98kADvXXhvQ/u65mqp9c=;
 b=yW4NuiNP8K2GHL5WPHMZMIRf+c/7QmcZO8yUW6ARnyMenGW0BNtgVtBw1suklo2QQeTfPG
 sdJ8W6HzYS7dsnPs4xuXrn8br6f7OMtXFf1lmMFAjkTEcsgOCQf1lUSXgP/Q61Yqg3OjaM
 57XU6esq8TBhE7tUZDpcpGrv9UMSfvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750164337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXv8kbHCEufZgfRYDtgpwLt98kADvXXhvQ/u65mqp9c=;
 b=nURxG4lzJTa1KYq5bdeKm+3a2gm9qJKiPmaVl2fyqjZ812zcI5YIt23YJ+MxGN6X0CqTSW
 V49VtzaymmkrNuCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yW4NuiNP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nURxG4lz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750164337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXv8kbHCEufZgfRYDtgpwLt98kADvXXhvQ/u65mqp9c=;
 b=yW4NuiNP8K2GHL5WPHMZMIRf+c/7QmcZO8yUW6ARnyMenGW0BNtgVtBw1suklo2QQeTfPG
 sdJ8W6HzYS7dsnPs4xuXrn8br6f7OMtXFf1lmMFAjkTEcsgOCQf1lUSXgP/Q61Yqg3OjaM
 57XU6esq8TBhE7tUZDpcpGrv9UMSfvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750164337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXv8kbHCEufZgfRYDtgpwLt98kADvXXhvQ/u65mqp9c=;
 b=nURxG4lzJTa1KYq5bdeKm+3a2gm9qJKiPmaVl2fyqjZ812zcI5YIt23YJ+MxGN6X0CqTSW
 V49VtzaymmkrNuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7102D13AE1;
 Tue, 17 Jun 2025 12:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WNVFGXFjUWhRSQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 17 Jun 2025 12:45:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 17 Jun 2025 14:45:34 +0200
MIME-Version: 1.0
Message-Id: <20250617-statmount_mnt_ns_id-v1-1-d8d81637d73e@suse.com>
References: <20250617-statmount_mnt_ns_id-v1-0-d8d81637d73e@suse.com>
In-Reply-To: <20250617-statmount_mnt_ns_id-v1-0-d8d81637d73e@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750164337; l=1239;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=L3ZU6Z8kYkI0cbpjX+6UvKYm15S2Y7sAZxbGuUDRnFI=;
 b=PWMPiTpVq6zpttNuVUkrH5PSb05nK/kOXNvfhXdfmo9n58Ds4KHIzDH5Esqe5r+JPqsOkzuFN
 PmeY9hZkmN9CO/2Zxo/XpLG6oO0nrFu+PB+7jZ/aMsr32QMumOxqvRa
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 925D0211CA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] Update statmount fallback definitions
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/mount.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/lapi/mount.h b/include/lapi/mount.h
index aea6bca77ac0c52cbccb892cbd0a205994ab19be..0f7bb5e4327f64e2b0c96511845e86a6c6af8221 100644
--- a/include/lapi/mount.h
+++ b/include/lapi/mount.h
@@ -51,6 +51,7 @@ struct mnt_id_req {
 	uint32_t spare;
 	uint64_t mnt_id;
 	uint64_t param;
+	uint64_t mnt_ns_id;
 };
 #endif
 
@@ -75,7 +76,18 @@ struct statmount {
 	uint64_t propagate_from;
 	uint32_t mnt_root;
 	uint32_t mnt_point;
-	uint64_t __spare2[50];
+	uint64_t mnt_ns_id;
+	uint32_t fs_subtype;
+	uint32_t sb_source;
+	uint32_t opt_num;
+	uint32_t opt_array;
+	uint32_t opt_sec_num;
+	uint32_t opt_sec_array;
+	uint32_t mnt_uidmap_num;
+	uint32_t mnt_uidmap;
+	uint32_t mnt_gidmap_num;
+	uint32_t mnt_gidmap;
+	uint64_t __spare2[44];
 	char str[];
 };
 #endif
@@ -108,6 +120,10 @@ struct statmount {
 # define STATMOUNT_FS_TYPE 0x00000020U
 #endif
 
+#ifndef STATMOUNT_MNT_NS_ID
+# define STATMOUNT_MNT_NS_ID 0x00000040U
+#endif
+
 #ifndef LSMT_ROOT
 # define LSMT_ROOT 0xffffffffffffffff
 #endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
