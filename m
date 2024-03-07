Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65E8C5475B
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 07:26:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 228DB3CE97D
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 08:26:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B7EE3C3320
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 08:26:43 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A1335200C03
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 08:26:42 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3E4434ADC;
 Thu,  7 Mar 2024 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709853921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=K1P+PGwrzLSbVLBlKeqC1QOoCQH5fFT5YaH5Qb66gn0=;
 b=pUQUqUfrFEQMpsDJrWdnT0Ka+qkNCharZLDK/deAM9FB6j0K39xbMxItw6z7HmL718BWmG
 sRJE3LPiK3iC7dI/An67eIy9HZ/L7qgBD96BLNQOPzqKaqx2E8crvTg3Adx3qR+iGg1SMX
 op3Nyv8SjRZqU2a3CWMUP9HiOvh3J4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709853921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=K1P+PGwrzLSbVLBlKeqC1QOoCQH5fFT5YaH5Qb66gn0=;
 b=yflWLAkN/rckQFQcG+wbFHeEnkItojKCv995NN+l6ZbYagkBkSveQzBeD/r9wex0rfo1++
 xQzVNEIJ8EEVcRDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709853921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=K1P+PGwrzLSbVLBlKeqC1QOoCQH5fFT5YaH5Qb66gn0=;
 b=pUQUqUfrFEQMpsDJrWdnT0Ka+qkNCharZLDK/deAM9FB6j0K39xbMxItw6z7HmL718BWmG
 sRJE3LPiK3iC7dI/An67eIy9HZ/L7qgBD96BLNQOPzqKaqx2E8crvTg3Adx3qR+iGg1SMX
 op3Nyv8SjRZqU2a3CWMUP9HiOvh3J4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709853921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=K1P+PGwrzLSbVLBlKeqC1QOoCQH5fFT5YaH5Qb66gn0=;
 b=yflWLAkN/rckQFQcG+wbFHeEnkItojKCv995NN+l6ZbYagkBkSveQzBeD/r9wex0rfo1++
 xQzVNEIJ8EEVcRDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BAC6413997;
 Thu,  7 Mar 2024 23:25:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 7YoOLOBM6mWrSQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Mar 2024 23:25:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  8 Mar 2024 00:25:10 +0100
Message-ID: <20240307232511.228396-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pUQUqUfr;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yflWLAkN
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[26.64%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: F3E4434ADC
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] doc/C-Test-API: Mention umask(0) in the library
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

Update after 50626b4a1.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/C-Test-API.asciidoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
index 08a76c403..90cf1df43 100644
--- a/doc/C-Test-API.asciidoc
+++ b/doc/C-Test-API.asciidoc
@@ -2462,6 +2462,9 @@ settings which may clear some of the bits. If your test depends on specific
 file permissions you need either to change umask to 0 or 'chmod()' the file
 afterwards or use 'SAFE_TOUCH()' that does the 'chmod()' for you.
 
+NOTE: Temporarily clearing umask with 'umask(0)' is done before creating a new
+      subdir in the cgroup in 'cgroup_dir_mk()'.
+
 2.2 access()
 ~~~~~~~~~~~~
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
