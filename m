Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07887CED628
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 08:30:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30F2B3C278C
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 10:30:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D6E83C25C9
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:11 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 24CFF6027A0
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6339A1F769;
 Wed,  9 Oct 2024 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uc8hSpMtKeIw6VBs5gNZPLPZe4UpPSy2pCucKWqdc2Q=;
 b=c6SB9rgp9sE2tUx+WrsmDadTbtUMbVR+bfv5LqK5PdkQlOj4ZTifHlaKQDLVHRlk6r28F1
 bU7/q5mORbs5U7jkjH+LUbPgzlhMP3VWVkhzNbUbmZaQ9kPgY3y80O+2Uv6awUFxMwOQ9G
 xn87yki6LvwAckWcBNUwSy6EZq7FiV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uc8hSpMtKeIw6VBs5gNZPLPZe4UpPSy2pCucKWqdc2Q=;
 b=2m0aAOfi1hADFaeQQbqah5uwrjbRGKUiGqaEQZo0UMDwOPLGoj2FQHQQJZ3F7EVYgRTJ/N
 Pe6DW/3E8EnXnrBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uc8hSpMtKeIw6VBs5gNZPLPZe4UpPSy2pCucKWqdc2Q=;
 b=c6SB9rgp9sE2tUx+WrsmDadTbtUMbVR+bfv5LqK5PdkQlOj4ZTifHlaKQDLVHRlk6r28F1
 bU7/q5mORbs5U7jkjH+LUbPgzlhMP3VWVkhzNbUbmZaQ9kPgY3y80O+2Uv6awUFxMwOQ9G
 xn87yki6LvwAckWcBNUwSy6EZq7FiV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uc8hSpMtKeIw6VBs5gNZPLPZe4UpPSy2pCucKWqdc2Q=;
 b=2m0aAOfi1hADFaeQQbqah5uwrjbRGKUiGqaEQZo0UMDwOPLGoj2FQHQQJZ3F7EVYgRTJ/N
 Pe6DW/3E8EnXnrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9AA1136BA;
 Wed,  9 Oct 2024 08:29:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A/r1I9M+BmeeTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 08:29:07 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 10:29:02 +0200
Message-Id: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAM4+BmcC/43N0QrCIBQG4FcJrzPOnLrZVe8REZrHJrQZcxvF2
 LvnCioiorvz//B/ZyQRW4+RrBcjaXHw0YcmhWK5IIdKN0ek3qZMGDAOIpP05GNXh77p9rHTj4t
 CCUoKZK4EJGl5btH5y13d7lKu0ia01/uTIZ/b396QU6DMOW40U8boYhP7iKtDqMnMDfxFKFDfC
 Z6IXAlRMuDWOvggxJPIAMrvhEiElI5jphUW1nwQ8g9CJgKc5UIaaZRxb8Q0TTconDmifgEAAA=
 =
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728462547; l=5305;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=iWNdYKtes+HNxWfvsoqvGHLdDTW6mehar1GJNL9Mi0Y=;
 b=DafjWqA6KRiORzqo0M7A/HAG6JeMs7kzgFPMwVj30i31/TeV9rw2jdti+Bjd1T1e8IPhcGQ2N
 TTj/z6+ON8VBv1NwLZzukQ1tPgLHaqhtjS4kTObzbNuvGJ4ydB+h59I
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,lwn.net:url]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 00/16] statmount/listmount testing suites
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

This patch-set is adding new testing suites for statmount() and listmount()
syscalls, which have been recently added in kernel v6.8.
To find out more information, please read the following documentation since
there's no man pages yet:

https://lwn.net/Articles/950569/
https://lore.kernel.org/lkml/170474400576.2602.7882507604401153304.pr-tracker-bot@kernel.org/T/

Along with kernel source code:

https://github.com/torvalds/linux/blob/1b294a1f35616977caddaddf3e9d28e576a1adbc/include/uapi/linux/mount.h#L155
https://github.com/torvalds/linux/blob/1b294a1f35616977caddaddf3e9d28e576a1adbc/tools/testing/selftests/filesystems/statmount/statmount_test.c

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v7:
- fix statmount01
- add more EOVERFLOW tests in statmount07
- add more invalid tests in listmount04
- Link to v6: https://lore.kernel.org/r/20241008-listmount_statmount-v6-0-0fd456b6b9bf@suse.com

