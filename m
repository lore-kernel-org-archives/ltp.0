Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040A9C79F9E
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 08:55:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 005B23E54F7
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 10:55:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1778F3C2FF9
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 10:55:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E91D1000248
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 10:55:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 874741F750;
 Mon,  7 Sep 2026 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788771326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/E4r3IAGgW+P+2ZI/jSTFJrDgK5gVEs4nL7zW0rfaLc=;
 b=HQbEDE8FtsLriQARSK0JHV8V2ladguOH0SV8p+6gnjRg5Vq4JUiRHO4Wz6I1ft3iaUk+Vd
 E3SXCuZNB2FIV5MCBmjt2KtUW1FqlMW5WxaqIPK5EZWcTKL3japQSI8wyS8UpQfVQQFYmP
 dgXiW8E67yEEOp7nD/NZliSlvxXD/z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788771326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/E4r3IAGgW+P+2ZI/jSTFJrDgK5gVEs4nL7zW0rfaLc=;
 b=jvA7G5oAMk15i5yCFjcPw5Vq61xZEu03JMfFkjzzAdOWCFoREEC2XZd/TY0WXHqyO3k4OI
 bNvnLYRDKrN9/xDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oQQMbC0F;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Acv1OqoQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788771322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/E4r3IAGgW+P+2ZI/jSTFJrDgK5gVEs4nL7zW0rfaLc=;
 b=oQQMbC0F0S33x18kD0S0FMEeyfSuchMCsVvHVb6i3ZGGGAfZmDkonhOQzKQjuwucehwu15
 tFl65RQ0Wgpl4zSioPpqbmLCBE90akWiK4rFTfF3vFqqDyA9ITpoPnl/ltr1yc7iBBpaEY
 N8dSBNuqjriDzObEE8PLZAOu0xSdZOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788771322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/E4r3IAGgW+P+2ZI/jSTFJrDgK5gVEs4nL7zW0rfaLc=;
 b=Acv1OqoQtDc+gb3tft5/jgpDtO2XRYkqLBXs4Pp44R07rzhZsCkpPUONoHg+NgIaVNYxY/
 tx6GdTY1OG0rsSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5584F13432;
 Mon,  7 Sep 2026 08:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lUAiE/p7nmr3WwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 07 Sep 2026 08:55:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 07 Sep 2026 10:55:15 +0200
Message-Id: <20260907-process_mrelease-v3-0-03bde3e5d77c@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPN7nmoC/32NQQrCMBBFr1JmbSSZjAVdeY9SJMaJDdimZLQoJ
 Xc39gAu34P//grCObLAqVkh8xIlpqmC3TXgBzfdWcVbZUCNpA+Ias7Js8hlzPxgJ6xswNbilSx
 yC3U2Zw7xvSW7vvIQ5ZnyZ3tYzM/+iS1GaUUmMAZHZI50lpfw3qcR+lLKFzFhXbGvAAAA
X-Change-ID: 20240522-process_mrelease-3f2632b432e6
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788771322; l=1872;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=ZGeRQlqAss1nsg0v3ywjQDVj3k+N6JFwpn8vYhvHtcg=;
 b=2UMW8xYcuHKQDo3DWulRrrNVmsdrRchHrbKGSJ5zvEcoefASgVbFHUVzqh/vc/PpaPkeLXMs+
 tCFWvswSws+DMwE4K/+/pRZ7hDW1K2p4RlYYO0Ra6cdiJgwUyBZA3Hc
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 874741F750
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,linux.it:email,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Add process_mrelease testing suite
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

This testing suite is meant to add coverage for process_mrelease()
syscall, introduced in the kernel 5.15.

The testing suite is providing following tests:
- process_mrelease01
- process_mrelease02

Since there's no man pages, please consider the following
documentation instead:

https://lwn.net/Articles/864184/
https://lwn.net/Articles/865341/

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
process_mrelease01:
- drop /proc/<pid>/maps check and unused shared memory setup
- retry on ESRCH with exponentially increasing memory allocations
- pass immediately when process_mrelease() returns success
- remove unneeded needs_root flag
- fix author name typo and description formatting

process_mrelease02:
- wait for child process after checkpoint wake to avoid zombies
- remove unneeded needs_root flag
- update doc comment formatting

Changes in v2:
- process_mrelease01: change the algorithm to ensure we released the
  memory after process_mrelease() is called
- process_mrelease02: verify ESRCH error
- Link to v1: https://lore.kernel.org/r/20240522-process_mrelease-v1-0-41fe2fa44194@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (2):
      Add process_mrelease01 test
      Add process_mrelease02 test

 runtest/syscalls                                   |  3 +
 .../kernel/syscalls/process_mrelease/.gitignore    |  2 +
 .../kernel/syscalls/process_mrelease/Makefile      |  7 ++
 .../syscalls/process_mrelease/process_mrelease01.c | 94 ++++++++++++++++++++++
 .../syscalls/process_mrelease/process_mrelease02.c | 90 +++++++++++++++++++++
 5 files changed, 196 insertions(+)
---
base-commit: 463b33ad464b6840d0a1df5d41939e50d55d542c
change-id: 20240522-process_mrelease-3f2632b432e6

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
