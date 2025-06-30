Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2242C83030
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 11:56:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 567873C5669
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 13:56:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0DA53C0131
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 13:56:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1B995200ADA
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 13:56:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA31B1F390;
 Mon, 30 Jun 2025 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751284595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dhzFomPa57e6ZVgkv3htQfz0+LGtMkYeZ2mV00WBLHY=;
 b=TgQXKBpDVt3IwGzzA8nFiQIyr8RCF5Zn5RYNs7/XOD7rLq5kDqkh8LfTbnOkQyohrkkTpH
 KPQstg3YZUgzMdkXjmPhtV8tHYmbvzl7uoNpgVsYHF6i2xQPOqVNOT+AK9orlhYiCH4fuc
 wJw9CbdnpXB/gL8lXp+hxaLa2l9UUt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751284595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dhzFomPa57e6ZVgkv3htQfz0+LGtMkYeZ2mV00WBLHY=;
 b=pHGYLRbZGZJ0vtsyMXMuVQKy5vsgR5+Y4GIxn1gqZobOz4NSCAG7RyXgDSMHdPT9npJmoC
 TBfsYrxTFXMDO4Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751284595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dhzFomPa57e6ZVgkv3htQfz0+LGtMkYeZ2mV00WBLHY=;
 b=TgQXKBpDVt3IwGzzA8nFiQIyr8RCF5Zn5RYNs7/XOD7rLq5kDqkh8LfTbnOkQyohrkkTpH
 KPQstg3YZUgzMdkXjmPhtV8tHYmbvzl7uoNpgVsYHF6i2xQPOqVNOT+AK9orlhYiCH4fuc
 wJw9CbdnpXB/gL8lXp+hxaLa2l9UUt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751284595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dhzFomPa57e6ZVgkv3htQfz0+LGtMkYeZ2mV00WBLHY=;
 b=pHGYLRbZGZJ0vtsyMXMuVQKy5vsgR5+Y4GIxn1gqZobOz4NSCAG7RyXgDSMHdPT9npJmoC
 TBfsYrxTFXMDO4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ED9213983;
 Mon, 30 Jun 2025 11:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rLIyHXN7YmiTQAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 30 Jun 2025 11:56:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 30 Jun 2025 13:56:33 +0200
Message-Id: <20250630-clock_nanosleep05-v2-0-15522d5551c6@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHF7YmgC/22NwQrCMBBEf6Xs2UiSklY9+R9SJI0bu1iTktWil
 Py7seBN5vQG5s0CjImQ4VAtkHAmphgK6E0FbrDhioIuhUFLbWSjpXBjdLdzsCHyiDhJIxrZ187
 31miPUHZTQk+v1XnqCg/Ej5je68Wsvu3P1v6xzUqU1KZVcm+126kjPxm3Lt6hyzl/ADFROQyxA
 AAA
X-Change-ID: 20250620-clock_nanosleep05-60b3cfba52fe
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751284595; l=1641;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=XTugBsgu6oelfLn6zYezaIK0l3gP3CAgDx1yNoLg/Sk=;
 b=pENUTM/l2U+qo973Y4Ua70HWbaLdiFTB5jiQ4/xJCb3gUDwm+9/1BqguxctEwxr2QJzvRnb7D
 u8aIUf5P5JmAIEytnCN06oN8iUShyRLW7NJBQKjY+jGt5rZ3OkDXkzt
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Rewrite openposix clock_settime bugged tests
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
 .../syscalls/clock_settime/clock_settime04.c       | 153 +++++++++++++++++++++
 4 files changed, 178 insertions(+)
---
base-commit: df591113afeb31107bc45bd5ba28a99b556d1028
change-id: 20250620-clock_nanosleep05-60b3cfba52fe

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
