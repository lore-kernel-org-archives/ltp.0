Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C09C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 09:42:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27E9C3E569A
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:42:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91E0B3E5686
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:41:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 25C8E6008E8
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 11:41:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 44AF478319
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784108507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m50xwR0VR3hHn5tbi61JJlNbkVqRkd50wwraOH//Hx4=;
 b=NMq4CMnbWlMdYaVDw1nBT+dcV9bGvYVWc8iv445z3vzyJjd94ev1KJEaPUQkr3yhCNOm4W
 iWVTiw6lf1hhyfOrO3q1Eze/atEV3id6XAZYnrku7E0O0tqV0JCZKLUzIod/Rm3GCIBWnr
 RSsJQAqpBnnxMIzhXxZ1uCfVIaV29Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784108507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m50xwR0VR3hHn5tbi61JJlNbkVqRkd50wwraOH//Hx4=;
 b=QIZeVK+JL96NaBpangEQaYyEttLxQflGUxyUz5N16vM9NcWefkxinLn62/bYNnLENf9KW+
 tjT+LbTKQWq9+DBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784108507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m50xwR0VR3hHn5tbi61JJlNbkVqRkd50wwraOH//Hx4=;
 b=NMq4CMnbWlMdYaVDw1nBT+dcV9bGvYVWc8iv445z3vzyJjd94ev1KJEaPUQkr3yhCNOm4W
 iWVTiw6lf1hhyfOrO3q1Eze/atEV3id6XAZYnrku7E0O0tqV0JCZKLUzIod/Rm3GCIBWnr
 RSsJQAqpBnnxMIzhXxZ1uCfVIaV29Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784108507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m50xwR0VR3hHn5tbi61JJlNbkVqRkd50wwraOH//Hx4=;
 b=QIZeVK+JL96NaBpangEQaYyEttLxQflGUxyUz5N16vM9NcWefkxinLn62/bYNnLENf9KW+
 tjT+LbTKQWq9+DBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34B5B779AD
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uSrOC9tVV2pKKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:41:47 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Jul 2026 11:41:33 +0200
Message-ID: <20260715094138.1679456-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.75 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.15)[-0.771];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] Even more epoll tests
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

Cyril Hrubis (5):
  syscalls: Add epoll_ctl07
  syscalls: Add epoll_wait13
  syscalls: Add epoll_wait14
  syscalls: Add epoll_wait15
  syscalls/epoll_wait15: Add EPOLLEXCLUSIVE test

 runtest/syscalls                              |   5 +
 .../kernel/syscalls/epoll_ctl/.gitignore      |   1 +
 .../kernel/syscalls/epoll_ctl/epoll_ctl07.c   |  60 ++++++++
 .../kernel/syscalls/epoll_wait/.gitignore     |   4 +
 .../kernel/syscalls/epoll_wait/epoll_wait13.c | 143 ++++++++++++++++++
 .../kernel/syscalls/epoll_wait/epoll_wait14.c | 114 ++++++++++++++
 .../kernel/syscalls/epoll_wait/epoll_wait15.c | 102 +++++++++++++
 .../kernel/syscalls/epoll_wait/epoll_wait16.c | 115 ++++++++++++++
 8 files changed, 544 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl07.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait13.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait14.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait15.c
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait16.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
