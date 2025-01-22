Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FD5C02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 12:48:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CE243C2F6A
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 13:48:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D873C3C2977
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:48:34 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C8B6F140113B
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:48:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EBA9D21746;
 Wed, 22 Jan 2025 12:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737550112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yZqfYnRekbaw34gkoxW6b6gk3+q42zwHMMfc7fv9+qY=;
 b=LHgi3oaXboyg8hgu5nc7KJs2vUxgA0PMCnj8BDx6UQ0yZ7ZLfJmp1EKXCk6hS3yKZ5hmKt
 3+FHX8rfIYkTpnHkfZnxVqHzmfVpMh+9lPfduAGedouO1xnOAOrKi06bSioPzUeIQPIp3l
 hmjVbMvbRV9tvy8rdh/aiSYRGc4EzXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737550112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yZqfYnRekbaw34gkoxW6b6gk3+q42zwHMMfc7fv9+qY=;
 b=SJ3hycYsin9zrWjn3hkZ/IBxBpyecgvPYRT/IwSIQlr79+7SDZjZF/2ynsUmC/koN1UC4i
 cVn0LbERi8y8iZDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=geL0qLpm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y+ti0OGB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737550111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yZqfYnRekbaw34gkoxW6b6gk3+q42zwHMMfc7fv9+qY=;
 b=geL0qLpmf5hwHNuKLh4CgPp0TQmmdoEt1mp3rCOgxr3HaHdfRuX6rR7gJ47JuRE9v4rwZb
 NAjecric81x3VuI2KQCv40m2rnBFunRwf3xAKec44Gfaw0d+mSgXaE3/z95xwY+ZAeQdOy
 1Zujvv3wRKdz5ico4MaY5p7x/cUPibQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737550111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yZqfYnRekbaw34gkoxW6b6gk3+q42zwHMMfc7fv9+qY=;
 b=Y+ti0OGBIoSYKGZyW2JwmAwty1iCwsSUONt0GKNFc8IIjzLKme0vqCeCRtDjmDaD6ilSUY
 rdnN8q6EQaRzKvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74E34136A1;
 Wed, 22 Jan 2025 12:48:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Pf+VEB/pkGeANAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 22 Jan 2025 12:48:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 22 Jan 2025 13:48:25 +0100
Message-Id: <20250122-cyril_script_update_timeouts-v1-0-5f668bbc6e0c@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABnpkGcC/x3MSwqDMBAA0KvIrBtIot14lVJCnIx1wE+YiWIR7
 97Q5du8C5SESaFvLhA6WHlbK9yjAZzi+iHDqRq89U/rvDP4FZ6DonAuYc8pFgqFF9r2oqaLiC1
 aO7QJoRZZaOTz37/e9/0D1aqT2m4AAAA=
X-Change-ID: 20250121-cyril_script_update_timeouts-4acc3c00b3dc
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737550111; l=4705;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=dgD3ZF5r6F38Jagam2rNOyaiukV75FR1pwj1nqV16uc=;
 b=DEnO+5+yknnezeKRVFVb+MdQkFkwknZaaX7oZ1G6pHXo6/YhCsLqrN/oq+yOb4ADonhxbacKq
 zZHwkOB2IQTB8/5kzL2yBSUWzsaUGSSRuvxCIoIaOGaXYwyideknqgi
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: EBA9D21746
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Update test timeouts in an automated way
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

First patch adds a script that can parse kirk test results, calculate
timeouts and patch tests with the newly calculated timeouts.

