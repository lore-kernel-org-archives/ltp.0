Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37C9F99344
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 09:58:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4541D3E5385
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 11:58:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F2243E20E6
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:58:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6DCA4600116
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:58:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A8225BCFF
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776938298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9DF6JkzwrxlpJ+nBwLsnXQQz68oX/YC3WqOVwmE2dqk=;
 b=m2+I5C7Qj7fR7svV66E+JuIWPO17A0qTA0YEQVLT5IN6hanhx/A1Qmp7Qh7FpeZCIxtKZa
 5zBSOeQ5/i5M7cU748r9LlMbTG+Q4Bj0AfvZhcCPL1hxCbjPRsAZFsBx/GWDxUD8iGAqEe
 mHbpZ9uO/3t7Ir5afTGinnyqRuqcifY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776938298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9DF6JkzwrxlpJ+nBwLsnXQQz68oX/YC3WqOVwmE2dqk=;
 b=69fe3ivrvv01zqebbN9FLykjXHdNkU5kRZtty6mYQicAB8gJxNp9H1y1Izk67V62LETdTa
 9e+Zr0viVJvQpwCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m2+I5C7Q;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=69fe3ivr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776938298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9DF6JkzwrxlpJ+nBwLsnXQQz68oX/YC3WqOVwmE2dqk=;
 b=m2+I5C7Qj7fR7svV66E+JuIWPO17A0qTA0YEQVLT5IN6hanhx/A1Qmp7Qh7FpeZCIxtKZa
 5zBSOeQ5/i5M7cU748r9LlMbTG+Q4Bj0AfvZhcCPL1hxCbjPRsAZFsBx/GWDxUD8iGAqEe
 mHbpZ9uO/3t7Ir5afTGinnyqRuqcifY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776938298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9DF6JkzwrxlpJ+nBwLsnXQQz68oX/YC3WqOVwmE2dqk=;
 b=69fe3ivrvv01zqebbN9FLykjXHdNkU5kRZtty6mYQicAB8gJxNp9H1y1Izk67V62LETdTa
 9e+Zr0viVJvQpwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A29E593A3
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ERL7GDrt6WlmUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:18 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 11:58:26 +0200
Message-ID: <20260423095834.11932-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7A8225BCFF
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/8] Add more epoll tests
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

Cyril Hrubis (8):
  syscalls: Add epoll_create03
  syscalls: Add epoll_wait08
  syscalls: Add epoll_wait09
  syscalls: Add epoll_ctl06
  syscall: Add epoll_wait10
  syscalls: Add epoll_wait11
  syscalls: Add epoll_wait12
  syscalls: Remove old epoll-ltp test

 runtest/syscalls                              |  11 +-
 testcases/kernel/syscalls/epoll/.gitignore    |   1 -
 testcases/kernel/syscalls/epoll/Makefile      |   8 -
 testcases/kernel/syscalls/epoll/README.1ST    |  38 -
 testcases/kernel/syscalls/epoll/epoll-ltp.c   | 738 ------------------
 .../kernel/syscalls/epoll_create/.gitignore   |   1 +
 .../syscalls/epoll_create/epoll_create03.c    |  72 ++
 .../kernel/syscalls/epoll_ctl/.gitignore      |   1 +
 .../kernel/syscalls/epoll_ctl/epoll_ctl06.c   |  71 ++
 .../kernel/syscalls/epoll_wait/.gitignore     |   5 +
 .../kernel/syscalls/epoll_wait/epoll_wait08.c |  69 ++
 .../kernel/syscalls/epoll_wait/epoll_wait09.c | 132 ++++
 .../kernel/syscalls/epoll_wait/epoll_wait10.c | 107 +++
 .../kernel/syscalls/epoll_wait/epoll_wait11.c |  94 +++
 .../kernel/syscalls/epoll_wait/epoll_wait12.c | 112 +++
 15 files changed, 674 insertions(+), 786 deletions(-)
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
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