Changes in v6:
- fix statmount01
- add more EOVERFLOW tests in statmount06
- Link to v5: https://lore.kernel.org/r/20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com

Changes in v5:
- usage of sx.data.stx_mask
- use TST_EXP_EQ_STR
- use tst_tmpdir_genpath()
- use !TST_PASS instead of TST_RET == -1
- listmount03
- listmount04
- statmount08
- Link to v4: https://lore.kernel.org/r/20240909-listmount_statmount-v4-0-39558204ddf0@suse.com

Changes in v4:
- listmount01: remove all filesystems run
- listmount02: better descriptions and proper unmount()
- statmount01: check all fields are zeroed
- statmount02: check also readonly flag
- statmount03: now it checks for all mount flags
- statmount04: moved read_peer_group inside statmount.h
- statmount07: add test for invalid values
- generic style fixes 
- fix statx import
- Link to v3: https://lore.kernel.org/r/20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com

---
Andrea Cervesato (16):
      Add SAFE_STATX macro
      Add TST_EXP_EQ_STR macro
      Add listmount/statmount syscalls
      Add listmount/statmount fallback declarations
      Add listmount01 test
      Add listmount02 test
      Add statmount01 test
      Add statmount02 test
      Add statmount03 test
      Add statmount04 test
      Add statmount05 test
      Add statmount06 test
      Add statmount07 test
      Add statmount08 test
      Add listmount03 test
      Add listmount04 test

 configure.ac                                      |   2 +
 include/lapi/mount.h                              |  70 ++++++++++
 include/lapi/stat.h                               | 111 ++++++++++-----
 include/lapi/syscalls/aarch64.in                  |   2 +
 include/lapi/syscalls/arc.in                      |   2 +
 include/lapi/syscalls/arm.in                      |   2 +
 include/lapi/syscalls/hppa.in                     |   2 +
 include/lapi/syscalls/i386.in                     |   2 +
 include/lapi/syscalls/ia64.in                     |   2 +
 include/lapi/syscalls/loongarch.in                |   2 +
 include/lapi/syscalls/mips_n32.in                 |   2 +
 include/lapi/syscalls/mips_n64.in                 |   2 +
 include/lapi/syscalls/mips_o32.in                 |   2 +
 include/lapi/syscalls/powerpc.in                  |   2 +
 include/lapi/syscalls/powerpc64.in                |   2 +
 include/lapi/syscalls/s390.in                     |   2 +
 include/lapi/syscalls/s390x.in                    |   2 +
 include/lapi/syscalls/sh.in                       |   2 +
 include/lapi/syscalls/sparc.in                    |   2 +
 include/lapi/syscalls/sparc64.in                  |   2 +
 include/lapi/syscalls/x86_64.in                   |   2 +
 include/tst_test_macros.h                         |  14 ++
 runtest/syscalls                                  |  14 ++
 testcases/kernel/syscalls/listmount/.gitignore    |   4 +
 testcases/kernel/syscalls/listmount/Makefile      |   7 +
 testcases/kernel/syscalls/listmount/listmount.h   |  27 ++++
 testcases/kernel/syscalls/listmount/listmount01.c |  63 +++++++++
 testcases/kernel/syscalls/listmount/listmount02.c | 105 ++++++++++++++
 testcases/kernel/syscalls/listmount/listmount03.c |  62 +++++++++
 testcases/kernel/syscalls/listmount/listmount04.c | 162 ++++++++++++++++++++++
 testcases/kernel/syscalls/statmount/.gitignore    |   8 ++
 testcases/kernel/syscalls/statmount/Makefile      |   7 +
 testcases/kernel/syscalls/statmount/statmount.h   |  51 +++++++
 testcases/kernel/syscalls/statmount/statmount01.c |  77 ++++++++++
 testcases/kernel/syscalls/statmount/statmount02.c |  84 +++++++++++
 testcases/kernel/syscalls/statmount/statmount03.c | 138 ++++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount04.c | 105 ++++++++++++++
 testcases/kernel/syscalls/statmount/statmount05.c | 123 ++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount06.c |  68 +++++++++
 testcases/kernel/syscalls/statmount/statmount07.c | 144 +++++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount08.c |  65 +++++++++
 41 files changed, 1515 insertions(+), 32 deletions(-)
---
base-commit: 701212f08d6e850457cc2b10238f28662ef48471
change-id: 20240516-listmount_statmount-080965e2f80e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
