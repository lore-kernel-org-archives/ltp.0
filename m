Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E2BC02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 12:35:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 602FB3C26CA
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 13:35:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1FFB3C2621
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 13:34:53 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 11B111A003D0
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 13:34:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ABC7E1F7C8
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 12:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737462890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JSKykoHkyRvfwCFj+EvrIo72mJdNqTNpKWcApdsjvjQ=;
 b=USC0i/2CnuG0VhLewLqjnvjPLhaYz8j4mcOfNftjNnijTapHFTsXj4IR9sOKsTu89wnwRy
 O0AkJ1O9Fn7OPY6UVlnafIc/nDkGDl2TxC2XelkA+GxUH5p9zUOADuCzbht4Zgxk2jZ/7+
 AUN1TmpVGycENY/gkdQ9UjjN8ZYD1X0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737462890;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JSKykoHkyRvfwCFj+EvrIo72mJdNqTNpKWcApdsjvjQ=;
 b=OyA4xF9Gfhe09/zOQCgY3pq+QozIQwzreWXTTUR0WgYs92b9rLhAadyoQMEoV1LlmN0L43
 56cZd2RwyIkCaMAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737462890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JSKykoHkyRvfwCFj+EvrIo72mJdNqTNpKWcApdsjvjQ=;
 b=USC0i/2CnuG0VhLewLqjnvjPLhaYz8j4mcOfNftjNnijTapHFTsXj4IR9sOKsTu89wnwRy
 O0AkJ1O9Fn7OPY6UVlnafIc/nDkGDl2TxC2XelkA+GxUH5p9zUOADuCzbht4Zgxk2jZ/7+
 AUN1TmpVGycENY/gkdQ9UjjN8ZYD1X0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737462890;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JSKykoHkyRvfwCFj+EvrIo72mJdNqTNpKWcApdsjvjQ=;
 b=OyA4xF9Gfhe09/zOQCgY3pq+QozIQwzreWXTTUR0WgYs92b9rLhAadyoQMEoV1LlmN0L43
 56cZd2RwyIkCaMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D8A31387C
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 12:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id w2ObJWqUj2cIVAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 12:34:50 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 13:34:42 +0100
Message-ID: <20250121123444.5380-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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

Cyril Hrubis (2):
  scripts: Add simple script for calculating timeouts
  syscalls: Update test timeouts

 scripts/calc_timeouts.py                      | 133 ++++++++++++++++++
 testcases/kernel/syscalls/access/access01.c   |   1 +
 testcases/kernel/syscalls/add_key/add_key05.c |   1 +
 testcases/kernel/syscalls/alarm/alarm05.c     |   1 +
 testcases/kernel/syscalls/alarm/alarm06.c     |   1 +
 testcases/kernel/syscalls/alarm/alarm07.c     |   1 +
 testcases/kernel/syscalls/bind/bind04.c       |   1 +
 testcases/kernel/syscalls/bpf/bpf_prog05.c    |   1 +
 testcases/kernel/syscalls/bpf/bpf_prog06.c    |   1 +
 testcases/kernel/syscalls/bpf/bpf_prog07.c    |   1 +
 .../kernel/syscalls/cachestat/cachestat01.c   |   1 +
 .../kernel/syscalls/cachestat/cachestat04.c   |   1 +
 testcases/kernel/syscalls/chdir/chdir01.c     |   1 +
 .../kernel/syscalls/clock_gettime/leapsec01.c |   1 +
 .../clock_nanosleep/clock_nanosleep01.c       |   1 +
 .../syscalls/clock_settime/clock_settime03.c  |   1 +
 .../syscalls/close_range/close_range01.c      |   1 +
 testcases/kernel/syscalls/connect/connect02.c |   1 +
 testcases/kernel/syscalls/creat/creat05.c     |   1 +
 testcases/kernel/syscalls/creat/creat09.c     |   1 +
 testcases/kernel/syscalls/execve/execve05.c   |   1 +
 .../kernel/syscalls/execveat/execveat03.c     |   1 +
 .../kernel/syscalls/fallocate/fallocate04.c   |   1 +
 .../kernel/syscalls/fallocate/fallocate05.c   |   1 +
 .../kernel/syscalls/fallocate/fallocate06.c   |   2 +-
 .../kernel/syscalls/fanotify/fanotify01.c     |   1 +
 .../kernel/syscalls/fanotify/fanotify03.c     |   1 +
 .../kernel/syscalls/fanotify/fanotify05.c     |   1 +
 .../kernel/syscalls/fanotify/fanotify06.c     |   1 +
 .../kernel/syscalls/fanotify/fanotify09.c     |   1 +
 .../kernel/syscalls/fanotify/fanotify10.c     |   1 +
 .../kernel/syscalls/fchmodat2/fchmodat2_01.c  |   1 +
 testcases/kernel/syscalls/fcntl/fcntl14.c     |   1 +
 testcases/kernel/syscalls/fcntl/fcntl36.c     |   1 +
 .../kernel/syscalls/fdatasync/fdatasync03.c   |   1 +
 .../kernel/syscalls/fgetxattr/fgetxattr01.c   |   1 +
 .../syscalls/fremovexattr/fremovexattr01.c    |   1 +
 .../syscalls/fremovexattr/fremovexattr02.c    |   1 +
 .../kernel/syscalls/fsconfig/fsconfig01.c     |   1 +
 .../kernel/syscalls/fsconfig/fsconfig03.c     |   1 +
 .../kernel/syscalls/fsetxattr/fsetxattr01.c   |   1 +
 testcases/kernel/syscalls/fsmount/fsmount01.c |   1 +
 testcases/kernel/syscalls/fsmount/fsmount02.c |   1 +
 testcases/kernel/syscalls/fsopen/fsopen01.c   |   1 +
 testcases/kernel/syscalls/fspick/fspick01.c   |   1 +
 testcases/kernel/syscalls/fspick/fspick02.c   |   1 +
 testcases/kernel/syscalls/fstatfs/fstatfs01.c |   1 +
 testcases/kernel/syscalls/fsync/fsync01.c     |   1 +
 testcases/kernel/syscalls/fsync/fsync04.c     |   1 +
 testcases/kernel/syscalls/getpid/getpid01.c   |   1 +
 .../kernel/syscalls/getxattr/getxattr02.c     |   1 +
 .../kernel/syscalls/getxattr/getxattr03.c     |   1 +
 testcases/kernel/syscalls/inotify/inotify03.c |   1 +
 testcases/kernel/syscalls/inotify/inotify05.c |   1 +
 testcases/kernel/syscalls/inotify/inotify07.c |   1 +
 testcases/kernel/syscalls/inotify/inotify08.c |   1 +
 testcases/kernel/syscalls/inotify/inotify11.c |   1 +
 testcases/kernel/syscalls/ioctl/ioctl02.c     |   1 +
 testcases/kernel/syscalls/ioctl/ioctl04.c     |   1 +
 testcases/kernel/syscalls/ioctl/ioctl08.c     |   1 +
 testcases/kernel/syscalls/ioctl/ioctl09.c     |   1 +
 .../kernel/syscalls/ioctl/ioctl_ficlone02.c   |   1 +
 .../kernel/syscalls/ioctl/ioctl_ficlone03.c   |   1 +
 .../syscalls/ioctl/ioctl_ficlonerange01.c     |   1 +
 .../syscalls/ioctl/ioctl_ficlonerange02.c     |   1 +
 .../kernel/syscalls/ioctl/ioctl_loop01.c      |   1 +
 66 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100755 scripts/calc_timeouts.py

-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
