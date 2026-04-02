Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E504D39418
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:17:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE8A53E1E7F
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:17:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E690D3E2F3C
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8CAE61A00F14
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 751AB5BDBC
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPxfYHmsPPT1lbiX27dZ8a+cbLdVv6q09xxmrLKhVLs=;
 b=YvavjTuM72BKdxhjxajdBlbJyFmoV940tbuZbutZ9E5uMYdP2apsCKDpd12TQQfegDYobt
 AIfKt2rr5YEPruIUg9ajZ3Pyw6wJaKkXciYepwXUC9+o1/qEwkd7CjHwWKgt3loDYIbYso
 UQxqxUpt3pEiDimM5N1DfV2V9bJFXu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPxfYHmsPPT1lbiX27dZ8a+cbLdVv6q09xxmrLKhVLs=;
 b=02XU4it/tuV4cjpmXY9L0EBiIJ/IhA3TueYGlFuE6MNlErT5bzheorTltg5bb4QZ+7j5i1
 S4gGIVue7saoXtDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPxfYHmsPPT1lbiX27dZ8a+cbLdVv6q09xxmrLKhVLs=;
 b=YvavjTuM72BKdxhjxajdBlbJyFmoV940tbuZbutZ9E5uMYdP2apsCKDpd12TQQfegDYobt
 AIfKt2rr5YEPruIUg9ajZ3Pyw6wJaKkXciYepwXUC9+o1/qEwkd7CjHwWKgt3loDYIbYso
 UQxqxUpt3pEiDimM5N1DfV2V9bJFXu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPxfYHmsPPT1lbiX27dZ8a+cbLdVv6q09xxmrLKhVLs=;
 b=02XU4it/tuV4cjpmXY9L0EBiIJ/IhA3TueYGlFuE6MNlErT5bzheorTltg5bb4QZ+7j5i1
 S4gGIVue7saoXtDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F4234A0B4
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SlfAFpRdzmnJDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:14:12 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:50 +0200
Message-ID: <20260402121356.31266-12-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 11/17] tests: uevent: Switch from needs_drivers to
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
 testcases/kernel/uevents/uevent01.c | 4 ++--
 testcases/kernel/uevents/uevent02.c | 4 ++--
 testcases/kernel/uevents/uevent03.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/uevents/uevent01.c b/testcases/kernel/uevents/uevent01.c
index 09ef42412..f5fe099d8 100644
--- a/testcases/kernel/uevents/uevent01.c
+++ b/testcases/kernel/uevents/uevent01.c
@@ -90,8 +90,8 @@ static struct tst_test test = {
 	.test_all = verify_uevent,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
-	.needs_drivers = (const char *const []) {
-		"loop",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_BLK_DEV_LOOP",
 		NULL
 	},
 	.needs_root = 1
diff --git a/testcases/kernel/uevents/uevent02.c b/testcases/kernel/uevents/uevent02.c
index abae4f88e..1135f55a8 100644
--- a/testcases/kernel/uevents/uevent02.c
+++ b/testcases/kernel/uevents/uevent02.c
@@ -148,8 +148,8 @@ static struct tst_test test = {
 	.test_all = verify_uevent,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
-	.needs_drivers = (const char *const []) {
-		"tun",
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_TUN",
 		NULL
 	},
 	.needs_root = 1
diff --git a/testcases/kernel/uevents/uevent03.c b/testcases/kernel/uevents/uevent03.c
index 23866460b..42d629a4a 100644
--- a/testcases/kernel/uevents/uevent03.c
+++ b/testcases/kernel/uevents/uevent03.c
@@ -239,8 +239,8 @@ static struct tst_test test = {
 	.test_all = verify_uevent,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
-	.needs_drivers = (const char *const[]) {
-		"uinput",
+	.needs_kconfigs = (const char *const[]) {
+		"CONFIG_INPUT_UINPUT",
 		NULL
 	},
 	.needs_root = 1,
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
