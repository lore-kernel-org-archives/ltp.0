Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB04C5B572
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 15:52:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72E013D0E92
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 17:52:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CE383CB9F4
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 17:52:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D86C0100022F
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 17:52:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D9E933E29;
 Tue, 11 Aug 2026 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786463533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aslHF72I/mSZdP+GzqETWDK9FgxP+EYJk2f3kJSkoAQ=;
 b=xYQeuYJKrnX7FoKFLgL/E60NLcg2rqzup29FAfkMdZgn/Tl4/fPpf2hkkAqwwV5UpeNz1f
 n4NAwsTZ3PL7Seel8Ouz5msOc38NeSLQYY3AquTOPQt6DdwCwlGTWy44xxIP8ZIpetFjXw
 YOY7HFvM5FvBtJUxLYqG/uDIoqSKesw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786463533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aslHF72I/mSZdP+GzqETWDK9FgxP+EYJk2f3kJSkoAQ=;
 b=pRqyF9Mv2xiPUVoJqDyuobp2H3ZFZNl8P2gRmxcUaZ/xYzrILUlK7Dgnwxv7lheaVH6IGg
 uVneuw51djl5t7Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iemOHrJR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/4AoKFKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786463528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aslHF72I/mSZdP+GzqETWDK9FgxP+EYJk2f3kJSkoAQ=;
 b=iemOHrJRwbJaEsI6JRfMiDdKH0IjkmhSXJhxUAR2bfsJWj1c1Gk3kg/qI5NEg+FdEPFvpa
 xVPq9JYoEOVNunci2huzWC25pjQVPwz5nME9vooZ4Etl49FALs5ZZ4+4motZP4ne1+PnpE
 Dcnt7A9e6CotiUASCVWX0JdIO/XVA30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786463528;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aslHF72I/mSZdP+GzqETWDK9FgxP+EYJk2f3kJSkoAQ=;
 b=/4AoKFKu13vrGwE6r1olCe8zmVXz3oyGefwoVSo/U2fYYeIbnyvVE0ZQ0l0AGq9wETZOhV
 YhAjmBSHK++XmPBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0010E779B2;
 Tue, 11 Aug 2026 15:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XmFcMidFe2rldAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Aug 2026 15:52:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 11 Aug 2026 17:51:58 +0200
Message-ID: <20260811155202.1744316-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D9E933E29
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] test_macros: Add TST_EXP_PASS_OR_FAIL()
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

Changes v2->v3:
* Remove TST_EXP_FD_OR_FAIL_() and TST_EXP_PASS_OR_FAIL_() (Cyril, Li)
* Actually use TST_EXP_PASS_OR_FAIL() in in few tests

Link to v2:
https://lore.kernel.org/ltp/20260710083337.1185184-1-pvorel@suse.cz/#r
https://patchwork.ozlabs.org/project/ltp/list/?series=513131&state=*

Petr Vorel (4):
  test macros: Fix TST_EXP_FD_OR_FAIL()
  test_macros: Add TST_EXP_PASS_OR_FAIL()
  tree: Use TST_EXP_PASS_OR_FAIL() and TST_EXP_FD_OR_FAIL()
  test_macros*.c: Simplify with macros macros

 include/tst_test_macros.h                     |  62 +++++++--
 lib/newlib_tests/test_macros01.c              |  57 +++++---
 lib/newlib_tests/test_macros03.c              |  42 +++---
 lib/newlib_tests/test_macros04.c              |  58 --------
 lib/newlib_tests/test_macros06.c              |  32 +++--
 testcases/kernel/syscalls/access/access01.c   |   9 +-
 .../kernel/syscalls/arch_prctl/arch_prctl01.c |   9 +-
 testcases/kernel/syscalls/bind/bind01.c       |   9 +-
 .../kernel/syscalls/epoll_ctl/epoll_ctl06.c   |  12 +-
 .../syscalls/finit_module/finit_module01.c    |   7 +-
 .../syscalls/init_module/init_module01.c      |   7 +-
 .../kernel/syscalls/landlock/landlock08.c     |  18 +--
 .../kernel/syscalls/landlock/landlock09.c     |  10 +-
 .../kernel/syscalls/landlock/landlock10.c     |   8 +-
 .../syscalls/landlock/landlock_tester.h       | 129 ++++++------------
 15 files changed, 195 insertions(+), 274 deletions(-)
 delete mode 100644 lib/newlib_tests/test_macros04.c

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
