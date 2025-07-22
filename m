Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CC5C83F1A
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 13:00:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CC733CCCED
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 15:00:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DFEF3CC9B0
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0510910009A6
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF50D2199E;
 Tue, 22 Jul 2025 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c8JZiQlM0ImeqeiDNhqyhQHWbTylaKQEFYfhzGpFE8E=;
 b=nDwfHpH7BXgOQzszO5tD+GNmR3x8zzfjeTajE+86nm/dVXdB5BL4wzGifSiDziloKtYiWM
 hd480P6eK/DFUVaV9XI9xrlQCQ9JfkW8nUKgeOgA8EHpH9PMmnkVynEwOEuNtEv5NY5Zb9
 uEGJVNbRwG/LkNOh9m3ImzbVaNZP7RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c8JZiQlM0ImeqeiDNhqyhQHWbTylaKQEFYfhzGpFE8E=;
 b=u5lL4taHdWZSO2KZdWmWg2LhWCBgSf7vbQlX8N7sYMtC7NwQpAwomFCF0tDZj0QB647+Qd
 aUPAhij485aQ3JCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nDwfHpH7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u5lL4taH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c8JZiQlM0ImeqeiDNhqyhQHWbTylaKQEFYfhzGpFE8E=;
 b=nDwfHpH7BXgOQzszO5tD+GNmR3x8zzfjeTajE+86nm/dVXdB5BL4wzGifSiDziloKtYiWM
 hd480P6eK/DFUVaV9XI9xrlQCQ9JfkW8nUKgeOgA8EHpH9PMmnkVynEwOEuNtEv5NY5Zb9
 uEGJVNbRwG/LkNOh9m3ImzbVaNZP7RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c8JZiQlM0ImeqeiDNhqyhQHWbTylaKQEFYfhzGpFE8E=;
 b=u5lL4taHdWZSO2KZdWmWg2LhWCBgSf7vbQlX8N7sYMtC7NwQpAwomFCF0tDZj0QB647+Qd
 aUPAhij485aQ3JCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF8CF132EA;
 Tue, 22 Jul 2025 12:59:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mT1fMS+Lf2igZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 12:59:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Jul 2025 14:59:10 +0200
Message-ID: <20250722125916.74967-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: EF50D2199E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/6]  shell lib: Add support for test cleanup
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

Hi,

v3:
https://lore.kernel.org/ltp/20250609124506.1454420-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=460106&state=*

Changes v3->v4:
* Add checks for $TST_SETUP and $TST_CLEANUP (Li)
NOTE: I decided to use TWARN for $TST_CLEANUP as usually test could run
without it.

* New commit: "tst_res_: Add support for TWARN"
@Cyril: you may not like it, but I would prefer TWARN either be
supported or removed in whole LTP. Not supporting it in shell loader
will lead sooner or later to errors:
Wrong type 'TWARN'
Usage: tst_{res,brk} filename lineno [TPASS|TBROK|TFAIL|TCONF|TINFO|TDEBUG] 'A short description'

* New commit: "tst_res_: Print error to stderr, with filename and
  lineno"
Printing to stderr, tst_res_ filename and lineno helps debugging wrong
code. Best would be if it prints either code which invoked it or the
original message, but at least this is an improvement.

Cyril Hrubis (1):
  shell lib: Add support for test cleanup

Petr Vorel (5):
  shell: Move shell code into functions
  tst_res_: Add support for TWARN
  tst_res_: Print error to stderr, with filename and lineno
  shell lib: Add basic support for test setup
  shell: Add shell_loader_setup_cleanup.sh test

 testcases/kernel/mem/vma/vma05.sh             | 45 ++++++++++---------
 testcases/lib/run_tests.sh                    |  5 ++-
 testcases/lib/tests/shell_loader.sh           | 19 +++++---
 .../lib/tests/shell_loader_all_filesystems.sh | 26 ++++++-----
 .../lib/tests/shell_loader_brk_cleanup.sh     | 25 +++++++++++
 testcases/lib/tests/shell_loader_c_child.sh   | 15 ++++---
 testcases/lib/tests/shell_loader_cleanup.sh   | 25 +++++++++++
 .../lib/tests/shell_loader_filesystems.sh     | 23 ++++++----
 .../lib/tests/shell_loader_invalid_block.sh   |  7 ++-
 .../tests/shell_loader_invalid_metadata.sh    |  7 ++-
 testcases/lib/tests/shell_loader_kconfigs.sh  |  7 ++-
 .../lib/tests/shell_loader_no_metadata.sh     |  7 ++-
 .../lib/tests/shell_loader_setup_cleanup.sh   | 31 +++++++++++++
 .../lib/tests/shell_loader_supported_archs.sh |  7 ++-
 testcases/lib/tests/shell_loader_tags.sh      |  7 ++-
 testcases/lib/tests/shell_loader_tcnt.sh      |  7 ++-
 .../lib/tests/shell_loader_wrong_metadata.sh  |  7 ++-
 testcases/lib/tst_env.sh                      |  5 ---
 testcases/lib/tst_res_.c                      |  8 ++--
 testcases/lib/tst_run.sh                      | 24 ++++++++++
 20 files changed, 239 insertions(+), 68 deletions(-)
 create mode 100755 testcases/lib/tests/shell_loader_brk_cleanup.sh
 create mode 100755 testcases/lib/tests/shell_loader_cleanup.sh
 create mode 100755 testcases/lib/tests/shell_loader_setup_cleanup.sh
 create mode 100644 testcases/lib/tst_run.sh

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
