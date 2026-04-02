Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D375D39418
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:18:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F7673E0E6E
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:18:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11B783E2F3D
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 891E91A01123
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4AAA25BDB1
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JW2fKFhnR2hJcnyPHR7aV1HhaQWC9+57y6OGn6CcFso=;
 b=O3liel5MEQp0gVloL9Z8MJNKnM0qon/ldCCZRNBOVlvZyoWfABaa7eSf9fIoW2CxukUqjZ
 LAXBWZs8+rYPwFKls8Fvzc37EDo4cZ8xJGnnKOQBZaXpU4JLOGxVVJGtkSW+SGq+34sBX1
 uF0TxuYPRdPf/Hwd2rtyqZ9GRz3ehGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JW2fKFhnR2hJcnyPHR7aV1HhaQWC9+57y6OGn6CcFso=;
 b=fKgIrBRMp9cze1S8tRrNIacPiojNT9hWqU8F25ebjX8Ziko+AHEVNVPxrUjWNuM5SPIv5B
 q5jvbnzaRkDHlFBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JW2fKFhnR2hJcnyPHR7aV1HhaQWC9+57y6OGn6CcFso=;
 b=O3liel5MEQp0gVloL9Z8MJNKnM0qon/ldCCZRNBOVlvZyoWfABaa7eSf9fIoW2CxukUqjZ
 LAXBWZs8+rYPwFKls8Fvzc37EDo4cZ8xJGnnKOQBZaXpU4JLOGxVVJGtkSW+SGq+34sBX1
 uF0TxuYPRdPf/Hwd2rtyqZ9GRz3ehGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JW2fKFhnR2hJcnyPHR7aV1HhaQWC9+57y6OGn6CcFso=;
 b=fKgIrBRMp9cze1S8tRrNIacPiojNT9hWqU8F25ebjX8Ziko+AHEVNVPxrUjWNuM5SPIv5B
 q5jvbnzaRkDHlFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 325A54A0B0
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ddgqC5ldzmnbDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:14:17 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:52 +0200
Message-ID: <20260402121356.31266-14-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402121356.31266-1-chrubis@suse.cz>
References: <20260402121356.31266-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 13/17] tests: can: Switch from needs_drivers to
 needs_kconfigs
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/network/can/cve/can_bcm01.c                 | 6 +++---
 testcases/network/can/filter-tests/can_filter.c       | 6 +++---
 testcases/network/can/filter-tests/can_rcv_own_msgs.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/network/can/cve/can_bcm01.c b/testcases/network/can/cve/can_bcm01.c
index 57ec4989f..3b66037e7 100644
--- a/testcases/network/can/cve/can_bcm01.c
+++ b/testcases/network/can/cve/can_bcm01.c
@@ -140,9 +140,9 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.skip_in_compat = 1,
 	.min_runtime = 30,
-	.needs_drivers = (const char *const[]) {
-		"vcan",
-		"can-bcm",
+	.needs_kconfigs = (const char *const[]) {
+		"CONFIG_CAN_VCAN",
+		"CONFIG_CAN_BCM",
 		NULL
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/network/can/filter-tests/can_filter.c b/testcases/network/can/filter-tests/can_filter.c
index 1ea8ea18f..8b4f2fc05 100644
--- a/testcases/network/can/filter-tests/can_filter.c
+++ b/testcases/network/can/filter-tests/can_filter.c
@@ -183,9 +183,9 @@ static struct tst_test test = {
 		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
 		{}
 	},
-	.needs_drivers = (const char *const[]) {
-		"vcan",
-		"can-raw",
+	.needs_kconfigs = (const char *const[]) {
+		"CONFIG_CAN_VCAN",
+		"CONFIG_CAN_RAW",
 		NULL
 	}
 };
diff --git a/testcases/network/can/filter-tests/can_rcv_own_msgs.c b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
index ba40666dc..2c0acecf9 100644
--- a/testcases/network/can/filter-tests/can_rcv_own_msgs.c
+++ b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
@@ -145,9 +145,9 @@ static struct tst_test test = {
 		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
 		{}
 	},
-	.needs_drivers = (const char *const[]) {
-		"vcan",
-		"can-raw",
+	.needs_kconfigs = (const char *const[]) {
+		"CONFIG_CAN_VCAN",
+		"CONFIG_CAN_RAW",
 		NULL
 	}
 };
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
