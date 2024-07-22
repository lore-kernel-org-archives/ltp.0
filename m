Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E0FC3DA5D
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 14:31:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 605CE3D1BF5
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 16:31:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1735C3D1BE7
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 16:29:34 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE1171000D55
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 16:29:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 69C3021B11;
 Mon, 22 Jul 2024 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721658564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UCzksuM07QBz5colSHQw704sneeVlDjs62yecON6ctg=;
 b=IuNIVXpz9KyRWM7UY5Nx58QufwErfVvKDO/SE0qfeX+dot9VZRMNcyYPkD119weawTrFX9
 N6DZBXOJ6ZqCSjmcEfeB59C8f0PFuL5cXGsBNuU+GI1xCqIBs+nzZMHaXZULo1UtZJ3gwT
 ytyN7mdCQs1xLBSxZmE2clYddAOAlt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721658564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UCzksuM07QBz5colSHQw704sneeVlDjs62yecON6ctg=;
 b=k8vAEiureOxqHygWp1Y69u4+fDUfFiKWVbBVMdY/WcWokwy8BD+0OqHc+dx7S6jJvGoaGp
 nOEUYMRqVH8H2ZCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IuNIVXpz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k8vAEiur
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721658564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UCzksuM07QBz5colSHQw704sneeVlDjs62yecON6ctg=;
 b=IuNIVXpz9KyRWM7UY5Nx58QufwErfVvKDO/SE0qfeX+dot9VZRMNcyYPkD119weawTrFX9
 N6DZBXOJ6ZqCSjmcEfeB59C8f0PFuL5cXGsBNuU+GI1xCqIBs+nzZMHaXZULo1UtZJ3gwT
 ytyN7mdCQs1xLBSxZmE2clYddAOAlt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721658564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UCzksuM07QBz5colSHQw704sneeVlDjs62yecON6ctg=;
 b=k8vAEiureOxqHygWp1Y69u4+fDUfFiKWVbBVMdY/WcWokwy8BD+0OqHc+dx7S6jJvGoaGp
 nOEUYMRqVH8H2ZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41508136A9;
 Mon, 22 Jul 2024 14:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7+cBDsRsnmazSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 22 Jul 2024 14:29:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 22 Jul 2024 16:28:39 +0200
Message-Id: <20240722-cachestat-v3-0-a0386f7cdaaa@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJdsnmYC/1XMQQ7CIBCF4as0sxYDWAJx5T1MFxM6CAtbwyDRN
 NxdrCuX/8vLtwFTTsRwHjbIVBOndelxOgzgIy43EmnuDVrqURplhEcfiQsWoVTwTmOQljz0/yN
 TSK/duk69Y+Ky5vdOV/1df4r9U6oWUhjjlMVZ4SjdhZ9MR7/eYWqtfQDG1GD9oQAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2873;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=lb1ohFgZoyfFgeq8ekaLFSNAq8frelCnmZ0hQVHJKF8=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmnmydNedI/MJLx0gu3EWe2XffuW5G+bTWvJFmL
 vcKun97396JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp5snQAKCRDLzBqyILPm
 Rv/TDACEwCSEOsDwp8tfJO2VDF67At9o8kSrMRAgZgAYkZdBDfkjVLP0FUliMjqpWi2rNq+5y7D
 FWlGl2Qopt2GZWg2U7xYdg+m+bCbIvVZbcBTKr4YQDFc2A7dAiLwyo5ehebFJT0pjFBT1CJylMU
 dASTpocoxM2LpcoQClipnTuo9SypLJwW45VjgHf525nHQObCGqJTjUgcaBDSsRR0fQ6O2PT7EzE
 DnYsowFzveqlFxwHjbDanafZdFqUmL7dgj5qO+RYqWXMMjcT1hl/YsfaRgRFitK4Il421Rh/Tha
 08+3NHC7/ZfQyL2eYecBlkqepMmQyx1e8EJ7caWlMKx0P0HB5vtSc0Y3rvjFYDY8uSmnt2IUkSP
 fl5FYNVyFG5XBkJenfbmRna0jUSfUHNKs2fnHi0AxuURaffcMtEZ1FJ1TDJ+YEnJVL7fZJAxu8e
 Ha8IWmLN25uqRwLoTio7EERA8njN14DgIUYT1rsWSedv07y9nOXwvXNUnCl35VyYmLocs=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 69C3021B11
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/5] cachestat testing suite
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

This suite is adding covergae for the cachestat() syscall which is
providing support for reading the file cache status and it has been
added in the kernel 6.5.

There's not a man page yet, so please consider the following link as
documentation:
https://lwn.net/Articles/917059/

---
Changes in v3:
- include stdlib.h when free() is used
- add cachestat04 test looping on all file descriptors
- Link to v2: https://lore.kernel.org/r/20240715-cachestat-v2-0-55817ad1a408@suse.com

Changes in v2:
- cachestat01: run test on multiple test pages
- remove cachestat01A
- cachestat02: run test on multiple test pages
- add new cachestat03 test

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>

---
Andrea Cervesato (5):
      Add cachestat fallback definitions
      Add cachestat01 test
      Add cachestat02 test
      Add cachestat03 test
      Add cachestat04 test

 configure.ac                                      |   4 +
 include/lapi/mman.h                               |  44 +++++++++
 include/lapi/syscalls/aarch64.in                  |   1 +
 include/lapi/syscalls/arc.in                      |   1 +
 include/lapi/syscalls/arm.in                      |   1 +
 include/lapi/syscalls/hppa.in                     |   1 +
 include/lapi/syscalls/i386.in                     |   1 +
 include/lapi/syscalls/ia64.in                     |   1 +
 include/lapi/syscalls/loongarch.in                |   1 +
 include/lapi/syscalls/mips_n32.in                 |   1 +
 include/lapi/syscalls/mips_n64.in                 |   1 +
 include/lapi/syscalls/mips_o32.in                 |   1 +
 include/lapi/syscalls/powerpc.in                  |   1 +
 include/lapi/syscalls/powerpc64.in                |   1 +
 include/lapi/syscalls/s390.in                     |   1 +
 include/lapi/syscalls/s390x.in                    |   1 +
 include/lapi/syscalls/sh.in                       |   1 +
 include/lapi/syscalls/sparc.in                    |   1 +
 include/lapi/syscalls/sparc64.in                  |   1 +
 include/lapi/syscalls/x86_64.in                   |   1 +
 runtest/syscalls                                  |   5 +
 testcases/kernel/syscalls/cachestat/.gitignore    |   4 +
 testcases/kernel/syscalls/cachestat/Makefile      |  10 ++
 testcases/kernel/syscalls/cachestat/cachestat.h   |  27 ++++++
 testcases/kernel/syscalls/cachestat/cachestat01.c | 106 ++++++++++++++++++++++
 testcases/kernel/syscalls/cachestat/cachestat02.c |  90 ++++++++++++++++++
 testcases/kernel/syscalls/cachestat/cachestat03.c |  80 ++++++++++++++++
 testcases/kernel/syscalls/cachestat/cachestat04.c |  58 ++++++++++++
 28 files changed, 446 insertions(+)
---
base-commit: 2433c503a6657273da895e36adda73942452c482
change-id: 20240515-cachestat-11fc82af07ec

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
