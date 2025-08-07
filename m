Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CFCC87FCF
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 07:03:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0011F3C90E1
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 09:03:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE05C3C8F7A
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 09:01:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B75F61400DA7
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 09:01:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 904921F7F4;
 Thu,  7 Aug 2025 07:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754550103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z7VVGN9Q6CfSG3bkySFCIWuEiFDOhAuhQCX6P/1wHjA=;
 b=pE4idb+Z3sxAlSha/36B+/gYi02R4I4dfYDgUU9SwreGDyMrqVSUyE1RUmnqN/CpadlR9x
 oqWLs5SBycKWwU5IoStsaEahN2JBWeTZiZLeWcaghtpC7+jJbRLtHLYfobGmNruAcZ7KCj
 uSzWRpEooQbEZz6o+x3PIl6sm//Xbf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754550103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z7VVGN9Q6CfSG3bkySFCIWuEiFDOhAuhQCX6P/1wHjA=;
 b=WgZMtwNvJezHAHKkhWQVQ9q1iCwkSWwp5D+kvfWPY8NfPwsKN26JYUbLhWNI/Y1eBrDAjU
 ZStP9kg7ToGalODw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754550102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z7VVGN9Q6CfSG3bkySFCIWuEiFDOhAuhQCX6P/1wHjA=;
 b=1VRz+y5Wyi8lssx9ebMfvzcNk2Tb6TpfSMIEohGyVw+wztaVZ7RZzzxwlT8hQgSOlstUZz
 VxUO8oqnKxLrSFRboGzJhaOs5gclDTnnFVoptxWPAZcOD4qZtwNqgnvITKDwvUS1TyKfj7
 EZ+jOj7GDKwtPDIGpDem514jSWaV6Sg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754550102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z7VVGN9Q6CfSG3bkySFCIWuEiFDOhAuhQCX6P/1wHjA=;
 b=FkRekMJewBHBdFYLNJgG14r4ycsNZOemPyF9qVJ8CNBPJ0aN9CwZVorseDrWxwjMbRIDZB
 Sqq0y/c7X/+KKqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64CA2136DC;
 Thu,  7 Aug 2025 07:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iddYFlZPlGhaDgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 07 Aug 2025 07:01:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 07 Aug 2025 09:01:38 +0200
Message-Id: <20250807-file_setattr_getattr-v6-0-ebe32b282d49@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFJPlGgC/43NwWrDMAyA4VcpPs9Dli3b6WnvUUZxHKU1bM2w0
 7BR8u5zOgYlbJCT+AX6dBOFc+Ii9rubyDylkoZLDfu0E/EcLieWqastEJDAg5J9euNj4TGMYz6
 efqZ0prG67whbIFFPPzL36fPOHl5rn1MZh/x1/zKpZfsLmr/BSUmQNhgddWMxevdSroWf4/AuF
 m/CLQYuBikm4EgNrw39aNA/hl4MF5wzrkO0cWWYLYapBnhGrcmENvqVQVsMqga20XTKM4DWD8Y
 8z98BlyhBxwEAAA==
X-Change-ID: 20250801-file_setattr_getattr-74963fd52b05
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754550102; l=3530;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=+E5OlPJzxnwDj25+K8LLndg8OQI+71Ew8AgJSPHg12g=;
 b=m3YHZn1e0VLxNIXpeUrpwQJVeY1AfKTdPRWE2yaj6BDCWUxV/PQdufS8QYMYdVzGCBnlv5cw8
 iX0kf9bj7V3BPG3BestdHRxm26KuzsIABIp5DyWfp/HHykvfjg9rOvm
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/7] file_setattr/file_getattr testing suite
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
Changes in v6:
- HAVE_FILE_GETATTR/HAVE_FILE_SETATTR
- file_attr01: use FILE_ATTR_SIZE_VER0
- Link to v5: https://lore.kernel.org/r/20250805-file_setattr_getattr-v5-0-2bc4d18e0033@suse.com

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

 configure.ac                                      |   6 +
 include/lapi/fs.h                                 |  70 ++++++++-
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
 26 files changed, 619 insertions(+), 1 deletion(-)
---
base-commit: e59c60ff44bfc50a360838cc2819e693f3741d75
change-id: 20250801-file_setattr_getattr-74963fd52b05

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
