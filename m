Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2594BCA5FFE
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 02:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791252264; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=J8mkar/ZwxpNrVwQNjXTo7S7KCUUDuDtzq6020p6LSc=;
 b=eZVYDIG8Xvb4C8SEcxCr8oytkf2DFEbHGybbHRUs4BAju+pQiCgSCXc3h9fZj7uHIs5z5
 nWAECJYPI6+pCzry8VQWEcjXRdWqCYRWjs/y7vtFYqzrRqPsalNfhr0FhI2lrIZ96NxahdI
 faHuKU3JsGw4CT89bVY0QsA48VZ887E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACD1D3EA965
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 04:04:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6F293E2E37
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 04:04:03 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B145D1400972
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 04:04:00 +0200 (CEST)
Received: from mail.andestech.com (atcpcs54.andestech.com [10.0.1.154])
 by Atcsqr.andestech.com with ESMTPS id 69623npc005769
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 6 Oct 2026 10:03:49 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs54.andestech.com
 (10.0.1.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Tue, 6 Oct
 2026 10:03:49 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Oct
 2026 10:03:49 +0800
To: <ltp@lists.linux.it>
Date: Tue, 6 Oct 2026 10:03:29 +0800
Message-ID: <20261006020331.3791608-1-cyyang772@andestech.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs54.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 69623npc005769
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Use SAFE_READ_ANY/SAFE_READ_ALL instead of 0/1
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
From: Victor Cheng-Yen Yang via ltp <ltp@lists.linux.it>
Reply-To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Commit ce782f9dc325 ("safe_macros: Add SAFE_READ_ANY_EAGAIN") added the
SAFE_READ_ANY and SAFE_READ_ALL names for the len_strict argument, but
most callers still pass a bare 0 or 1. This series replaces them.

There is no functional change: SAFE_READ_ANY == 0, SAFE_READ_ALL == 1.

Patch 1 converts the library and the new API tests, patch 2 the old
test.h API callers.

Victor Cheng-Yen Yang (2):
  Update call sites of SAFE_READ() to use the enum values
  Update old API call sites of SAFE_READ() to use the enum values

 lib/tests/tst_safe_macros.c                    |  4 ++--
 lib/tst_safe_file_at.c                         |  2 +-
 lib/tst_security.c                             |  4 ++--
 testcases/cve/cve-2016-7042.c                  |  2 +-
 testcases/cve/cve-2026-46331.c                 |  2 +-
 testcases/kernel/controllers/io/io_control01.c |  4 ++--
 testcases/kernel/coredump/coredump01.c         |  2 +-
 testcases/kernel/coredump/coredump02.c         |  2 +-
 testcases/kernel/crypto/af_alg08.c             |  2 +-
 testcases/kernel/fs/fsplough/fsplough.c        |  4 ++--
 testcases/kernel/fs/fsx-linux/fsx-linux.c      |  2 +-
 testcases/kernel/fs/inode/inode01.c            |  2 +-
 testcases/kernel/fs/stream/stream05.c          |  2 +-
 testcases/kernel/input/input01.c               |  3 ++-
 testcases/kernel/input/input03.c               |  2 +-
 testcases/kernel/input/input06.c               |  3 ++-
 testcases/kernel/input/input_common.h          |  2 +-
 testcases/kernel/io/ltp-aiodio/aiocp.c         |  4 ++--
 testcases/kernel/io/ltp-aiodio/common.h        |  4 ++--
 testcases/kernel/irq/irqbalance01.c            |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap11.c   |  4 ++--
 .../kernel/mem/hugetlb/hugemmap/hugemmap41.c   |  2 +-
 testcases/kernel/mem/mmapstress/mmapstress01.c |  2 +-
 testcases/kernel/mem/thp/thp04.c               |  2 +-
 testcases/kernel/pty/pty01.c                   |  4 ++--
 testcases/kernel/pty/pty02.c                   |  2 +-
 .../kernel/security/dirtypipe/dirtypipe.c      |  4 ++--
 testcases/kernel/syscalls/acct/acct02.c        |  3 ++-
 testcases/kernel/syscalls/bind/bind04.c        |  4 ++--
 testcases/kernel/syscalls/bind/bind05.c        |  4 ++--
 testcases/kernel/syscalls/dup2/dup203.c        |  2 +-
 testcases/kernel/syscalls/dup2/dup207.c        |  2 +-
 .../kernel/syscalls/epoll_ctl/epoll_ctl01.c    |  2 +-
 .../syscalls/epoll_pwait/epoll_pwait01.c       |  2 +-
 .../kernel/syscalls/epoll_wait/epoll_wait01.c  |  6 +++---
 .../kernel/syscalls/epoll_wait/epoll_wait06.c  |  4 ++--
 .../kernel/syscalls/epoll_wait/epoll_wait07.c  |  2 +-
 .../kernel/syscalls/epoll_wait/epoll_wait09.c  |  2 +-
 .../kernel/syscalls/epoll_wait/epoll_wait10.c  |  2 +-
 .../kernel/syscalls/epoll_wait/epoll_wait13.c  |  2 +-
 .../kernel/syscalls/epoll_wait/epoll_wait16.c  |  2 +-
 testcases/kernel/syscalls/eventfd/eventfd01.c  |  2 +-
 testcases/kernel/syscalls/eventfd/eventfd02.c  |  2 +-
 testcases/kernel/syscalls/eventfd/eventfd03.c  |  2 +-
 testcases/kernel/syscalls/eventfd/eventfd04.c  |  2 +-
 testcases/kernel/syscalls/eventfd/eventfd05.c  |  2 +-
 testcases/kernel/syscalls/eventfd/eventfd06.c  |  4 ++--
 .../kernel/syscalls/eventfd2/eventfd2_03.c     |  2 +-
 testcases/kernel/syscalls/exit/exit02.c        |  2 +-
 .../kernel/syscalls/fallocate/fallocate04.c    |  2 +-
 .../kernel/syscalls/fallocate/fallocate06.c    |  2 +-
 .../kernel/syscalls/fanotify/fanotify01.c      | 18 +++++++++---------
 .../kernel/syscalls/fanotify/fanotify02.c      |  8 ++++----
 .../kernel/syscalls/fanotify/fanotify04.c      |  2 +-
 .../kernel/syscalls/fanotify/fanotify07.c      |  4 ++--
 .../kernel/syscalls/fanotify/fanotify11.c      |  3 ++-
 .../kernel/syscalls/fanotify/fanotify12.c      |  2 +-
 .../kernel/syscalls/fanotify/fanotify13.c      |  2 +-
 .../kernel/syscalls/fanotify/fanotify15.c      |  5 +++--
 .../kernel/syscalls/fanotify/fanotify16.c      |  6 ++++--
 .../kernel/syscalls/fanotify/fanotify19.c      |  5 +++--
 .../kernel/syscalls/fanotify/fanotify22.c      |  3 ++-
 .../kernel/syscalls/fanotify/fanotify23.c      |  5 +++--
 .../kernel/syscalls/fanotify/fanotify24.c      |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl11.c      |  4 ++--
 testcases/kernel/syscalls/fcntl/fcntl31.c      |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl34.c      |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl36.c      |  6 +++---
 testcases/kernel/syscalls/fork/fork07.c        |  2 +-
 testcases/kernel/syscalls/fork/fork08.c        |  2 +-
 testcases/kernel/syscalls/fork/fork10.c        |  4 ++--
 .../kernel/syscalls/ftruncate/ftruncate01.c    |  2 +-
 testcases/kernel/syscalls/inotify/inotify01.c  |  4 ++--
 testcases/kernel/syscalls/inotify/inotify02.c  |  2 +-
 testcases/kernel/syscalls/inotify/inotify03.c  |  2 +-
 testcases/kernel/syscalls/inotify/inotify04.c  |  2 +-
 testcases/kernel/syscalls/inotify/inotify05.c  |  5 +++--
 testcases/kernel/syscalls/inotify/inotify10.c  |  2 +-
 testcases/kernel/syscalls/inotify/inotify11.c  |  3 ++-
 testcases/kernel/syscalls/inotify/inotify12.c  |  2 +-
 .../kernel/syscalls/ioctl/ioctl_ficlone01.c    |  4 ++--
 .../syscalls/ioctl/ioctl_ficlonerange01.c      |  4 ++--
 testcases/kernel/syscalls/linkat/linkat01.c    |  3 ++-
 testcases/kernel/syscalls/llseek/llseek03.c    |  4 ++--
 testcases/kernel/syscalls/lseek/lseek01.c      |  4 ++--
 testcases/kernel/syscalls/lseek/lseek07.c      |  2 +-
 testcases/kernel/syscalls/lseek/lseek11.c      |  2 +-
 .../kernel/syscalls/lsm/lsm_list_modules02.c   |  2 +-
 testcases/kernel/syscalls/madvise/madvise08.c  |  5 +++--
 .../memfd_create/memfd_create_common.c         |  2 +-
 testcases/kernel/syscalls/mmap/mmap01.c        |  2 +-
 testcases/kernel/syscalls/mmap/mmap03.c        |  2 +-
 testcases/kernel/syscalls/mmap/mmap12.c        |  2 +-
 testcases/kernel/syscalls/mmap/mmap21.c        |  2 +-
 testcases/kernel/syscalls/mount/mount03.c      |  2 +-
 testcases/kernel/syscalls/mremap/mremap07.c    |  2 +-
 testcases/kernel/syscalls/msync/msync04.c      |  8 +++++---
 testcases/kernel/syscalls/open/open12.c        |  2 +-
 testcases/kernel/syscalls/open/open14.c        |  2 +-
 testcases/kernel/syscalls/open/open15.c        |  4 ++--
 testcases/kernel/syscalls/openat/openat02.c    |  2 +-
 testcases/kernel/syscalls/openat/openat03.c    |  2 +-
 .../syscalls/pidfd_getfd/pidfd_getfd01.c       |  2 +-
 testcases/kernel/syscalls/pipe/pipe01.c        |  2 +-
 testcases/kernel/syscalls/pipe/pipe02.c        |  2 +-
 testcases/kernel/syscalls/pipe/pipe10.c        |  2 +-
 testcases/kernel/syscalls/pipe/pipe11.c        |  2 +-
 testcases/kernel/syscalls/pipe/pipe12.c        |  2 +-
 testcases/kernel/syscalls/pipe/pipe13.c        |  2 +-
 testcases/kernel/syscalls/pipe/pipe14.c        |  4 ++--
 testcases/kernel/syscalls/pipe/pipe15.c        |  4 ++--
 testcases/kernel/syscalls/poll/poll01.c        |  2 +-
 testcases/kernel/syscalls/pread/pread01.c      |  2 +-
 testcases/kernel/syscalls/pwrite/pwrite01.c    |  2 +-
 .../kernel/syscalls/renameat2/renameat202.c    |  2 +-
 testcases/kernel/syscalls/seccomp/seccomp01.c  |  2 +-
 .../kernel/syscalls/sendfile/sendfile08.c      |  2 +-
 .../kernel/syscalls/signalfd/signalfd01.c      |  2 +-
 testcases/kernel/syscalls/splice/splice01.c    |  2 +-
 testcases/kernel/syscalls/splice/splice04.c    |  3 ++-
 testcases/kernel/syscalls/splice/splice05.c    |  3 ++-
 testcases/kernel/syscalls/splice/splice06.c    |  4 ++--
 testcases/kernel/syscalls/splice/splice08.c    |  2 +-
 testcases/kernel/syscalls/statx/statx06.c      |  2 +-
 .../kernel/syscalls/symlinkat/symlinkat01.c    |  3 ++-
 testcases/kernel/syscalls/tee/tee01.c          |  2 +-
 testcases/kernel/syscalls/timerfd/timerfd01.c  |  2 +-
 testcases/kernel/syscalls/timerfd/timerfd04.c  |  2 +-
 testcases/kernel/syscalls/umount2/umount2_01.c |  2 +-
 .../syscalls/userfaultfd/userfaultfd01.c       |  2 +-
 .../syscalls/userfaultfd/userfaultfd02.c       |  2 +-
 .../syscalls/userfaultfd/userfaultfd03.c       |  2 +-
 .../syscalls/userfaultfd/userfaultfd04.c       |  2 +-
 .../syscalls/userfaultfd/userfaultfd05.c       |  2 +-
 .../syscalls/userfaultfd/userfaultfd06.c       |  2 +-
 .../syscalls/userfaultfd/userfaultfd07.c       |  2 +-
 .../kernel/syscalls/vmsplice/vmsplice01.c      |  2 +-
 testcases/kernel/syscalls/write/write03.c      |  2 +-
 testcases/kernel/syscalls/writev/writev03.c    |  5 +++--
 testcases/kernel/syscalls/writev/writev07.c    |  4 ++--
 testcases/kernel/watchqueue/common.h           |  2 +-
 .../network/can/filter-tests/can_filter.c      |  3 ++-
 .../can/filter-tests/can_rcv_own_msgs.c        |  6 ++++--
 .../network/nfs/nfs_stress/nfs05_make_tree.c   |  2 +-
 testcases/network/sockets/xfrm01.c             |  2 +-
 testcases/network/sockets/xfrm02.c             |  2 +-
 testcases/network/sockets/xfrm03.c             |  2 +-
 147 files changed, 221 insertions(+), 198 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
