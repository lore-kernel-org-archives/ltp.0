Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91F1C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 12:36:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 509653E5691
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 14:36:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18C903E1D74
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 14:36:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8EABA200774
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 14:36:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7D5B7649E
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784118981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4rv/ewUo0WdBhDA5NPMKAw2RW+s+VHNSlptQHtDvu+A=;
 b=D03OXYBHV7F05y/kbK3t5fs7EdlxzyfEFJr34KF3yWtHVM2e2DYdWGQMOUzBqTxA0YK0sM
 5BeM8g5BGAecTekBu/r/w/UE6RS3UeNU5FP5y4bqgWaGgGNYhsRCv+kYKPnMN2pfS7eFzQ
 I7yVehw/PEAN2DlEi/t/23Afc9m4JGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784118981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4rv/ewUo0WdBhDA5NPMKAw2RW+s+VHNSlptQHtDvu+A=;
 b=vWM9iKOnpSgLgUhA8gL/Hn31zEB63l1PIMsu3BEEU4td8okBi1oX02DkxbCBquGJaiGlmL
 L8KJCTqjVtETzaCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yp3hzpNr;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=43sRYzng
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784118980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4rv/ewUo0WdBhDA5NPMKAw2RW+s+VHNSlptQHtDvu+A=;
 b=yp3hzpNrPSnJm9ONwzCKq02bP3ELaWOhoBEcHJeqFH5bVx7wPcMHYLaI6UTe8SovvELmYV
 pT36kYkeGub4ZlZ878Zexlf8aSCyv0fdWcL9iK564PPDqxpM4cdJOkaNxa8NOiu6sep9/U
 k7x+s3UTujsSh1KfY7ZAnf3J4K8zeRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784118980;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4rv/ewUo0WdBhDA5NPMKAw2RW+s+VHNSlptQHtDvu+A=;
 b=43sRYzngCQW0ogIn7u1U+8ktVB+uNYwVAoLs2Gwrsa8xqNlNsrrWP4aiEqqfzkwM+fh8bK
 hpxHdQqysekMGtBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B63AF779AD
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:36:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MNiSK8R+V2rgWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:36:20 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Jul 2026 14:36:07 +0200
Message-ID: <20260715123612.1684984-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:mid, suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C7D5B7649E
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5] Even more epoll tests
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

Even after the patchset there were gaps in the coverage.

v2:
 - fixed compilation failure on missing EPOLLEXCLUSIVE
 - fixed the round vs round+1 in TFAIL message in epoll_wait16
 - fixed typos in commit messages

 - didn't add the tst_reap_children() in epoll_wait16 since the
   test library collects the children processes automatically

Cyril Hrubis (5):
  syscalls: Add epoll_ctl07
  syscalls: Add epoll_wait13
  syscalls: Add epoll_wait14
  syscalls: Add epoll_wait15
  syscalls: Add epoll_wait16 EPOLLEXCLUSIVE test

 include/lapi/epoll.h                          |   4 +
 runtest/syscalls                              |   5 +
 .../kernel/syscalls/epoll_ctl/.gitignore      |   1 +
 .../kernel/syscalls/epoll_ctl/epoll_ctl07.c   |  60 ++++++++
 .../kernel/syscalls/epoll_wait/.gitignore     |   4 +
 .../kernel/syscalls/epoll_wait/epoll_wait13.c | 143 ++++++++++++++++++
 .../kernel/syscalls/epoll_wait/epoll_wait14.c | 114 ++++++++++++++
 .../kernel/syscalls/epoll_wait/epoll_wait15.c | 102 +++++++++++++
 .../kernel/syscalls/epoll_wait/epoll_wait16.c | 115 ++++++++++++++
 9 files changed, 548 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl07.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait13.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait14.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait15.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait16.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
