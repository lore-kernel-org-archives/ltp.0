Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA1606A31C
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Qp1Q/HnQ;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Wk2wMjb1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kNU+1uwQ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+U8V74Ms
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D2813EA605
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:18:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5C3A3E9E10
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4006C20096B
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1E1821DA8;
 Tue, 20 Oct 2026 10:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zBfKZiHWcAp39cEbxbBD08qrGt9ANGrez03Y3FC8+3I=;
 b=Qp1Q/HnQGdgmj8LRsKGz9CNpSB/t4w8k+hK7nyVrzN0+6CXmDbeHwDgFrGxJz8uHAitFLm
 xGNzqtGlgV0QPDAIb0d19klBgUA2IgcvXBt+nUgs20vWhbd3jgoPLjF/iHPrGjyQpaiJ/u
 f0DM30YOYlahPA6vBwZBXOi/QNdCgFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zBfKZiHWcAp39cEbxbBD08qrGt9ANGrez03Y3FC8+3I=;
 b=Wk2wMjb1Of2NvFp45R47vsSCjnc8N/V0D4pY/aVcuyQ8yGe5owiJdASB0rdRKXNIylFz7v
 NYEbPv0DJvjBCeDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kNU+1uwQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+U8V74Ms
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zBfKZiHWcAp39cEbxbBD08qrGt9ANGrez03Y3FC8+3I=;
 b=kNU+1uwQUOgccaTJgKmcFTUoVoLRONefAx8dVo9ypD510hl8hWzgMslVjOJce4K1O9SmFG
 u2jOrf3MM8L6mEx84fSJ5+sFWygmk7zNbD4RRarBIbnQlhJ6NycNPHV3dporWXpK6WavfZ
 KhzKC7xeB95OShFF5bF9xQjUy1z3SuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491392;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zBfKZiHWcAp39cEbxbBD08qrGt9ANGrez03Y3FC8+3I=;
 b=+U8V74MsOtG6meCxvER+JCATvs6IWJCsUoAmnspJHdPJoQ82eEhf3q1WrvgSvCebM87TFN
 Ua/K/rr4nNW+nGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E7A8136CC;
 Tue, 20 Oct 2026 10:16:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2PKGIA/12rCMgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:16:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:16:29 +0200
Message-Id: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAH4/12oC/2XNQQ7CIBAF0Ks0rMXAtEBx5T2MixYGi4lioG00p
 neX6qJNzax+8t+fN0kYPSZyKN4k4uiTD/ccxK4gpmvuF6Te5kyAgWQ119SZLobQUyk5F84yW2l
 FcvsR0fnnd+l0/uU0tFc0/cznRudTH+Lr+2rkc+9/deSUUbAGTJnPgT6mIeHehBuZR0dYMWALg
 8yYBLTAtFAN27ByzeqFlZlJIRtoBRcK5IZVK1byhVWZCWUMtrJ2GtSKTdP0AfDu785UAQAA
X-Change-ID: 20260819-fchroot-66115fd0d497
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491392; l=4651;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=IfdLEXfYmpAk2eVT2zd2s3rase7/hbJb0da1druV5no=;
 b=1LE7MuKW9DSA2sbh3JcDSskr2iJYke67fXMwZOTGjUCc2QgxiAQSSqImzC0bgnXyP63SVUgGQ
 d+de3zl7ZGED+EsjlKFmPUMjjV6jVMcYjApeXjPyv2h2JFav0sz68dh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D1E1821DA8
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 00/14] fchroot: add fchroot() testing suite
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

fchroot() is a new syscall introduced in Linux v7.3 together with
failfs, a kernel internal filesystem where every operation fails with
EOPNOTSUPP. The syscall is the fd-based counterpart of chroot(2): it
moves the process root to the directory referenced by a file descriptor,
or to the failfs root via the FD_FAILFS_ROOT sentinel.

The series adds lapi fallback definitions for the new fd sentinels and
adds 13 tests covering:

