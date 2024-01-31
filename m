Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549F8C47DB3
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 18:07:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D23083CF91C
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 19:07:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C04DA3CE0C3
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:07:04 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ACB9860B2E8
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:07:03 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 82EE521E5C;
 Wed, 31 Jan 2024 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706724422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wUXeTG8O8JAihhf6u7mT8Ck1nFHzf+ODP1UPHEOdsn0=;
 b=dhlbfpHsTAeAOxFcLe80orhrScotbkEav6lcy23QMyEjHMoVZMVtbdQa4VnogISgHOGBI7
 P+IG9OeIF3O+4wQyncNi5oMnYhHi3EtuyDKuaNrRXQbQiOWfZ7h2EgHch4dEKxTiH5JpF7
 M/GygfPF+xqgaI0DGUX5WYKHGgZoLfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706724422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wUXeTG8O8JAihhf6u7mT8Ck1nFHzf+ODP1UPHEOdsn0=;
 b=X8TUTsiAa76LZdPoSyCkU9Ur/48MGcs8Jwr2nDVt/4a3IsYnBzWMLUZ3Dcm5PVsJzDIKaL
 6RUVG10NW1ZHaGBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706724422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wUXeTG8O8JAihhf6u7mT8Ck1nFHzf+ODP1UPHEOdsn0=;
 b=dhlbfpHsTAeAOxFcLe80orhrScotbkEav6lcy23QMyEjHMoVZMVtbdQa4VnogISgHOGBI7
 P+IG9OeIF3O+4wQyncNi5oMnYhHi3EtuyDKuaNrRXQbQiOWfZ7h2EgHch4dEKxTiH5JpF7
 M/GygfPF+xqgaI0DGUX5WYKHGgZoLfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706724422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wUXeTG8O8JAihhf6u7mT8Ck1nFHzf+ODP1UPHEOdsn0=;
 b=X8TUTsiAa76LZdPoSyCkU9Ur/48MGcs8Jwr2nDVt/4a3IsYnBzWMLUZ3Dcm5PVsJzDIKaL
 6RUVG10NW1ZHaGBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 60859139D9;
 Wed, 31 Jan 2024 18:07:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id RdQXFkaMumUoIgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 18:07:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 19:06:54 +0100
Message-ID: <20240131180659.23587-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dhlbfpHs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=X8TUTsiA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 82EE521E5C
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] MNTPOINT macro cleanup
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

Hi,

I understand that we don't need minor cleanups like this, thus feel free
to ignore.

Kind regards,
Petr

