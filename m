Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ADFCCD1A5
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 08:45:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB4573CF29E
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 10:45:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E109F3CE04F
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 10:45:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58D8160080A
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 10:45:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D448321228;
 Fri, 24 Oct 2025 08:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761295506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oia1nzijyhbWBBlWVi5l7+JpQbBQgdXmPaMKFlYL6cU=;
 b=GYUBvUP9gdU3azqtitImaOoVkpPtbZV18CxDwUdPz4AZqJAydRpmTRNNT0BelpTzLsRgYZ
 qrLhy4H/YYT+IIduhBl+oayFrAKEDkd/xk83BG1cL0IKbKPxt1O6bY/sGuBM4KcYfOL/h0
 VN8SJAQeiqyGfjWBJboEYJXLVGdT6i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761295506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oia1nzijyhbWBBlWVi5l7+JpQbBQgdXmPaMKFlYL6cU=;
 b=mMYoeOw8YuIhj2MILUiLkjSQVDqdWGQvmCtrfvEz1U03Cfu65fGqqPBBc+KEdqRITLoeoO
 pRh84tlWjj1IOlAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761295501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oia1nzijyhbWBBlWVi5l7+JpQbBQgdXmPaMKFlYL6cU=;
 b=sFpywz5VPxpC4AFy+txsHQmO/vIRLXZIWHYgfLtzeVxaPDaq96n8TWLRRjUYrpzUOx8JyH
 tgcZ7ctg3xOKlJFAwhjcEDu6eiAgzzvrv8xNocOjd7qkEGdCDEuvxyAqIa/K6Js2H5Aup1
 LCQ0WY4fWOQ8TXZWY0s0vgQtgoei7oc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761295501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oia1nzijyhbWBBlWVi5l7+JpQbBQgdXmPaMKFlYL6cU=;
 b=r6Lvj4GLQ9/aGUixtsST9reXgwTiE7NIbmsi2OePmB45NmKjXkmf2yA+jXPIwNtIRFwfNq
 d/M9/K+CDddnsRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BA6213693;
 Fri, 24 Oct 2025 08:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6eXiI408+2iFZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Oct 2025 08:45:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 24 Oct 2025 10:44:56 +0200
Message-ID: <20251024084456.581607-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] kirk: Update to v3.0
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

https://github.com/linux-test-project/kirk/releases/tag/v3.0

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/kirk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kirk b/tools/kirk
index 2b5d0be7f0..e0ef9f28bc 160000
--- a/tools/kirk
+++ b/tools/kirk
@@ -1 +1 @@
-Subproject commit 2b5d0be7f0cddfc05d9c606656219c7a0326512c
+Subproject commit e0ef9f28bcf15d00cf8a03915df894bb38a5d8ea
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
