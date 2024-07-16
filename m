Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BB1C3DA49
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 15:33:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 261DB3D1A6E
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 17:33:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 214613D199A
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 17:33:35 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F40C609A58
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 17:33:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F21011F8C2
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 15:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721144012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OqxNtFkayMGPr5UVor3jNkAnmRAVuZ1ZmMePtsxnb3s=;
 b=MI4DPJKblomNOLfnnx+PODaR1JIowZi0yRehZNAbAnYn9C4vs6QV3tJ6rB7Ggw3TwBOueO
 oNS+xLDgj2N1HUGKtjEjHNXSNaXcYZEmNU/mzMp8mOHVXKxCRDK5I6mb4NJV3ys41T8++H
 aArjUAvnKYmzvgC+uhoC0A3tBaxkpGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721144012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OqxNtFkayMGPr5UVor3jNkAnmRAVuZ1ZmMePtsxnb3s=;
 b=N9zQmuaOO8I63AVsn3lFRK3GCK/Zt/lu8JMCcv04qfU3LOE2RdaUIpndXUk22XK6bt6P9T
 Npg1nmAodiFyDOBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721144011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OqxNtFkayMGPr5UVor3jNkAnmRAVuZ1ZmMePtsxnb3s=;
 b=orFozwKNTjRqqVCvYdafTp8xM6D537q8cr8/ylgwvv+pBfzz3UfxoJ/roQNSmpitxsf1Pw
 Ak45e/moHZYL4gAIPwhIhiBIQp057F7qjny3pD5mlWrrVUJGt67ELIRNAxxytT0NKzjouk
 tptBIRm91VBRESIKGNe5S9tKhVqFzfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721144011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OqxNtFkayMGPr5UVor3jNkAnmRAVuZ1ZmMePtsxnb3s=;
 b=K9ME+DKgzWIm/FDCBxBV7kaVAB7lwNKrPLw/Z3nravi/7OhVHW5o3J5kQjL8G3vGVQHPXb
 nqk/jrTHejkyjuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEE7513795
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 15:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kk+ZNcqSlmakFAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 15:33:30 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 16 Jul 2024 17:36:02 +0200
Message-ID: <20240716153604.22984-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Spamd-Result: default: False [1.20 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 0/2] Shell test library v3
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

We have discussed shell and C integration during our LTP montly meeting.
I started to dig around after to see how complicated would that task be
and it turns out that it's fairly easy.

This patchset implements a proof of a concept for two things:

- seamless integration of shell with C code
- second patch builds on top of that and implements a shell loader
  that can run shell tests from within the C test library

Cyril Hrubis (2):
  Add support for mixing C and shell code
  testcaes/lib: Add shell loader

 include/tst_test.h                            | 38 +++++++++
 lib/tst_test.c                                | 51 ++++++++++++
 testcases/lib/.gitignore                      |  2 +
 testcases/lib/Makefile                        |  5 +-
 testcases/lib/run_tests.sh                    | 12 +++
 testcases/lib/tests/.gitignore                |  6 ++
 testcases/lib/tests/Makefile                  | 11 +++
 testcases/lib/tests/shell_loader.sh           | 12 +++
 .../lib/tests/shell_loader_all_filesystems.sh | 22 ++++++
 testcases/lib/tests/shell_test01.c            | 17 ++++
 testcases/lib/tests/shell_test02.c            | 18 +++++
 testcases/lib/tests/shell_test03.c            | 25 ++++++
 testcases/lib/tests/shell_test04.c            | 18 +++++
 testcases/lib/tests/shell_test05.c            | 27 +++++++
 testcases/lib/tests/shell_test06.c            | 16 ++++
 testcases/lib/tests/shell_test_brk.sh         |  6 ++
 testcases/lib/tests/shell_test_check_argv.sh  | 25 ++++++
 testcases/lib/tests/shell_test_checkpoint.sh  |  7 ++
 testcases/lib/tests/shell_test_pass.sh        |  6 ++
 testcases/lib/tst_env.sh                      | 16 ++++
 testcases/lib/tst_res_.c                      | 58 ++++++++++++++
 testcases/lib/tst_run_shell.c                 | 78 +++++++++++++++++++
 22 files changed, 474 insertions(+), 2 deletions(-)
 create mode 100755 testcases/lib/run_tests.sh
 create mode 100644 testcases/lib/tests/.gitignore
 create mode 100644 testcases/lib/tests/Makefile
 create mode 100755 testcases/lib/tests/shell_loader.sh
 create mode 100755 testcases/lib/tests/shell_loader_all_filesystems.sh
 create mode 100644 testcases/lib/tests/shell_test01.c
 create mode 100644 testcases/lib/tests/shell_test02.c
 create mode 100644 testcases/lib/tests/shell_test03.c
 create mode 100644 testcases/lib/tests/shell_test04.c
 create mode 100644 testcases/lib/tests/shell_test05.c
 create mode 100644 testcases/lib/tests/shell_test06.c
 create mode 100755 testcases/lib/tests/shell_test_brk.sh
 create mode 100755 testcases/lib/tests/shell_test_check_argv.sh
 create mode 100755 testcases/lib/tests/shell_test_checkpoint.sh
 create mode 100755 testcases/lib/tests/shell_test_pass.sh
 create mode 100644 testcases/lib/tst_env.sh
 create mode 100644 testcases/lib/tst_res_.c
 create mode 100644 testcases/lib/tst_run_shell.c

-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
