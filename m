Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F9DC87FD1
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 17:45:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A1F33C6A5A
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 19:45:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93EE13C65E7
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 19:44:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D82B71400B8E
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 19:44:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 303202125A;
 Tue,  5 Aug 2025 17:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754415883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=13OjI1ULvsDeItdALso2jbQNjsB1MmbCRwBVglNNqNQ=;
 b=D87kmNDjwkaWi3+NAAueFzChrAhtGWwWEwsN7LDzl2jpbRAcfwZsnwaSNhj6Ho/jI/+4Yf
 LjHfRpVNcfmX8r83OIZtcf2LCRzkDBe6RcnUAxPObkYjfPunoCEE2M5PTZO3Zua2Jbf/X5
 btdeI7/vY0qZoD2IQEWf4+66uHxT/rY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754415883;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=13OjI1ULvsDeItdALso2jbQNjsB1MmbCRwBVglNNqNQ=;
 b=0IwHyK8m9hPXji5WatkeQESH7eMpQLkA9jP8E1tnYzAf43Bo1eRFFOJMR6nIzD8K0MoZUf
 f4fL94fGoEH3D/AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754415883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=13OjI1ULvsDeItdALso2jbQNjsB1MmbCRwBVglNNqNQ=;
 b=D87kmNDjwkaWi3+NAAueFzChrAhtGWwWEwsN7LDzl2jpbRAcfwZsnwaSNhj6Ho/jI/+4Yf
 LjHfRpVNcfmX8r83OIZtcf2LCRzkDBe6RcnUAxPObkYjfPunoCEE2M5PTZO3Zua2Jbf/X5
 btdeI7/vY0qZoD2IQEWf4+66uHxT/rY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754415883;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=13OjI1ULvsDeItdALso2jbQNjsB1MmbCRwBVglNNqNQ=;
 b=0IwHyK8m9hPXji5WatkeQESH7eMpQLkA9jP8E1tnYzAf43Bo1eRFFOJMR6nIzD8K0MoZUf
 f4fL94fGoEH3D/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04BEF13A50;
 Tue,  5 Aug 2025 17:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pcqoOQpDkmhaFQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 05 Aug 2025 17:44:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Aug 2025 19:44:39 +0200
Message-Id: <20250805-file_setattr_getattr-v5-0-2bc4d18e0033@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAdDkmgC/43NUQuCMBDA8a8ie24xbzunPfU9ImLOMweVsZkU4
 ndvGoFEQU/H/+B+N7BA3lFgm2RgnnoXXHuJgauE2cZcjsRdFZuBABS5SHntTnQI1Jmu84fja3K
 tikzWFUIpkMXTq6fa3Wd2t4/duNC1/jF/6dNp+wbVd7BPueCZUdLKIgOb6224BVrb9swmr4d/D
 JgMTAkFWSzo05BLA38YcjK00VrpCiCzH4b6x1DREDmBlKhMafOFMY7jE4Cx6ymDAQAA
X-Change-ID: 20250801-file_setattr_getattr-74963fd52b05
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754415882; l=3334;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=P9A9PZasu2fzNHF73Pjk2rNKdREP4gHQWIdpJ4Lz+bo=;
 b=SsNKmewVVgABQyVVaJMiA/NR8GIFhVgLr1jUR114MDVJGAuif/sgl9DpXxd976kFeo/0f0O+y
 IZQFroR8KzZDiKvJXjJ15lHRe69aKBpbyv59uhlLPVx9Eo/zImbMbu1
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/7] file_setattr/file_getattr testing suite
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

This testing suite is validating file_getattr and file_setattr
syscalls, introducing tests for error validation and basic
functionalities. These features have been introduced in the kernel 6.17.

https://lore.kernel.org/lkml/20250725-vfs-fileattr-fcfc534aac44@brauner/

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- file_attr04: only check for ENOTDIR
- Link to v4: https://lore.kernel.org/r/20250805-file_setattr_getattr-v4-0-08e23354abc8@suse.com

Changes in v4:
- import <linux/fs.h> in lapi/fs.h via HAVE_LINUX_FS
- file_attr01: initialize variables via .bufs and add one more test case
  for invalid usize
- file_attr02: avoid setting file desc to -1
- file_attr03: make use of AT_FWD
- add file_attr04 test
- Link to v3: https://lore.kernel.org/r/20250805-file_setattr_getattr-v3-0-67a7747d226c@suse.com

Changes in v3:
- fix fallback for fsxattr flags attributes
- Link to v2: https://lore.kernel.org/r/20250804-file_setattr_getattr-v2-0-651e50ec59e7@suse.com

Changes in v2:
- remove unrelated files
- fix fs.h ifndef
- Link to v1: https://lore.kernel.org/r/20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com

---
Andrea Cervesato (7):
      Update LTP to the latest syscalls
      fs: add struct fsxattr fallback definitions
      fs: add file_setattr/file_getattr fallback definitions
      Add file_attr01 test
      Add file_attr02 test
      Add file_attr03 test
      Add file_attr04 test

 configure.ac                                      |   4 +
 include/lapi/fs.h                                 |  66 +++++++-
 include/lapi/syscalls/arc.in                      |   7 +
 include/lapi/syscalls/arm.in                      |   7 +
 include/lapi/syscalls/arm64.in                    |   7 +
 include/lapi/syscalls/i386.in                     |   7 +
 include/lapi/syscalls/loongarch64.in              |   7 +
 include/lapi/syscalls/mips64.in                   |   7 +
 include/lapi/syscalls/mips64n32.in                |   7 +
 include/lapi/syscalls/mipso32.in                  |   7 +
 include/lapi/syscalls/parisc.in                   |   7 +
 include/lapi/syscalls/powerpc.in                  |   7 +
 include/lapi/syscalls/powerpc64.in                |   7 +
 include/lapi/syscalls/s390.in                     |   7 +
 include/lapi/syscalls/s390x.in                    |   7 +
 include/lapi/syscalls/sh.in                       |   7 +
 include/lapi/syscalls/sparc.in                    |   7 +
 include/lapi/syscalls/sparc64.in                  |   7 +
 include/lapi/syscalls/x86_64.in                   |   7 +
 runtest/syscalls                                  |   5 +
 testcases/kernel/syscalls/file_attr/.gitignore    |   4 +
 testcases/kernel/syscalls/file_attr/Makefile      |   8 +
 testcases/kernel/syscalls/file_attr/file_attr01.c | 178 ++++++++++++++++++++++
 testcases/kernel/syscalls/file_attr/file_attr02.c |  92 +++++++++++
 testcases/kernel/syscalls/file_attr/file_attr03.c |  76 +++++++++
 testcases/kernel/syscalls/file_attr/file_attr04.c |  62 ++++++++
 26 files changed, 613 insertions(+), 1 deletion(-)
---
base-commit: b62b831cf0ba0420d4f2d4db2989ea0ad139d398
change-id: 20250801-file_setattr_getattr-74963fd52b05

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
