Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA62CC54791
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 09:24:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 161A63CFD0E
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 10:24:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D15833CEC1D
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 10:23:39 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1059C6009DB
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 10:23:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BBA261F7C0;
 Wed, 13 Mar 2024 09:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710321817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zoQXp63WV+kT3XeOtx18SWMC0mkzA2MlgaXm6NMutHs=;
 b=iEWRPVSG+8K4AAgqCZZmFrCcQp00jVJnb3DTTMLYmwxGpObYeHwGCmbdoln44VOyiZoDCP
 YthU2o9pT8nx4eKImHTW1lS62DfKN80tl69s3DyC1361gAXRvo/6BsTcfejFHJ5KhVc1XM
 hBWX3JVAaPj6V+mu9h4MW7Uv9VfIRY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710321817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zoQXp63WV+kT3XeOtx18SWMC0mkzA2MlgaXm6NMutHs=;
 b=tAK0BJMtjMcQpAQZIGQ9D18lzGjei4up/10qxh0xa3rHAz9u3EBNnjtM28QeCMV8Dn6S+i
 DPpRuPG0k0sJDYBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710321817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zoQXp63WV+kT3XeOtx18SWMC0mkzA2MlgaXm6NMutHs=;
 b=iEWRPVSG+8K4AAgqCZZmFrCcQp00jVJnb3DTTMLYmwxGpObYeHwGCmbdoln44VOyiZoDCP
 YthU2o9pT8nx4eKImHTW1lS62DfKN80tl69s3DyC1361gAXRvo/6BsTcfejFHJ5KhVc1XM
 hBWX3JVAaPj6V+mu9h4MW7Uv9VfIRY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710321817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zoQXp63WV+kT3XeOtx18SWMC0mkzA2MlgaXm6NMutHs=;
 b=tAK0BJMtjMcQpAQZIGQ9D18lzGjei4up/10qxh0xa3rHAz9u3EBNnjtM28QeCMV8Dn6S+i
 DPpRuPG0k0sJDYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 827D213981;
 Wed, 13 Mar 2024 09:23:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kPPhHJlw8WU2dAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 13 Mar 2024 09:23:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 13 Mar 2024 10:23:30 +0100
Message-Id: <20240313092331.18069-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240313092331.18069-1-andrea.cervesato@suse.de>
References: <20240313092331.18069-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[20.55%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/3] Print prot flag when SAFE_MMAP() fails
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
 include/tst_safe_macros.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 15f914619..63ad46b85 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -304,12 +304,18 @@ static inline void *safe_mmap(const char *file, const int lineno,
                               int prot, int flags, int fd, off_t offset)
 {
 	void *rval;
+	char *prot_buf;
 
 	rval = mmap(addr, length, prot, flags, fd, offset);
 	if (rval == MAP_FAILED) {
+		prot_buf = (char*) safe_malloc(file, lineno, 0, 512);
+		prot_to_str(prot, prot_buf);
+
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			"mmap(%p,%zu,%d,%d,%d,%ld) failed",
-			addr, length, prot, flags, fd, (long) offset);
+			"mmap(%p,%zu,%s(%x),%d,%d,%ld) failed",
+			addr, length, prot_buf, prot, flags, fd, (long) offset);
+
+		free(prot_buf);
 	}
 
 	return rval;
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