Second patch updates tests timeouts using this script with a results
captured on RPi zero.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Cyril Hrubis (2):
      scripts: Add simple script for calculating timeouts
      syscalls: Update test timeouts

 scripts/calctimeouts.py                            | 232 +++++++++++++++++++++
 testcases/kernel/syscalls/access/access01.c        |   1 +
 testcases/kernel/syscalls/add_key/add_key05.c      |   1 +
 testcases/kernel/syscalls/alarm/alarm05.c          |   1 +
 testcases/kernel/syscalls/alarm/alarm06.c          |   1 +
 testcases/kernel/syscalls/alarm/alarm07.c          |   1 +
 testcases/kernel/syscalls/bind/bind04.c            |   1 +
 testcases/kernel/syscalls/bpf/bpf_prog05.c         |   1 +
 testcases/kernel/syscalls/bpf/bpf_prog06.c         |   1 +
 testcases/kernel/syscalls/bpf/bpf_prog07.c         |   1 +
 testcases/kernel/syscalls/cachestat/cachestat01.c  |   1 +
 testcases/kernel/syscalls/cachestat/cachestat04.c  |   1 +
 testcases/kernel/syscalls/chdir/chdir01.c          |   1 +
 .../kernel/syscalls/clock_gettime/leapsec01.c      |   1 +
 .../syscalls/clock_nanosleep/clock_nanosleep01.c   |   1 +
 .../syscalls/clock_settime/clock_settime03.c       |   1 +
 .../kernel/syscalls/close_range/close_range01.c    |   1 +
 testcases/kernel/syscalls/connect/connect02.c      |   1 +
 testcases/kernel/syscalls/creat/creat05.c          |   1 +
 testcases/kernel/syscalls/creat/creat09.c          |   1 +
 testcases/kernel/syscalls/execve/execve05.c        |   1 +
 testcases/kernel/syscalls/execveat/execveat03.c    |   1 +
 testcases/kernel/syscalls/fallocate/fallocate04.c  |   1 +
 testcases/kernel/syscalls/fallocate/fallocate05.c  |   1 +
 testcases/kernel/syscalls/fallocate/fallocate06.c  |   2 +-
 testcases/kernel/syscalls/fanotify/fanotify01.c    |   1 +
 testcases/kernel/syscalls/fanotify/fanotify03.c    |   1 +
 testcases/kernel/syscalls/fanotify/fanotify05.c    |   1 +
 testcases/kernel/syscalls/fanotify/fanotify06.c    |   1 +
 testcases/kernel/syscalls/fanotify/fanotify09.c    |   1 +
 testcases/kernel/syscalls/fanotify/fanotify10.c    |   1 +
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c |   1 +
 testcases/kernel/syscalls/fcntl/fcntl14.c          |   1 +
 testcases/kernel/syscalls/fcntl/fcntl36.c          |   1 +
 testcases/kernel/syscalls/fdatasync/fdatasync03.c  |   1 +
 testcases/kernel/syscalls/fgetxattr/fgetxattr01.c  |   1 +
 .../kernel/syscalls/fremovexattr/fremovexattr01.c  |   1 +
 .../kernel/syscalls/fremovexattr/fremovexattr02.c  |   1 +
 testcases/kernel/syscalls/fsconfig/fsconfig01.c    |   1 +
 testcases/kernel/syscalls/fsconfig/fsconfig03.c    |   1 +
 testcases/kernel/syscalls/fsetxattr/fsetxattr01.c  |   1 +
 testcases/kernel/syscalls/fsmount/fsmount01.c      |   1 +
 testcases/kernel/syscalls/fsmount/fsmount02.c      |   1 +
 testcases/kernel/syscalls/fsopen/fsopen01.c        |   1 +
 testcases/kernel/syscalls/fspick/fspick01.c        |   1 +
 testcases/kernel/syscalls/fspick/fspick02.c        |   1 +
 testcases/kernel/syscalls/fstatfs/fstatfs01.c      |   1 +
 testcases/kernel/syscalls/fsync/fsync01.c          |   1 +
 testcases/kernel/syscalls/fsync/fsync04.c          |   1 +
 testcases/kernel/syscalls/getpid/getpid01.c        |   1 +
 testcases/kernel/syscalls/getxattr/getxattr02.c    |   1 +
 testcases/kernel/syscalls/getxattr/getxattr03.c    |   1 +
 testcases/kernel/syscalls/inotify/inotify03.c      |   1 +
 testcases/kernel/syscalls/inotify/inotify05.c      |   1 +
 testcases/kernel/syscalls/inotify/inotify07.c      |   1 +
 testcases/kernel/syscalls/inotify/inotify08.c      |   1 +
 testcases/kernel/syscalls/inotify/inotify11.c      |   1 +
 testcases/kernel/syscalls/ioctl/ioctl02.c          |   1 +
 testcases/kernel/syscalls/ioctl/ioctl04.c          |   1 +
 testcases/kernel/syscalls/ioctl/ioctl08.c          |   1 +
 testcases/kernel/syscalls/ioctl/ioctl09.c          |   1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c  |   1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c  |   1 +
 .../kernel/syscalls/ioctl/ioctl_ficlonerange01.c   |   1 +
 .../kernel/syscalls/ioctl/ioctl_ficlonerange02.c   |   1 +
 testcases/kernel/syscalls/ioctl/ioctl_loop01.c     |   1 +
 66 files changed, 297 insertions(+), 1 deletion(-)
---
base-commit: d3df587ed1ee3f881f802f5060506a8192c38e0d
change-id: 20250121-cyril_script_update_timeouts-4acc3c00b3dc

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
