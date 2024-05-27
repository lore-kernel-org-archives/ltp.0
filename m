Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1278C25B78
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 20:29:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 519D23D03F9
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 22:29:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D0303D0387
 for <ltp@lists.linux.it>; Mon, 27 May 2024 22:29:04 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9D5A11A00692
 for <ltp@lists.linux.it>; Mon, 27 May 2024 22:29:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 317C622180;
 Mon, 27 May 2024 20:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716841742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YtUgyzEK44RETr/VdA2nK1ph1FKYbPLna62Lpt0UUb4=;
 b=hACdjZara8QVq98aGRS1InUQ4Ybvf6pp0kHiOeM1/rrkkP7kuj4PPyxp1JnQS9qu6ZdNfF
 09Z4a786sH7YRtCngTHUysmeQ5ggi0X49CuGavco6oYVgx5dJ2+0o6+2ImTmSQNnAidQcr
 a9kF9z+6i/A/eyAAgsK9rhOwqO6CvPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716841742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YtUgyzEK44RETr/VdA2nK1ph1FKYbPLna62Lpt0UUb4=;
 b=McsOtF/aydiZg6xlsYgnLp+AIk4IV1uUfnPRU2E/KTnsVLlTx9702SCqkUiMOJr2xKUd+h
 +6D/4VHy5UlbHhBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716841742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YtUgyzEK44RETr/VdA2nK1ph1FKYbPLna62Lpt0UUb4=;
 b=hACdjZara8QVq98aGRS1InUQ4Ybvf6pp0kHiOeM1/rrkkP7kuj4PPyxp1JnQS9qu6ZdNfF
 09Z4a786sH7YRtCngTHUysmeQ5ggi0X49CuGavco6oYVgx5dJ2+0o6+2ImTmSQNnAidQcr
 a9kF9z+6i/A/eyAAgsK9rhOwqO6CvPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716841742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YtUgyzEK44RETr/VdA2nK1ph1FKYbPLna62Lpt0UUb4=;
 b=McsOtF/aydiZg6xlsYgnLp+AIk4IV1uUfnPRU2E/KTnsVLlTx9702SCqkUiMOJr2xKUd+h
 +6D/4VHy5UlbHhBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F30AF13A6B;
 Mon, 27 May 2024 20:29:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I5LsOA3tVGYUZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 20:29:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 May 2024 22:28:57 +0200
Message-ID: <20240527202858.350200-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_device: Print info about acquiring device
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

Print how much space is being acquired. Also print hint on ENOSPC.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index d659b54cf..635b39d08 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -289,8 +289,10 @@ const char *tst_acquire_loop_device(unsigned int size, const char *filename)
 {
 	unsigned int acq_dev_size = size ? size : DEV_SIZE_MB;
 
+	tst_resm(TINFO, "Acquiring loop device %u MB", acq_dev_size);
 	if (tst_prealloc_file(filename, 1024 * 1024, acq_dev_size)) {
-		tst_resm(TWARN | TERRNO, "Failed to create %s", filename);
+		tst_resm(TWARN | TERRNO, "Failed to create %s%s", filename,
+			 errno == ENOSPC ? " (not enough space in $TMPDIR?)" : "");
 		return NULL;
 	}
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
