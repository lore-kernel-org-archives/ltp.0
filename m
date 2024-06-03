Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64996C25B75
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 12:35:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B4793D01A2
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 14:35:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84F703D01A2
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 14:35:05 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DCF9860066C
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 14:35:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C11862003A;
 Mon,  3 Jun 2024 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717418101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G+o/gCWwI/B0DYPIecD5mvzXDQwmVOTjNCuOw6oapNo=;
 b=JdV4pSeMiKZ/TT/ZY//NaSaOCP8/rBGCSsm+f0nw/awtXzyVrNqKXVVWC1RGzWrACSGQDe
 XiXEz1D+TIYnEWxJtSihgUmpqQkIQoHYKuuYW1sTIDuNaBMqugcq0RPt5fM2DER1rYy72c
 nP8n1ztK3TqYE3PBwxIv66L5/IunMxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717418101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G+o/gCWwI/B0DYPIecD5mvzXDQwmVOTjNCuOw6oapNo=;
 b=XqxzdL8jsEz22UH0Sztl1qwu354DaTR/fXsst9lkdWtuMlbK2L3/uWWTvFmFnQD+KHeh9y
 UQUwJsNtVC6pUlDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717418101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G+o/gCWwI/B0DYPIecD5mvzXDQwmVOTjNCuOw6oapNo=;
 b=JdV4pSeMiKZ/TT/ZY//NaSaOCP8/rBGCSsm+f0nw/awtXzyVrNqKXVVWC1RGzWrACSGQDe
 XiXEz1D+TIYnEWxJtSihgUmpqQkIQoHYKuuYW1sTIDuNaBMqugcq0RPt5fM2DER1rYy72c
 nP8n1ztK3TqYE3PBwxIv66L5/IunMxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717418101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G+o/gCWwI/B0DYPIecD5mvzXDQwmVOTjNCuOw6oapNo=;
 b=XqxzdL8jsEz22UH0Sztl1qwu354DaTR/fXsst9lkdWtuMlbK2L3/uWWTvFmFnQD+KHeh9y
 UQUwJsNtVC6pUlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2EF113A93;
 Mon,  3 Jun 2024 12:35:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YjYaKnW4XWZVPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 03 Jun 2024 12:35:01 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  3 Jun 2024 14:34:53 +0200
Message-ID: <20240603123455.7968-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] tst_test per FS options and small cleanup
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

Add per FS mkfs and mount options and move mkfs_opts to the tst_test
struct in two quotactl tests.

Cyril Hrubis (2):
  lib: tst_test: Add per filesystem mkfs and mount opts
  syscalls: quotactl: Move mkfs opts into tst_test

 include/tst_test.h                            | 64 ++++++++++------
 lib/tst_test.c                                | 73 +++++++++++++------
 .../kernel/syscalls/fanotify/fanotify22.c     |  4 +-
 .../kernel/syscalls/fanotify/fanotify23.c     |  4 +-
 .../kernel/syscalls/getxattr/getxattr04.c     |  4 +-
 testcases/kernel/syscalls/ioctl/ioctl08.c     |  4 +-
 testcases/kernel/syscalls/mmap/mmap16.c       | 19 ++---
 .../kernel/syscalls/quotactl/quotactl01.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl02.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl03.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl04.c     | 19 +++--
 .../kernel/syscalls/quotactl/quotactl05.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl06.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl07.c     |  4 +-
 .../kernel/syscalls/quotactl/quotactl08.c     | 19 ++---
 .../kernel/syscalls/quotactl/quotactl09.c     |  6 +-
 testcases/kernel/syscalls/statx/statx05.c     |  4 +-
 testcases/kernel/syscalls/statx/statx06.c     |  8 +-
 testcases/kernel/syscalls/statx/statx07.c     |  4 +-
 testcases/kernel/syscalls/statx/statx09.c     |  4 +-
 20 files changed, 168 insertions(+), 102 deletions(-)

-- 
2.44.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
