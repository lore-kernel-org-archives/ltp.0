Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03A5C83029
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 15:31:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E335C3C5EA3
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 17:31:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6578F3C0433
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 17:31:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 95B091000C2F
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 17:31:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A8DA1F393;
 Mon, 30 Jun 2025 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751297484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+9dPy9XHcLuIPkyfKBe8Bl0TaTyTTai0fv5zBMQC34=;
 b=rtgcCeiC6dTQmQhqm9UGnPYLBUIRpExT9ICnr6KyRO6wMW9KkrX12ECeEAmjxL4vX/r6g7
 lAuLiLMfW3b2PW3WwMb75iz4LmHVlJubomwOvvceo5bk49rxCpDFE4ymnSeixL9RiBScN1
 xjIXfR0ToCC1pxWcTAj9i5fjRIwwGyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751297484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+9dPy9XHcLuIPkyfKBe8Bl0TaTyTTai0fv5zBMQC34=;
 b=rtNPfgZ73XhLX6oe2/MhI7688/ddIKxt0aRZ9ulhxwu5TXc24hqCBCrBRoXnMoZeQ45q/N
 1cpwoc/X0nYAEaBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751297484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+9dPy9XHcLuIPkyfKBe8Bl0TaTyTTai0fv5zBMQC34=;
 b=rtgcCeiC6dTQmQhqm9UGnPYLBUIRpExT9ICnr6KyRO6wMW9KkrX12ECeEAmjxL4vX/r6g7
 lAuLiLMfW3b2PW3WwMb75iz4LmHVlJubomwOvvceo5bk49rxCpDFE4ymnSeixL9RiBScN1
 xjIXfR0ToCC1pxWcTAj9i5fjRIwwGyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751297484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+9dPy9XHcLuIPkyfKBe8Bl0TaTyTTai0fv5zBMQC34=;
 b=rtNPfgZ73XhLX6oe2/MhI7688/ddIKxt0aRZ9ulhxwu5TXc24hqCBCrBRoXnMoZeQ45q/N
 1cpwoc/X0nYAEaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BB6613A24;
 Mon, 30 Jun 2025 15:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 47rDHMytYmj6BQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 30 Jun 2025 15:31:24 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 30 Jun 2025 17:32:05 +0200
Message-ID: <20250630153205.19017-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630153205.19017-1-chrubis@suse.cz>
References: <20250630153205.19017-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/statmount06: Fix and enable the test on
 FUSE
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

Reported-by: Jan Polensky <japo@linux.ibm.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/statmount/statmount06.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/statmount/statmount06.c b/testcases/kernel/syscalls/statmount/statmount06.c
index fe41d5b87..89717a3fb 100644
--- a/testcases/kernel/syscalls/statmount/statmount06.c
+++ b/testcases/kernel/syscalls/statmount/statmount06.c
@@ -36,8 +36,10 @@ static void run(void)
 	if (!TST_PASS)
 		return;
 
+	const char *fs_type = tst_device->is_fuse ? "fuseblk" : tst_device->fs_type;
+
 	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_FS_TYPE);
-	TST_EXP_EQ_STR(st_mount->str + st_mount->fs_type, tst_device->fs_type);
+	TST_EXP_EQ_STR(st_mount->str + st_mount->fs_type, fs_type);
 }
 
 static void setup(void)
@@ -55,10 +57,6 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.skip_filesystems = (const char *const []) {
-		"fuse",
-		NULL
-	},
 	.bufs = (struct tst_buffers []) {
 		{&st_mount, .size = SM_SIZE},
 		{}
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
