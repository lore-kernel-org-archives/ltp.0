Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA31FC5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 16:01:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E5BF3D03B0
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:01:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8FE33CCDB8
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9BB41600290
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 268E43E02;
 Mon, 10 Aug 2026 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUfqc8CukiqC4WalndckWKUPHK4KhkVraiCe8XHKErM=;
 b=p0AckS4t1SjJje5NDOPPb+6znJ/oEykMgWUxbgitO4RjGwMCn8Zpn8V7Hngcpz2zqKwIdF
 SyhxMpsNAfrEoDAJn2kh1Io+YmJWvn+di2FC+TzmxnLuv4x5K3TNIT5r8/ab3kQ3m2Rvty
 QMxOdJsILm01/Wq09ja33IoXKaHI9kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUfqc8CukiqC4WalndckWKUPHK4KhkVraiCe8XHKErM=;
 b=A6W2BDbPM9Cb3TVzRyq75phqWsawIm12S/a09uwvUf4F/V7XoVjpyFjagG9/butiddngHk
 vOdqSNZRW/05gVDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUfqc8CukiqC4WalndckWKUPHK4KhkVraiCe8XHKErM=;
 b=lYXNGTJxUFWoYobhrnqPJTpzNxfJewna9MVw402U2Kq6DPmzw+o4/7fyJL7F/aIGUXcch+
 4rfaGrqfmpk2/zMNyL6fJAIgCHO+byJc+RrrZYGV7dfTnoO0CRBO5cNrfLo/c8ESc49coy
 PEufEnvmyUTKkW/C5hQIMfNqjyqsop0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUfqc8CukiqC4WalndckWKUPHK4KhkVraiCe8XHKErM=;
 b=3UukDByCTOzJ3+XZX7T/+dQ/xOLRe3DQirxp3EojYdR8Flrt/pck7KNGxoLID1zn7hNIII
 GyW6PyqbmWIZpODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0198E779BC;
 Mon, 10 Aug 2026 16:00:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cCvoOrL1eWquLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 16:00:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Aug 2026 18:00:43 +0200
Message-ID: <20260810160048.1040517-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810160048.1040517-1-pvorel@suse.cz>
References: <20260810160048.1040517-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/7] lib: Rename function check_kver() =>
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

This is a preparation for struct tst_test max_kver member in the next
commit.

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v4.

 lib/tst_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index a147521e9d..5e64fb5b63 100644
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
@@ -1457,7 +1457,7 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TCONF, "Test needs to be run as root");
 
 	if (tst_test->min_kver)
-		check_kver(tst_test->min_kver, 1);
+		check_min_kver(tst_test->min_kver, 1);
 
 	if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
 		tst_brk(TCONF, "Kernel is locked down, skipping test");
@@ -1580,7 +1580,7 @@ static void do_setup(int argc, char *argv[])
 				tst_check_cmd(tst_test->filesystems->mkfs_ver, 1);
 
 			if (tst_test->filesystems && tst_test->filesystems->min_kver)
-				check_kver(tst_test->filesystems->min_kver, 1);
+				check_min_kver(tst_test->filesystems->min_kver, 1);
 
 			prepare_device(tst_test->filesystems);
 		}
@@ -1984,7 +1984,7 @@ static void run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
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
