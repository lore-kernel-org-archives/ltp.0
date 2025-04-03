Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A94C3600C
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 10:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B92AB3CB28B
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 12:19:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FC773CB251
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 12:19:20 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 483961A00900
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 12:19:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E8F5211AA;
 Thu,  3 Apr 2025 10:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743675559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aSwUycrf/slYEUBzIAJD0B87lJkG0iRUGPviqSvyJsU=;
 b=qTM3jXD9fEiaUZSGPqz5EWim8FpgLi1ZSMUwuBsYd+DW6DZFU8PBPtmhNp+ZnpFRNmSj5O
 sKzBpHSB/+K3T0DcwC8QO775Zj5yKlioOrnai3651vhwJnUp28eVxp26vx6pC6VElcnxN+
 eCbc5YiGR6+uApeBXUMePruxgCgHx6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743675559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aSwUycrf/slYEUBzIAJD0B87lJkG0iRUGPviqSvyJsU=;
 b=yTy9LSljC6zZqvXTI78OXYUjWAmjk6KKEG0QnzSJ+G4JEjO8pmULM+qXYbp7/g2IUU5/cu
 kCQv8GK6agA/5jCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743675559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aSwUycrf/slYEUBzIAJD0B87lJkG0iRUGPviqSvyJsU=;
 b=qTM3jXD9fEiaUZSGPqz5EWim8FpgLi1ZSMUwuBsYd+DW6DZFU8PBPtmhNp+ZnpFRNmSj5O
 sKzBpHSB/+K3T0DcwC8QO775Zj5yKlioOrnai3651vhwJnUp28eVxp26vx6pC6VElcnxN+
 eCbc5YiGR6+uApeBXUMePruxgCgHx6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743675559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aSwUycrf/slYEUBzIAJD0B87lJkG0iRUGPviqSvyJsU=;
 b=yTy9LSljC6zZqvXTI78OXYUjWAmjk6KKEG0QnzSJ+G4JEjO8pmULM+qXYbp7/g2IUU5/cu
 kCQv8GK6agA/5jCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E909413A50;
 Thu,  3 Apr 2025 10:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OMvTN6Zg7mcUAgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Apr 2025 10:19:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  3 Apr 2025 12:19:11 +0200
Message-ID: <20250403101912.459507-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403101912.459507-1-pvorel@suse.cz>
References: <20250403101912.459507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 1/2] runtest/ipc: Enable named pipes on
 non-blocking IO
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

Tests were disabled from the start (edab67b3a0 in 2001) due EAGAIN.
Tests are working now even on very old SLE12-SP3 based 4.4 kernel,
therefore enable them.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ipc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/runtest/ipc b/runtest/ipc
index db7f7bed58..f5cdea1974 100644
--- a/runtest/ipc
+++ b/runtest/ipc
@@ -4,10 +4,9 @@
 pipeio_1 pipeio -T pipeio_1 -c 5 -s 4090 -i 100 -b -f x80
 # spawns 5 children to write 100 chunks of 4090 bytes to a named pipe
 # using blocking I/O
-#pipeio_2 pipeio -T pipeio_2 -c 5 -s 4090 -i 100 -f x80
+pipeio_2 pipeio -T pipeio_2 -c 5 -s 4090 -i 100 -f x80
 # spawns 5 children to write 100 chunks of 4090 bytes to a named pipe
 # using non-blocking I/O
-# This test hits EAGAIN, which pipeio doesn't handle at the moment
 pipeio_3 pipeio -T pipeio_3 -c 5 -s 4090 -i 100 -u -b -f x80
 # spawns 5 children to write 100 chunks of 4090 bytes to an unnamed pipe
 # using blocking I/O
@@ -20,10 +19,9 @@ pipeio_5 pipeio -T pipeio_5 -c 5 -s 5000 -i 10 -b -f x80
 pipeio_6 pipeio -T pipeio_6 -c 5 -s 5000 -i 10 -b -u -f x80
 # spawns 5 children to write 10 chunks of 5000 bytes to an unnamed pipe
 # using blocking I/O
-#pipeio_7 pipeio -T pipeio_7 -c 5 -s 5000 -i 10 -f x80
+pipeio_7 pipeio -T pipeio_7 -c 5 -s 5000 -i 10 -f x80
 # spawns 5 children to write 10 chunks of 5000 bytes to a named pipe
 # using non-blocking I/O
-# This test hits EAGAIN, which pipeio doesn't handle at the moment
 pipeio_8 pipeio -T pipeio_8 -c 5 -s 5000 -i 10 -u -f x80
 # spawns 5 children to write 10 chunks of 5000 bytes to an unnamed pipe
 # using non-blocking I/O
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
