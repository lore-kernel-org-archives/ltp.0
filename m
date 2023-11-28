Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19A0C07CA9
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 09:16:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CA773CDAB5
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 10:16:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09C003CDA4C
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:16:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CF13D209A00
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:15:41 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A1801F6E6;
 Tue, 28 Nov 2023 09:15:36 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 16CCC139FC;
 Tue, 28 Nov 2023 09:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id QqILBLivZWUtTgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 09:15:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Nov 2023 10:15:21 +0100
Message-ID: <20231128091524.340808-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de; dkim=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz; dmarc=none
X-Rspamd-Queue-Id: 4A1801F6E6
X-Spamd-Result: default: False [16.32 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.cz];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(4.60)[~all:c];
 NEURAL_SPAM_SHORT(2.93)[0.977]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[99.99%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] ptrace: Remove old autotools checks
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CI: https://github.com/pevik/ltp/actions/runs/7016508622

Petr Vorel (3):
  ptrace: Remove old autotools checks
  ptrace: Build ptrace06, enable in runtest/syscalls
  ptrace: Remove simple_tracer.c

 configure.ac                                  |   1 -
 m4/ltp-ptrace.m4                              |  26 ----
 runtest/syscalls                              |   5 +-
 testcases/kernel/controllers/freezer/vfork.c  |   4 +-
 testcases/kernel/syscalls/ptrace/.gitignore   |   1 +
 testcases/kernel/syscalls/ptrace/Makefile     |  27 +---
 .../syscalls/ptrace/make_syscall_list.sh      |   7 -
 testcases/kernel/syscalls/ptrace/ptrace.h     |  38 -----
 testcases/kernel/syscalls/ptrace/ptrace01.c   |   3 +-
 testcases/kernel/syscalls/ptrace/ptrace02.c   |   3 +-
 testcases/kernel/syscalls/ptrace/ptrace03.c   |   3 +-
 testcases/kernel/syscalls/ptrace/ptrace04.c   |   4 +-
 testcases/kernel/syscalls/ptrace/ptrace05.c   |   4 +-
 testcases/kernel/syscalls/ptrace/ptrace06.c   |   5 +-
 testcases/kernel/syscalls/ptrace/ptrace07.c   |   3 +-
 testcases/kernel/syscalls/ptrace/ptrace11.c   |   3 +-
 .../kernel/syscalls/ptrace/simple_tracer.c    | 144 ------------------
 testcases/kernel/syscalls/ptrace/syscalls.h   |  17 ---
 18 files changed, 14 insertions(+), 284 deletions(-)
 delete mode 100644 m4/ltp-ptrace.m4
 delete mode 100755 testcases/kernel/syscalls/ptrace/make_syscall_list.sh
 delete mode 100644 testcases/kernel/syscalls/ptrace/ptrace.h
 delete mode 100644 testcases/kernel/syscalls/ptrace/simple_tracer.c
 delete mode 100644 testcases/kernel/syscalls/ptrace/syscalls.h

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
