Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A397ACDD1D5
	for <ltp@archiver.kernel.org>; Mon, 30 Sep 2024 19:23:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 336253C56E3
	for <ltp@archiver.kernel.org>; Mon, 30 Sep 2024 21:23:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE4463C56E3
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 21:21:47 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 75DBD1A0117C
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 21:21:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 63F2821A68
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 19:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727724098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OOBFk/M1tIhlXzI/Jk7w9P9mTpKASYbB1jRRn+0RNeU=;
 b=b5Oy++Fk/ZnruTmKrzx5eZbAWfStd8YJUU4pHb2NZAMcllp0FFmbtgS+QPc4GTSR8VZFA4
 CbVaksm10T9UDwFflA+NCXMw6JGL302bQtogTn9X9OxqIlKZRaoLD56Bt6GBtxIPsskHbb
 P1HoASIn/u2jEmz2m+lf5kotZ8iJfb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727724098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OOBFk/M1tIhlXzI/Jk7w9P9mTpKASYbB1jRRn+0RNeU=;
 b=cGGWyi7K22SnyCk+E7xq2MXGATWLvWeDkNL6NiWvZClgown43xdIT5FtrNLsWPli+BItBg
 nKR1LcmUnRVjJrDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727724098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OOBFk/M1tIhlXzI/Jk7w9P9mTpKASYbB1jRRn+0RNeU=;
 b=b5Oy++Fk/ZnruTmKrzx5eZbAWfStd8YJUU4pHb2NZAMcllp0FFmbtgS+QPc4GTSR8VZFA4
 CbVaksm10T9UDwFflA+NCXMw6JGL302bQtogTn9X9OxqIlKZRaoLD56Bt6GBtxIPsskHbb
 P1HoASIn/u2jEmz2m+lf5kotZ8iJfb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727724098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OOBFk/M1tIhlXzI/Jk7w9P9mTpKASYbB1jRRn+0RNeU=;
 b=cGGWyi7K22SnyCk+E7xq2MXGATWLvWeDkNL6NiWvZClgown43xdIT5FtrNLsWPli+BItBg
 nKR1LcmUnRVjJrDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52C49136CB
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 19:21:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id icjNEkL6+mY3ZwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 19:21:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 30 Sep 2024 21:21:18 +0200
Message-Id: <20240930-generate_syscalls-v3-0-e56ede4bc7f5@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC76+mYC/23NQQqDMBCF4atI1k1JRiXaVe9RSonJqAGrkrGhI
 t69USi4cPk/mG8WRugdErslC/MYHLmhj5FeEmZa3TfInY3NQEAmSkh5gz16PeGLZjK664irQlg
 DAKqyFYt3o8fafXfz8YzdOpoGP+8vgtzWv5adaEFywctM5kLp0lht7vQhvJrhzTYswBFQZwBEQ
 IqizmvQNpXFAVjX9QfgOEdT8gAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727724098; l=3406;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=5lst0cMYubx0ND5ilH8qF9CUsL8fVjxfs+7fsdT0cwI=;
 b=qxcdY2668CEkFczmNlSg+LoJL1+jAhvypAzZ7hCpyUbwT4dfmGeoNpjjDOwDo3bWZQYUpfPMM
 GiUm7g2kGf5BEAxTpB/6ITcSdgI9i9pvMXRl3ebeIvN4/mUjrvszCYM
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] Automatically generate syscalls.h
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
Andrea Cervesato (4):
      Refactor regen.sh script to generate syscalls
      Add script to generate arch(s) dependant syscalls
      Delete obsolete strip_syscall.awk file
      Update syscalls files

 configure.ac                                       |   2 +-
 include/lapi/syscalls/arc.in                       |  41 +-
 include/lapi/syscalls/arm.in                       | 819 +++++++++++----------
 include/lapi/syscalls/{loongarch.in => arm64.in}   |  12 +-
 include/lapi/syscalls/blacklist-syscalls.txt       |   6 +
 include/lapi/syscalls/generate_arch.sh             | 210 ++++++
 include/lapi/syscalls/generate_syscalls.sh         | 118 +++
 include/lapi/syscalls/hppa.in                      |  52 --
 include/lapi/syscalls/i386.in                      |  18 +-
 include/lapi/syscalls/ia64.in                      |  10 +-
 .../lapi/syscalls/{aarch64.in => loongarch64.in}   |  20 +-
 include/lapi/syscalls/{mips_n64.in => mips64.in}   |  13 +-
 .../lapi/syscalls/{mips_n32.in => mips64n32.in}    |  13 +-
 include/lapi/syscalls/{mips_o32.in => mipso32.in}  |  21 +-
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
 26 files changed, 1367 insertions(+), 737 deletions(-)
---
base-commit: 08cb938197e82eddce146662a47ff990827ff60a
change-id: 20240923-generate_syscalls-780dc2227bdb

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
