Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F05C02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 11:36:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB9EB3C7BCF
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 12:36:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58FC13C4D06
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:36:04 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 99AC8618FE7
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:36:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D16A7211D4;
 Thu, 16 Jan 2025 11:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737027362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iy22AENHncBjTBJ20R3sQ4xDgL57Srq983RpqV/xyxE=;
 b=uwMuMEtwpZKoHm80eyCJE1AglGGOQRtSHsWPZO6+S26hA2rU/f9jkCNxDEC0e//j5GObtT
 6rGK3SXRvbqlulz8V/PNC8tUcebfULRru4aHy0nbj+XVOS0DDpwHbVTN6yF6TirvQoxcMG
 cWR0Oi5dB+Kqp0AMMLNz/dyseo8y/Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737027362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iy22AENHncBjTBJ20R3sQ4xDgL57Srq983RpqV/xyxE=;
 b=g3C4c/7jUivhuuoOG2qGvuFBNfY3aE1qJbI/VHk79nNUDteKrkI7ZYv/4aIfLgQ+kvTn84
 gxgtOvPESTxG7KBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737027362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iy22AENHncBjTBJ20R3sQ4xDgL57Srq983RpqV/xyxE=;
 b=uwMuMEtwpZKoHm80eyCJE1AglGGOQRtSHsWPZO6+S26hA2rU/f9jkCNxDEC0e//j5GObtT
 6rGK3SXRvbqlulz8V/PNC8tUcebfULRru4aHy0nbj+XVOS0DDpwHbVTN6yF6TirvQoxcMG
 cWR0Oi5dB+Kqp0AMMLNz/dyseo8y/Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737027362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iy22AENHncBjTBJ20R3sQ4xDgL57Srq983RpqV/xyxE=;
 b=g3C4c/7jUivhuuoOG2qGvuFBNfY3aE1qJbI/VHk79nNUDteKrkI7ZYv/4aIfLgQ+kvTn84
 gxgtOvPESTxG7KBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A32113332;
 Thu, 16 Jan 2025 11:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +5o1HSLviGdrOgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 Jan 2025 11:36:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Jan 2025 12:35:59 +0100
Message-Id: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB/viGcC/23NQQ6CMBCF4auYrq2ZTksBV97DGAJlkC4EwyDRE
 O5uIZoQZfkm/f6OgqnzxOK4G0VHg2ffNmGY/U64Om+uJH0ZtkBAoxCMrPwzY+rZl1lP3LNMYps
 bizbGJBKB3TsKb5bk+RJ27blvu9fyw6Dm6yem1H9sUBIkKdCVts6G7IkfTAfX3sTcGvDrI1BgN
 zwG74yuojjHIi/sj9drn254HTw6suBSMKDSlZ+m6Q0fyT3+LwEAAA==
X-Change-ID: 20241204-fix_setsid_tests-876a46267285
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737027362; l=2732;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Uf9zAT36zUxvLLnbh0f83emm5WnX9nl75U071ByG83M=;
 b=q3VmnlJhYU/9aynfAzngs4E2BtArtSROBDbY7LV0bSn9lgWcdLYMwytNgY6iXbnFEPnL1x0Bs
 r4TyYTud0ZXARizVvyQ4E96O3K4FD1WLlXatsZvRyxa4qOsIORTL/+9
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 00/12] Fix tests failing with setsid
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

Following tests are failing when running on a new session started with
setsid command/syscall: pty01, ptem01, setpgid01.

Tihs patch-set refactor them in order to fix this issue. Some tests like
pty01 and ptem01 have been split into multiple files due to their
complexity.

Fixes: https://github.com/linux-test-project/kirk/issues/28
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- TST_EXP_EQ_STRN: copy input strings inside a buffer in order to handle
  end of the string
- Link to v3: https://lore.kernel.org/r/20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com

Changes in v3:
- move slave/master opening in common.h
- check if master device exists inside open_master()
- check if slave device has right permissions inside open_slave()
- add TST_EXP_EQ_STRN macro
- fix SAFE_PTSNAME macro
- move master handling inside setup/cleanup in most of the test
- Link to v2: https://lore.kernel.org/r/20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com

Changes in v2:
- add SAFE_PTSNAME macro
- ptem01: check ptsname() with TBROK
- Link to v1: https://lore.kernel.org/r/20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com

---
Andrea Cervesato (12):
      Refactor setpgid01 test
      Add SAFE_PTSNAME macro
      Refactor ptem01 test
      Add ptem02 test
      Add ptem03 test
      Add ptem04 test
      Add ptem05 test
      Add ptem06 test
      Add TST_EXP_EQ_STRN macro
      Refactor pty01 test
      Add pty08 test
      Add pty09 test

 include/tst_safe_macros.h                     |   4 +
 include/tst_test_macros.h                     |  31 ++
 lib/tst_safe_macros.c                         |  14 +
 runtest/pty                                   |   7 +
 testcases/kernel/pty/.gitignore               |   7 +
 testcases/kernel/pty/common.h                 |  68 ++++
 testcases/kernel/pty/ptem01.c                 | 456 +++-----------------------
 testcases/kernel/pty/ptem02.c                 |  71 ++++
 testcases/kernel/pty/ptem03.c                 |  49 +++
 testcases/kernel/pty/ptem04.c                 |  49 +++
 testcases/kernel/pty/ptem05.c                 |  55 ++++
 testcases/kernel/pty/ptem06.c                 |  52 +++
 testcases/kernel/pty/pty01.c                  | 409 +++--------------------
 testcases/kernel/pty/pty08.c                  |  38 +++
 testcases/kernel/pty/pty09.c                  |  74 +++++
 testcases/kernel/syscalls/setpgid/setpgid01.c | 152 ++-------
 16 files changed, 620 insertions(+), 916 deletions(-)
---
base-commit: 578ba63ab115cfbc2374c6b7a4d1fae5fffd18ee
change-id: 20241204-fix_setsid_tests-876a46267285

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
