Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555E2C83F1A
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 09:42:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B05B93CC255
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 11:42:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A454F3CC2A8
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 11:42:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7268E140006D
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 11:42:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE0DC216EF;
 Thu, 17 Jul 2025 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752745319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r31wLrCDvqOC+CaAbrWviMnhrcEGH2H+2M+OhwBfAhI=;
 b=bYFsXpk9cN/e0t+dlqNicgl0akXxv3y86bsOATRkF6gUjP8h47dg7/v5Hyd1kM72SpuWt5
 h5BIUzCmmgJ+hZpeFtoGsG4V7dppF4E2fLaC/mkT8baFQdk/s599KvtvKu9F50r04ZE13V
 jIQ7JlINBqJZI3jG6laNeRjCLtyseK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752745319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r31wLrCDvqOC+CaAbrWviMnhrcEGH2H+2M+OhwBfAhI=;
 b=744JiyAuZbUY4Lc/EDMCx/MXrPd3bjD/f7/o7C8wG3ehudaY3+fTT7Cg0o8n/oVf0bM4F8
 z4AzlDSjBy5niwDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cZ8Dh27E;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LX4eAYyD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752745318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r31wLrCDvqOC+CaAbrWviMnhrcEGH2H+2M+OhwBfAhI=;
 b=cZ8Dh27ESNRoH62QbmpgUEY0Hkyzo50GYMil6opnLdkcVef9hf0AhDRMAndEBej1AU/VjW
 JAS4SFvzqFGoj8uw0KifoQR8ybrTYYKZa16LO4Zccz5pxPhiGR2kdcFeTMRQ2Nj9DzToXt
 XvKWgN1Bzm8jibU4KOZJO9NyZynwDdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752745318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r31wLrCDvqOC+CaAbrWviMnhrcEGH2H+2M+OhwBfAhI=;
 b=LX4eAYyDCiI0Yzx3kkr/4LcM+pzGhW+K9gLj3z3wdoxkKcEaxfY/F3e8FbIJbNEh2HYl33
 1Jqv5OL+woi1TRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8306013A6C;
 Thu, 17 Jul 2025 09:41:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4Q0RHmbFeGjdWwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 17 Jul 2025 09:41:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 17 Jul 2025 11:41:56 +0200
Message-Id: <20250717-clock_nanosleep05-v3-0-6934fc1a2505@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGTFeGgC/23OwQrCMAwG4FcZPVtpU7KpJ99DRLouc8XZjlaLM
 vbudgNhh5HTH/i/ZGSRgqXITsXIAiUbrXc5qF3BTKfdnbhtcmYgAEUJgpvem8fNaedjTzQI5KW
 olWlrjdASy70hUGs/i3m55tzZ+PLhu5xIct7+tWpDS5LnUVhJcdRgDvIc35H2xj/ZjCVYAWrrn
 QRccIkI0CCiNOUKmKbpB/GVUa7yAAAA
X-Change-ID: 20250620-clock_nanosleep05-60b3cfba52fe
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752745318; l=1866;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=PR9pDLcGaUuLo7LOY1q22AQuQwmzmiqJmWB53iXJXUg=;
 b=6qZOy5GaKMJWjkF90sDPGzVrJM7zYNNCz7ZcxITo2i7lCkv+7kpKoavHu8DJQXcATDE1w4/oY
 d9eLFaZrMQ0CIj0fX9wvNjurq5dpR4wvdQ4rFzwRxT1Si9wvMS2w6hA
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: AE0DC216EF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Rewrite openposix clock_settime bugged tests
 inside LTP
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

Both clock_settime_7-1 and clock_settime_8-1 are affected by the
same bug which is probably related to the way tests are written.

sleep() is used by the parent and is not reliable. It can oversleep
or undersleep according to system overload or signals which are
received. And we never check for its return value. Using
clock_nanosleep would make parent more reliable in this case.

At the same time, the test is taking for granted a certain
synchronization between child and parent, which is not always true
in case of system overload.

My suggestion is to rewrite the test using LTP, which has better
timing handling (see tst_timer.h).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- remove checkpoints
- sleep with REALTIME only, but take time in MONOTONIC
- use only clock_settime variant
- Link to v2: https://lore.kernel.org/r/20250630-clock_nanosleep05-v2-0-15522d5551c6@suse.com

Changes in v2:
- add SAFE_CLOCK_NANOSLEEP
- move child to MONOTONIC clock
- simplify child_nanosleep by passing flags
- calculate delta by checking sleep() time between beginning and ending time
- keep variants only for child
- Link to v1: https://lore.kernel.org/r/20250627-clock_nanosleep05-v1-1-1357109a2c81@suse.com

---
Andrea Cervesato (2):
      Add SAFE_CLOCK_NANOSLEEP macro utility
      Add clock_settime04 test

 include/tst_safe_clocks.h                          |  23 ++++
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/clock_settime/.gitignore |   1 +
 .../syscalls/clock_settime/clock_settime04.c       | 140 +++++++++++++++++++++
 4 files changed, 165 insertions(+)
---
base-commit: 39072797fa63be2a5e85b1a79379b98a8bfa8d29
change-id: 20250620-clock_nanosleep05-60b3cfba52fe

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
