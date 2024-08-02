Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F00EC3DA49
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 08:25:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BB6A3D1F3E
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 10:25:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1847E3D1F42
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:24:02 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8A03A1001189
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:23:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F0C81FB9C;
 Fri,  2 Aug 2024 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722587037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8nF0J6QImDyNy2jaktOo6I2AH/d6qFpcUga4ObqGG0s=;
 b=gyE+GNk8eL8aUeEQkXPbHGOYbZvzKfvapXeUxA0vriV0zP7uXW7PmzvrdmT8F+BjAinq4i
 PgX7xjdKW8tMZ2dQdc0z018BK1lg+FITdV6nIK3aHhj2nFNTO/fIRf258pMxeAQwJZt+d1
 5ebtm8pWnL8XRke72VWvzthp0tnkMg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722587037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8nF0J6QImDyNy2jaktOo6I2AH/d6qFpcUga4ObqGG0s=;
 b=ZpXqikZw7po8ez/YrZcLR1F4i2hhtGiN0NnWNVBMRAhJ34pB6sQzr8Pp84sN2IZ3zVh4cd
 KiQ4h4z8y5kTE8Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gyE+GNk8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZpXqikZw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722587037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8nF0J6QImDyNy2jaktOo6I2AH/d6qFpcUga4ObqGG0s=;
 b=gyE+GNk8eL8aUeEQkXPbHGOYbZvzKfvapXeUxA0vriV0zP7uXW7PmzvrdmT8F+BjAinq4i
 PgX7xjdKW8tMZ2dQdc0z018BK1lg+FITdV6nIK3aHhj2nFNTO/fIRf258pMxeAQwJZt+d1
 5ebtm8pWnL8XRke72VWvzthp0tnkMg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722587037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8nF0J6QImDyNy2jaktOo6I2AH/d6qFpcUga4ObqGG0s=;
 b=ZpXqikZw7po8ez/YrZcLR1F4i2hhtGiN0NnWNVBMRAhJ34pB6sQzr8Pp84sN2IZ3zVh4cd
 KiQ4h4z8y5kTE8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BF2C13999;
 Fri,  2 Aug 2024 08:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QWguAJ2XrGaaFgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 02 Aug 2024 08:23:57 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 02 Aug 2024 10:23:45 +0200
Message-Id: <20240802-fchmodat2-v5-0-bff2ec1a4f06@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJGXrGYC/13OQQ6DIBAF0KsY1qVhBhDsqvdoukCEykJtpDVtG
 u9eNE2kLv9k3p/5kOjG4CI5FR8yuinEMPQpyENBbGv6m6OhSZkgQ8EkKOpt2w2NeSCVtUZdqka
 BtyTt30fnw2vtulxTbkN8DON7rZ5gmf5aELKWCSijUEEtTKXLtHCOz+iOdujIUjLhBhXyHGKCr
 pQ6uRqAux3kORQ55MvFxirrbclFrXdQbFCzv1dFgsqjBzCSG1ZlcJ7nL7O48yhMAQAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3909;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=vVyM1LGLvxWFRhoayQGknKUE6KfUmzt3FIUnbGHRcuM=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmrJeYWSmH8OsYyTW7yNfXGUFXSGHiHV5xQr2d7
 0LNY42spZGJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqyXmAAKCRDLzBqyILPm
 RqMRC/9MiaHOPDHcCBDh/1wMeH0+buPcNhoU3XgXBip9rL4tm03nIpJIhRURZ0KeGhf87JnjrpF
 DcCvKSC1XIPeUAHD3uFf37AC1SbuahJW9NvqkKxwKb7/RGLfGCgjnPfe74pLr9XVyZPA0xLzmxg
 HKk30/QGPaxNIPMEdtjrSTjs0cXuSZ1NePGQugrdfoJn9WpsGQ2H35/8Su70ziVypb5x0QpxxBR
 diZqDaRcAB8I6XP2UiHuAQy8yE6xHx+RMz5ReO2qdy2uatE3DYjxNzzSHUpU1a9VRn3Qo/OIe1Q
 4YhXaWfAIdUtFfT2+Wlg073T9RzzLSjgDrCIydrKvViL7A1zxcOMxEGG6G4pTXImAUsrctF1wyK
 XfrmZM09Hi6TNb7ubPZgF9GfbiYaCg3nQB/gPECVxiSsuhfuXDPHFCgZdPswqDA/tkI1qR6bTRn
 plL8vISLKAiVYTkBWnZdzgalrgulFNx7Rkh1dVACHFKgmnKhnYxvlwXMHE4hWSa6wUvIo=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, phoronix.com:url, suse.com:email, suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3F0C81FB9C
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/5] Add fchmodat2 testing suite
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

