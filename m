Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1733CEFC20
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 15:04:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91F5E3C26BE
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 17:04:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 258613C1CEC
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 17:00:14 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B8A50600D14
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 17:00:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 26B9D1FB61;
 Tue,  8 Oct 2024 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728399606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vDZDbT7D+hW2TlqnkiXf1FhDo45e1UAxu4rDwMSmyqw=;
 b=Qh5IlCX+mhr8/gjWydzAQdCMOq5p6D+cNwW+8sfGIcX4Pfl64MyOojdcUReGBFuvelfnxi
 B3lEtCAIMYEytJs20pYQDc+qJUVTuh1coQ1H5F6lSlxfNWjX5HY6NhPHgSkedUqSlth5h7
 wwes2xS8ObAtT8fRaDs6JHZVv3oQXiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728399606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vDZDbT7D+hW2TlqnkiXf1FhDo45e1UAxu4rDwMSmyqw=;
 b=JlQDVPYHVYaxJDgNjlToKwO72S4IyTupX34vgaggLE+2388v84ytQAjbcF/r8W7syZTI8i
 UinMpV8pa6D9tAAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728399606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vDZDbT7D+hW2TlqnkiXf1FhDo45e1UAxu4rDwMSmyqw=;
 b=Qh5IlCX+mhr8/gjWydzAQdCMOq5p6D+cNwW+8sfGIcX4Pfl64MyOojdcUReGBFuvelfnxi
 B3lEtCAIMYEytJs20pYQDc+qJUVTuh1coQ1H5F6lSlxfNWjX5HY6NhPHgSkedUqSlth5h7
 wwes2xS8ObAtT8fRaDs6JHZVv3oQXiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728399606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vDZDbT7D+hW2TlqnkiXf1FhDo45e1UAxu4rDwMSmyqw=;
 b=JlQDVPYHVYaxJDgNjlToKwO72S4IyTupX34vgaggLE+2388v84ytQAjbcF/r8W7syZTI8i
 UinMpV8pa6D9tAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70528137CF;
 Tue,  8 Oct 2024 15:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /mJhD/VIBWf6KgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Oct 2024 15:00:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 16:59:55 +0200
Message-Id: <20241008-listmount_statmount-v6-0-0fd456b6b9bf@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOtIBWcC/33N0QqCMBQG4FeJXbc4zm1uXfUeETHdWQ5Sw6kU4
 rs3DSpCujv/D/93RhKw9RjIfjOSFgcffFPHILcbUpSmviD1NmbCgHEQiaRXH7qq6evuHDrzuig
 o0FIgcwqQxOWtRefvi3o8xVzGTdM+lidDOrf/vSGlQJlzPDdM57nJDqEPuCuaiszcwD+EBr1O8
 EikWgjFgFvr4IcQbyIBUOuEiISUjmNiNGY2/yKmaXoC5ZSqujsBAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728399604; l=5108;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=fLYiWBjnf4D7vrzcuyZUfg/KkIG8fag9JUTEMIVT4RA=;
 b=b2RvOIVICA3BDw8KBrZIXWP7akJgrKod+jwgQBA008YqjRkVns9XGau3WoySm90FSuwU/njpJ
 GTP9n7nEvdZBDQU+/gJ4UogITLB95k+Sv1p8JdjS/dkRM7QmV45JXQv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.19)[-0.969]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 00/16] statmount/listmount testing suites
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
Changes in v6:
- fix statmount01
- add more EOVERFLOW tests in statmount06
- Link to v5: https://lore.kernel.org/r/20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com

Changes in v5:
- usage of sx.data.stx_mask
- use TST_EXP_EQ_STR
- use tst_tmpdir_genpath()
- use !TST_PASS instead of TST_RET == -1
- listmount03
- listmount04
- statmount08
- Link to v4: https://lore.kernel.org/r/20240909-listmount_statmount-v4-0-39558204ddf0@suse.com

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
Andrea Cervesato (16):
      Add SAFE_STATX macro
      Add TST_EXP_EQ_STR macro
      Add listmount/statmount syscalls
      Add listmount/statmount fallback declarations
      Add listmount01 test
      Add listmount02 test
      Add statmount01 test
      Add statmount02 test
      Add statmount03 test
      Add statmount04 test
      Add statmount05 test
      Add statmount06 test
      Add statmount07 test
      Add statmount08 test
      Add listmount03 test
      Add listmount04 test

 configure.ac                                      |   2 +
 include/lapi/mount.h                              |  70 +++++++++++
 include/lapi/stat.h                               | 111 ++++++++++++-----
 include/lapi/syscalls/aarch64.in                  |   2 +
 include/lapi/syscalls/arc.in                      |   2 +
 include/lapi/syscalls/arm.in                      |   2 +
 include/lapi/syscalls/hppa.in                     |   2 +
 include/lapi/syscalls/i386.in                     |   2 +
 include/lapi/syscalls/ia64.in                     |   2 +
 include/lapi/syscalls/loongarch.in                |   2 +
 include/lapi/syscalls/mips_n32.in                 |   2 +
 include/lapi/syscalls/mips_n64.in                 |   2 +
 include/lapi/syscalls/mips_o32.in                 |   2 +
 include/lapi/syscalls/powerpc.in                  |   2 +
 include/lapi/syscalls/powerpc64.in                |   2 +
 include/lapi/syscalls/s390.in                     |   2 +
 include/lapi/syscalls/s390x.in                    |   2 +
 include/lapi/syscalls/sh.in                       |   2 +
 include/lapi/syscalls/sparc.in                    |   2 +
 include/lapi/syscalls/sparc64.in                  |   2 +
 include/lapi/syscalls/x86_64.in                   |   2 +
 include/tst_test_macros.h                         |  14 +++
 runtest/syscalls                                  |  14 +++
 testcases/kernel/syscalls/listmount/.gitignore    |   4 +
 testcases/kernel/syscalls/listmount/Makefile      |   7 ++
 testcases/kernel/syscalls/listmount/listmount.h   |  27 ++++
 testcases/kernel/syscalls/listmount/listmount01.c |  63 ++++++++++
 testcases/kernel/syscalls/listmount/listmount02.c | 105 ++++++++++++++++
 testcases/kernel/syscalls/listmount/listmount03.c |  62 ++++++++++
 testcases/kernel/syscalls/listmount/listmount04.c |  97 +++++++++++++++
 testcases/kernel/syscalls/statmount/.gitignore    |   8 ++
 testcases/kernel/syscalls/statmount/Makefile      |   7 ++
 testcases/kernel/syscalls/statmount/statmount.h   |  51 ++++++++
 testcases/kernel/syscalls/statmount/statmount01.c |  77 ++++++++++++
 testcases/kernel/syscalls/statmount/statmount02.c |  84 +++++++++++++
 testcases/kernel/syscalls/statmount/statmount03.c | 138 +++++++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount04.c | 105 ++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount05.c | 123 ++++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount06.c |  68 ++++++++++
 testcases/kernel/syscalls/statmount/statmount07.c | 144 ++++++++++++++++++++++
 testcases/kernel/syscalls/statmount/statmount08.c |  65 ++++++++++
 41 files changed, 1450 insertions(+), 32 deletions(-)
---
base-commit: 701212f08d6e850457cc2b10238f28662ef48471
change-id: 20240516-listmount_statmount-080965e2f80e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
