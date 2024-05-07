Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD73C10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 15:52:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D58243CDC06
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 17:52:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5A1F3C81B3
 for <ltp@lists.linux.it>; Tue,  7 May 2024 17:52:32 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4A6E51400BE4
 for <ltp@lists.linux.it>; Tue,  7 May 2024 17:52:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2ECC620C8A
 for <ltp@lists.linux.it>; Tue,  7 May 2024 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715097151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=szdw2/Dvfj0fOMtPq+5g8ynlf/5LE8zpUXfYkUzr8oY=;
 b=i1H+61PCfrmhFfDlkaNJoaEZjZ18eK4XW2mbLHsm67c31IH6ZBCYUMtYkFuaE9AihWNZ+l
 pqX0mXqQOOE1cL6ysz6Pwh+uJx21mmc+uUdc3nmF5tOxlbuHCNosNLDRrCndpU9sQUzYPv
 mKoovWdKEAIC35jYGNZnFdvSvR5CMn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715097151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=szdw2/Dvfj0fOMtPq+5g8ynlf/5LE8zpUXfYkUzr8oY=;
 b=ZvBxLo2lYuRAhQFPBeDjXPUXJnQ07vJKo4twRT6YzNUD+emheduBzRcKzYTju7aI753d0D
 kaOMhplOBCALbMBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i1H+61PC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZvBxLo2l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715097151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=szdw2/Dvfj0fOMtPq+5g8ynlf/5LE8zpUXfYkUzr8oY=;
 b=i1H+61PCfrmhFfDlkaNJoaEZjZ18eK4XW2mbLHsm67c31IH6ZBCYUMtYkFuaE9AihWNZ+l
 pqX0mXqQOOE1cL6ysz6Pwh+uJx21mmc+uUdc3nmF5tOxlbuHCNosNLDRrCndpU9sQUzYPv
 mKoovWdKEAIC35jYGNZnFdvSvR5CMn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715097151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=szdw2/Dvfj0fOMtPq+5g8ynlf/5LE8zpUXfYkUzr8oY=;
 b=ZvBxLo2lYuRAhQFPBeDjXPUXJnQ07vJKo4twRT6YzNUD+emheduBzRcKzYTju7aI753d0D
 kaOMhplOBCALbMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A82C13A2D
 for <ltp@lists.linux.it>; Tue,  7 May 2024 15:52:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MXgNBj9OOmZeXAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 07 May 2024 15:52:31 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  7 May 2024 17:52:23 +0200
Message-ID: <20240507155225.14126-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.00 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2ECC620C8A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] safe_mmap(): Fix compiler warning in tst_res() format
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

The length variable has type size_t so the appropriate format is %zu.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_safe_macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index f228b99e1..8de8ef106 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -281,7 +281,7 @@ static inline void *safe_mmap(const char *file, const int lineno,
 	tst_prot_to_str(prot, prot_buf);
 
 	tst_res_(file, lineno, TDEBUG,
-		"mmap(%p, %ld, %s(%x), %d, %d, %ld)",
+		"mmap(%p, %zu, %s(%x), %d, %d, %ld)",
 		addr, length, prot_buf, prot, flags, fd, offset);
 
 	rval = mmap(addr, length, prot, flags, fd, offset);
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
