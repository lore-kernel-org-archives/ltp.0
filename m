Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73A0E6B240
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 10:49:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 137943CD2BE
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 11:49:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 819793CCD27
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 11:48:57 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2CD87141D082
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 11:48:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 42EAC1F8D9;
 Fri,  1 Nov 2024 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730458135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+zNixNtk/mOEA+nqM82SNl1TJGukASI68TARJiqUPiw=;
 b=UzYYyInOHGhaW67+lhf8oS9Cr/3ACs1AIQlnm5+rMv2AoLey+6KyDquI22f9K2CzGnY8K1
 Djvq1IOCiBJ+Q2gHHkPTKq3e6XEBeDD0nhqNVh9geS9GYfJip3Db3LpWyw/PZYTVFhIjbR
 TxdptGEuuNa4FRPyc4LsuYUpmhONQno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730458135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+zNixNtk/mOEA+nqM82SNl1TJGukASI68TARJiqUPiw=;
 b=f//Gu9A1jd0MdHeAnFGD+YmWRmBdtkZwEDA5TrTLKDM+G1r92yjIa9PHaeGInrqv+hLOE0
 JvOHdtS7D0rghjCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730458135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+zNixNtk/mOEA+nqM82SNl1TJGukASI68TARJiqUPiw=;
 b=UzYYyInOHGhaW67+lhf8oS9Cr/3ACs1AIQlnm5+rMv2AoLey+6KyDquI22f9K2CzGnY8K1
 Djvq1IOCiBJ+Q2gHHkPTKq3e6XEBeDD0nhqNVh9geS9GYfJip3Db3LpWyw/PZYTVFhIjbR
 TxdptGEuuNa4FRPyc4LsuYUpmhONQno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730458135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+zNixNtk/mOEA+nqM82SNl1TJGukASI68TARJiqUPiw=;
 b=f//Gu9A1jd0MdHeAnFGD+YmWRmBdtkZwEDA5TrTLKDM+G1r92yjIa9PHaeGInrqv+hLOE0
 JvOHdtS7D0rghjCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACA1A13722;
 Fri,  1 Nov 2024 10:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id reR/FxWyJGcIUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 01 Nov 2024 10:48:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 01 Nov 2024 11:48:25 +0100
Message-Id: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPmxJGcC/4XQ3WrDMAwF4Fcpvl6G/y3vau8xxpBtpTV0yYi7s
 FLy7nMKG8EEenkE+nTQjRWaMhX2crixieZc8jjU4J8OLJ5wOFKXU81Mcqm5l6o70kATXuijXEv
 E87l0DniKUkoXUmB172uiPv/czbf3mk+5XMbpej8xi3X6p+kdbRYd77wWhjv0MWF8Ld+FnuP4y
 VZsllvA7QGyAoJDb3qJSQloALUBFN8DVAXIWEqkQ3S9aQD9DwjO/R6gK2CUBHRgQsDUAGYD7Dc
 wawNKFsGl6MA1gN0CYg+w6w8wgUWlIsm2gXsIuAr0iqSN3ILQ1ADwEIAKACmDPlkHKmyAZVl+A
 eVrMLp4AgAA
X-Change-ID: 20240923-generate_syscalls-780dc2227bdb
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730458133; l=4917;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=NLhChHMtG79NpKHHutrU0B9pSN/lXB/yifYbN2j6IcA=;
 b=9yKknYnGoo/2JtXxTVTxRIIDR5ZKQQnc2qJhU9OIL8HelGWE2ZGLT/R+fXFCuuB7rkJM18twI
 N4LMB7nPQ/dBNXRtSOd7sno2yrY/J7cv41MPxkzUhQr4t4FzVDBnbFL
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 0/5] Automatically generate syscalls.h
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

The problem we have at the moment is that all syscalls input files must
be changed by hand each time we need to test a new syscall. The idea is
to simplify this process, providing a script that is able to read from
kernel sources and to generate all syscalls files we need.

This patch set adds a new command inside the syscalls folder and
it refactors the previous regen.sh code.
The new way we have to generate the syscalls.h file is the following:

	include/lapi/syscalls/generate_arch.sh 		path/to/kernel/source
	include/lapi/syscalls/generate_syscalls.sh 	path/to/syscalls.h

