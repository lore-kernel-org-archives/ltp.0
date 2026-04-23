Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18C8F9937B
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 12:03:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83FE83E537D
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 14:03:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E39BF3E28DD
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 14:03:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8FECC1000992
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 14:03:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EEF545BD62
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776945781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y4X8rqzI6KuzXFApppq3PTY1PnMOnEMddhE2kH1wUVo=;
 b=BkFB1rz7/3pcuyP+B/sw4M3Vkh5E8oa9lR8rkztkijXdNakxoKTZwNwYrk4k4Fnh0NL6rz
 kCPlT0R177tnCvrmj7yFYklowiSOy25Jmvl4fUsGNxHp8ZRj1GosyMQrQ4cdZ0UYGrH9V9
 WKXvE3YN/ylQNt4qr8Ug+1lxWUcL6As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776945781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y4X8rqzI6KuzXFApppq3PTY1PnMOnEMddhE2kH1wUVo=;
 b=g59qFpqImbg9CB9vUP8PToeMaiVENOZMcl4ljRzA7woPXpXMB9RxTV5SFa/oe5OPFezqm6
 2DTeoDIZIGsN96Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776945780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y4X8rqzI6KuzXFApppq3PTY1PnMOnEMddhE2kH1wUVo=;
 b=FWKIYNZU/8uI3PAV4LzYoVDwCzUcbL1gSRyQ9jDZVopyT/KkTe+aPGnY/iws+/cZtljKUu
 ajvapGYw4YRh4To1vdGjviyB1skFA9IR+ZUSlzU4iCwzsKn2XjHf7n5p39b4ElkA4JvE2O
 wDOIUl97x+gIw+wJYl28RA5zGm3u3EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776945780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y4X8rqzI6KuzXFApppq3PTY1PnMOnEMddhE2kH1wUVo=;
 b=q1tOlBrWFf5NNWhxTnJ/38yCb46Tbzw4igdy1Ms+xVuC8bpR3L7W5VQyTowB8S5eNVxLbC
 7qU0zFEKDN0AIzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1259593A3
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +HP7NHQK6mmwUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:03:00 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 14:03:01 +0200
Message-ID: <20260423120309.18049-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/8] Add more epoll tests
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

v2:
  - fixed typos pointed out by ltp-agent

Cyril Hrubis (8):
  syscalls: Add epoll_create03
  syscalls: Add epoll_wait08
  syscalls: Add epoll_wait09
  syscalls: Add epoll_ctl06
  syscalls: Add epoll_wait10
  syscalls: Add epoll_wait11
  syscalls: Add epoll_wait12
  syscalls: Remove old epoll-ltp test

 runtest/syscalls                              |  12 +-
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
 15 files changed, 675 insertions(+), 786 deletions(-)
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
