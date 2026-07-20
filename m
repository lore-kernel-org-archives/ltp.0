Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373F6C44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 11:48:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D03D3E5285
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 13:48:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A574A3E21D3
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 13:48:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 36D5710005CF
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 13:48:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5655279F1B;
 Mon, 20 Jul 2026 11:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784548112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LfagjQKQjNwabMROEe24neUB/VaKRIMqnVpxoZOZHv8=;
 b=bMTCrnXAshYrnnv834K5Sz7AqPab1k2IMUnPOmuJm7aKglBp5A890BXdY2bDvjJv8S8EsK
 0oSIakaa9k4wTB9hayV27zb5NfQ1sOAtOb1VM6G7BEZRwo42bU2VPOm+PwVZwmNlyPwl6b
 SFVkkNbfr5vUen1nZ2Iuv0yMUw7viIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784548112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LfagjQKQjNwabMROEe24neUB/VaKRIMqnVpxoZOZHv8=;
 b=39CJPrdtFQQ/Jj1bKqWjIgBlfp3nnfZABLTdsJ4JK3ND0oyIrPULJZCDz0T5bw9nglO7dS
 mPNTfi8tAfIBKaCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784548112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LfagjQKQjNwabMROEe24neUB/VaKRIMqnVpxoZOZHv8=;
 b=bMTCrnXAshYrnnv834K5Sz7AqPab1k2IMUnPOmuJm7aKglBp5A890BXdY2bDvjJv8S8EsK
 0oSIakaa9k4wTB9hayV27zb5NfQ1sOAtOb1VM6G7BEZRwo42bU2VPOm+PwVZwmNlyPwl6b
 SFVkkNbfr5vUen1nZ2Iuv0yMUw7viIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784548112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LfagjQKQjNwabMROEe24neUB/VaKRIMqnVpxoZOZHv8=;
 b=39CJPrdtFQQ/Jj1bKqWjIgBlfp3nnfZABLTdsJ4JK3ND0oyIrPULJZCDz0T5bw9nglO7dS
 mPNTfi8tAfIBKaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37F42779AA;
 Mon, 20 Jul 2026 11:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UzgKCxALXmoYLgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 20 Jul 2026 11:48:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 20 Jul 2026 13:48:25 +0200
Message-Id: <20260720-convert_fallocate_suite-v1-0-50ae85c56c03@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAkLXmoC/x3MTQqAIBBA4avErBNsoh+6SkSYjTUQGmoSRHdPW
 n6L9x4I5JkCDMUDnhIHdjajKgvQu7IbCV6zASW2skMptLOJfJyNOg6nVaQ5XBxJ9CjrCs1i6gY
 h16cnw/d/Hqf3/QCgiajqaQAAAA==
X-Change-ID: 20260720-convert_fallocate_suite-820312fbf352
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784548112; l=839;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=ZrTIiwHTAQvqSN5nwH0i5tpqV17RKpS70O9Sfqp4Zn0=;
 b=sNiodgvts6AkREHOyNE59xVhaknOzxqm0ObAdW4N8yA0asPtwAVFJ2JtiyrU7bZtb26qfZE4z
 O2y60mmKU2wDYtRJ+nUH+0nIlJC8z9YRM5h6lvi3FLwS6/iFYCbHIFM
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Convert fallocate testing suite
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

Testing a new multi-agent converter that does a deep analysis on the
code, evaluate if it needs to be converted line by line or it only needs
a complete rewrite, then it spawn an agent for writing the test, one for
reviewing and it iterates until test is out of issues.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      fallocate01: Convert to new API
      fallocate02: Convert to new API

 testcases/kernel/syscalls/fallocate/fallocate01.c | 337 ++++++----------------
 testcases/kernel/syscalls/fallocate/fallocate02.c | 193 ++++---------
 2 files changed, 157 insertions(+), 373 deletions(-)
---
base-commit: ab04cf4157defb7f21a3cbf3392dec758dab590a
change-id: 20260720-convert_fallocate_suite-820312fbf352

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
