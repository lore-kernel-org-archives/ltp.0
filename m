Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AB9CDB47C
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:22:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D5653E5352
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:22:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 083B83E6203
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 20B6110009EE
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8D3E71441
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YcCoklq7IkH/9TvN8ADUzR/6nf6WtS+3bxVZQ1jvdLA=;
 b=hIw6oiXTqPtf/bAxP7wT4Oj2+u+4noudYbXlzn2/sTxLwOL9VN38h2V/4SKK8X0p5ZDBhY
 1JX4+Ob598lT6Ki2raiKqPxZkbB+tMz29rs9CNo6FhruXA4zPmoaypbeQUkmjFlIrCWE/b
 ABEHDyJ7jSnGqKQUw76X9AtSObI64yE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YcCoklq7IkH/9TvN8ADUzR/6nf6WtS+3bxVZQ1jvdLA=;
 b=jSfgdKARMIFpC9GBZ99q3uB8BeGQLGMLGU0BF7aT2ZS7r0xjRdm1/TpcNkQtlIMjY4Heup
 sfFRxYIiae2GLfDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YcCoklq7IkH/9TvN8ADUzR/6nf6WtS+3bxVZQ1jvdLA=;
 b=W+JRnwZi8lgR+RetprvANIP+ZJOzoUotjDZEZxCqSKymD5ztyU8UuRq8mNGT8GGOwgmJgz
 TvTmkSpwyece68/9BeBn0YM1KuUpqSpQ6qV1W4Aqayy1dorSZjY/bXAkZdlH8/+Iyyjx3v
 9VFFILWH/gnp6n8kVjcAJxk/2kei6w4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YcCoklq7IkH/9TvN8ADUzR/6nf6WtS+3bxVZQ1jvdLA=;
 b=JXfb8kOyVpKGJdf88Y5IizxqCNU2+39GPY7KPAhhm9XRG5ihWn6ws2wF5NclGBrTYtQBat
 Pv8nB+MCXCwebuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA613779A8
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /hi7KAShO2pBAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:00 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:47 +0200
Message-ID: <20260624091900.4107041-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/13] runtest generator prototype for runtest/cve
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

This patchset is mostly preparation for the runtest file generator. We
add two more fields to the tst_test structure. Rewrite tests to new
libraries etc. But it also fixes bugs in the build system. These
patches should go in regardless of the last patch that introduces the
runtest file generator.

Once the runtest generator is merged we can easily add more. e.g.
syscalls-ipc. However the main point of these changes is to have the
complete information on how to filter and run tests in the metadata so
that we can add advanced filtering and features to the kirk test runner.
Or eventually that people can generate their own runtest files on demand
based on the JSON metadata with their own scripts and rules.

Cyril Hrubis (13):
  tst_test: Add may_kmemleak flag and annotate tests
  keyctl01.sh: Rewrite to the new shell library
  keyctl01.sh: Remove the keyctl subcommand check
  tst_run_shell: Add support for groups in the env JSON
  vma05.sh, keyctl01.sh: Add groups
  mem/ksm05: Add proper runtime support
  mem/thp01: Add proper runtime support
  lib: tst_test: Move the iterations to struct tst_test
  syscalls/setsockopt08: Add .iterations = 100
  testcases: Fix the CVE tags
  build: rules.mk: Fix HOST_MAKE_TARGET rule
  mem: vma03: Rewrite to the new test library
  metadata: Add runtest file generator

 include/mk/rules.mk                           |   4 +-
 include/tst_test.h                            |  10 +-
 lib/tst_test.c                                |   8 +-
 metadata/.gitignore                           |   1 +
 metadata/Makefile                             |  10 +-
 metadata/genruntest.c                         | 292 ++++++++++++++++++
 metadata/metaparse.c                          |   1 +
 runtest/.gitignore                            |   1 +
 runtest/cve                                   | 100 ------
 runtest/mm                                    |   4 +-
 testcases/commands/keyctl/keyctl01.sh         |  89 ++----
 testcases/cve/cve-2022-4378.c                 |   1 +
 testcases/cve/cve-2025-21756.c                |   1 +
 testcases/cve/cve-2025-38236.c                |   1 +
 testcases/kernel/containers/userns/userns08.c |   2 +-
 testcases/kernel/crypto/af_alg08.c            |   1 +
 testcases/kernel/mem/ksm/ksm05.c              |  27 +-
 testcases/kernel/mem/thp/thp01.c              |  11 +-
 testcases/kernel/mem/vma/vma03.c              | 189 +++++-------
 testcases/kernel/mem/vma/vma05.sh             |   3 +
 testcases/kernel/pty/pty04.c                  |   2 +-
 .../kernel/security/dirtypipe/dirtypipe.c     |   2 +-
 testcases/kernel/syscalls/bpf/bpf_prog05.c    |   2 +-
 testcases/kernel/syscalls/bpf/bpf_prog06.c    |   2 +-
 testcases/kernel/syscalls/bpf/bpf_prog07.c    |   2 +-
 .../kernel/syscalls/fsconfig/fsconfig03.c     |   1 +
 .../gethostbyname_r/gethostbyname_r01.c       |   2 +-
 .../kernel/syscalls/io_uring/io_uring04.c     |   1 +
 testcases/kernel/syscalls/kill/kill13.c       |   2 +-
 .../perf_event_open/perf_event_open03.c       |   1 +
 .../syscalls/set_mempolicy/set_mempolicy05.c  |   2 +-
 .../kernel/syscalls/setsockopt/setsockopt03.c |   2 +-
 .../kernel/syscalls/setsockopt/setsockopt08.c |   1 +
 testcases/lib/tst_run_shell.c                 |  18 +-
 testcases/network/sockets/vsock01.c           |   2 +-
 testcases/network/sockets/xfrm01.c            |   1 +
 testcases/network/sockets/xfrm02.c            |   1 +
 testcases/network/sockets/xfrm03.c            |   1 +
 38 files changed, 490 insertions(+), 311 deletions(-)
 create mode 100644 metadata/genruntest.c
 create mode 100644 runtest/.gitignore
 delete mode 100644 runtest/cve
 mode change 100644 => 100755 testcases/commands/keyctl/keyctl01.sh

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
