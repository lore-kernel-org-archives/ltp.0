Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3EFC54791
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 11:55:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B473A3CFD1A
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 12:55:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AED03C02E6
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 12:54:55 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D8772209F3B
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 12:54:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5346221C78;
 Wed, 13 Mar 2024 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710330894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2St71oC6AIZECBt9dE5/r5XnR7g2a/JFAbWhs6P94uE=;
 b=DVz+CyS6h+7T7EQsf2XwE1GumSLjiqD9giSN9W2CNQUgyBZQHYGY8fCIl17L1KMw78NN6G
 PB26MOMkTkYKHVfq71J1RkW3dKjtaLT/2lFBs+JEOQAdj2Ft6rvg45ns1Yd/xRiRw7mT3Q
 i70xazoUU7zT2l8RE3d9YgyblshGQD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710330894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2St71oC6AIZECBt9dE5/r5XnR7g2a/JFAbWhs6P94uE=;
 b=8HiZWvVTbO/drqCEV1w1xs/oUlH1wvLi+5OI4dUYA1s7ap/7EWskVIvf5B8sRQ0+SFbNy9
 5DW4s4kyyLis2hDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710330894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2St71oC6AIZECBt9dE5/r5XnR7g2a/JFAbWhs6P94uE=;
 b=DVz+CyS6h+7T7EQsf2XwE1GumSLjiqD9giSN9W2CNQUgyBZQHYGY8fCIl17L1KMw78NN6G
 PB26MOMkTkYKHVfq71J1RkW3dKjtaLT/2lFBs+JEOQAdj2Ft6rvg45ns1Yd/xRiRw7mT3Q
 i70xazoUU7zT2l8RE3d9YgyblshGQD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710330894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2St71oC6AIZECBt9dE5/r5XnR7g2a/JFAbWhs6P94uE=;
 b=8HiZWvVTbO/drqCEV1w1xs/oUlH1wvLi+5OI4dUYA1s7ap/7EWskVIvf5B8sRQ0+SFbNy9
 5DW4s4kyyLis2hDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19AF61397F;
 Wed, 13 Mar 2024 11:54:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QHpHAw6U8WWxKAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 13 Mar 2024 11:54:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 13 Mar 2024 12:54:47 +0100
Message-Id: <20240313115448.7755-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240313115448.7755-1-andrea.cervesato@suse.de>
References: <20240313115448.7755-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DVz+CyS6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8HiZWvVT
X-Spamd-Result: default: False [2.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[43.79%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 5346221C78
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/3] Print prot flag when SAFE_MMAP() fails
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
Add TDEBUG message for safe_mmap as well

 include/tst_safe_macros.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index b17cba753..8821f038a 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -304,12 +304,19 @@ static inline void *safe_mmap(const char *file, const int lineno,
                               int prot, int flags, int fd, off_t offset)
 {
 	void *rval;
+	char prot_buf[512];
+
+	prot_to_str(prot, prot_buf);
+
+	tst_res_(file, lineno, TDEBUG,
+		"mmap(%p, %ld, %s(%x), %d, %d, %ld)",
+		addr, length, prot_buf, prot, flags, fd, offset);
 
 	rval = mmap(addr, length, prot, flags, fd, offset);
 	if (rval == MAP_FAILED) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			"mmap(%p,%zu,%d,%d,%d,%ld) failed",
-			addr, length, prot, flags, fd, (long) offset);
+			"mmap(%p,%zu,%s(%x),%d,%d,%ld) failed",
+			addr, length, prot_buf, prot, flags, fd, (long) offset);
 	}
 
 	return rval;
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