Petr Vorel (5):
  hugemmap: Move MNTPOINT definition to header
  tree: Define MNTPOINT in include/tst_fs.h
  tree: Reuse MNTPOINT definition
  tree: Use MNTPOINT macro instead of string
  doc/C-API: Update MNTPOINT related examples

 doc/C-Test-API.asciidoc                       |  5 ++--
 include/tst_fs.h                              |  3 ++-
 testcases/kernel/fs/fs_fill/fs_fill.c         |  1 -
 .../kernel/io/direct_io/dma_thread_diotest.c  |  9 +++----
 .../hugetlb/hugefallocate/hugefallocate01.c   |  1 -
 .../hugetlb/hugefallocate/hugefallocate02.c   |  1 -
 .../kernel/mem/hugetlb/hugefork/hugefork01.c  |  1 -
 .../kernel/mem/hugetlb/hugefork/hugefork02.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap12.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap15.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap16.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap17.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap18.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap19.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap20.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap21.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap22.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap23.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap24.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap25.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap26.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap27.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap28.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap29.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap30.c  |  1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap31.c  |  1 -
 testcases/kernel/syscalls/access/access04.c   |  5 ++--
 testcases/kernel/syscalls/chdir/chdir01.c     |  1 -
 testcases/kernel/syscalls/chmod/chmod06.c     |  5 ++--
 testcases/kernel/syscalls/chown/chown04.c     |  6 ++---
 testcases/kernel/syscalls/creat/creat06.c     |  4 +--
 testcases/kernel/syscalls/creat/creat09.c     |  1 -
 .../kernel/syscalls/fallocate/fallocate05.c   |  1 -
 .../kernel/syscalls/fallocate/fallocate06.c   |  1 -
 .../kernel/syscalls/fanotify/fanotify14.c     |  1 -
 testcases/kernel/syscalls/fchmod/fchmod06.c   |  5 ++--
 testcases/kernel/syscalls/fchown/fchown04.c   |  5 ++--
 .../kernel/syscalls/fgetxattr/fgetxattr01.c   |  1 -
 .../kernel/syscalls/fgetxattr/fgetxattr02.c   |  1 -
 .../syscalls/fremovexattr/fremovexattr01.c    |  1 -
 .../syscalls/fremovexattr/fremovexattr02.c    |  1 -
 .../kernel/syscalls/fsconfig/fsconfig01.c     |  1 -
 .../kernel/syscalls/fsconfig/fsconfig03.c     |  1 -
 .../kernel/syscalls/fsetxattr/fsetxattr01.c   |  1 -
 .../kernel/syscalls/fsetxattr/fsetxattr02.c   |  1 -
 testcases/kernel/syscalls/fsmount/fsmount01.c |  1 -
 testcases/kernel/syscalls/fsmount/fsmount02.c |  1 -
 testcases/kernel/syscalls/fsopen/fsopen01.c   |  1 -
 testcases/kernel/syscalls/fspick/fspick01.c   |  1 -
 testcases/kernel/syscalls/fspick/fspick02.c   |  1 -
 testcases/kernel/syscalls/fstatfs/fstatfs01.c |  5 ++--
 testcases/kernel/syscalls/fsync/fsync01.c     |  4 +--
 .../kernel/syscalls/ftruncate/ftruncate04.c   |  1 -
 .../kernel/syscalls/getxattr/getxattr02.c     |  1 -
 .../kernel/syscalls/getxattr/getxattr03.c     |  1 -
 .../kernel/syscalls/getxattr/getxattr04.c     |  1 -
 testcases/kernel/syscalls/inotify/inotify03.c | 25 ++++++++-----------
 testcases/kernel/syscalls/ioctl/ioctl04.c     | 10 ++++----
 testcases/kernel/syscalls/link/link08.c       |  3 +--
 .../syscalls/lremovexattr/lremovexattr01.c    |  1 -
 testcases/kernel/syscalls/mkdir/mkdir03.c     |  3 +--
 testcases/kernel/syscalls/mkdir/mkdir09.c     |  1 -
 testcases/kernel/syscalls/mkdirat/mkdirat02.c |  3 +--
 testcases/kernel/syscalls/mknod/mknod07.c     |  7 +++---
 testcases/kernel/syscalls/mknodat/mknodat02.c |  9 +++----
 testcases/kernel/syscalls/mmap/mmap16.c       |  1 -
 testcases/kernel/syscalls/mount/mount01.c     |  1 -
 testcases/kernel/syscalls/mount/mount03.c     |  1 -
 testcases/kernel/syscalls/mount/mount04.c     |  1 -
 testcases/kernel/syscalls/mount/mount07.c     |  1 -
 .../syscalls/mount_setattr/mount_setattr01.c  |  1 -
 .../kernel/syscalls/move_mount/move_mount01.c |  1 -
 .../kernel/syscalls/move_mount/move_mount02.c |  1 -
 testcases/kernel/syscalls/open/open11.c       |  1 -
 testcases/kernel/syscalls/open/open12.c       |  1 -
 .../kernel/syscalls/open_tree/open_tree01.c   |  1 -
 .../kernel/syscalls/open_tree/open_tree02.c   |  1 -
 testcases/kernel/syscalls/openat/openat04.c   |  1 -
 testcases/kernel/syscalls/prctl/prctl06.h     |  1 -
 testcases/kernel/syscalls/preadv/preadv03.c   |  1 -
 testcases/kernel/syscalls/preadv2/preadv203.c |  1 -
 testcases/kernel/syscalls/pwritev/pwritev03.c |  1 -
 .../kernel/syscalls/quotactl/quotactl01.c     |  1 -
 .../kernel/syscalls/quotactl/quotactl06.c     |  1 -
 .../kernel/syscalls/quotactl/quotactl08.c     |  1 -
 .../syscalls/quotactl/quotactl_syscall_var.h  |  1 -
 testcases/kernel/syscalls/rename/rename01.c   |  5 ++--
 testcases/kernel/syscalls/rename/rename03.c   | 11 ++++----
 testcases/kernel/syscalls/rename/rename04.c   |  5 ++--
 testcases/kernel/syscalls/rename/rename05.c   |  5 ++--
 testcases/kernel/syscalls/rename/rename06.c   |  5 ++--
 testcases/kernel/syscalls/rename/rename07.c   |  5 ++--
 testcases/kernel/syscalls/rename/rename08.c   |  5 ++--
 testcases/kernel/syscalls/rename/rename10.c   |  5 ++--
 testcases/kernel/syscalls/rename/rename11.c   |  1 -
 testcases/kernel/syscalls/rename/rename12.c   |  5 ++--
 testcases/kernel/syscalls/rename/rename13.c   |  7 +++---
 .../kernel/syscalls/renameat/renameat01.c     |  1 -
 testcases/kernel/syscalls/rmdir/rmdir02.c     |  5 ++--
 .../syscalls/set_mempolicy/set_mempolicy03.c  |  1 -
 .../syscalls/set_mempolicy/set_mempolicy04.c  |  1 -
 .../kernel/syscalls/setxattr/setxattr01.c     |  1 -
 testcases/kernel/syscalls/statfs/statfs01.c   |  5 ++--
 testcases/kernel/syscalls/statvfs/statvfs01.c |  5 ++--
 testcases/kernel/syscalls/statx/statx01.c     |  3 +--
 testcases/kernel/syscalls/statx/statx04.c     |  5 ++--
 testcases/kernel/syscalls/statx/statx05.c     |  1 -
 testcases/kernel/syscalls/statx/statx06.c     |  5 ++--
 testcases/kernel/syscalls/statx/statx08.c     |  7 +++---
 testcases/kernel/syscalls/statx/statx09.c     |  1 -
 testcases/kernel/syscalls/statx/statx10.c     |  1 -
 testcases/kernel/syscalls/statx/statx12.c     |  1 -
 testcases/kernel/syscalls/umount/umount01.c   |  1 -
 testcases/kernel/syscalls/umount/umount02.c   |  1 -
 testcases/kernel/syscalls/umount/umount03.c   |  1 -
 .../kernel/syscalls/umount2/umount2_01.c      |  1 -
 .../kernel/syscalls/umount2/umount2_02.c      |  1 -
 testcases/kernel/syscalls/utime/utime01.c     |  5 ++--
 testcases/kernel/syscalls/utime/utime02.c     |  5 ++--
 testcases/kernel/syscalls/utime/utime03.c     |  1 -
 testcases/kernel/syscalls/utime/utime04.c     |  5 ++--
 testcases/kernel/syscalls/utime/utime05.c     |  7 +++---
 testcases/kernel/syscalls/utime/utime06.c     |  5 ++--
 .../kernel/syscalls/utimensat/utimensat01.c   |  1 -
 testcases/kernel/syscalls/utimes/utimes01.c   |  3 +--
 testcases/kernel/syscalls/writev/writev03.c   |  1 -
 133 files changed, 99 insertions(+), 232 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
