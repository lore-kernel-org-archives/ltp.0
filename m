Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2F4C61DBD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:13:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B68C3E5E0E
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 16:13:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A4F83E2FCB
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:12:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0FAAA1A000F1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:11:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A62021F01;
 Fri, 28 Aug 2026 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mHCAiFLIKIC4Tfpqfo4TckOv17vCsmMycQhLjyJwlgI=;
 b=1lLYW/aGbzunBHznH7G9gIEx68Ngx2RffB6moN3k6/Hri0SAH/pTZwMWUgfbzGIUSpVbWA
 3QzSKZfCU+SYe31FR6FaIzEGcyHUR+VPPkv/nGSr4dz6BAgqWFABZZ1LDFUax0iRFSAGFu
 4sHo/COQ5pdRTLfI0Z7cdpW7+c/C3KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mHCAiFLIKIC4Tfpqfo4TckOv17vCsmMycQhLjyJwlgI=;
 b=oUwgFyjVT7jRJMr0zaT4Bwy/WeZ8ktEh/wnkMiFJu/cFlSJI1jy5+EU7Un2djSfJEWXfgq
 XGoGaWYLpOqYEOAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mHCAiFLIKIC4Tfpqfo4TckOv17vCsmMycQhLjyJwlgI=;
 b=x7Pe5VrOo/dZml8YnheNG6RQMMT0/2XQRq97QqUsZvurEBf6T7iFqaGmef3MeaumriZ6WL
 B/5tHYKGUABG41Pa2lRjSloltsa3/RtWELJ9rBeWAf7NO3QdT+cUI1uzrOgGflHryoKPwM
 MmOxU7YN+0k8OLqW4NPcTGvbCDVUvic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mHCAiFLIKIC4Tfpqfo4TckOv17vCsmMycQhLjyJwlgI=;
 b=uRKVMEqEdMJtrsGD7L5Oi/OoWgux+/QkwBEc/YqhcnwIhofmAZ26uVNT8r6Kw5SCdn5JHQ
 UP7b2N+mniw2iPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C58713515;
 Fri, 28 Aug 2026 14:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WIEYESCXkWpoGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 14:11:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 16:11:34 +0200
Message-Id: <20260828-fchroot-v3-0-656a2b515726@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABaXkWoC/2WNQQ7CIBBFr9KwFjNMLRVX3sO4qDBYTBQDLdE0v
 btQFzYxs3rJe38mFik4iuxQTSxQctH5R4Z6UzHdd48rcWcyMwSUsBeKW90H7wcupRCNNWB2qmX
 Zfgay7rUsnc5fjuPlRnooeTF6Fwcf3surJIr3v5oEB45Go67zWVTHOEbaan9nZTThKkP4ZZgzk
 EgGQTVtB6tsnucPK6bG0OYAAAA=
X-Change-ID: 20260819-fchroot-66115fd0d497
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787926304; l=5358;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=tjR8iqzTWcr855s8YKE/ynk9t+0WqJTgVMnX+3w4fgU=;
 b=cZpj1oReAWEcBuyejNiosfjXrW13A5/0PkBIY1MStUYi6jA1yIcwHFP5+JVWPiZNkqj5+ZYN3
 iIEp5ckYNFvDdQW9hYEbz5Kn0WV9evRHOEBpRSTQ65ArAg4tf6C9gUh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email, linux.it:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 00/15] fchroot: add fchroot() testing suite
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
Andrea Cervesato (15):
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
      [STAGING] fchroot09: test setns escape from failfs root
      [STAGING] fchroot10: test failfs entry without no_new_privs
      [STAGING] fchroot11: test failfs entry with no_new_privs
      [STAGING] fchroot12: test failfs entry with shared fs_struct
      [STAGING] fchroot13: test failfs entry when chrooted

 include/lapi/fcntl.h                               |  13 +++
 include/lapi/syscalls/arc.in                       |   3 +
 include/lapi/syscalls/arm.in                       |   4 +-
 include/lapi/syscalls/arm64.in                     |   3 +
 include/lapi/syscalls/i386.in                      |   4 +-
 include/lapi/syscalls/loongarch64.in               |   3 +
 include/lapi/syscalls/mips64.in                    |   5 +-
 include/lapi/syscalls/mips64n32.in                 |   5 +-
 include/lapi/syscalls/mipso32.in                   |   5 +-
 include/lapi/syscalls/parisc.in                    |   4 +-
 include/lapi/syscalls/powerpc.in                   |   4 +-
 include/lapi/syscalls/powerpc64.in                 |   4 +-
 include/lapi/syscalls/s390.in                      |   5 +-
 include/lapi/syscalls/s390x.in                     |   5 +-
 include/lapi/syscalls/sh.in                        |   4 +-
 include/lapi/syscalls/sparc.in                     |   5 +-
 include/lapi/syscalls/sparc64.in                   |   5 +-
 include/lapi/syscalls/x86_64.in                    |   5 +-
 runtest/staging                                    |  14 +++
 testcases/kernel/syscalls/fchroot/.gitignore       |  14 +++
 testcases/kernel/syscalls/fchroot/Makefile         |   7 ++
 testcases/kernel/syscalls/fchroot/fchroot01.c      |  58 ++++++++++
 testcases/kernel/syscalls/fchroot/fchroot02.c      |  75 ++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot03.c      |  72 ++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot04.c      |  70 ++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot05.c      |  75 ++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot06.c      | 126 +++++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot07.c      |  56 +++++++++
 .../kernel/syscalls/fchroot/fchroot07_child.c      |  16 +++
 testcases/kernel/syscalls/fchroot/fchroot08.c      |  69 +++++++++++
 testcases/kernel/syscalls/fchroot/fchroot09.c      |  86 ++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot10.c      |  50 ++++++++
 testcases/kernel/syscalls/fchroot/fchroot11.c      |  70 ++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot12.c      |  85 ++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot13.c      |  63 +++++++++++
 35 files changed, 1073 insertions(+), 19 deletions(-)
---
base-commit: 3c0271a307bd765c2fd652c325762a90ddf5d46f
change-id: 20260819-fchroot-66115fd0d497

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
