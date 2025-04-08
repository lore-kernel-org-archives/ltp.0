Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E555DC369A2
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 14:10:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 675E93CB3A1
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 16:10:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2790D3CB35F
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 16:10:16 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6BC366008E5
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 16:10:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9848D1F388
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744121415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T6rAptYHCPP+2hvX9oPfxxCMqKQ/Szm2O2ifrulO0qs=;
 b=V3aIN2inWFnBpIQwAyaYaL2jzV+6NabkS1LdGDmo4TGcPr4YTAwhKFI6T7+rA4/fb/5LHw
 6ZMVsvRe3ZYCvLiLy39rBh73QrhXObCW4h9OiC8jlXI7LV0Vr+EoV32yuf4D9/wOUDuvoF
 t9couzrdjY09RaSlpJKXkCPPnfIUl/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744121415;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T6rAptYHCPP+2hvX9oPfxxCMqKQ/Szm2O2ifrulO0qs=;
 b=DVwjiNK2U2ukXfx6H5i2aHTuZ0gtEO+0T2qjV/hWa40ER8ExlJRU+ALsWpGQ+2Tp7E1uWI
 TNKE52dnlQB/xQAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744121415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T6rAptYHCPP+2hvX9oPfxxCMqKQ/Szm2O2ifrulO0qs=;
 b=V3aIN2inWFnBpIQwAyaYaL2jzV+6NabkS1LdGDmo4TGcPr4YTAwhKFI6T7+rA4/fb/5LHw
 6ZMVsvRe3ZYCvLiLy39rBh73QrhXObCW4h9OiC8jlXI7LV0Vr+EoV32yuf4D9/wOUDuvoF
 t9couzrdjY09RaSlpJKXkCPPnfIUl/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744121415;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T6rAptYHCPP+2hvX9oPfxxCMqKQ/Szm2O2ifrulO0qs=;
 b=DVwjiNK2U2ukXfx6H5i2aHTuZ0gtEO+0T2qjV/hWa40ER8ExlJRU+ALsWpGQ+2Tp7E1uWI
 TNKE52dnlQB/xQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83D4C13A1E
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 14:10:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DxbDH0cu9WemQAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 08 Apr 2025 14:10:15 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  8 Apr 2025 16:09:43 +0200
Message-ID: <20250408140944.36020-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: Fix bug in tst_test metadata validation
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

The results pointer is NULL when do_setup() checks tst_test metadata
validity. Print the invalid runtime value from the correct pointer.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_test.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 9a23cd4a0..694861d95 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1267,10 +1267,8 @@ static void do_setup(int argc, char *argv[])
 			tst_test->timeout);
 	}
 
-	if (tst_test->runtime < 0) {
-		tst_brk(TBROK, "Invalid runtime value %i",
-			results->runtime);
-	}
+	if (tst_test->runtime < 0)
+		tst_brk(TBROK, "Invalid runtime value %i", tst_test->runtime);
 
 	if (tst_test->tconf_msg)
 		tst_brk(TCONF, "%s", tst_test->tconf_msg);
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
