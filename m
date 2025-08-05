Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632DFC87FD1
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 07:02:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56A5B3C7BD5
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 09:02:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3D613C19EB
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 09:01:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C241A14010E6
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 09:01:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 92F8F2174C;
 Tue,  5 Aug 2025 07:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754377311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hr2QjFNXSc1jaiTJYufcG7aN4L39+8ekij0csdM9LpU=;
 b=ivRXVd9G1Ac0HWKt5KpnyKfsd4J6CbgQZiYOxtTnaNjmcA30M3QxJfzwDq7Qecci5783cS
 OOlpTaswMpP8Z7ruGvoTNbxspqobMlX3nCCXefPbibVMGBbjTQWEoKmrTHXN2J1k/YDsaD
 caklZx0xC49GswWuH3pLNv0vJD9SdSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754377311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hr2QjFNXSc1jaiTJYufcG7aN4L39+8ekij0csdM9LpU=;
 b=IOhJQlEtdaD5x4FbPa83X0YSEdUMo0DmL2FdUOQgR+M0E60B/jzqT4nLESqGuxhDlfrxZC
 nOimmDNBBBdxmOAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ivRXVd9G;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IOhJQlEt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754377311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hr2QjFNXSc1jaiTJYufcG7aN4L39+8ekij0csdM9LpU=;
 b=ivRXVd9G1Ac0HWKt5KpnyKfsd4J6CbgQZiYOxtTnaNjmcA30M3QxJfzwDq7Qecci5783cS
 OOlpTaswMpP8Z7ruGvoTNbxspqobMlX3nCCXefPbibVMGBbjTQWEoKmrTHXN2J1k/YDsaD
 caklZx0xC49GswWuH3pLNv0vJD9SdSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754377311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hr2QjFNXSc1jaiTJYufcG7aN4L39+8ekij0csdM9LpU=;
 b=IOhJQlEtdaD5x4FbPa83X0YSEdUMo0DmL2FdUOQgR+M0E60B/jzqT4nLESqGuxhDlfrxZC
 nOimmDNBBBdxmOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 637D913A50;
 Tue,  5 Aug 2025 07:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JlbPFV+skWgiGgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 05 Aug 2025 07:01:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Aug 2025 09:01:48 +0200
Message-Id: <20250805-file_setattr_getattr-v3-0-67a7747d226c@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFyskWgC/43NSwrCMBCA4auUWRvJo+lr5T1ESk2n7YC2ksSgl
 N7dtCK4cOFq+AfmmxkcWkIHVTKDxUCOpjGG2iVghmbskVEbGySXmhdcsI4uWDv0jfe27t+T5Wm
 Zqa7V8sw1xNObxY4eG3s8xR7I+ck+ty9BrNsPmP4Gg2CcZU2qjCozaYr84O4O92a6wuoF+Y8hV
 0ML1ByNLvHbWJblBSw3jeb7AAAA
X-Change-ID: 20250801-file_setattr_getattr-74963fd52b05
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754377311; l=2701;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=T1Qx5JEI1kuq1sIzD/08iCGE3BqedoR6CgG3CW217Qo=;
 b=KeqS0VmDTqUWAyaPTjIghW8Pk3v35VIwD5QW1oTYkZHRdNUpaL6EuAGLhrO31i8YNyhEJQ5Zt
 dPXYnKL3ATsByj1cyOz7T5L6luOWEp/HI6FlqvamARDj1D8putN/TjN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 92F8F2174C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/6] file_setattr/file_getattr testing suite
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
Changes in v3:
- fix fallback for fsxattr flags attributes
- Link to v2: https://lore.kernel.org/r/20250804-file_setattr_getattr-v2-0-651e50ec59e7@suse.com

Changes in v2:
- remove unrelated files
- fix fs.h ifndef
- Link to v1: https://lore.kernel.org/r/20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com

---
Andrea Cervesato (6):
      Update LTP to the latest syscalls
      fs: add struct fsxattr fallback definitions
      fs: add file_setattr/file_getattr fallback definitions
      Add file_attr01 test
      Add file_attr02 test
      Add file_attr03 test

 configure.ac                                      |   3 +
 include/lapi/fs.h                                 |  64 ++++++++
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
 runtest/syscalls                                  |   4 +
 testcases/kernel/syscalls/file_attr/.gitignore    |   3 +
 testcases/kernel/syscalls/file_attr/Makefile      |   8 +
 testcases/kernel/syscalls/file_attr/file_attr01.c | 171 ++++++++++++++++++++++
 testcases/kernel/syscalls/file_attr/file_attr02.c |  94 ++++++++++++
 testcases/kernel/syscalls/file_attr/file_attr03.c |  81 ++++++++++
 25 files changed, 547 insertions(+)
---
base-commit: b62b831cf0ba0420d4f2d4db2989ea0ad139d398
change-id: 20250801-file_setattr_getattr-74963fd52b05

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
