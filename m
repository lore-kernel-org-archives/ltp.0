Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1440BC5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 16:02:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 942F03D04D2
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:02:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86A203CF68D
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5933B1A00363
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C368C80DE3;
 Mon, 10 Aug 2026 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BkPf8V+M37V3gCPpI4XDuE27W4e8rCQoAAWG6gGDQbk=;
 b=r2z/rCxnZXa3uF8oY4Sm/5LifVajsBe6zwt+44Q6QrcecF8FV1hvwoNl3s2aMkHBNuviQq
 dfw7akhHQGnyfWg1cUMvVF0mDPzko+RUoYBPAlqymcWeIzgyDnMI7QQ8Z2g/WQ2wtmIB5L
 SXscHvGb1xkwL4PgFvE3EdWAVctgqzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377654;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BkPf8V+M37V3gCPpI4XDuE27W4e8rCQoAAWG6gGDQbk=;
 b=/6gxGnAdEOqom5gXECyLFLvQmYgBG87KtmfUkERVjL/812OHIoWKtIM2qL1+KCJ2E/EGcs
 vIMTviF1udB60jAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mhhTqxol;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gBclEmnA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BkPf8V+M37V3gCPpI4XDuE27W4e8rCQoAAWG6gGDQbk=;
 b=mhhTqxolPdYhlsDgguYYvDtn6JbncMMYeLaHjLyKR0wK5B3uxYf1sO58Ehw1kmkQ/o+KHv
 DWFK9TEiUKX/6GVq/9m6KCobhbVISPYzjatz0760r5+lXxYbMvpf2qQ8A9RGMidqnQ4qh3
 wWPc05hzWsrwVc4nSxOQPqXtGqXwF18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BkPf8V+M37V3gCPpI4XDuE27W4e8rCQoAAWG6gGDQbk=;
 b=gBclEmnAt+eeYMvj6VzQDBazS067OhI81lx2rw4wkT+6+CuqQ6KpuZR8nvQEq0J5gKjcNH
 S01iE9CT3zPgziBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E2A1779B2;
 Mon, 10 Aug 2026 16:00:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ukt7JbL1eWquLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 16:00:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Aug 2026 18:00:41 +0200
Message-ID: <20260810160048.1040517-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: C368C80DE3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/7] Add support for .max_kver
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

Hi all,

Changes v4->v5:
* Remove code which does metadata validation (3 commits, Cyril).
* Add commit to fix creat07.c timeout on test failure (agent).
* Use proper name for function (underscore at the end)
* Add one more test, increase max_kver in the test added previous
  version.

Link to v4:
https://lore.kernel.org/ltp/20260805151451.648990-1-pvorel@suse.cz/

Link to v3:
https://patchwork.kernel.org/project/ltp/list/?series=1138093&state=*
https://lore.kernel.org/ltp/20260731105132.187177-1-pvorel@suse.cz/T/#t

Link to v2:
https://lore.kernel.org/ltp/6a6a2091.9b80fa5d.4e4ae.7aac@mx.google.com/T/#t

Link to v1:
https://lore.kernel.org/ltp/20260729091717.23042-1-pvorel@suse.cz/T/#t
https://patchwork.ozlabs.org/project/ltp/list/?series=516120&state=*


Petr Vorel (7):
  tst_kvercmp: Factor out error handling
  lib: Rename function check_kver() => check_min_kver()
  lib: Add support for max_kver to struct tst_test and tst_fs
  creat07: Avoid timeout on the test failure
  creat07: execve04: Remove version check, add linux-git
  fanotify20: Skip on v7.2
  lib: Add 2 basic tests for .min_kver && .max_kver

 doc/developers/writing_tests.rst              |  3 +
 include/tst_test.h                            | 13 +++-
 lib/newlib_tests/.gitignore                   |  2 +
 lib/newlib_tests/runtest.sh                   |  2 +
 lib/newlib_tests/tst_max_kver_old.c           | 21 +++++++
 lib/newlib_tests/tst_min_kver_max_kver.c      | 22 +++++++
 lib/tst_kvercmp.c                             | 23 ++++++--
 lib/tst_test.c                                | 59 +++++++++++++++----
 testcases/kernel/syscalls/creat/creat07.c     | 23 ++++----
 testcases/kernel/syscalls/execve/execve04.c   | 24 ++++----
 .../kernel/syscalls/fanotify/fanotify20.c     |  4 ++
 11 files changed, 156 insertions(+), 40 deletions(-)
 create mode 100644 lib/newlib_tests/tst_max_kver_old.c
 create mode 100644 lib/newlib_tests/tst_min_kver_max_kver.c

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
