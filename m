Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D15CA0EFA
	for <ltp@archiver.kernel.org>; Tue, 26 Aug 2025 13:21:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 208C03CBD4C
	for <ltp@archiver.kernel.org>; Tue, 26 Aug 2025 15:21:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA3B63C2A7B
 for <ltp@lists.linux.it>; Tue, 26 Aug 2025 15:20:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3FD2510000EE
 for <ltp@lists.linux.it>; Tue, 26 Aug 2025 15:20:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F0701F38C;
 Tue, 26 Aug 2025 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756214441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+CVR3tIIrqszRJxn6fFFv9ntziQexoHdrteKrBJXtRc=;
 b=PAGkxurnSWZyQA2gAaXShJfaMu1CBndN1hfNccjjoDKW+yel4+BOfcsUSwI2GzYhEBe2EW
 jqT39FlGwtYSOf6TBXNr8TOchoLwhUvyj75zmr1EgORBOs/Jwlt17JB+Hqgc06Gxbdcs0I
 xz6qtzlVYzqY9FcvqMdw6qvhgt75IBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756214441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+CVR3tIIrqszRJxn6fFFv9ntziQexoHdrteKrBJXtRc=;
 b=LkCj2IekEWOpm0R/yp067L7BkKlDDMd3Wz8k6zKzvBMNjg/pv34UWRN4LS3nQEXuc0kP0L
 DLx+G5qSe5kIAvCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756214441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+CVR3tIIrqszRJxn6fFFv9ntziQexoHdrteKrBJXtRc=;
 b=PAGkxurnSWZyQA2gAaXShJfaMu1CBndN1hfNccjjoDKW+yel4+BOfcsUSwI2GzYhEBe2EW
 jqT39FlGwtYSOf6TBXNr8TOchoLwhUvyj75zmr1EgORBOs/Jwlt17JB+Hqgc06Gxbdcs0I
 xz6qtzlVYzqY9FcvqMdw6qvhgt75IBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756214441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+CVR3tIIrqszRJxn6fFFv9ntziQexoHdrteKrBJXtRc=;
 b=LkCj2IekEWOpm0R/yp067L7BkKlDDMd3Wz8k6zKzvBMNjg/pv34UWRN4LS3nQEXuc0kP0L
 DLx+G5qSe5kIAvCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DF1313A31;
 Tue, 26 Aug 2025 13:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pMCNNqi0rWhMLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 26 Aug 2025 13:20:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 26 Aug 2025 15:20:37 +0200
Message-Id: <20250826-upgrade_tools-v1-0-1e9d8d4c5e2f@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKW0rWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyMz3dKC9KLElNT4kvz8nGLdZLPEtERzU3PLVMMkJaCegqLUtMwKsHn
 RsbW1AE2daHVfAAAA
X-Change-ID: 20250826-upgrade_tools-c6afa7579e1b
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756214440; l=481;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=PzQHPXNP6j5TVdSxT4ig++VVOSe8J4sqX8LAymWzkSs=;
 b=euDla0mNEg2GXkjtg/Od3/qEHB9fKGjUS8jZRpD3BC6nmXcSRbeTuP1S6yYgLg8Dt5FBNYN9y
 KaOdTsuadODBBgT08XRKAeMYAU/CyZ1js3y+WeGzrqn0Pb3wqAoBwzR
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Upgrade kirk and ltx
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

These are the latest and most stable versions we have.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      kirk: version 2.2.2
      ltx: version 1.3

 tools/kirk        | 2 +-
 tools/ltx/ltx-src | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 3b70bbd649f436404af934ee3f1828e471f68ca4
change-id: 20250826-upgrade_tools-c6afa7579e1b

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
