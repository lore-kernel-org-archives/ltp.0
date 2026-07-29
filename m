Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA6DC54F51
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 09:58:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B53E3E4AF0
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 11:58:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53E613E4CE7
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:58:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D846814001EC
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:58:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 28A837CA1A;
 Wed, 29 Jul 2026 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785319076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aPtg00JrhK8/Vjr07JBzV5f5YI3DGgx5eDU7hyyKK/k=;
 b=CFj1a7sYYoh5KtjZbsgsF435q2quJ3gwe9bQ0V5YZZqf9kN7SQ0LlSZWAHf2wDH5LeL5KK
 lKuFIaoI2eyRSf+8OW5+labcSNqUyykIAAJLodwZlsEWEcUMAlUxSXr+PgVkU0yzDaX3EE
 g/EOdqdv3ChMhdSr4LobzFoIjYtgbYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785319076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aPtg00JrhK8/Vjr07JBzV5f5YI3DGgx5eDU7hyyKK/k=;
 b=UanVFGhf3XgFwabh+3q8RqiHP1bB89fX88PHTrEeJhQDNYgCTUUAp8qZkyNmB6zSAdAh7v
 PRxrCTkeTCabgYAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785319072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aPtg00JrhK8/Vjr07JBzV5f5YI3DGgx5eDU7hyyKK/k=;
 b=GYxeXlSFOpYqMWif4HeohyXt9sPJh3Qz5IOpXyszcDAfylhKoILslmGMpR4pdT+6ASdg99
 ikFuPEoIhr9P9uTu4zOQKgBDF6ePEVzPoiGe9HsX2LOofAMeFNMhYZJ5Y2LrF+cqFCeD60
 A0cJTb5fMbTkskVqxM9y+ngZaHcA3YM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785319072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aPtg00JrhK8/Vjr07JBzV5f5YI3DGgx5eDU7hyyKK/k=;
 b=id81MhlztjPnYBKvGNkZhCtZMk15WWS+2ELjrSIgRtlQnzXTO9v8lfJSf3m/Lpadc9e5TT
 PVDEwYFKo8ceyTAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F18B4779A1;
 Wed, 29 Jul 2026 09:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EOaTOZ/OaWrTJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Jul 2026 09:57:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 11:57:26 +0200
Message-ID: <20260729095730.29185-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729095730.29185-1-pvorel@suse.cz>
References: <20260729095730.29185-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/5] lib: Rename function check_kver() =>
 check_min_kver()
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

Preparation for a next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as v1.

 lib/tst_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 5c3607016e..778a1fed40 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1058,11 +1058,11 @@ static void do_exit(int ret)
 }
 
 /*
- * Check for the required kernel version.
+ * Check for the minimal required kernel version.
  *
  * return: true if the kernel version is high enough, false otherwise.
  */
-static bool check_kver(const char *min_kver, const int brk_nosupp)
+static bool check_min_kver(const char *min_kver, const int brk_nosupp)
 {
 	char *msg;
 	int v1, v2, v3;
@@ -1461,7 +1461,7 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TCONF, "Test needs to be run as root");
 
 	if (tst_test->min_kver)
-		check_kver(tst_test->min_kver, 1);
+		check_min_kver(tst_test->min_kver, 1);
 
 	if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
 		tst_brk(TCONF, "Kernel is locked down, skipping test");
@@ -1584,7 +1584,7 @@ static void do_setup(int argc, char *argv[])
 				tst_check_cmd(tst_test->filesystems->mkfs_ver, 1);
 
 			if (tst_test->filesystems && tst_test->filesystems->min_kver)
-				check_kver(tst_test->filesystems->min_kver, 1);
+				check_min_kver(tst_test->filesystems->min_kver, 1);
 
 			prepare_device(tst_test->filesystems);
 		}
@@ -1988,7 +1988,7 @@ static void run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
 	if (fs->mkfs_ver && !tst_check_cmd(fs->mkfs_ver, 0))
 		return;
 
-	if (fs->min_kver && !check_kver(fs->min_kver, 0))
+	if (fs->min_kver && !check_min_kver(fs->min_kver, 0))
 		return;
 
 	prepare_device(fs);
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
