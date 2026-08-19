Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663D3C5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 21:25:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFBD03CD600
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 23:25:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA15D3CD6A7
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ACCE0100098F
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BFF6584CEC;
 Wed, 19 Aug 2026 21:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dEj11k5fUO7pZkhcIqb1KkosSe9OglzmsBSaoi6V+LA=;
 b=Vao/YbDMG18ZqmMyklKd37iTKkQd7Zq4n2tBei3IjuSSwZ/F8WMA3OVQDHwcNS7X+V8fxO
 3I0Uv2krz6mB65KOQ2jUbgqI8xoDJ/vzcyUKkaCXAGwRdvLnrj4HTboT7hS4gKhlFKeQrw
 8UGXSC1/MoFTjHCP3PDjqwyiCMtguEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174664;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dEj11k5fUO7pZkhcIqb1KkosSe9OglzmsBSaoi6V+LA=;
 b=SCxq0Xd75s37rwu2FSkgVxpsUsoHOI46Vg8jaF8kHxINhVasDOOVQJMufVV+L1Jr/ojAQO
 TJUuAnoXoSvfAhCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PFNOPAo9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kwyjYXMw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dEj11k5fUO7pZkhcIqb1KkosSe9OglzmsBSaoi6V+LA=;
 b=PFNOPAo9X4LAEu48/mGI03jy9ERSm4iA0E7iLHpRa82y5hpoUUUs6lHSBaCBGl+OoG73yN
 sWHhlCJvv3vWSIofKfKq7DMLUbLGiG1DFY0vCvzfpIqKVDRcX7A0AvbVbisNzF+ziqBthU
 3EExu3u1Tn16gmAzjkaxBOOptfq+RAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dEj11k5fUO7pZkhcIqb1KkosSe9OglzmsBSaoi6V+LA=;
 b=kwyjYXMwAMyzq/f2qnkRRWrYTqnyr79YRQzEXbbe6ihscRLv5f4id2TP89I/MOCgwVpT0g
 aYWhYjNjK/ejIACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CC802F81;
 Wed, 19 Aug 2026 21:24:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cBgbNgIfhmqSGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Aug 2026 21:24:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 23:24:15 +0200
Message-Id: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP8ehmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0NL3bTkjKL8/BJdMzNDQ9O0FIMUE0tzJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tACFyhulrAAAA
X-Change-ID: 20260819-fchroot-66115fd0d497
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787174658; l=4695;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=0idKCZsvpSSh8CeQviSg0N+V8EP1sqkhfPfQDA4NZH8=;
 b=3EJQ5hP2G536zm3dAu+d+e9AR/tNP8PeVNk+05nwPRfMnZPIUWaZiCgZagW2H9IPAwnnhy5gP
 6aeX9HgVbsxCmtUn+D3tFWGcuLEcpJ9QHveVBDxJKoR+DwI1wlXMax6
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: BFF6584CEC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/16] fchroot: add fchroot() testing suite
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
Andrea Cervesato (16):
      syscalls: add v7.3 syscall numbers
      syscalls: update outdated syscall entries
      lapi: fallback fchroot() parameters
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

 include/lapi/fcntl.h                          | 13 ++++
 include/lapi/syscalls/arc.in                  |  3 +
 include/lapi/syscalls/arm.in                  |  4 +-
 include/lapi/syscalls/arm64.in                |  3 +
 include/lapi/syscalls/i386.in                 |  4 +-
 include/lapi/syscalls/loongarch64.in          |  3 +
 include/lapi/syscalls/mips64.in               |  5 +-
 include/lapi/syscalls/mips64n32.in            |  5 +-
 include/lapi/syscalls/mipso32.in              |  5 +-
 include/lapi/syscalls/parisc.in               |  4 +-
 include/lapi/syscalls/powerpc.in              |  4 +-
 include/lapi/syscalls/powerpc64.in            |  4 +-
 include/lapi/syscalls/s390.in                 |  5 +-
 include/lapi/syscalls/s390x.in                |  5 +-
 include/lapi/syscalls/sh.in                   |  4 +-
 include/lapi/syscalls/sparc.in                |  5 +-
 include/lapi/syscalls/sparc64.in              |  5 +-
 include/lapi/syscalls/x86_64.in               |  5 +-
 runtest/staging                               | 14 +++++
 testcases/kernel/syscalls/fchroot/.gitignore  | 13 ++++
 testcases/kernel/syscalls/fchroot/Makefile    |  7 +++
 testcases/kernel/syscalls/fchroot/fchroot01.c | 57 +++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot02.c | 80 ++++++++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot03.c | 77 +++++++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot04.c | 66 ++++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot05.c | 75 ++++++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot06.c | 90 +++++++++++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot07.c | 71 +++++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot08.c | 52 ++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot09.c | 70 +++++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot10.c | 49 +++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot11.c | 74 ++++++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot12.c | 82 ++++++++++++++++++++++++
 testcases/kernel/syscalls/fchroot/fchroot13.c | 62 ++++++++++++++++++
 34 files changed, 1006 insertions(+), 19 deletions(-)
---
base-commit: 567528e2f809c1309802433703c083bd15ab81a8
change-id: 20260819-fchroot-66115fd0d497

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
