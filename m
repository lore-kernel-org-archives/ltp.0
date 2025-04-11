Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408A1C36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 13:30:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB4043CB5CA
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 15:30:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2DCF3CB585
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 15:30:06 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1F29F1400275
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 15:30:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D7A41F457;
 Fri, 11 Apr 2025 13:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744378204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3pRu45m0ccJJ3Gqblw3QdXR7HKte7CCQ1aBuHkjJi74=;
 b=K35hSfYhdB1RKnzA4fCez+0wd1swrmJTBd+1mZP30yPzXj5rJCGfTdKquNYqZJELrTeGWV
 hqQLu3kblTspkjakK//w7krF4Tprj6d7SrajwQxSecp2sSldtqciwXnT37A1qfPsX2BZ0E
 4uwgcma4X4YZK8DpKNPz3IBV9X84LfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744378204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3pRu45m0ccJJ3Gqblw3QdXR7HKte7CCQ1aBuHkjJi74=;
 b=RFEQSa7xirAld24vXotdXXg8XNW86J6DqWWj11vNfNlL0dhVQ7G/p0n4CZkUKzRfAyG9jL
 XkXhFmLfw4zUayCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744378204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3pRu45m0ccJJ3Gqblw3QdXR7HKte7CCQ1aBuHkjJi74=;
 b=K35hSfYhdB1RKnzA4fCez+0wd1swrmJTBd+1mZP30yPzXj5rJCGfTdKquNYqZJELrTeGWV
 hqQLu3kblTspkjakK//w7krF4Tprj6d7SrajwQxSecp2sSldtqciwXnT37A1qfPsX2BZ0E
 4uwgcma4X4YZK8DpKNPz3IBV9X84LfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744378204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3pRu45m0ccJJ3Gqblw3QdXR7HKte7CCQ1aBuHkjJi74=;
 b=RFEQSa7xirAld24vXotdXXg8XNW86J6DqWWj11vNfNlL0dhVQ7G/p0n4CZkUKzRfAyG9jL
 XkXhFmLfw4zUayCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE6A113886;
 Fri, 11 Apr 2025 13:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xGxoM1sZ+WfJdgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Apr 2025 13:30:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Apr 2025 15:29:55 +0200
Message-ID: <20250411132955.330226-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] fanotify2[23]: Fix TCONF on TMPDIR on btrfs
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

Fanotify support needs to be detected on the filesystem where it's
actually used (e.g. MOUNT_PATH). This way invalid TCONF is fixed:

fanotify22.c:296: TCONF: FAN_FS_ERROR not supported on ext4 filesystem
fanotify23.c:233: TCONF: FAN_ATTRIB not supported on ext2 filesystem

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Amir,

thanks for a hint!

Kind regards,
Petr

 testcases/kernel/syscalls/fanotify/fanotify22.c | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify23.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 2fbb6fa404..20c7a6aca2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -295,7 +295,7 @@ static void setup(void)
 {
 	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 						FAN_MARK_FILESYSTEM,
-						FAN_FS_ERROR, ".");
+						FAN_FS_ERROR, MOUNT_PATH);
 	pre_corrupt_fs();
 
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify23.c b/testcases/kernel/syscalls/fanotify/fanotify23.c
index 896a8a850a..26c9e87fbd 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify23.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify23.c
@@ -229,10 +229,10 @@ static void setup(void)
 {
 	SAFE_TOUCH(TEST_FILE, 0666, NULL);
 
-	REQUIRE_MARK_TYPE_SUPPORTED_ON_FS(FAN_MARK_EVICTABLE, ".");
+	REQUIRE_MARK_TYPE_SUPPORTED_ON_FS(FAN_MARK_EVICTABLE, MOUNT_PATH);
 	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 						FAN_MARK_FILESYSTEM,
-						FAN_ATTRIB, ".");
+						FAN_ATTRIB, MOUNT_PATH);
 
 	SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressure);
 	/* Set high priority for evicting inodes */
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
