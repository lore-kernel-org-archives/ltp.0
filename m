Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC18C25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 09:37:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C52B83CF8C0
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 11:37:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80C8C3CF782
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:34:01 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AD4B860A64F
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:33:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 71E2520488;
 Wed, 15 May 2024 09:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715765635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mr7hKM9gO6z7NRtkhGc21vcss/v5F0iG1TDtouWvJUg=;
 b=jk6vaGjTmKGrH/RGMCJpokYeuMWpcqKRLsszD4KL7z1jLQfembQfx8nHckdAqvwLLVFUnn
 2GM4dUYLzF+3d47k575jm60eKJvfWbVdMvEx0/Q0CgjisdTGy3M70i8LXMU3zf0yLfP0yK
 27TOBcGVLOEin1mO7CF8JF/wIIRVnbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715765635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mr7hKM9gO6z7NRtkhGc21vcss/v5F0iG1TDtouWvJUg=;
 b=vMImBRhQQsdSpRbsNa2owIMZSSBysyAKE09EWxWk0Lij+Jh084ZWTq4KbbZm4cGJFbbv0F
 ZiMvmDY6Qvxa8SBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jk6vaGjT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vMImBRhQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715765635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mr7hKM9gO6z7NRtkhGc21vcss/v5F0iG1TDtouWvJUg=;
 b=jk6vaGjTmKGrH/RGMCJpokYeuMWpcqKRLsszD4KL7z1jLQfembQfx8nHckdAqvwLLVFUnn
 2GM4dUYLzF+3d47k575jm60eKJvfWbVdMvEx0/Q0CgjisdTGy3M70i8LXMU3zf0yLfP0yK
 27TOBcGVLOEin1mO7CF8JF/wIIRVnbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715765635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mr7hKM9gO6z7NRtkhGc21vcss/v5F0iG1TDtouWvJUg=;
 b=vMImBRhQQsdSpRbsNa2owIMZSSBysyAKE09EWxWk0Lij+Jh084ZWTq4KbbZm4cGJFbbv0F
 ZiMvmDY6Qvxa8SBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C1BE1372E;
 Wed, 15 May 2024 09:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vuSVEIOBRGb1TwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 15 May 2024 09:33:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 15 May 2024 11:33:39 +0200
Message-Id: <20240515093349.7347-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 71E2520488
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 00/10] statmount/listmount testing suites
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

This patch-set is adding new testing suites for statmount() and listmount()
syscalls, which have been recently added in kernel v6.8.
To find out more information, please read the following documentation since
there's no man pages yet:

https://lwn.net/Articles/950569/
https://lore.kernel.org/lkml/170474400576.2602.7882507604401153304.pr-tracker-bot@kernel.org/T/

Along with kernel source code:

https://github.com/torvalds/linux/blob/1b294a1f35616977caddaddf3e9d28e576a1adbc/include/uapi/linux/mount.h#L155
https://github.com/torvalds/linux/blob/1b294a1f35616977caddaddf3e9d28e576a1adbc/tools/testing/selftests/filesystems/statmount/statmount_test.c

Andrea Cervesato (10):
  Add SAFE_STATX macro
  Add listmount/statmount fallback declarations
  Add listmount01 test
  Add listmount02 test
  Add stamount01 test
  Add statmount02 test
  Add statmount03 test
  Add statmount04 test
  Add statmount05 test
  Add statmount06 test

 configure.ac                                  |   5 +
 include/lapi/mount.h                          |  67 +++++++++
 include/lapi/stat.h                           |  10 +-
 include/lapi/syscalls/aarch64.in              |   2 +
 include/lapi/syscalls/arc.in                  |   2 +
 include/lapi/syscalls/arm.in                  |   2 +
 include/lapi/syscalls/hppa.in                 |   2 +
 include/lapi/syscalls/i386.in                 |   2 +
 include/lapi/syscalls/ia64.in                 |   2 +
 include/lapi/syscalls/loongarch.in            |   2 +
 include/lapi/syscalls/mips_n32.in             |   2 +
 include/lapi/syscalls/mips_n64.in             |   2 +
 include/lapi/syscalls/mips_o32.in             |   2 +
 include/lapi/syscalls/powerpc.in              |   2 +
 include/lapi/syscalls/powerpc64.in            |   2 +
 include/lapi/syscalls/s390.in                 |   2 +
 include/lapi/syscalls/s390x.in                |   2 +
 include/lapi/syscalls/sh.in                   |   2 +
 include/lapi/syscalls/sparc.in                |   2 +
 include/lapi/syscalls/sparc64.in              |   2 +
 include/lapi/syscalls/x86_64.in               |   2 +
 include/tst_safe_macros.h                     |   7 +
 lib/tst_safe_macros.c                         |  21 +++
 runtest/syscalls                              |  10 ++
 .../kernel/syscalls/listmount/.gitignore      |   2 +
 testcases/kernel/syscalls/listmount/Makefile  |   7 +
 .../kernel/syscalls/listmount/listmount.h     |  26 ++++
 .../kernel/syscalls/listmount/listmount01.c   |  66 +++++++++
 .../kernel/syscalls/listmount/listmount02.c   | 106 ++++++++++++++
 .../kernel/syscalls/statmount/.gitignore      |   6 +
 testcases/kernel/syscalls/statmount/Makefile  |   7 +
 .../kernel/syscalls/statmount/statmount.h     |  26 ++++
 .../kernel/syscalls/statmount/statmount01.c   |  69 +++++++++
 .../kernel/syscalls/statmount/statmount02.c   |  76 ++++++++++
 .../kernel/syscalls/statmount/statmount03.c   |  99 +++++++++++++
 .../kernel/syscalls/statmount/statmount04.c   | 133 +++++++++++++++++
 .../kernel/syscalls/statmount/statmount05.c   | 138 ++++++++++++++++++
 .../kernel/syscalls/statmount/statmount06.c   |  73 +++++++++
 38 files changed, 989 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/listmount/.gitignore
 create mode 100644 testcases/kernel/syscalls/listmount/Makefile
 create mode 100644 testcases/kernel/syscalls/listmount/listmount.h
 create mode 100644 testcases/kernel/syscalls/listmount/listmount01.c
 create mode 100644 testcases/kernel/syscalls/listmount/listmount02.c
 create mode 100644 testcases/kernel/syscalls/statmount/.gitignore
 create mode 100644 testcases/kernel/syscalls/statmount/Makefile
 create mode 100644 testcases/kernel/syscalls/statmount/statmount.h
 create mode 100644 testcases/kernel/syscalls/statmount/statmount01.c
 create mode 100644 testcases/kernel/syscalls/statmount/statmount02.c
 create mode 100644 testcases/kernel/syscalls/statmount/statmount03.c
 create mode 100644 testcases/kernel/syscalls/statmount/statmount04.c
 create mode 100644 testcases/kernel/syscalls/statmount/statmount05.c
 create mode 100644 testcases/kernel/syscalls/statmount/statmount06.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
