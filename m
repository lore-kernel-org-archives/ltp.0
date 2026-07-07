Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97866C43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 13:43:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D5DD3E2AAD
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 15:43:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8D373E2AAD
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 15:42:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F052214002B3
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 15:42:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B891975E79;
 Tue,  7 Jul 2026 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783431748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Un7qtQFJkqmHhO+knbEBmxtAfgcV1nrbI2Z//gN9+cU=;
 b=vV3A3oaWU3Q67lBS7cClru3Eer0hYEiSmokEBResbbY2qqy1t6UzHE7nFbIEPv8Uzka2aX
 ZQMn9jZNqo3ZyvUqrSYaIq1yr6KVpdFugeDRUJHyMMJwiXmLcj/1+XaAQqJpgj78QI6pQ2
 h+3mI1UA6iOyu4YLLfNdtGhSiXzm3I8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783431748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Un7qtQFJkqmHhO+knbEBmxtAfgcV1nrbI2Z//gN9+cU=;
 b=YxkAxQmjpCjgujNQDpmlfnrVOK+uGHtZv9cbkmqBlePuQqV74g9kAMCOhHDozsbFH+WSGg
 uxAVCoW3k5hQZfCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783431747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Un7qtQFJkqmHhO+knbEBmxtAfgcV1nrbI2Z//gN9+cU=;
 b=SQB4UJ0xL4rrxm/0ra35D+CYU2MLa/6n6ajTm5cfwIIipNU51OmeSv6YmIl7XqST6aVNpi
 ozrvLYTsBnX9EYAqHc+M6YXsGvtDd54Vc3j5pdWadZS03X2QShWYeqQ5ijjc/LHsNwNoTf
 ieOBZ49O6CHrsq+l2/dvrClxSOzX+oE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783431747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Un7qtQFJkqmHhO+knbEBmxtAfgcV1nrbI2Z//gN9+cU=;
 b=bi/KkxvBUVa03U7Qv9prxwwfMSPyis3Msbx7u9qp4UZP/r4rMECIDWLtc22Kqy7q/hwQ4e
 vQXGKAuDzTl8J9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 956B1779AE;
 Tue,  7 Jul 2026 13:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GbwEIkMCTWr8OgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Jul 2026 13:42:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Jul 2026 15:42:26 +0200
Message-Id: <20260707-cve-2026-46331-v3-0-3f6f1d697eec@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEICTWoC/32MOQ7CMBAAvxJtzSKvrxAq/oEoIntNXJAgGyxQl
 L/jpKKBckaamSFzipzh2MyQuMQcp7GC2jXghn68MkZfGaSQVrTCoiuMK6C2ShFqpUPXuSCdJaj
 RPXGIr214vlQeYn5M6b39C63256oQCnTGeG2CkNLTKT8z7910g/VU5P9a1tob1m1PpPqD/qqXZ
 fkAnw1rPukAAAA=
X-Change-ID: 20260706-cve-2026-46331-434f99cf2c61
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783431747; l=2002;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=uG7EskrNf35qDcxlojcpAQWsGqNR21gzRlnBgsRPuBQ=;
 b=C2sIlKp96li56oS5m2T2yMhmFoJVNYBpuJK03sGrM8EkrueaMnee3ceRb6j2xkP22lxeWHJJj
 JnyMVF8R0hUBdXb1kc/M6PvpF+zxCdX8cJtkN6wcziU9DCjFZdefar4
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url, imap1.dmz-prg2.suse.org:helo,
 suse.com:email, suse.com:mid, mitre.org:url]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] Reproducer for cve-2026-46331
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

tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.1.0-rc5-virtme/build/.config'
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_cveTzmFu2 as tmpdir (overlayfs filesystem)
tst_test.c:2047: TINFO: LTP version: 20260529-80-g0b891ea23
tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc5-virtme #9 SMP PREEMPT_DYNAMIC Mon Jul  6 14:50:05 CEST 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.1.0-rc5-virtme/build/.config'
tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s
cve-2026-46331.c:221: TFAIL: Page cache corrupted via act_pedit partial COW bypass

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=899ee91156e5

HINT: You _MAY_ be vulnerable to CVE(s):

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2026-46331

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- fix build failure in opensuse 42.2
- Link to v2: https://lore.kernel.org/20260706-cve-2026-46331-v2-0-d5e47a113a84@suse.com

Changes in v2:
- remove sleep()
- Link to v1: https://lore.kernel.org/20260706-cve-2026-46331-v1-0-c55d45f022d1@suse.com

---
Andrea Cervesato (4):
      lapi: Add pkt_cls.h fallback
      lapi: Add pkt_sched.h fallback
      lapi: Add tc_pedit.h fallback
      cve: Add act_pedit page-cache corruption test

 configure.ac                   |   2 +
 include/lapi/pkt_cls.h         |  19 +++
 include/lapi/pkt_sched.h       |  19 +++
 include/lapi/tc_pedit.h        |  52 ++++++++
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/cve-2026-46331.c | 272 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 366 insertions(+)
---
base-commit: 0b891ea23ed7315afa12df92fe12f1218a420bde
change-id: 20260706-cve-2026-46331-434f99cf2c61

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
