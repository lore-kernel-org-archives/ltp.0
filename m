Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81177C02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 13:27:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E12723C302F
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 14:27:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B30F3C2F40
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 14:26:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A49F1142176C
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 14:26:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D04C2125A;
 Wed, 22 Jan 2025 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737552403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hNuSYVTwmLRRHyjN0DsstObZwL2/oSYzR6g/JbFj1Vk=;
 b=at/+Mhr91DtzK+mwGjSExtpi414VF6P5N3+9YL3UmQbdfoOATcdO5I/LBAI8FcZHRu4g7B
 OWYms3bNMZvhmQBChvlycuCjRUHdZu5hnotWKdionB67vjMYWiGwonoXYXeiCRlGRpvlJ6
 rVzvErhsr6cGX7TVpVK9saTRifuXPSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737552403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hNuSYVTwmLRRHyjN0DsstObZwL2/oSYzR6g/JbFj1Vk=;
 b=qQ5RzICPkpmdm45J1BeHq80lgEdgY+tlu1euG5Y/8OtTHeVljp2SxFAYaD2r4oP3GRQSGg
 vvksHwVZ/viwCAAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="at/+Mhr9";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qQ5RzICP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737552403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hNuSYVTwmLRRHyjN0DsstObZwL2/oSYzR6g/JbFj1Vk=;
 b=at/+Mhr91DtzK+mwGjSExtpi414VF6P5N3+9YL3UmQbdfoOATcdO5I/LBAI8FcZHRu4g7B
 OWYms3bNMZvhmQBChvlycuCjRUHdZu5hnotWKdionB67vjMYWiGwonoXYXeiCRlGRpvlJ6
 rVzvErhsr6cGX7TVpVK9saTRifuXPSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737552403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hNuSYVTwmLRRHyjN0DsstObZwL2/oSYzR6g/JbFj1Vk=;
 b=qQ5RzICPkpmdm45J1BeHq80lgEdgY+tlu1euG5Y/8OtTHeVljp2SxFAYaD2r4oP3GRQSGg
 vvksHwVZ/viwCAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C55A41397D;
 Wed, 22 Jan 2025 13:26:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I/hGJBLykGfwcwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 22 Jan 2025 13:26:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 22 Jan 2025 14:26:39 +0100
Message-Id: <20250122-cyril_script_update_timeouts-v2-0-c29846cc0925@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA/ykGcC/33NQQqDMBCF4avIrJuSxCqlq96jiOg41oFqQiZKR
 bx7U6HbLv+3+N4GQoFJ4JZtEGhhYTelsKcMcGimJynuUoPVttDGGoVr4FctGNjHevZdE6mOPJK
 bo6hLg5ij1m3eISTCB+r5ffCPKvXAEl1Yj7fFfNcfbP/Di1FaFX1ZXtsWS9J4l1nojG6Eat/3D
 wiwdZ3HAAAA
X-Change-ID: 20250121-cyril_script_update_timeouts-4acc3c00b3dc
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737552402; l=4960;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=/s3TJWFBBhE+sum3FJrR/ivJCimIxjitRNYS0igCwIU=;
 b=tP/MrvJu9MqTqapVsykfGhHnl5JeOQHQUn49eadFBEO6PWBJMEV0MKcxyrKc1o6ikM5CfywLM
 NQT9D5fTDqFBXg8oT2ea8xNj14vHZF1vw5cA9mO5VBzINu6yG952EGV
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 3D04C2125A
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Update test timeouts in an automated way
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
Changes in v2:
- override timeout only if test's timeout is bigger than the one
  calculated
- use '..' relative path for LTP source code
- Link to v1: https://lore.kernel.org/r/20250122-cyril_script_update_timeouts-v1-0-5f668bbc6e0c@suse.com

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
