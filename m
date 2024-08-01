Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE413C3DA64
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:10:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A3B93D1F52
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:10:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D95A73D1EF3
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:08:53 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B3B85608A6B
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:08:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5F16219DF;
 Thu,  1 Aug 2024 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722514129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RzEXsVjfsFZNIle//BUDbEoHdH8JnzCGciz/v3oVa20=;
 b=hFGMVbTKxPrMWshLS/2pjaIxmKBFXJjb8xa+uoVlXg7NWt2BXtP2/7Qpx/ZyNkC6BmNk8E
 KlydF1dATgZ2WvKErAMG1U4Ly/0WFtgl/GicVP3KsKMGAPFDoBNB7dwBi9JuBqG+ZmPU4p
 //EFsXqDvj1VwevfN+JVoTnLpfv8pI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722514129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RzEXsVjfsFZNIle//BUDbEoHdH8JnzCGciz/v3oVa20=;
 b=Mg639s/gPmzwsQuxfiQn69e9TyvelGE9qgA6fkpYkaitUPmdIcJZkD4o7u4cnyYWzo+Otn
 wdZN3w05aEU3MhDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hFGMVbTK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Mg639s/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722514129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RzEXsVjfsFZNIle//BUDbEoHdH8JnzCGciz/v3oVa20=;
 b=hFGMVbTKxPrMWshLS/2pjaIxmKBFXJjb8xa+uoVlXg7NWt2BXtP2/7Qpx/ZyNkC6BmNk8E
 KlydF1dATgZ2WvKErAMG1U4Ly/0WFtgl/GicVP3KsKMGAPFDoBNB7dwBi9JuBqG+ZmPU4p
 //EFsXqDvj1VwevfN+JVoTnLpfv8pI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722514129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RzEXsVjfsFZNIle//BUDbEoHdH8JnzCGciz/v3oVa20=;
 b=Mg639s/gPmzwsQuxfiQn69e9TyvelGE9qgA6fkpYkaitUPmdIcJZkD4o7u4cnyYWzo+Otn
 wdZN3w05aEU3MhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EE3813946;
 Thu,  1 Aug 2024 12:08:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6xZsG9F6q2aiVwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 12:08:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 14:08:37 +0200
Message-Id: <20240801-landlock-v5-0-663d7383b335@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMZ6q2YC/13NTQ7CIBCG4asY1mIGyo+48h7GBYXBErU1RRtN0
 7tL60LS5TfheRlJwj5iIofNSHocYopdm4fcbohrbHtBGn3ehAMXoJimN9v6W+eu1Im9FYpXVgh
 N8vNHjyG+l9TpnHcT07PrP0t5YPP1F9HA/pGBUaByj8YGJYzV/JheCXeuu5O5MfDCMSgczy4Eb
 XwNTHupV64qXflflZ3TNaBBH0wNKycKx2XhRHZKBWmZA6dMVbhpmr7/Qf6URwEAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2982;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=NsmIDsq1Bb4c5HEo0OESgYuY/hQ1u2kDhFpeUBeVSMs=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq3rMp0eG7FKpUTE/P/x1uLg0omnEfX/msf9jJ
 sOTLdOrL3WJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqt6zAAKCRDLzBqyILPm
 RljRC/4w6LFG6PdYyaHFNXq/ifH1IoEB3p/4I1H64kjf7g2hnFFx+jrjZyu00dJmXhKs7JHrO/C
 IKwqMwupAh1ALCl0df+eiVjNqjyM/qkgaj/juOSioE3MjbWJ/Q1RSPCWUoLj+3JvEaP+mgQ1oYb
 FlFumDTwu2enkecPHkMT/S+rKxu5o+pLSIY6T6fco8YdHsvsoQZRuisiXGB8zbBHhPEZVLy7FEM
 Qbw1jFThdxb3eeoQdaZPUWXhZ79HUp4JWzLN6WBLfj3pEi128K3RoMayTzeNamTEWSratgIt8Yv
 b62YiLHd0JU42OoO1OAG8kAxlZOXU8df3tqoJ/OT5pq3p2JYX0qY0wtNZ0kDVoUTlU20yoQUy17
 zXsE03fquu3KdP7m66qp5yw/tpkBFo91jy26g13J7hACpMkqewS0kaT/P9xT4Lt4+CpzUy/h9er
 BfRwJuHk4iCCDvR6h8s/pTF5Z8jJ/OeYQb9Cq761eTpMQ6e+njPHTlH6Q0b0XMEt2Zf0s=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C5F16219DF
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/6] landlock testing suite
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

This testing suite is meant to test the following syscalls:

- landlock_create_ruleset
- landlock_add_rule
- landlock_restrict_self

Documentation can be found in kernel manuals and inside the official
kernel documentation at

https://www.kernel.org/doc/html/latest/userspace-api/landlock.html

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- landlock0[123]: remove minimum kernel check
- landlock04: cleanup/setup for sandbox folder, enforce_ruleset() inside
  the child, skip vfat and exfat for some tests, now working with -i >= 0
- landlock05: remove minimum kernel check
- landlock06: remove exfat from skip
- Link to v4: https://lore.kernel.org/r/20240725-landlock-v4-0-66f5a1c0c693@suse.com

Changes in v4:
- landlock03: fix TBROK on -i usage
- landlock04: fix EINVAL caused by namespace sharing on kernel <=6.6
- Link to v3: https://lore.kernel.org/r/20240711-landlock-v3-0-c7b0e9edf9b0@suse.com

Changes in v3:
- landlock01: 1 byte less when
  HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET is defined
- landlock04: dynamically assign read/exec permissions to dependences
- landlock05: estetic fix and skip exfat
- landlock06: estetic fix and skip exfat
- Link to v2: https://lore.kernel.org/r/20240710-landlock-v2-0-ff79db017d57@suse.com

Changes in v2:
- remove -lc unused dependency from Makefile
- move SAFE_LANDLOCK_* macros in lapi/landlock.h
- define CAP_MKNOD in the lapi/capability.h
- fix landlock fallback in order to let LTP build properly
- fix landlock01 EINVAL test when "struct landlock_ruleset_attr" size is
  too small
- Link to v1: https://lore.kernel.org/r/20240701-landlock-v1-0-58e9af649a72@suse.com

---
Andrea Cervesato (6):
      Get ABI version from landlock common library
      Add CAP_MKNOD fallback in lapi/capability.h
      Disable kernel version check in landlock tests
      Add landlock04 test
      Add landlock05 test
      Add landlock06 test

 include/lapi/capability.h                          |  12 +-
 runtest/syscalls                                   |   3 +
 testcases/kernel/syscalls/landlock/.gitignore      |   4 +
 testcases/kernel/syscalls/landlock/landlock01.c    |   1 -
 testcases/kernel/syscalls/landlock/landlock02.c    |   1 -
 testcases/kernel/syscalls/landlock/landlock03.c    |   1 -
 testcases/kernel/syscalls/landlock/landlock04.c    | 212 +++++++++++
 testcases/kernel/syscalls/landlock/landlock05.c    | 118 +++++++
 testcases/kernel/syscalls/landlock/landlock06.c    | 107 ++++++
 .../kernel/syscalls/landlock/landlock_common.h     |   4 +-
 testcases/kernel/syscalls/landlock/landlock_exec.c |   9 +
 .../kernel/syscalls/landlock/landlock_tester.h     | 393 +++++++++++++++++++++
 12 files changed, 857 insertions(+), 8 deletions(-)
---
base-commit: eee3b2dd6d9dae6120646bc14c30e460989d7df6
change-id: 20240617-landlock-c48a4623a447

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
