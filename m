Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDA0C48BC1
	for <ltp@archiver.kernel.org>; Wed, 14 Feb 2024 17:10:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6663A3D07D8
	for <ltp@archiver.kernel.org>; Wed, 14 Feb 2024 18:10:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF0AC3CF3BB
 for <ltp@lists.linux.it>; Wed, 14 Feb 2024 18:10:02 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 14B79600748
 for <ltp@lists.linux.it>; Wed, 14 Feb 2024 18:10:01 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 292D01FD18;
 Wed, 14 Feb 2024 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707930600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GQbfkBj84iMveEDcTj3JAPbH6YIOxpzBF4D4agNlIxk=;
 b=J9aAlcWqaYzI4ePo1pYAJtXV2rJc6NYwfhrW+szf4/WaYu7Ns1zEfxewRCNdU4yMc28FcA
 uyOpH6tD4wlsCKA7sPPwu+q5B2FSI8PMD+FP2Lwr7pMvA4cl5HbjhIgX5xI8/4x/yuTmGY
 5sncHGhp2tAPupzKJZYMuGT+N9jQpho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707930600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GQbfkBj84iMveEDcTj3JAPbH6YIOxpzBF4D4agNlIxk=;
 b=KvDaoWSTxtKFNFxRctdjIP9dLq8Q1rK6yGoP7P7uQvMUsBE7B8DWJL7soZgog9YeiDubSR
 XzpOkTk+VOwrhDBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707930600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GQbfkBj84iMveEDcTj3JAPbH6YIOxpzBF4D4agNlIxk=;
 b=J9aAlcWqaYzI4ePo1pYAJtXV2rJc6NYwfhrW+szf4/WaYu7Ns1zEfxewRCNdU4yMc28FcA
 uyOpH6tD4wlsCKA7sPPwu+q5B2FSI8PMD+FP2Lwr7pMvA4cl5HbjhIgX5xI8/4x/yuTmGY
 5sncHGhp2tAPupzKJZYMuGT+N9jQpho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707930600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GQbfkBj84iMveEDcTj3JAPbH6YIOxpzBF4D4agNlIxk=;
 b=KvDaoWSTxtKFNFxRctdjIP9dLq8Q1rK6yGoP7P7uQvMUsBE7B8DWJL7soZgog9YeiDubSR
 XzpOkTk+VOwrhDBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 83FEF13A0B;
 Wed, 14 Feb 2024 17:09:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id ReqAHefzzGUnNQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 14 Feb 2024 17:09:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 14 Feb 2024 18:09:46 +0100
Message-ID: <20240214170949.793338-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] License cleanup
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