This is a patch-set that implements fchmodat2() syscall coverage.
fchmodat2() has been added in kernel 6.6 in order to support
AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
There's no man pages yet, so please take the following links as
main documentation along with kernel source code:

https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@brauner/

***********
* WARNING *
***********

fchmodat2_02 fails with EOPNOTSUPP because of missing feature.
According to documentation, the feature has been implemented in
kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
on symbolic files. Also kselftests, which are meant to test the
functionality, are not working and they are treating fchmodat2()
syscall failure as SKIP. Please take a look at the following code
before reviewing:

https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- fchmodat2_01: check for EOPNOTSUPP, added tag and removed kernel
  version in order to let backported feature to be available for testing
- Link to v4: https://lore.kernel.org/r/20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com

Changes in v4:
- add SAFE_FCHMODAT2
- Link to v3: https://lore.kernel.org/r/20240724-fchmodat2-v3-0-1dc7cfc634b8@suse.com

Changes in v3:
- removed fchmodat2.h
- Link to v2: https://lore.kernel.org/r/20240723-fchmodat2-v2-0-e658a98b113e@suse.com

Changes in v2:
- merge first 3 tests into a unique one
- move fchmodat2 in lapi/stat.h
- add test for error checking
- Link to v1: https://lore.kernel.org/r/20240521-fchmodat2-v1-0-191b4a986202@suse.com

---
Andrea Cervesato (5):
      Add SAFE_SYMLINKAT macro
      Add fchmodat2 syscalls definitions
      Add fchmodat2 fallback definition
      Add fchmodat2_01 test
      Add fchmodat2_02 test

 include/lapi/stat.h                                |  16 +++
 include/lapi/syscalls/aarch64.in                   |   1 +
 include/lapi/syscalls/arc.in                       |   1 +
 include/lapi/syscalls/arm.in                       |   1 +
 include/lapi/syscalls/hppa.in                      |   1 +
 include/lapi/syscalls/i386.in                      |   1 +
 include/lapi/syscalls/ia64.in                      |   1 +
 include/lapi/syscalls/loongarch.in                 |   1 +
 include/lapi/syscalls/mips_n32.in                  |   1 +
 include/lapi/syscalls/mips_n64.in                  |   1 +
 include/lapi/syscalls/mips_o32.in                  |   1 +
 include/lapi/syscalls/powerpc.in                   |   1 +
 include/lapi/syscalls/powerpc64.in                 |   1 +
 include/lapi/syscalls/s390.in                      |   1 +
 include/lapi/syscalls/s390x.in                     |   1 +
 include/lapi/syscalls/sh.in                        |   1 +
 include/lapi/syscalls/sparc.in                     |   1 +
 include/lapi/syscalls/sparc64.in                   |   1 +
 include/lapi/syscalls/x86_64.in                    |   1 +
 include/safe_macros_fn.h                           |   4 +
 include/tst_safe_macros.h                          |   3 +
 lib/safe_macros.c                                  |  20 ++++
 runtest/syscalls                                   |   3 +
 testcases/kernel/syscalls/fchmodat2/.gitignore     |   2 +
 testcases/kernel/syscalls/fchmodat2/Makefile       |   7 ++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 123 +++++++++++++++++++++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c |  68 ++++++++++++
 27 files changed, 264 insertions(+)
---
base-commit: 8422d4680b21e6576da63c677b5d49f46b477df0
change-id: 20240517-fchmodat2-5b82867d71fc

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
