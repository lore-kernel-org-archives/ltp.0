Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D33C83F17
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 11:47:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABF3B3CC17D
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 13:47:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E872A3CB1A6
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 13:46:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F0B60200903
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 13:46:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5151A21B3A;
 Thu, 31 Jul 2025 11:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753962391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CEkDnLOr2KADiUDqOQerjRgy0L3Ew6MXxD+DgnZUJSw=;
 b=VhinqosKVlLE14DrayXWXEsIzU5x9xIXVgzdGzTYYZG0z13XfXQhGVESDj9lv6XalLXL9K
 hzEIuPkH6G//+V9444ajc5jk3rVpKfmRNqB1giYxhj2FFC/ySZC2XhpNuoJQ3+dvMsKVmV
 Y/0Dtn5fCSc42ow1ZgCEP3x5IWsetcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753962391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CEkDnLOr2KADiUDqOQerjRgy0L3Ew6MXxD+DgnZUJSw=;
 b=fJjrKA+gJYMyn46a0zZyaLuQ/T8MtMniNyPdeb9xw6fGRYkyUMyOLUkacNqUuQJ1ZUAnYw
 yDjwu/ToRK1b0nAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753962391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CEkDnLOr2KADiUDqOQerjRgy0L3Ew6MXxD+DgnZUJSw=;
 b=VhinqosKVlLE14DrayXWXEsIzU5x9xIXVgzdGzTYYZG0z13XfXQhGVESDj9lv6XalLXL9K
 hzEIuPkH6G//+V9444ajc5jk3rVpKfmRNqB1giYxhj2FFC/ySZC2XhpNuoJQ3+dvMsKVmV
 Y/0Dtn5fCSc42ow1ZgCEP3x5IWsetcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753962391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CEkDnLOr2KADiUDqOQerjRgy0L3Ew6MXxD+DgnZUJSw=;
 b=fJjrKA+gJYMyn46a0zZyaLuQ/T8MtMniNyPdeb9xw6fGRYkyUMyOLUkacNqUuQJ1ZUAnYw
 yDjwu/ToRK1b0nAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29DBB13A8A;
 Thu, 31 Jul 2025 11:46:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tJCBB5dXi2h2SgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 31 Jul 2025 11:46:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 31 Jul 2025 13:46:24 +0200
Message-Id: <20250731-clock_nanosleep05-v5-0-0118cf6b2454@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJBXi2gC/4XOUYvCMAwH8K8ifbbSpkvn7snvIcfRZelZ9FZZt
 dwh++52A1FkcOTpH5JfchOJh8BJfKxuYuAcUoh9CbheCTq4/ptl6EoWoACVBSXpFOn41bs+phP
 zWaG0qjXkW4fgWZS988A+/M7m/rPkQ0iXOPzNJ7Keug+tXtCylqUM1lo1Dmird+maeEPxR0xYh
 hfALL2TQSqpEQE6RNRk3wDzBGq9+IEpgG1M5Um7MoVvQPUvUBWg3rZkofONVf4FGMfxDqwWnrp
 0AQAA
X-Change-ID: 20250620-clock_nanosleep05-60b3cfba52fe
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753962391; l=2211;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=TWsX4D2PvReebA1juY7A99FBn0u0KCcRk+my9BWW5Ug=;
 b=11Xm7Jqd0Fslr2orr9P80EFgj9rr1lfU96pufHjqQck/ZS0nscP/JmyzPWvziUTqZSQxJccP7
 qFByLh3edOVCZRcLvyUM+615jt7bc6LXwR9HGvl4NocoIu1mFrBGG0Y
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/2] Rewrite openposix clock_settime bugged tests
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
Changes in v5:
- move back to variants for clock_settime/clock_gettime
- Link to v4: https://lore.kernel.org/r/20250717-clock_nanosleep05-v4-0-78bc62df960f@suse.com

Changes in v4:
- change description to include REALTIME instead of MONOTONIC
- Link to v3: https://lore.kernel.org/r/20250717-clock_nanosleep05-v3-0-6934fc1a2505@suse.com

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

 include/tst_safe_clocks.h                          |  23 +++
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/clock_settime/.gitignore |   1 +
 .../syscalls/clock_settime/clock_settime04.c       | 160 +++++++++++++++++++++
 4 files changed, 185 insertions(+)
---
base-commit: 91fa413eb521fde80d57c79bd3d2fb5cbe4ad3f4
change-id: 20250620-clock_nanosleep05-60b3cfba52fe

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
