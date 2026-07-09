Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC00CC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 08:55:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21B1D3E294D
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:55:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 731C03E5C62
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:54:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DDAEA10005BE
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:54:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E76175DC4
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 08:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783587250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FCNIpWXc4Vz5dfbXpfW5CL4P9RQ/dYUeY2JCQ0b/KLM=;
 b=CT/ZIYCU8qxrLSgnCaCuwd5HUoF+dhC0Xe+BuMaXBAFKA/4vJT9Vdulx5zwiGm4qeN7S6+
 7wx0UR+2tIcb5qpsB/miSazjnvcjB23N3LjlXhcfc8mIs7UlbWwPKUeDQw8FOcD6XIUOWu
 qe3YvfP4WtdQ5vG9Z/M63likyKKzg1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783587250;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FCNIpWXc4Vz5dfbXpfW5CL4P9RQ/dYUeY2JCQ0b/KLM=;
 b=4R4lOZ2E+tCzj0Ojc/NINOXDY4e/bGexHvI6bQzFvajJ/6LAByU6QxHjLM4ab/jFJ3ff+R
 79A6T31zO0HqaqCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dQoplfyo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MJM5H+eR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783587248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FCNIpWXc4Vz5dfbXpfW5CL4P9RQ/dYUeY2JCQ0b/KLM=;
 b=dQoplfyoz8SYmEE+YEYnd2I6CsW1rk/PjrliU+tCqsA8qbc2jy/kvPTsqzB5R0Z//iL56r
 +pv8qM2cG5SyUk3OJVtkmMs1Lzr9sJlhmk2vUZUCB5CgVW0/T8iXJkzm2wervZEaF1Iuru
 E3SyDhrUyH3nmf1pxEy4FRYJh1DSoNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783587248;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FCNIpWXc4Vz5dfbXpfW5CL4P9RQ/dYUeY2JCQ0b/KLM=;
 b=MJM5H+eRiSc6alCD96Um+qLawjLRSOMeRPjvK1ueARisNmiw5NPYg3WlzS946qAT1FNfh7
 0dxnZHxgNDxSzBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58B11779AA
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 08:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Lim7FLBhT2oKHgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 08:54:08 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 10:53:44 +0200
Message-ID: <20260709085353.345957-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6E76175DC4
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/9] Add more epoll tests
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

This patchset adds much more epoll tests, with that the coverage is
mostly complete so that we can remove the old and ugly epoll-ltp test.

v3:
  - fixed failures pointed out by Li
  - added :manpage: links to doc comments
  - fixed doc comments (as requested by ltp-agent)
  - fixed copyrights
  - added SAFE_POLL()
  - simplified epoll_wait10 (as requested by Andrea)

Cyril Hrubis (9):
  syscalls: Add epoll_create03
  syscalls: Add epoll_wait08
  syscalls: Add epoll_wait09
  syscalls: Add epoll_ctl06
  syscalls: Add epoll_wait10
  syscalls: Add epoll_wait11
  SAFE_MACROS: Add SAFE_POLL()
  syscalls: Add epoll_wait12
  syscalls: Remove old epoll-ltp test

 include/tst_safe_macros.h                     |   6 +
 lib/tst_safe_macros.c                         |  18 +
 runtest/syscalls                              |  12 +-
 testcases/kernel/syscalls/epoll/.gitignore    |   1 -
 testcases/kernel/syscalls/epoll/Makefile      |   8 -
 testcases/kernel/syscalls/epoll/README.1ST    |  38 -
 testcases/kernel/syscalls/epoll/epoll-ltp.c   | 738 ------------------
 .../kernel/syscalls/epoll_create/.gitignore   |   1 +
 .../syscalls/epoll_create/epoll_create03.c    |  72 ++
 .../kernel/syscalls/epoll_ctl/.gitignore      |   1 +
 .../kernel/syscalls/epoll_ctl/epoll_ctl06.c   |  72 ++
 .../kernel/syscalls/epoll_wait/.gitignore     |   5 +
 .../kernel/syscalls/epoll_wait/epoll_wait08.c |  69 ++
 .../kernel/syscalls/epoll_wait/epoll_wait09.c | 132 ++++
 .../kernel/syscalls/epoll_wait/epoll_wait10.c | 103 +++
 .../kernel/syscalls/epoll_wait/epoll_wait11.c |  93 +++
 .../kernel/syscalls/epoll_wait/epoll_wait12.c | 111 +++
 17 files changed, 694 insertions(+), 786 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/epoll/.gitignore
 delete mode 100644 testcases/kernel/syscalls/epoll/Makefile
 delete mode 100644 testcases/kernel/syscalls/epoll/README.1ST
 delete mode 100644 testcases/kernel/syscalls/epoll/epoll-ltp.c
 create mode 100644 testcases/kernel/syscalls/epoll_create/epoll_create03.c
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait08.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait09.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait10.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait11.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait12.c

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
