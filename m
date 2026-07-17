Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E33C44507
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 06:29:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 745C83E24DE
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 08:29:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A6E53C018D
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 08:29:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 328062000A0
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 08:29:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D8D578D5F;
 Fri, 17 Jul 2026 06:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784269741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uIhel6fAYeJb/dqeNW5aEFsy9GA+7txZmkw9q6BmGlM=;
 b=RpuyL04IMvH9+7Q9pzJOTx/0E5VplP/BTuwsNhcBcUHcPv46FdG2Gi+PHWQCKav21Z5+XA
 dFqhDLR/GDunQmwJm/dAbyWJrrnWxsDu2CSbZVT8nenrczKYQxk28th0SNr3BemdFroNVW
 M6OzH0np0m7As+LGf5xuloXh/QJNHEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784269741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uIhel6fAYeJb/dqeNW5aEFsy9GA+7txZmkw9q6BmGlM=;
 b=IyrWdmdb5iw9hyt0HYIoPyiRi7YwC+yG/Xr5bMeffYiEM6ehOoVyKs3EdPjOLOW03gY5/k
 1UYgB8dztU2z8jBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784269741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uIhel6fAYeJb/dqeNW5aEFsy9GA+7txZmkw9q6BmGlM=;
 b=RpuyL04IMvH9+7Q9pzJOTx/0E5VplP/BTuwsNhcBcUHcPv46FdG2Gi+PHWQCKav21Z5+XA
 dFqhDLR/GDunQmwJm/dAbyWJrrnWxsDu2CSbZVT8nenrczKYQxk28th0SNr3BemdFroNVW
 M6OzH0np0m7As+LGf5xuloXh/QJNHEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784269741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uIhel6fAYeJb/dqeNW5aEFsy9GA+7txZmkw9q6BmGlM=;
 b=IyrWdmdb5iw9hyt0HYIoPyiRi7YwC+yG/Xr5bMeffYiEM6ehOoVyKs3EdPjOLOW03gY5/k
 1UYgB8dztU2z8jBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76FC8779AA;
 Fri, 17 Jul 2026 06:29:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 970rGq3LWWrMSgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 17 Jul 2026 06:29:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 17 Jul 2026 08:29:00 +0200
MIME-Version: 1.0
Message-Id: <20260717-fix_tst_test_hugepages-v1-1-a63bf2ccdd17@suse.com>
X-B4-Tracking: v=1; b=H4sIAKvLWWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Nz3bTMiviS4pL4klQgkVGanlqQmJ5arJuWZJxsYZFqaW5olqwE1Fx
 QlApUCTY4Ora2FgAq3lkQaAAAAA==
X-Change-ID: 20260717-fix_tst_test_hugepages-fb3c88e9716c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784269741; l=1283;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=4TyY4DTpuTqSzSluL+8LQs4iHhrBnwoxBWJKtaWCMAM=;
 b=zZFWJHD67DpUoub006yGhWZA+AMO86eZbrWRULTIttrJPH4cC9FiGfhvmSaLfhPIguhy5VZKk
 fjGv4wIfbBUCYaH9dVFVCWDfT+IQyeH9xhOqqCTEnA9OznoJo9YD/CU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugepages: ensure CONFIG_COMPACTION is defined
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

Add check to ensure CONFIG_COMPACTION=y when we need to use hugepages
inside tests. The kernel configuration is used to enable usage of
`/proc/sys/vm/compact_memory` inside the LTP core library.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
The issue was raised by https://github.com/linux-test-project/ltp/pull/1335
that is trying to solve a problem with cachestat03.
---
 lib/tst_hugepage.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index 40ecfa162a236a8674628f8ffe7a8fd2ccd52712..8fba466b0ebb04d43542d686d6bb9173f1a14cb8 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -46,6 +46,11 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
 		goto set_hugepages;
 	}
 
+	if (access(PATH_VM_COMPACT_MEMORY, F_OK)) {
+		if (hp->policy == TST_NEEDS || hp->policy == TST_REQUEST)
+			tst_brk(TCONF, "CONFIG_COMPACTION not enabled in kernel");
+	}
+
 	SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "3");
 	SAFE_FILE_PRINTF(PATH_VM_COMPACT_MEMORY, "1");
 	if (hp->policy == TST_NEEDS) {

---
base-commit: d6fe8d8e7a58c83b6a192fb27cd2ecf5249182f7
change-id: 20260717-fix_tst_test_hugepages-fb3c88e9716c

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
