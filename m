Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658D0C54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 09:44:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 071153C5529
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:44:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED8A43C2C13
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:44:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3760E1400326
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:44:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B5ADC21ECD;
 Tue, 27 May 2025 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748339063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SaE10Btk+wPgbdZ7kFLjAI8tIqJNXGei1rCZLom9yQI=;
 b=XetdFlFdhg5jgRiMqWMSLCJybXcP5SKoXEYo8b1Yx0DO7pNkbc+DH6KInNcGyoexdQg3LT
 fiU0fQQocpJUJHe0Yu7y9FPI44kwRcFtekdaEI7NrUYpxg2ygpgpNd0x4CVC5F6wGL+YnV
 5TIpVi7wNkmwABhPnwd4ReqRpLYbxWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748339063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SaE10Btk+wPgbdZ7kFLjAI8tIqJNXGei1rCZLom9yQI=;
 b=6J00ovcryS/u+BqLv7hCEWS/o2o3uaBhNTUREAbShuIkDdIx0qqzXkNOcRzow09oMhYaKD
 I/rQXFJNJyoAqrAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XetdFlFd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6J00ovcr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748339063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SaE10Btk+wPgbdZ7kFLjAI8tIqJNXGei1rCZLom9yQI=;
 b=XetdFlFdhg5jgRiMqWMSLCJybXcP5SKoXEYo8b1Yx0DO7pNkbc+DH6KInNcGyoexdQg3LT
 fiU0fQQocpJUJHe0Yu7y9FPI44kwRcFtekdaEI7NrUYpxg2ygpgpNd0x4CVC5F6wGL+YnV
 5TIpVi7wNkmwABhPnwd4ReqRpLYbxWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748339063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SaE10Btk+wPgbdZ7kFLjAI8tIqJNXGei1rCZLom9yQI=;
 b=6J00ovcryS/u+BqLv7hCEWS/o2o3uaBhNTUREAbShuIkDdIx0qqzXkNOcRzow09oMhYaKD
 I/rQXFJNJyoAqrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DB3B136E0;
 Tue, 27 May 2025 09:44:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gVzqHHeJNWjSXQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 27 May 2025 09:44:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 27 May 2025 11:44:14 +0200
Message-ID: <20250527094415.4760-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B5ADC21ECD
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] kirk: version 2.1
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
 tools/kirk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kirk b/tools/kirk
index 6d419d419..a2d43e302 160000
--- a/tools/kirk
+++ b/tools/kirk
@@ -1 +1 @@
-Subproject commit 6d419d419a416238c785f626212d35d1940a0df0
+Subproject commit a2d43e302171ff62a717ec25eebbc0b6f8a3fe3e
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