- the basic directory fd use case and the argument error paths
  (EINVAL, EBADF, ENOTDIR)
- the permission checks, both execute permission and CAP_SYS_CHROOT
- entering failfs as root: EOPNOTSUPP on every absolute lookup,
  unreachable working directory, root that can not be referenced or
  pinned, path walks anchored at file descriptors, execve blocked,
  fork inheritance and the setns() escape
- the unprivileged entry rules: no_new_privs, shared fs_struct and
  the already chrooted case

The testing suite creation has been assisted by GLM 5.3.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- drop syscall table commits already merged in master
- drop [STAGING] prefix and move runtest entries to runtest/syscalls
- remove redundant exit(0) in forked test processes
- fchroot04, fchroot11: use /dev/zero instead of /etc/passwd
- fchroot06: simplify upwards path construction and use SAFE_STAT()
- fchroot08, fchroot09: drop unnecessary symlink setup and open "/" directly
- fchroot09: clarify setns() escape description
- fchroot11: check unprivileged userns support before testing failfs block
- Link to v4: https://lore.kernel.org/20260831-fchroot-v4-0-57cceb68f927@suse.com

Changes in v4:
- restore fchroot08 commit
- fix descriptions
- improve setup() inside tests
- Link to v3: https://lore.kernel.org/20260828-fchroot-v3-0-656a2b515726@suse.com

Changes in v3:
- remove order specific tests inside the descriptions
- fchroot07: add child
- fix snprintf() possible overflows
- fix tests using TST_EXP_* macros
- use stat(".", ..) where it's needed
- Link to v2: https://lore.kernel.org/20260820-fchroot-v2-0-062ed20957a0@suse.com

Changes in v2:
- make description more readable
- invert fork() logic for the main test process
- fix the issues found by the agent
- Link to v1: https://lore.kernel.org/20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (14):
      lapi: fallback fchroot() parameters
      fchroot01: test fchroot() with a directory fd
      fchroot02: test fchroot() invalid arguments
      fchroot03: test fchroot() permission checks
      fchroot04: test fchroot() into failfs as root
      fchroot05: test failfs root can not be referenced
      fchroot06: test path walks under failfs root
      fchroot07: test execve blocked by failfs root
      fchroot08: test failfs root fork inheritance
      fchroot09: test setns escape from failfs root
      fchroot10: test failfs entry without no_new_privs
      fchroot11: test failfs entry with no_new_privs
      fchroot12: test failfs entry with shared fs_struct
      fchroot13: test failfs entry when chrooted

 include/lapi/fcntl.h                               |  13 +++
 runtest/syscalls                                   |  14 +++
 testcases/kernel/syscalls/fchroot/.gitignore       |  14 +++
 testcases/kernel/syscalls/fchroot/Makefile         |   7 ++
 testcases/kernel/syscalls/fchroot/fchroot01.c      |  56 ++++++++++
 testcases/kernel/syscalls/fchroot/fchroot02.c      |  75 +++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot03.c      |  70 ++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot04.c      |  67 +++++++++++
 testcases/kernel/syscalls/fchroot/fchroot05.c      |  73 ++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot06.c      | 124 +++++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot07.c      |  58 ++++++++++
 .../kernel/syscalls/fchroot/fchroot07_child.c      |  16 +++
 testcases/kernel/syscalls/fchroot/fchroot08.c      |  52 +++++++++
 testcases/kernel/syscalls/fchroot/fchroot09.c      |  68 +++++++++++
 testcases/kernel/syscalls/fchroot/fchroot10.c      |  52 +++++++++
 testcases/kernel/syscalls/fchroot/fchroot11.c      |  85 ++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot12.c      |  83 ++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot13.c      |  61 ++++++++++
 18 files changed, 988 insertions(+)
---
base-commit: 1aae0e4d9d1e2e7818fda773b372cee8fb856de7
change-id: 20260819-fchroot-66115fd0d497

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
