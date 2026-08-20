Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212DDC5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:46:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9E103CE127
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:46:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAC493CDED8
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:44:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B887E14000FD
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:44:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DCBA884F96;
 Thu, 20 Aug 2026 07:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9bFKpqoN+u4SWSwmtEdwdlRTbSypKpZ2HbwCyhs5uu0=;
 b=brqn9/+HMEC8Cg/LFOEq/zp1twT2sL/eIMUhAwCkExpViXnBAYzMZDhS+AfG9goQulLiZ9
 ntYlkoa94bwj89Kh2uM+o9uk3elxuqqXEKOovGa2gvm9gMjfLjZ0F8PXCkGDC0lhZxrb0h
 zfY9Igf6YwGtgKO2Lklhlw+Ib86qRZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9bFKpqoN+u4SWSwmtEdwdlRTbSypKpZ2HbwCyhs5uu0=;
 b=TaozhnCg6MbT26GbZRGSdbIuTtp5ZILF4usG1GF8HsT4tu+usiJmPXdT60BUiFWCKD/+ZU
 gLZJjCtWuXvV0PDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9bFKpqoN+u4SWSwmtEdwdlRTbSypKpZ2HbwCyhs5uu0=;
 b=O9fBpXx+aahYqsx/1epiWK9zSsiV8D1VGWlBJ7vfDUrKfrd2Jeo5crxL2Xi2W4kx9V9oN9
 mpFimPUiL8OItb1Lx1Yec09YLkGgMreE12BDTWph0q/+YRVR3disR9Ef1j3YAxMdpjqfcg
 Jlgcjm1/k89iVB2OZWkDhmP9CxDuVdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211883;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9bFKpqoN+u4SWSwmtEdwdlRTbSypKpZ2HbwCyhs5uu0=;
 b=+8nfJog0M91drwgaUam3y4Wq2WLGylOOVbUMH9vmyAzGLP4xVzkwupxX7Zui3mxgBn+/np
 wnt7HqKP8hETSICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A94FE27A8;
 Thu, 20 Aug 2026 07:44:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id F/VlJWuwhmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:40 +0200
Message-Id: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGiwhmoC/2WNQQ7CIBREr9L8tRhARevKe5guFD6CiaXhU6Jpu
 LtQl2ZWL3kzswBh9Ehw7haImD35MFaQmw60u40PZN5UBsml4ifRM6tdDCExpYQ4WMPNvj9Ctae
 I1r/XpevwY5rvT9Sp1ZvhPKUQP+tVFs37X82CcSaNlnpXY2V/oZlwq8MLhlLKF5kxlQOvAAAA
X-Change-ID: 20260819-fchroot-66115fd0d497
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=4952;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=AAgINonhILI7IJElFbSKE82fQVwX1tQvYB5dXkt43hk=;
 b=B4A9zOqpKK7KbF5T+ZgN7Ma2CD7G5vi7qFyPpDrS1CnHNYHnAYu4JySA6JZRagnit2EtRe5bS
 eJLoQyD2HZSC9bU0PDkJpdoqbZRRHHWgfO6+K1KxFkqUjTk+AiaAcWI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linux.it:email,
 suse.com:mid, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 00/16] fchroot: add fchroot() testing suite
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

fchroot() is a new syscall introduced in the Linux v7.3 development
cycle together with failfs, a kernel internal filesystem where every
operation fails with EOPNOTSUPP. The syscall is the fd-based
counterpart of chroot(2): it moves the process root to the directory
referenced by a file descriptor, or to the failfs root via the
FD_FAILFS_ROOT sentinel.

The series first updates the architecture syscall number tables and
adds lapi fallback definitions for the new fd sentinels, then adds 13
tests covering:

- the basic directory fd use case and the argument error paths
  (EINVAL, EBADF, ENOTDIR)
- the permission checks, both execute permission and CAP_SYS_CHROOT
- entering failfs as root: EOPNOTSUPP on every absolute lookup,
  unreachable working directory, root that can not be referenced or
  pinned, path walks anchored at file descriptors, execve blocked,
  fork inheritance and the setns() escape
- the unprivileged entry rules: no_new_privs, shared fs_struct and
  the already chrooted case

fchroot() is not part of any released kernel yet, so the tests are
added to runtest/staging and each patch carries the [STAGING] prefix
as required by the LTP ground rules.

The testing suite creation has been assisted by GLM 5.3.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- make description more readable
- invert fork() logic for the main test process
- fix the issues found by the agent
- Link to v1: https://lore.kernel.org/20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (16):
      syscalls: add v7.3 syscall numbers
      syscalls: update outdated syscall entries
      [STAGING] lapi: fallback fchroot() parameters
      [STAGING] fchroot01: test fchroot() with a directory fd
      [STAGING] fchroot02: test fchroot() invalid arguments
      [STAGING] fchroot03: test fchroot() permission checks
      [STAGING] fchroot04: test fchroot() into failfs as root
      [STAGING] fchroot05: test failfs root can not be referenced
      [STAGING] fchroot06: test path walks under failfs root
      [STAGING] fchroot07: test execve blocked by failfs root
      [STAGING] fchroot08: test failfs root fork inheritance
      [STAGING] fchroot09: test setns escape from failfs root
      [STAGING] fchroot10: test failfs entry without no_new_privs
      [STAGING] fchroot11: test failfs entry with no_new_privs
      [STAGING] fchroot12: test failfs entry with shared fs_struct
      [STAGING] fchroot13: test failfs entry when chrooted

 include/lapi/fcntl.h                          |  13 +++
 include/lapi/syscalls/arc.in                  |   3 +
 include/lapi/syscalls/arm.in                  |   4 +-
 include/lapi/syscalls/arm64.in                |   3 +
 include/lapi/syscalls/i386.in                 |   4 +-
 include/lapi/syscalls/loongarch64.in          |   3 +
 include/lapi/syscalls/mips64.in               |   5 +-
 include/lapi/syscalls/mips64n32.in            |   5 +-
 include/lapi/syscalls/mipso32.in              |   5 +-
 include/lapi/syscalls/parisc.in               |   4 +-
 include/lapi/syscalls/powerpc.in              |   4 +-
 include/lapi/syscalls/powerpc64.in            |   4 +-
 include/lapi/syscalls/s390.in                 |   5 +-
 include/lapi/syscalls/s390x.in                |   5 +-
 include/lapi/syscalls/sh.in                   |   4 +-
 include/lapi/syscalls/sparc.in                |   5 +-
 include/lapi/syscalls/sparc64.in              |   5 +-
 include/lapi/syscalls/x86_64.in               |   5 +-
 runtest/staging                               |  14 +++
 testcases/kernel/syscalls/fchroot/.gitignore  |  13 +++
 testcases/kernel/syscalls/fchroot/Makefile    |   7 ++
 testcases/kernel/syscalls/fchroot/fchroot01.c |  59 +++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot02.c |  80 ++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot03.c |  78 +++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot04.c |  70 +++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot05.c |  75 +++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot06.c | 117 ++++++++++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot07.c |  72 ++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot08.c |  69 +++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot09.c |  87 +++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot10.c |  50 +++++++++++
 testcases/kernel/syscalls/fchroot/fchroot11.c |  70 +++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot12.c |  85 +++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot13.c |  63 ++++++++++++++
 34 files changed, 1076 insertions(+), 19 deletions(-)
---
base-commit: 567528e2f809c1309802433703c083bd15ab81a8
change-id: 20260819-fchroot-66115fd0d497

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