Scripts are independent and they can be run separately.
generate_syscalls.sh is the equivalent of regen.sh, but its code has
been cleaned up.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v9:
- use of printf when printing "\n" string, in order to support both dash
  and bash. BEWARE: ugliness triggered.
- rename *.in files with supported-arch.txt file naming convention
- update *.in files in a separated commit
- update documentation to be more readable
- aesthetic code changes
- Link to v8: https://lore.kernel.org/r/20241031-generate_syscalls-v8-0-8e35a9d6783b@suse.com

Changes in v8:
- use /bin/sh -eu
- support for dash and removed all bashism madness
- validation: https://github.com/acerv/ltp/actions/runs/11615377438
- Link to v7: https://lore.kernel.org/r/20241031-generate_syscalls-v7-0-f3e26c06814e@suse.com

Changes in v7:
- check for errors in generate_syscalls.sh
- add documentation
- validation: https://github.com/acerv/ltp/actions/runs/11611080151
- Link to v6: https://lore.kernel.org/r/20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com

Changes in v6:
- aesthetic changes in the syscall generator
- fix fallback definitions in the syscalls.h file generator 
- Link to v5: https://lore.kernel.org/r/20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com

Changes in v5:
- license SPDX inside scripts files
- quote shell variables inside scripts
- some generic code cleanup
- Link to v4: https://lore.kernel.org/r/20241009-generate_syscalls-v4-0-5328a785bbad@suse.com

Changes in v4:
- remove blacklist file
- update syscalls files
- Link to v3: https://lore.kernel.org/r/20240930-generate_syscalls-v3-0-e56ede4bc7f5@suse.com

Changes in v3:
- fix generate_arch.sh to work properly for all architectures
- rename some arch .in files and handle renaming inside
  generate_syscalls.sh using the right gcc directives
- Link to v2: https://lore.kernel.org/r/20240927-generate_syscalls-v2-0-108f5f2ad318@suse.com

Changes in v2:
- refactor regen.sh
- split syscalls.h and syscalls .in files creation
- updated syscalls .in files
- Link to v1: https://lore.kernel.org/r/20240924-generate_syscalls-v1-0-941507a9cdac@suse.com

---
Andrea Cervesato (5):
      Refactor regen.sh script to generate syscalls
      Add script to generate arch(s) dependant syscalls
      Update arch(s) syscalls files
      Delete obsolete strip_syscall.awk file
      Add documentation about syscalls.h generator

 configure.ac                                       |   2 +-
 doc/developers/test_case_tutorial.rst              |  29 +-
 include/lapi/syscalls/arc.in                       |  41 +-
 include/lapi/syscalls/arm.in                       | 821 +++++++++++----------
 include/lapi/syscalls/{loongarch.in => arm64.in}   |  12 +-
 include/lapi/syscalls/generate_arch.sh             | 213 ++++++
 include/lapi/syscalls/generate_syscalls.sh         | 109 +++
 include/lapi/syscalls/hppa.in                      |  54 --
 include/lapi/syscalls/i386.in                      |  18 +-
 .../lapi/syscalls/{aarch64.in => loongarch64.in}   |  20 +-
 include/lapi/syscalls/{mips_n64.in => mips64.in}   |  13 +-
 .../lapi/syscalls/{mips_n32.in => mips64n32.in}    |  13 +-
 include/lapi/syscalls/{mips_o32.in => mipso32.in}  |  19 +-
 include/lapi/syscalls/parisc.in                    | 397 ++++++++++
 include/lapi/syscalls/powerpc.in                   |  19 +-
 include/lapi/syscalls/powerpc64.in                 |  47 +-
 include/lapi/syscalls/regen.sh                     | 129 ----
 include/lapi/syscalls/s390.in                      |  15 +-
 include/lapi/syscalls/s390x.in                     |  15 +-
 include/lapi/syscalls/sh.in                        |  15 +-
 include/lapi/syscalls/sparc.in                     |  14 +-
 include/lapi/syscalls/sparc64.in                   |  16 +-
 include/lapi/syscalls/strip_syscall.awk            |  19 -
 .../lapi/syscalls/{order => supported-arch.txt}    |  12 +-
 include/lapi/syscalls/x86_64.in                    |  51 +-
 25 files changed, 1351 insertions(+), 762 deletions(-)
---
base-commit: 84e77afb3acc4bc69c434c430cc1c1d000427921
change-id: 20240923-generate_syscalls-780dc2227bdb

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
