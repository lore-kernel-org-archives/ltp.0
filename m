Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F52C282C1
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 17:25:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4B693C9E7B
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 18:25:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7A413C9AAF
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 18:24:44 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 470F31425B56
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 18:24:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1625F1F460;
 Fri, 28 Feb 2025 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740763483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CciwqdY0TdJKQdE+rOPlLhaGvLw1Y5ZT3pudZvyO4BQ=;
 b=JrKv4I5ziR8gKQJBeb/NsC3rKZJDrLB1PU4gW8GR2V4dFBwEfBQjQrCFc5nuW1afXhVwQu
 BNxtp7zi9SMBigKVnW8oSYsdH+NX7Su+7y0bcyzJkJs5pCkOkkoz6olemDNM8vIoDS7rXW
 J8rG9Gle67SMBrfEVt4C7FHdE+iZnrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740763483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CciwqdY0TdJKQdE+rOPlLhaGvLw1Y5ZT3pudZvyO4BQ=;
 b=yYAlrqq2S9ruq2viUQ6pLCJH6kdyDubmm0N+MtQR+dOXmEtfYvRlAUS9focN+R/38bd0iy
 KVCNkKY5Z/FBMMDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740763483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CciwqdY0TdJKQdE+rOPlLhaGvLw1Y5ZT3pudZvyO4BQ=;
 b=JrKv4I5ziR8gKQJBeb/NsC3rKZJDrLB1PU4gW8GR2V4dFBwEfBQjQrCFc5nuW1afXhVwQu
 BNxtp7zi9SMBigKVnW8oSYsdH+NX7Su+7y0bcyzJkJs5pCkOkkoz6olemDNM8vIoDS7rXW
 J8rG9Gle67SMBrfEVt4C7FHdE+iZnrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740763483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CciwqdY0TdJKQdE+rOPlLhaGvLw1Y5ZT3pudZvyO4BQ=;
 b=yYAlrqq2S9ruq2viUQ6pLCJH6kdyDubmm0N+MtQR+dOXmEtfYvRlAUS9focN+R/38bd0iy
 KVCNkKY5Z/FBMMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 911881344A;
 Fri, 28 Feb 2025 17:24:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K+FyIFrxwWeQcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Feb 2025 17:24:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Feb 2025 18:24:33 +0100
Message-ID: <20250228172439.3276777-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 0/5] shell loader rewrite to support TST_SETUP
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

attempt to implement Cyril's suggestions:

https://lore.kernel.org/ltp/Z69OLsDLMzNw6RGt@yuki.lan/
https://lore.kernel.org/ltp/Z69QpMlrGVDwpz8w@yuki.lan/

Kind regards,
Petr

Cyril Hrubis (1):
  shell lib: Add support for test cleanup

Petr Vorel (4):
  lib: Allow test to have positional args
  shell: Move shell code into functions
  shell lib: Add basic support for test cleanup
  shell: Add shell_loader_setup_cleanup.sh test

 doc/developers/writing_tests.rst              |  2 +-
 include/tst_test.h                            |  5 +-
 lib/tst_test.c                                |  9 +++-
 testcases/kernel/mem/vma/vma05.sh             | 47 ++++++++++---------
 testcases/lib/run_tests.sh                    |  5 +-
 testcases/lib/tests/shell_loader.sh           | 19 ++++----
 .../lib/tests/shell_loader_all_filesystems.sh | 26 +++++-----
 .../lib/tests/shell_loader_brk_cleanup.sh     | 23 +++++++++
 testcases/lib/tests/shell_loader_c_child.sh   | 15 +++---
 testcases/lib/tests/shell_loader_cleanup.sh   | 23 +++++++++
 .../lib/tests/shell_loader_filesystems.sh     | 23 +++++----
 .../lib/tests/shell_loader_invalid_block.sh   |  7 ++-
 .../tests/shell_loader_invalid_metadata.sh    |  7 ++-
 testcases/lib/tests/shell_loader_kconfigs.sh  |  7 ++-
 .../lib/tests/shell_loader_no_metadata.sh     |  7 ++-
 .../lib/tests/shell_loader_setup_cleanup.sh   | 29 ++++++++++++
 .../lib/tests/shell_loader_supported_archs.sh |  7 ++-
 testcases/lib/tests/shell_loader_tags.sh      |  7 ++-
 testcases/lib/tests/shell_loader_tcnt.sh      |  7 ++-
 .../lib/tests/shell_loader_wrong_metadata.sh  |  7 ++-
 testcases/lib/tst_exec.sh                     | 19 ++++++++
 testcases/lib/tst_loader.sh                   |  5 +-
 testcases/lib/tst_run_shell.c                 | 16 +++++--
 23 files changed, 235 insertions(+), 87 deletions(-)
 create mode 100755 testcases/lib/tests/shell_loader_brk_cleanup.sh
 create mode 100755 testcases/lib/tests/shell_loader_cleanup.sh
 create mode 100755 testcases/lib/tests/shell_loader_setup_cleanup.sh
 create mode 100755 testcases/lib/tst_exec.sh

-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
