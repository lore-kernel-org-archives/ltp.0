Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A41C369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 13:04:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF3903CBC9B
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 15:04:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8A8F3CAAF5
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:04:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9DFEA1A00987
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:04:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 83AE22195D;
 Wed, 30 Apr 2025 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746018260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=McOtFUVCq0RccwnYznPqlan9KQcQ1hIdWsoJAAfmu0w=;
 b=gNaA5dFfEUNDcs8/DC74ef85zK7e+PiuW20xO89w6dWWTb01WxgTiYHP2qTjgByIC0lKxW
 P0TTDdqE9fVZUMwXhl/GxjHHZcDwF5FMlEpgBEYPzazfU1+QYNsH5OGnlmnA56z/bIc8Up
 Ck48g9t6vP8ABEf3HI+bATGgowQylTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746018260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=McOtFUVCq0RccwnYznPqlan9KQcQ1hIdWsoJAAfmu0w=;
 b=Dq8CPRy+nFUX/z5lDiHmBH7u/jLbglTMfEGD8ubXALev30ydQcf7TfrRycvd2vgCIFA0i2
 WTnLAkzslpS3dtDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746018260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=McOtFUVCq0RccwnYznPqlan9KQcQ1hIdWsoJAAfmu0w=;
 b=gNaA5dFfEUNDcs8/DC74ef85zK7e+PiuW20xO89w6dWWTb01WxgTiYHP2qTjgByIC0lKxW
 P0TTDdqE9fVZUMwXhl/GxjHHZcDwF5FMlEpgBEYPzazfU1+QYNsH5OGnlmnA56z/bIc8Up
 Ck48g9t6vP8ABEf3HI+bATGgowQylTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746018260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=McOtFUVCq0RccwnYznPqlan9KQcQ1hIdWsoJAAfmu0w=;
 b=Dq8CPRy+nFUX/z5lDiHmBH7u/jLbglTMfEGD8ubXALev30ydQcf7TfrRycvd2vgCIFA0i2
 WTnLAkzslpS3dtDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E27313A25;
 Wed, 30 Apr 2025 13:04:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id idBiO9MfEmhRawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Apr 2025 13:04:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 30 Apr 2025 15:04:13 +0200
Message-ID: <20250430130417.43523-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] shell loader rewrite to support TST_SETUP
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

Hi Cyril, all,

we are getting there, but not yet finished.

one remaining problem - it requires *full* path in PATH. I wonder what
basic I'm missing.  The current change requires to use full path
otherwise execvpe() fails.

I suppose it is due change cwd due creating temporary directory - it
fails only with:
"needs_tmpdir": true
shell_loader_setup_cleanup.sh does not suffer this problem.
It's also not dash related, problem is on bash as well.

# PATH="testcases/lib:testcases/lib/tests:$PATH" shell_loader.sh
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_sheQVjoS6 as tmpdir (tmpfs filesystem)
tst_test.c:1903: TINFO: LTP version: 20250130-250-g344e47016d
...
tst_test.c:1720: TINFO: Overall timeout per run is 0h 00m 30s
tst_test.c:218: TBROK: execvpe(shell_loader.sh, ...) failed!: ENOENT (2)

NOTE: export PATH does not help.

# export PATH="testcases/lib:testcases/lib/tests:$PATH"
# shell_loader.sh
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_sheQVjoS6 as tmpdir (tmpfs filesystem)
tst_test.c:1903: TINFO: LTP version: 20250130-250-g344e47016d
...
tst_test.c:1720: TINFO: Overall timeout per run is 0h 00m 30s
tst_test.c:218: TBROK: execvpe(shell_loader.sh, ...) failed!: ENOENT (2)

Full path helps:

# PATH="/opt/ltp/testcases/bin:$PATH" shell_loader.sh
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_shejdXdvf as tmpdir (tmpfs filesystem)
tst_test.c:1903: TINFO: LTP version: 20250130-250-g344e47016d
...
tst_test.c:1720: TINFO: Overall timeout per run is 0h 00m 30s
shell_loader.sh:-1: TPASS: Shell loader works fine!
shell_loader.sh:-1: TPASS: We are running in temp directory in /tmp/LTP_shejdXdvf

And yes, we have -1 on dash, but as you noted in tst_env.sh we can do
nothing about it.

Changes v1->v2:
* use tst_env.sh also in tests instead using tst_exec.sh in
  tst_run_shell.c. Therefore remove "lib: Allow test to have positional
  args" commit.

Link to v1:
https://patchwork.ozlabs.org/project/ltp/list/?series=446566&state=*
https://lore.kernel.org/ltp/20250228172439.3276777-1-pvorel@suse.cz/

Cyril Hrubis (1):
  shell lib: Add support for test cleanup

Petr Vorel (3):
  shell: Move shell code into functions
  shell lib: Add basic support for test setup
  shell: Add shell_loader_setup_cleanup.sh test

 testcases/kernel/mem/vma/vma05.sh             | 47 ++++++++++---------
 testcases/lib/run_tests.sh                    |  5 +-
 testcases/lib/tests/shell_loader.sh           | 21 +++++----
 .../lib/tests/shell_loader_all_filesystems.sh | 28 ++++++-----
 .../lib/tests/shell_loader_brk_cleanup.sh     | 25 ++++++++++
 testcases/lib/tests/shell_loader_c_child.sh   | 17 ++++---
 testcases/lib/tests/shell_loader_cleanup.sh   | 25 ++++++++++
 .../lib/tests/shell_loader_filesystems.sh     | 25 ++++++----
 .../lib/tests/shell_loader_invalid_block.sh   |  9 +++-
 .../tests/shell_loader_invalid_metadata.sh    |  9 +++-
 testcases/lib/tests/shell_loader_kconfigs.sh  |  9 +++-
 .../lib/tests/shell_loader_no_metadata.sh     |  9 +++-
 .../lib/tests/shell_loader_setup_cleanup.sh   | 31 ++++++++++++
 .../lib/tests/shell_loader_supported_archs.sh |  9 +++-
 testcases/lib/tests/shell_loader_tags.sh      |  9 +++-
 testcases/lib/tests/shell_loader_tcnt.sh      |  9 +++-
 .../lib/tests/shell_loader_wrong_metadata.sh  |  9 +++-
 testcases/lib/tst_env.sh                      |  5 --
 testcases/lib/tst_loader.sh                   | 15 ++++--
 19 files changed, 235 insertions(+), 81 deletions(-)
 create mode 100755 testcases/lib/tests/shell_loader_brk_cleanup.sh
 create mode 100755 testcases/lib/tests/shell_loader_cleanup.sh
 create mode 100755 testcases/lib/tests/shell_loader_setup_cleanup.sh

-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