Petr Vorel (3):
  tree: Fix license GPL-2.0-or-later
  tree: Fix SPDX license GPL-2.0-only
  tree: Relicense GPL-2.0 (v2 only) => GPL-2.0-or-later

 include/old/test.h                                              | 2 +-
 lib/tst_fs_type.c                                               | 2 +-
 lib/tst_process_state.c                                         | 2 +-
 lib/tst_timer.c                                                 | 2 +-
 scripts/checkpatch.pl                                           | 2 +-
 testcases/kernel/containers/mountns/mountns01.c                 | 2 +-
 testcases/kernel/containers/mountns/mountns02.c                 | 2 +-
 testcases/kernel/containers/mountns/mountns03.c                 | 2 +-
 testcases/kernel/containers/mountns/mountns04.c                 | 2 +-
 testcases/kernel/containers/mqns/mqns_02.c                      | 2 +-
 testcases/kernel/containers/netns/netns_netlink.c               | 2 +-
 testcases/kernel/containers/pidns/pidns03.c                     | 2 +-
 testcases/kernel/containers/pidns/pidns04.c                     | 2 +-
 testcases/kernel/containers/pidns/pidns06.c                     | 2 +-
 testcases/kernel/containers/pidns/pidns10.c                     | 2 +-
 testcases/kernel/controllers/io/io_control01.c                  | 2 +-
 testcases/kernel/controllers/memcg/memcontrol01.c               | 2 +-
 testcases/kernel/controllers/memcg/memcontrol02.c               | 2 +-
 testcases/kernel/controllers/memcg/memcontrol03.c               | 2 +-
 testcases/kernel/controllers/memcg/memcontrol04.c               | 2 +-
 testcases/kernel/controllers/memcg/memcontrol_common.h          | 2 +-
 testcases/kernel/io/ltp-aiodio/aio-stress.c                     | 2 +-
 testcases/kernel/security/dirtypipe/dirtypipe.c                 | 2 +-
 testcases/kernel/syscalls/adjtimex/adjtimex01.c                 | 2 +-
 testcases/kernel/syscalls/adjtimex/adjtimex02.c                 | 2 +-
 testcases/kernel/syscalls/capset/capset01.c                     | 2 +-
 testcases/kernel/syscalls/chown/chown01.c                       | 2 +-
 testcases/kernel/syscalls/clock_gettime/leapsec01.c             | 2 +-
 testcases/kernel/syscalls/close_range/close_range01.c           | 2 +-
 testcases/kernel/syscalls/close_range/close_range02.c           | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify01.c                 | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify02.c                 | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify03.c                 | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify04.c                 | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify05.c                 | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify06.c                 | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify08.c                 | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify10.c                 | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify12.c                 | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify13.c                 | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify14.c                 | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify23.c                 | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify_child.c             | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl30.c                       | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl33.c                       | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl38.c                       | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl39.c                       | 2 +-
 testcases/kernel/syscalls/fork/fork04.c                         | 2 +-
 testcases/kernel/syscalls/fork/fork13.c                         | 2 +-
 testcases/kernel/syscalls/fstatfs/fstatfs01.c                   | 2 +-
 testcases/kernel/syscalls/getgid/getgid01.c                     | 2 +-
 testcases/kernel/syscalls/gethostid/gethostid01.c               | 2 +-
 testcases/kernel/syscalls/gethostname/gethostname01.c           | 2 +-
 testcases/kernel/syscalls/getpagesize/getpagesize01.c           | 2 +-
 testcases/kernel/syscalls/getpgrp/getpgrp01.c                   | 2 +-
 testcases/kernel/syscalls/getppid/getppid01.c                   | 2 +-
 testcases/kernel/syscalls/getrusage/getrusage01.c               | 2 +-
 testcases/kernel/syscalls/getrusage/getrusage03.c               | 2 +-
 testcases/kernel/syscalls/getrusage/getrusage03.h               | 2 +-
 testcases/kernel/syscalls/getrusage/getrusage03_child.c         | 2 +-
 testcases/kernel/syscalls/inotify/inotify04.c                   | 2 +-
 testcases/kernel/syscalls/inotify/inotify10.c                   | 2 +-
 testcases/kernel/syscalls/lstat/lstat01.c                       | 2 +-
 testcases/kernel/syscalls/mknod/mknod01.c                       | 2 +-
 testcases/kernel/syscalls/mlock/mlock03.c                       | 2 +-
 testcases/kernel/syscalls/mlock/mlock04.c                       | 2 +-
 testcases/kernel/syscalls/mount/mount03.c                       | 2 +-
 testcases/kernel/syscalls/mount/mount03_suid_child.c            | 2 +-
 testcases/kernel/syscalls/munlock/munlock01.c                   | 2 +-
 testcases/kernel/syscalls/munlock/munlock02.c                   | 2 +-
 testcases/kernel/syscalls/ptrace/ptrace01.c                     | 2 +-
 testcases/kernel/syscalls/ptrace/ptrace08.c                     | 2 +-
 testcases/kernel/syscalls/readahead/readahead01.c               | 2 +-
 testcases/kernel/syscalls/readahead/readahead02.c               | 2 +-
 testcases/kernel/syscalls/reboot/reboot01.c                     | 2 +-
 testcases/kernel/syscalls/reboot/reboot02.c                     | 2 +-
 testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c | 2 +-
 testcases/kernel/syscalls/sbrk/sbrk01.c                         | 2 +-
 testcases/kernel/syscalls/sbrk/sbrk02.c                         | 2 +-
 testcases/kernel/syscalls/setdomainname/setdomainname01.c       | 2 +-
 testcases/kernel/syscalls/setdomainname/setdomainname02.c       | 2 +-
 testcases/kernel/syscalls/setdomainname/setdomainname03.c       | 2 +-
 testcases/kernel/syscalls/setgid/setgid01.c                     | 2 +-
 testcases/kernel/syscalls/setregid/setregid01.c                 | 2 +-
 testcases/kernel/syscalls/setregid/setregid02.c                 | 2 +-
 testcases/kernel/syscalls/setregid/setregid03.c                 | 2 +-
 testcases/kernel/syscalls/setregid/setregid04.c                 | 2 +-
 testcases/kernel/syscalls/setresuid/setresuid05.c               | 2 +-
 testcases/kernel/syscalls/setreuid/setreuid01.c                 | 2 +-
 testcases/kernel/syscalls/setxattr/setxattr03.c                 | 2 +-
 testcases/kernel/syscalls/sigpending/sigpending02.c             | 2 +-
 testcases/kernel/syscalls/statfs/statfs01.c                     | 2 +-
 testcases/kernel/syscalls/statvfs/statvfs01.c                   | 2 +-
 testcases/kernel/syscalls/statvfs/statvfs02.c                   | 2 +-
 testcases/kernel/syscalls/timer_create/timer_create01.c         | 2 +-
 testcases/kernel/syscalls/timer_create/timer_create02.c         | 2 +-
 testcases/kernel/syscalls/timer_delete/timer_delete01.c         | 2 +-
 testcases/kernel/syscalls/timer_delete/timer_delete02.c         | 2 +-
 testcases/kernel/syscalls/timer_settime/timer_settime01.c       | 2 +-
 testcases/kernel/syscalls/timer_settime/timer_settime02.c       | 2 +-
 testcases/kernel/syscalls/ustat/ustat01.c                       | 2 +-
 testcases/kernel/syscalls/ustat/ustat02.c                       | 2 +-
 testcases/kernel/syscalls/wait/wait02.c                         | 2 +-
 .../open_posix_testsuite/conformance/interfaces/shm_open/37-1.c | 2 +-
 104 files changed, 104 insertions(+), 104 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
