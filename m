Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6351FD37E33
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 13:36:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEBA93C9BE5
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 14:36:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FA573C9A42
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 14:35:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A03D9600A46
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 14:35:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05ED133BAA;
 Wed, 14 Jan 2026 13:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768397753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FL2SKWGNVqDpBSubXzDdLd5SKAq6b76Q/9Clha6i3Ew=;
 b=a3bRNDvNnR5imyxQUoAnJyUXnKxuTdoOuWuUnZAtA221Uy4Hu33z1LUUVZyleHL2CnYGFz
 ZAXmHOsDePlM9zV3Z9geE+NMmhyQMzayUGhAKYrQk975xpHAmZozQ+TY32a9wJp9AJV/Ox
 1pwqhhzYruAD97YajWZgeVVyUpJiGA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768397753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FL2SKWGNVqDpBSubXzDdLd5SKAq6b76Q/9Clha6i3Ew=;
 b=9UH47Lft7lGVHRmL+VDCEIcbYeHX/nA56Zt5OJDWfeXuAIJxmvttf0PiZivbjRt0nvj0TR
 hbQum3OYNs72X5AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a3bRNDvN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9UH47Lft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768397753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FL2SKWGNVqDpBSubXzDdLd5SKAq6b76Q/9Clha6i3Ew=;
 b=a3bRNDvNnR5imyxQUoAnJyUXnKxuTdoOuWuUnZAtA221Uy4Hu33z1LUUVZyleHL2CnYGFz
 ZAXmHOsDePlM9zV3Z9geE+NMmhyQMzayUGhAKYrQk975xpHAmZozQ+TY32a9wJp9AJV/Ox
 1pwqhhzYruAD97YajWZgeVVyUpJiGA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768397753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FL2SKWGNVqDpBSubXzDdLd5SKAq6b76Q/9Clha6i3Ew=;
 b=9UH47Lft7lGVHRmL+VDCEIcbYeHX/nA56Zt5OJDWfeXuAIJxmvttf0PiZivbjRt0nvj0TR
 hbQum3OYNs72X5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FD4C3EA63;
 Wed, 14 Jan 2026 13:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1jDbDribZ2nzFAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 14 Jan 2026 13:35:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 14 Jan 2026 14:35:48 +0100
Message-ID: <20260114133548.411077-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 05ED133BAA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] kirk: Update to v3.2
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

https://github.com/linux-test-project/kirk/releases/tag/v3.2
* Framework is no longer a plugin by @acerv in #86
* sut: add --optimize-sut option by @acerv in #87
* stabilized tests execution for CI

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/kirk/kirk-src | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kirk/kirk-src b/tools/kirk/kirk-src
index 526f81d43e..2eff923cb5 160000
--- a/tools/kirk/kirk-src
+++ b/tools/kirk/kirk-src
@@ -1 +1 @@
-Subproject commit 526f81d43e711b8a2f1ccc7a89e82b96fe090e96
+Subproject commit 2eff923cb5dd97184c21ae47bd9778eab3f184e8
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
