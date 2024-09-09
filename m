Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1E5ECE579
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 10:01:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30E573C0F7B
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 12:01:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E1553C1422
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:32 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6EBE1206C28
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8725821BDE;
 Mon,  9 Sep 2024 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g9kGx3dPIjDyz5JqEGWWJ26TuxEZgSTJm7KBhtqUghQ=;
 b=G+3PUhjI3bozqJNQnYOL8nf/zvttke3qJ8uGg+CxlikcL3+BzVKO9gQBVUd1qhxtOeMggw
 eTs9Q/8LADv1hP10MVm47jCD803TYkgNI0f8xIUKAcwwJwN+2yV5fO858dWiUS3VQxei8P
 V/iXsgrYDt1tgMXifMMVdBE1Yzl2nCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g9kGx3dPIjDyz5JqEGWWJ26TuxEZgSTJm7KBhtqUghQ=;
 b=3N6X/N5igcw4ISTk0XR37Z8a+T3X+/g/PE/bqZIAQrfUaV9gaCa82CLnVPeyzpT3ag4Jkw
 i9W4EH2vDiFx3wCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g9kGx3dPIjDyz5JqEGWWJ26TuxEZgSTJm7KBhtqUghQ=;
 b=G+3PUhjI3bozqJNQnYOL8nf/zvttke3qJ8uGg+CxlikcL3+BzVKO9gQBVUd1qhxtOeMggw
 eTs9Q/8LADv1hP10MVm47jCD803TYkgNI0f8xIUKAcwwJwN+2yV5fO858dWiUS3VQxei8P
 V/iXsgrYDt1tgMXifMMVdBE1Yzl2nCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g9kGx3dPIjDyz5JqEGWWJ26TuxEZgSTJm7KBhtqUghQ=;
 b=3N6X/N5igcw4ISTk0XR37Z8a+T3X+/g/PE/bqZIAQrfUaV9gaCa82CLnVPeyzpT3ag4Jkw
 i9W4EH2vDiFx3wCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D405713312;
 Mon,  9 Sep 2024 10:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A5MPJzrH3mb+DgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 09 Sep 2024 10:00:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 09 Sep 2024 12:00:22 +0200
Message-Id: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADbH3mYC/32NQQ7CIBREr9L8tRiktLauvIdpDNSPJbFg+JRoG
 u4u1r27eZO8mRUIg0WCU7VCwGTJeldA7ioYJ+XuyOytMAguJG8OLXtYirNfXLxSVL/EeMf7tkF
 hOo5QzGdAY1/b6mUoPBXHh/d2kupv+38v1YwzYYzUSvRaq+OZFsL96GcYcs4foNIgLLUAAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725876026; l=4503;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=+UQwr8mEUFsBZZv3Ji79B56Rz8XRs1x1gBm5MsrJzl0=;
 b=FNPNiQCj5kVRgh6F7HKQw0jl6/J0mSK1eW0J9CexxednLn9XXLANLUZEp75jhNGAcLnru3vpk
 2ko6xHbZo2aDcTMZFPP7dqd1pFtrJKOeyO3DtftLZuDP2swbu03FiFb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 00/13] statmount/listmount testing suites
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
Andrea Cervesato (13):
      Add SAFE_STATX macro
      Add listmount/statmount syscalls
      Add listmount/statmount fallback declarations
      Add listmount01 test
      Add listmount02 test
      Add statmount01 test
      Add statmount02 test
      Add statmount03 test
      Add statmount04 test
      Add statmount05 test
      Add TST_EXP_EQ_STR macro
      Add statmount06 test
      Add statmount07 test

 compile_flags.txt                                  |   1 +
 configure.ac                                       |   4 +
 include/lapi/mount.h                               |  70 +++++++++++
 include/lapi/stat.h                                | 111 ++++++++++++-----
 include/lapi/syscalls/aarch64.in                   |   2 +
 include/lapi/syscalls/arc.in                       |   2 +
 include/lapi/syscalls/arm.in                       |   2 +
 include/lapi/syscalls/hppa.in                      |   2 +
 include/lapi/syscalls/i386.in                      |   2 +
 include/lapi/syscalls/ia64.in                      |   2 +
 include/lapi/syscalls/loongarch.in                 |   2 +
 include/lapi/syscalls/mips_n32.in                  |   2 +
 include/lapi/syscalls/mips_n64.in                  |   2 +
 include/lapi/syscalls/mips_o32.in                  |   2 +
 include/lapi/syscalls/powerpc.in                   |   2 +
 include/lapi/syscalls/powerpc64.in                 |   2 +
 include/lapi/syscalls/s390.in                      |   2 +
 include/lapi/syscalls/s390x.in                     |   2 +
 include/lapi/syscalls/sh.in                        |   2 +
 include/lapi/syscalls/sparc.in                     |   2 +
 include/lapi/syscalls/sparc64.in                   |   2 +
 include/lapi/syscalls/x86_64.in                    |   2 +
 include/tst_test_macros.h                          |  14 +++
 runtest/syscalls                                   |  11 ++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c |   2 +
 testcases/kernel/syscalls/listmount/.gitignore     |   2 +
 testcases/kernel/syscalls/listmount/Makefile       |   7 ++
 testcases/kernel/syscalls/listmount/listmount.h    |  26 ++++
 testcases/kernel/syscalls/listmount/listmount01.c  |  63 ++++++++++
 testcases/kernel/syscalls/listmount/listmount02.c  | 105 ++++++++++++++++
 testcases/kernel/syscalls/statmount/.gitignore     |   7 ++
 testcases/kernel/syscalls/statmount/Makefile       |   7 ++
 testcases/kernel/syscalls/statmount/statmount.h    |  50 ++++++++
 testcases/kernel/syscalls/statmount/statmount01.c  |  82 ++++++++++++
 testcases/kernel/syscalls/statmount/statmount02.c  |  84 +++++++++++++
 testcases/kernel/syscalls/statmount/statmount03.c  | 137 +++++++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount04.c  | 105 ++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount05.c  | 128 +++++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount06.c  |  68 ++++++++++
 testcases/kernel/syscalls/statmount/statmount07.c  |  75 +++++++++++
 40 files changed, 1163 insertions(+), 32 deletions(-)
---
base-commit: 6df425bb7040e1c849cb84a83f5e8808967efc0e
change-id: 20240516-listmount_statmount-080965e2f80e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
