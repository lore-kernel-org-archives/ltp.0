Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10EAC3DA4A
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 11:22:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EA243CEF08
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:22:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E56F53CDE6D
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:48 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A252A603A46
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B1141F7E4;
 Thu, 11 Jul 2024 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dtnkb47+OExbEXK+bLpvZWzzB7RKDYdGs3rk93F4KCA=;
 b=mD8QMPMHpt6ZVOYDNEhi7O1mDIPsNYbvbnwo5RCojCDd8wS0Emj3wklWABzW6t6WAiOcSl
 bMAVHwXMy5QWcw6fkBPuv+WDbvv6pwIHBiJ2DmnB781mawakXiIALx1HLLZDQiIh9M6b6D
 xy+OPogEKq97AORtaB5kuvaRxv4Brw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dtnkb47+OExbEXK+bLpvZWzzB7RKDYdGs3rk93F4KCA=;
 b=9iIxHH2Iyb7NT86HaBh2JY2L0yWWptmWU7nC6/E7wdo6AvqiIbCI/TAETJ07YvfUCl/14j
 J1bogSmfiD32fzCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mD8QMPMH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9iIxHH2I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dtnkb47+OExbEXK+bLpvZWzzB7RKDYdGs3rk93F4KCA=;
 b=mD8QMPMHpt6ZVOYDNEhi7O1mDIPsNYbvbnwo5RCojCDd8wS0Emj3wklWABzW6t6WAiOcSl
 bMAVHwXMy5QWcw6fkBPuv+WDbvv6pwIHBiJ2DmnB781mawakXiIALx1HLLZDQiIh9M6b6D
 xy+OPogEKq97AORtaB5kuvaRxv4Brw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dtnkb47+OExbEXK+bLpvZWzzB7RKDYdGs3rk93F4KCA=;
 b=9iIxHH2Iyb7NT86HaBh2JY2L0yWWptmWU7nC6/E7wdo6AvqiIbCI/TAETJ07YvfUCl/14j
 J1bogSmfiD32fzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1419C139E0;
 Thu, 11 Jul 2024 11:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R3fmAo2/j2bBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jul 2024 11:18:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jul 2024 13:18:11 +0200
Message-Id: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHO/j2YC/02MQQ7CIBQFr9L8tRigtLSuvIdxgfCxxAoGlGia3
 l1aF3Y5L29mgoTRYYJDNUHE7JILvkC9q0APyl+ROFMYOOWCtkySUXkzBn0jWnRKtLxWQkgo90d
 E695r6nQuPLj0DPGzljNb1l9EUvaPZEYoaTrslW1FryQ/plfCvQ53WBqZbzxGNx4vnrWyNxfKp
 Gnkxpvn+QvYVBWy1wAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3909;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=gbjNi6E6tjGQKjnO0706AHrAFXYG/oYG5EM610vnBy4=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmj7972oojUeVBG98WnI+3qW0Xa6lIECjDdLUlr
 DC22zXOC4KJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo+/ewAKCRDLzBqyILPm
 Rk0KC/9Pm+C6duL7d2e6qTx6VxYXWDHj1DXt9qXKdYuR5WE+knuhauEuQatFgxWGLYC/Z3apeom
 unmsP0lWg5eFl3hqv7y89Udhz8MXrCDQhWv6rfQ2HlFmWd822v/kqsg6LcqoVUWAMhk5VcMF94y
 /5kG1oC7w6k82eNfFzse1IlJz0Bo6Kox/oGFxQctnXH0T/E1mmDQwqR5R2Tpb+I689DaQXKeccq
 fCIFBVsjat6a+8URroWPI42RHzVaczLi93WJHLu42U0pI1pP4Otc8Q3SiVVRtCrad3TkBVZQJym
 f5rChPe7mMFN5pkvMuZyRXWEVHoB3ReLRK+M7NcjcZQwXqRUy6YhsH0SNM2917qAh5lJrZaurUL
 ETWLEDKk2DeZCR1Y29u2axPegkvb1qPFeYHcvl98UiKwu8dYrxGQWzcwbw9EafWsXqhDb28FWSi
 xF5djYRFdzvMrMzR0mahYH88ogUccoIGPbwV/mbOaFXGKNur/uVzwXQzAlSewhEFDL2JE=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: 3B1141F7E4
X-Spamd-Result: default: False [-1.51 / 50.00];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 00/11] landlock testing suite
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
Andrea Cervesato (11):
      Add landlock syscalls definitions
      Add lapi/landlock.h fallback
      Added three more SAFE_* macros for landlock sandbox:
      Add SAFE_PRCTL macro
      Add landlock01 test
      Add landlock02 test
      Add landlock03 test
      Add CAP_MKNOD fallback in lapi/capability.h
      Add landlock04 test
      Add landlock05 test
      Add landlock06 test

 configure.ac                                       |   6 +
 include/lapi/capability.h                          |  12 +-
 include/lapi/landlock.h                            | 184 +++++++++++
 include/lapi/syscalls/aarch64.in                   |   3 +
 include/lapi/syscalls/arc.in                       |   3 +
 include/lapi/syscalls/arm.in                       |   3 +
 include/lapi/syscalls/hppa.in                      |   3 +
 include/lapi/syscalls/i386.in                      |   3 +
 include/lapi/syscalls/ia64.in                      |   3 +
 include/lapi/syscalls/mips_n32.in                  |   3 +
 include/lapi/syscalls/mips_n64.in                  |   3 +
 include/lapi/syscalls/mips_o32.in                  |   3 +
 include/lapi/syscalls/powerpc.in                   |   3 +
 include/lapi/syscalls/powerpc64.in                 |   3 +
 include/lapi/syscalls/s390.in                      |   3 +
 include/lapi/syscalls/s390x.in                     |   3 +
 include/lapi/syscalls/sh.in                        |   3 +
 include/lapi/syscalls/sparc.in                     |   3 +
 include/lapi/syscalls/sparc64.in                   |   3 +
 include/lapi/syscalls/x86_64.in                    |   3 +
 include/tst_safe_macros.h                          |   6 +
 lib/tst_safe_macros.c                              |  17 +
 runtest/syscalls                                   |   7 +
 testcases/kernel/syscalls/landlock/.gitignore      |   7 +
 testcases/kernel/syscalls/landlock/Makefile        |   7 +
 testcases/kernel/syscalls/landlock/landlock01.c    |  92 ++++++
 testcases/kernel/syscalls/landlock/landlock02.c    | 153 +++++++++
 testcases/kernel/syscalls/landlock/landlock03.c    | 119 +++++++
 testcases/kernel/syscalls/landlock/landlock04.c    | 214 +++++++++++++
 testcases/kernel/syscalls/landlock/landlock05.c    | 116 +++++++
 testcases/kernel/syscalls/landlock/landlock06.c    | 112 +++++++
 .../kernel/syscalls/landlock/landlock_common.h     |  74 +++++
 testcases/kernel/syscalls/landlock/landlock_exec.c |   9 +
 .../kernel/syscalls/landlock/landlock_tester.h     | 350 +++++++++++++++++++++
 34 files changed, 1532 insertions(+), 4 deletions(-)
---
base-commit: 591c56b045b2d44a0f4ba1a13545420b23e909b5
change-id: 20240617-landlock-c48a4623a447

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
