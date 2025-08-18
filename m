Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BF7CA0EE4
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 14:17:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFD773CC815
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 16:17:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B5103CC791
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 16:16:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B69DC6007A9
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 16:16:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA476210F6
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 14:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755526614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Q6LpPccPEM7IC904Mba14Fwqm8qC8cMHDo6yA1nijVs=;
 b=iLNnD8yI6Ji+N9Ez1yiQ42uVMY/OrXj4jW2Cr5wdfvxaLJ7VuZdx0aGhfnemLapZ7pXcXG
 pX4DVDamBspnfTCIhWk95eBOgd2ZYsBYxgOw+UGuKvmq3aVjxmCVIJ4ocSDXXwJJL1v38k
 yhmXcp4xeV8SbM+6stIYYOJ0ubBzYww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755526614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Q6LpPccPEM7IC904Mba14Fwqm8qC8cMHDo6yA1nijVs=;
 b=vqrGNFM1otpElH7pbiZByjUaA407HzILdd11d6Ojvjj04kpdYtrO7qAVoIFe4BWuzDo8ZY
 fuOg12bBEhdJdWBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755526613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Q6LpPccPEM7IC904Mba14Fwqm8qC8cMHDo6yA1nijVs=;
 b=lh09Sq0HOdI1Q1anRHA7h0OUxq30eMOX8AP9w3uCfSR+/t+vySWypkaTqL3arZ+HN6PDD/
 1ZdFOx575qkuic9wyKXatrUrh3VNDi87foEDyW+hyIdkTgnh8W4+HcOUWOCn3JQgVdrrUh
 e/MQo6FOyhQ0pa9Bhx/gk8AlQUiBRx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755526613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Q6LpPccPEM7IC904Mba14Fwqm8qC8cMHDo6yA1nijVs=;
 b=/QuXo0MPV2irwVCHMXYJN7j7KBIJ1CeGPCyXbl5firMqIoVTnkZJLPnYWC8bwAM9ORBR9K
 Pkk9w8lW45tkZkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE2C113686
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 14:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zW7VNdU1o2ifGAAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 14:16:53 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 18 Aug 2025 16:16:50 +0200
Message-ID: <20250818141653.11720-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] timer_create02: minor typo fix
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/timer_create/timer_create02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/timer_create/timer_create02.c b/testcases/kernel/syscalls/timer_create/timer_create02.c
index 551cf50b9..1fd0dd945 100644
--- a/testcases/kernel/syscalls/timer_create/timer_create02.c
+++ b/testcases/kernel/syscalls/timer_create/timer_create02.c
@@ -65,7 +65,7 @@ static void run(unsigned int n)
 
 	if (TST_RET != -1 || TST_ERR != tc->error) {
 		tst_res(TFAIL | TTERRNO,
-			"%s idn't fail as expected (%s) - Got",
+			"%s did not fail as expected (%s) - Got",
 			tc->desc, tst_strerrno(tc->error));
 		return;
 	}
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
