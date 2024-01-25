Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263BBC47258
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 10:00:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 881263CE1DA
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 11:00:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7947A3C54BD
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 11:00:13 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6CC1E1A00704
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 11:00:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A7B221EF9;
 Thu, 25 Jan 2024 10:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706176812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NRsGe0ZPp6sMT93cNHXQZFqhLspaPERVqIJH/jhF4Og=;
 b=wCE13XT/ndTj38oERhsOzn9rpYr4zR2nQp7KRMsl8fRcMCJ6ShWUNcfHZFrYrXVu0A/JZL
 bH8E/6QJKCzvXp0Eue8+hAnTPTo0NnQpV1PPe8gsQeIho21sZ6PpeF5dvBZG2K1Jq8AdYp
 gXMinPm340H1VORtn9/ANSVlTiQIo3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706176812;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NRsGe0ZPp6sMT93cNHXQZFqhLspaPERVqIJH/jhF4Og=;
 b=2IprqP/yhocGbDF5tbS+yUyVG8xSm1m7dqBk3O9IRWbjv+9AeiGQ44GrmUKNm6AbyBBmwb
 ginm3fpXSZ0sPVAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706176812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NRsGe0ZPp6sMT93cNHXQZFqhLspaPERVqIJH/jhF4Og=;
 b=wCE13XT/ndTj38oERhsOzn9rpYr4zR2nQp7KRMsl8fRcMCJ6ShWUNcfHZFrYrXVu0A/JZL
 bH8E/6QJKCzvXp0Eue8+hAnTPTo0NnQpV1PPe8gsQeIho21sZ6PpeF5dvBZG2K1Jq8AdYp
 gXMinPm340H1VORtn9/ANSVlTiQIo3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706176812;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NRsGe0ZPp6sMT93cNHXQZFqhLspaPERVqIJH/jhF4Og=;
 b=2IprqP/yhocGbDF5tbS+yUyVG8xSm1m7dqBk3O9IRWbjv+9AeiGQ44GrmUKNm6AbyBBmwb
 ginm3fpXSZ0sPVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F8D513649;
 Thu, 25 Jan 2024 10:00:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qFRRDiwxsmXcXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Jan 2024 10:00:12 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 25 Jan 2024 11:00:08 +0100
Message-ID: <20240125100009.387096-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.71)[83.56%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] fs_fill: Increase timeout to 5 min
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

1 min timeout sometimes is not enough.
Although it could be fixed LTP_RUNTIME_MUL=2, let's prolong the default
timeout.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/fs/fs_fill/fs_fill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index 325e83643..3b4ee1ae9 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -121,7 +121,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.max_runtime = 60,
+	.max_runtime = 300,
 	.needs_root = 1,
 	.dev_min_size = 1024,
 	.mount_device = 1,
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
