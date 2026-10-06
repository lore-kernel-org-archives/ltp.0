Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BFBCA5FF0
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 02:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791252276; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=F35z8rM5COlKTpQZcDApXazBtxUuojxLiOYQm1cGbO4=;
 b=UK0Na3/HE3LBSUgXq+Tbe7flE53BKImNWsor2SU/ZKBrgp4OxlSV75Md5y21cQJXeu7Sc
 cmADMevdS0FaEvESuYCsX+/f9OvNIkk3tEEobJcZE36+QnRMCY0caxLqwY2/akyGOZt9CbU
 fHGbC5kCFCl5qSFLfMlOe9ViP+HNVwU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBE263EAC3F
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 04:04:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 229863EA99E
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 04:04:14 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 792591A007FD
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 04:04:11 +0200 (CEST)
Received: from mail.andestech.com (atcpcs53.andestech.com [10.0.1.153])
 by Atcsqr.andestech.com with ESMTPS id 696243Yg006041
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 6 Oct 2026 10:04:03 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs53.andestech.com
 (10.0.1.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Tue, 6 Oct
 2026 10:04:03 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Oct
 2026 10:04:03 +0800
To: <ltp@lists.linux.it>
Date: Tue, 6 Oct 2026 10:03:30 +0800
Message-ID: <20261006020331.3791608-2-cyyang772@andestech.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006020331.3791608-1-cyyang772@andestech.com>
References: <20261006020331.3791608-1-cyyang772@andestech.com>
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs53.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 696243Yg006041
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Update call sites of SAFE_READ() to use the enum
 values
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

From: Victor Cheng-Yen Yang <cyyang772@andestech.com>

SAFE_READ_ANY (0) and SAFE_READ_ALL (1) were added along with
SAFE_READ_ANY_EAGAIN so that the len_strict parameter is no longer a
nameless boolean. Replace the remaining magic numbers in the library and
in the new API tests so that the intent of every call site is visible
without looking up the prototype.

The conversion is mechanical: 0 becomes SAFE_READ_ANY and 1 becomes
SAFE_READ_ALL. Calls that no longer fit in 80 columns are re-wrapped,
and whitespace on touched lines is fixed.
No functional change.

Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
---
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
 testcases/kernel/syscalls/seccomp/seccomp01.c  |  2 +-
 .../kernel/syscalls/sendfile/sendfile08.c      |  2 +-
 .../kernel/syscalls/signalfd/signalfd01.c      |  2 +-
 testcases/kernel/syscalls/splice/splice01.c    |  2 +-
 testcases/kernel/syscalls/splice/splice04.c    |  3 ++-
 testcases/kernel/syscalls/splice/splice05.c    |  3 ++-
 testcases/kernel/syscalls/splice/splice06.c    |  4 ++--
 testcases/kernel/syscalls/splice/splice08.c    |  2 +-
 testcases/kernel/syscalls/statx/statx06.c      |  2 +-
 testcases/kernel/syscalls/tee/tee01.c          |  2 +-
 testcases/kernel/syscalls/timerfd/timerfd01.c  |  2 +-
 testcases/kernel/syscalls/timerfd/timerfd04.c  |  2 +-
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
 139 files changed, 209 insertions(+), 188 deletions(-)

diff --git a/lib/tst_safe_file_at.c b/lib/tst_safe_file_at.c
index 257f70291..1c92ffd7e 100644
--- a/lib/tst_safe_file_at.c
+++ b/lib/tst_safe_file_at.c
@@ -67,7 +67,7 @@ ssize_t safe_file_readat(const char *const file, const int lineno,
 	if (fd < 0)
 		return -1;
 
-	rval = safe_read(file, lineno, NULL, 0, fd, buf, nbyte - 1);
+	rval = safe_read(file, lineno, NULL, SAFE_READ_ANY, fd, buf, nbyte - 1);
 	if (rval < 0)
 		return -1;
 
diff --git a/lib/tst_security.c b/lib/tst_security.c
index 00be4d72e..2540258c6 100644
--- a/lib/tst_security.c
+++ b/lib/tst_security.c
@@ -42,7 +42,7 @@ int tst_lsm_enabled(const char *name)
 	memset(data, 0, BUFSIZ);
 
 	fd = SAFE_OPEN(LSM_SYS_FILE, O_RDONLY);
-	SAFE_READ(0, fd, data, BUFSIZ);
+	SAFE_READ(SAFE_READ_ANY, fd, data, BUFSIZ);
 	SAFE_CLOSE(fd);
 
 	ptr = strtok(data, ",");
@@ -126,7 +126,7 @@ int tst_secureboot_enabled(void)
 		tst_brk(TBROK | TERRNO, "Invalid open() return value %d", fd);
 		return -1;
 	}
-	SAFE_READ(1, fd, data, VAR_DATA_SIZE);
+	SAFE_READ(SAFE_READ_ALL, fd, data, VAR_DATA_SIZE);
 	SAFE_CLOSE(fd);
 	tst_res(TINFO, "SecureBoot: %s", data[VAR_DATA_SIZE - 1] ? "on" : "off");
 	return data[VAR_DATA_SIZE - 1];
diff --git a/testcases/cve/cve-2016-7042.c b/testcases/cve/cve-2016-7042.c
index 0556789d6..360181dea 100644
--- a/testcases/cve/cve-2016-7042.c
+++ b/testcases/cve/cve-2016-7042.c
@@ -34,7 +34,7 @@ static void do_test(void)
 
 	tst_res(TINFO, "Attempting to crash the system");
 
-	SAFE_READ(0, fd, buf, BUFSIZ);
+	SAFE_READ(SAFE_READ_ANY, fd, buf, BUFSIZ);
 
 	tst_res(TPASS, "Bug not reproduced");
 
diff --git a/testcases/cve/cve-2026-46331.c b/testcases/cve/cve-2026-46331.c
index 3d32a1cbb..439b1280a 100644
--- a/testcases/cve/cve-2026-46331.c
+++ b/testcases/cve/cve-2026-46331.c
@@ -246,7 +246,7 @@ static void run(void)
 	 * file position, so it is still at 0. Keeping the same fd
 	 * guarantees we hit the same page-cache pages.
 	 */
-	SAFE_READ(1, file_fd, readback, sizeof(readback));
+	SAFE_READ(SAFE_READ_ALL, file_fd, readback, sizeof(readback));
 	SAFE_CLOSE(file_fd);
 	file_fd = -1;
 
diff --git a/testcases/kernel/controllers/io/io_control01.c b/testcases/kernel/controllers/io/io_control01.c
index 93e6aed87..abb95ef51 100644
--- a/testcases/kernel/controllers/io/io_control01.c
+++ b/testcases/kernel/controllers/io/io_control01.c
@@ -72,7 +72,7 @@ static void run(void)
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 
 	fd = SAFE_OPEN("/dev/urandom", O_RDONLY, 0600);
-	SAFE_READ(1, fd, buf, pgsz);
+	SAFE_READ(SAFE_READ_ALL, fd, buf, pgsz);
 	SAFE_CLOSE(fd);
 
 	fd = SAFE_OPEN("mnt/dat", O_WRONLY | O_CREAT, 0600);
@@ -87,7 +87,7 @@ static void run(void)
 	fd = SAFE_OPEN("mnt/dat", O_RDONLY, 0600);
 
 	for (i = 0; i < 4; i++)
-		SAFE_READ(1, fd, buf, pgsz);
+		SAFE_READ(SAFE_READ_ALL, fd, buf, pgsz);
 
 	tst_res(TPASS, "Did some IO in the IO controller");
 
diff --git a/testcases/kernel/coredump/coredump01.c b/testcases/kernel/coredump/coredump01.c
index 15aaf8c56..6a013b689 100644
--- a/testcases/kernel/coredump/coredump01.c
+++ b/testcases/kernel/coredump/coredump01.c
@@ -51,7 +51,7 @@ static void verify_elf_core(const char *path)
 	int fd;
 
 	fd = SAFE_OPEN(path, O_RDONLY);
-	SAFE_READ(1, fd, hdr, sizeof(hdr));
+	SAFE_READ(SAFE_READ_ALL, fd, hdr, sizeof(hdr));
 	SAFE_CLOSE(fd);
 
 	memcpy(&e_type, hdr + EI_NIDENT, sizeof(e_type));
diff --git a/testcases/kernel/coredump/coredump02.c b/testcases/kernel/coredump/coredump02.c
index 7b0b4c43e..746bd4079 100644
--- a/testcases/kernel/coredump/coredump02.c
+++ b/testcases/kernel/coredump/coredump02.c
@@ -63,7 +63,7 @@ static void load_core(const char *path)
 	core_buf = SAFE_MALLOC(core_len);
 
 	fd = SAFE_OPEN(path, O_RDONLY);
-	SAFE_READ(1, fd, core_buf, core_len);
+	SAFE_READ(SAFE_READ_ALL, fd, core_buf, core_len);
 	SAFE_CLOSE(fd);
 }
 
diff --git a/testcases/kernel/crypto/af_alg08.c b/testcases/kernel/crypto/af_alg08.c
index 7a2432522..6e1b81b09 100644
--- a/testcases/kernel/crypto/af_alg08.c
+++ b/testcases/kernel/crypto/af_alg08.c
@@ -126,7 +126,7 @@ static void run(void)
 	SAFE_CLOSE(file_fd);
 
 	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
-	SAFE_READ(1, file_fd, readback, sizeof(readback));
+	SAFE_READ(SAFE_READ_ALL, file_fd, readback, sizeof(readback));
 	SAFE_CLOSE(file_fd);
 
 	if (memcmp(readback, original, OVERWRITE_SIZE) != 0)
diff --git a/testcases/kernel/fs/fsplough/fsplough.c b/testcases/kernel/fs/fsplough/fsplough.c
index 65db3738e..590c7a734 100644
--- a/testcases/kernel/fs/fsplough/fsplough.c
+++ b/testcases/kernel/fs/fsplough/fsplough.c
@@ -122,7 +122,7 @@ static void do_pwritev(void *buf, size_t offset, size_t size)
 static void do_read(void *buf, size_t offset, size_t size)
 {
 	SAFE_LSEEK(read_fd, offset, SEEK_SET);
-	SAFE_READ(1, read_fd, buf, size);
+	SAFE_READ(SAFE_READ_ALL, read_fd, buf, size);
 }
 
 static void do_pread(void *buf, size_t offset, size_t size)
@@ -265,7 +265,7 @@ static void run(void)
 	/* Check final file contents */
 	for (start = 0; start < filesize; start += bufsize) {
 		length = MIN(bufsize, filesize - start);
-		SAFE_READ(1, read_fd, writebuf, length);
+		SAFE_READ(SAFE_READ_ALL, read_fd, writebuf, length);
 
 		if (memcmp(writebuf, filedata + start, length)) {
 			tst_res(TFAIL, "Final data mismatch at [%zu:%zu]",
diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index 2e0f17a5e..89682adb2 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -137,7 +137,7 @@ static int op_read(void)
 	memset(temp_buff, 0, file_max_size);
 
 	SAFE_LSEEK(file_desc, (off_t)pos.offset, SEEK_SET);
-	SAFE_READ(0, file_desc, temp_buff, pos.size);
+	SAFE_READ(SAFE_READ_ANY, file_desc, temp_buff, pos.size);
 
 	int ret = memory_compare(
 		file_buff + pos.offset,
diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
index 0e94b3337..e7190fc99 100644
--- a/testcases/kernel/fs/inode/inode01.c
+++ b/testcases/kernel/fs/inode/inode01.c
@@ -102,7 +102,7 @@ static uint64_t verify_file(const struct tcase *tc, const char *path)
 	}
 
 	for (i = 0; i < tc->repetitions; i++) {
-		SAFE_READ(1, fd, buf, len);
+		SAFE_READ(SAFE_READ_ALL, fd, buf, len);
 		if (memcmp(buf, path, len))
 			tst_brk(TFAIL, "%s contains unexpected data at record %u", path, i);
 	}
diff --git a/testcases/kernel/fs/stream/stream05.c b/testcases/kernel/fs/stream/stream05.c
index 04cb237a1..583416f6e 100644
--- a/testcases/kernel/fs/stream/stream05.c
+++ b/testcases/kernel/fs/stream/stream05.c
@@ -38,7 +38,7 @@ static void run(void)
 
 	SAFE_FSYNC(fd);
 	SAFE_FSEEK(stream, 0, SEEK_SET);
-	SAFE_READ(1, fd, buff, BUFFSIZE);
+	SAFE_READ(SAFE_READ_ALL, fd, buff, BUFFSIZE);
 
 	TST_EXP_EQ_STRN(data, buff, DATASIZE);
 	TST_EXP_EQ_STRN(data, buff + 3, DATASIZE);
diff --git a/testcases/kernel/input/input01.c b/testcases/kernel/input/input01.c
index e57b041e2..fa8258d9d 100644
--- a/testcases/kernel/input/input01.c
+++ b/testcases/kernel/input/input01.c
@@ -32,7 +32,8 @@ static void run(void)
 	tst_res(TINFO, "Reading events back");
 
 	for (int i = 0; i < NUM_EVENTS; i++) {
-		SAFE_READ(0, fd_recv, iev, 3 * sizeof(struct input_event));
+		SAFE_READ(SAFE_READ_ANY, fd_recv, iev,
+			  3 * sizeof(struct input_event));
 
 		TST_EXP_EQ_LI(iev[0].type, EV_REL);
 		TST_EXP_EQ_LI(iev[0].code, REL_X);
diff --git a/testcases/kernel/input/input03.c b/testcases/kernel/input/input03.c
index 5229379cf..9547215bd 100644
--- a/testcases/kernel/input/input03.c
+++ b/testcases/kernel/input/input03.c
@@ -34,7 +34,7 @@ static void recv_data(void)
 	while (events < NUM_EVENTS) {
 		memset(buf, 0, sizeof(buf));
 
-		num_bytes = SAFE_READ(0, fd_recv, buf, sizeof(buf));
+		num_bytes = SAFE_READ(SAFE_READ_ANY, fd_recv, buf, sizeof(buf));
 
 		for (int i = 0; i < num_bytes / 3; i++) {
 			if (buf[3*i] & PS2_RIGHT_BTN)
diff --git a/testcases/kernel/input/input06.c b/testcases/kernel/input/input06.c
index 969c90f63..ecffafebb 100644
--- a/testcases/kernel/input/input06.c
+++ b/testcases/kernel/input/input06.c
@@ -43,7 +43,8 @@ static int check_event(struct input_event *iev, int event, int code, int value)
 
 static void read_events(void)
 {
-	int num_bytes = SAFE_READ(0, fd_recv, events, sizeof(events));
+	int num_bytes = SAFE_READ(SAFE_READ_ANY, fd_recv, events,
+				  sizeof(events));
 
 	if (!num_bytes)
 		tst_brk(TBROK, "Failed to read events");
diff --git a/testcases/kernel/input/input_common.h b/testcases/kernel/input/input_common.h
index 9acdb86be..946fd32cb 100644
--- a/testcases/kernel/input/input_common.h
+++ b/testcases/kernel/input/input_common.h
@@ -84,7 +84,7 @@ static inline void verify_no_events_queued(const int fd_recv)
 	if (!num_events)
 		return;
 
-	num_bytes = SAFE_READ(0, fd_recv, &ev, sizeof(ev));
+	num_bytes = SAFE_READ(SAFE_READ_ANY, fd_recv, &ev, sizeof(ev));
 	if (!num_bytes)
 		return;
 
diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
index 2a4afe110..adfee63b7 100644
--- a/testcases/kernel/io/ltp-aiodio/aiocp.c
+++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
@@ -301,8 +301,8 @@ static void run(void)
 	reads = howmany(filesize, buffsize);
 
 	for (i = 0; i < reads; i++) {
-		r = SAFE_READ(0, srcfd, srcbuff, buffsize);
-		SAFE_READ(0, dstfd, dstbuff, buffsize);
+		r = SAFE_READ(SAFE_READ_ANY, srcfd, srcbuff, buffsize);
+		SAFE_READ(SAFE_READ_ANY, dstfd, dstbuff, buffsize);
 		if (memcmp(srcbuff, dstbuff, r)) {
 			tst_res(TFAIL, "Files are not identical");
 			return;
diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
index 9a2d27166..29fa507d4 100644
--- a/testcases/kernel/io/ltp-aiodio/common.h
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -78,7 +78,7 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
 		SAFE_LSEEK(fd, SEEK_SET, 0);
 
 		for (i = 0; i < filesize + 1; i += sizeof(buff)) {
-			r = SAFE_READ(0, fd, buff, sizeof(buff));
+			r = SAFE_READ(SAFE_READ_ANY, fd, buff, sizeof(buff));
 			if (r > 0) {
 				bufoff = check_zero(buff, r);
 				if (bufoff) {
@@ -121,7 +121,7 @@ static inline void io_read_eof(const char *filename, volatile int *run_child)
 
 		offset = SAFE_LSEEK(fd, SEEK_END, 0);
 
-		r = SAFE_READ(0, fd, buff, sizeof(buff));
+		r = SAFE_READ(SAFE_READ_ANY, fd, buff, sizeof(buff));
 		if (r > 0) {
 			bufoff = check_zero(buff, r);
 			if (bufoff) {
diff --git a/testcases/kernel/irq/irqbalance01.c b/testcases/kernel/irq/irqbalance01.c
index 9d15cdc60..d142c79ec 100644
--- a/testcases/kernel/irq/irqbalance01.c
+++ b/testcases/kernel/irq/irqbalance01.c
@@ -69,7 +69,7 @@ static char *read_proc_file(const char *const path, size_t *const len_out)
 			buf = SAFE_REALLOC(buf, total_len);
 		}
 
-		ret = SAFE_READ(0, fd,
+		ret = SAFE_READ(SAFE_READ_ANY, fd,
 				buf + used_len,
 				total_len - used_len - 1);
 		used_len += ret;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
index 087e8c691..fa25251e2 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
@@ -40,7 +40,7 @@ static void run_test(void)
 	SAFE_WRITE(1, nfd, p, IOSZ);
 	SAFE_LSEEK(nfd, 0, SEEK_SET);
 
-	SAFE_READ(1, nfd, buf, IOSZ);
+	SAFE_READ(SAFE_READ_ALL, nfd, buf, IOSZ);
 	if (memcmp(P0, buf, 8)) {
 		tst_res(TFAIL, "Memory mismatch after Direct-IO write");
 		goto cleanup;
@@ -48,7 +48,7 @@ static void run_test(void)
 	SAFE_LSEEK(nfd, 0, SEEK_SET);
 
 	memset(p, 0, IOSZ);
-	SAFE_READ(1, nfd, p, IOSZ);
+	SAFE_READ(SAFE_READ_ALL, nfd, p, IOSZ);
 
 	if (memcmp(p, P0, 8))
 		tst_res(TFAIL, "Memory mismatch after Direct-IO read");
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
index d59811d8f..a95be4603 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
@@ -89,7 +89,7 @@ static void run_test(void)
 	}
 
 	SAFE_CLOSE(pipefd[1]);
-	SAFE_READ(1, pipefd[0], &p, sizeof(p));
+	SAFE_READ(SAFE_READ_ALL, pipefd[0], &p, sizeof(p));
 	SAFE_CLOSE(pipefd[0]);
 
 	tst_res(TINFO, "Parent received address %p", p);
diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index bafdfbaa7..bdf8425c4 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -219,7 +219,7 @@ static void fileokay(char *file, unsigned char *expbuf)
 	mappages = roundup(mapsize, pagesize) / pagesize;
 
 	for (i = 0; i < mappages; i++) {
-		cnt = SAFE_READ(0, fd, readbuf, pagesize);
+		cnt = SAFE_READ(SAFE_READ_ANY, fd, readbuf, pagesize);
 		if ((unsigned int)cnt != pagesize) {
 			/* Okay if at last page in file... */
 			if ((i * pagesize) + cnt != mapsize)
diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index a4b2fa7bc..01555ef4d 100644
--- a/testcases/kernel/mem/thp/thp04.c
+++ b/testcases/kernel/mem/thp/thp04.c
@@ -106,7 +106,7 @@ static void *thread_run(void *arg)
 		madvise(write_thp, thp_size, MADV_DONTNEED);
 		memcpy(&c, write_ptr, sizeof(c));
 		SAFE_LSEEK(readfd, (off_t)write_ptr, SEEK_SET);
-		SAFE_READ(1, readfd, &c, sizeof(int));
+		SAFE_READ(SAFE_READ_ALL, readfd, &c, sizeof(int));
 		tst_fzsync_end_race_b(&fzsync_pair);
 		/* Wait for dirty page handling before next madvise() */
 		usleep(10);
diff --git a/testcases/kernel/pty/pty01.c b/testcases/kernel/pty/pty01.c
index 99f8d32d3..b1f2bfca9 100644
--- a/testcases/kernel/pty/pty01.c
+++ b/testcases/kernel/pty/pty01.c
@@ -27,7 +27,7 @@ static void run(void)
 
 	memset(buf, 0, BUFSIZ);
 	SAFE_WRITE(SAFE_WRITE_ALL, masterfd, STRING, string_len);
-	SAFE_READ(0, slavefd, buf, string_len);
+	SAFE_READ(SAFE_READ_ANY, slavefd, buf, string_len);
 	TST_EXP_EQ_STRN(STRING, buf, string_len - 1);
 
 	tst_res(TINFO, "Send message to slave and read it from master");
@@ -38,7 +38,7 @@ static void run(void)
 	/* we need to write string_len + 1, because kernel converts newline
 	 * into carriage return + newline
 	 */
-	SAFE_READ(0, masterfd, buf, string_len + 1);
+	SAFE_READ(SAFE_READ_ANY, masterfd, buf, string_len + 1);
 	TST_EXP_EQ_STRN(STRING, buf, string_len - 1);
 }
 
diff --git a/testcases/kernel/pty/pty02.c b/testcases/kernel/pty/pty02.c
index 11eec1b8d..99c1363fb 100644
--- a/testcases/kernel/pty/pty02.c
+++ b/testcases/kernel/pty/pty02.c
@@ -50,7 +50,7 @@ static void do_test(void)
 	pts = SAFE_OPEN(ptsname(ptmx), O_RDONLY);
 	/* write newline to ptmx to avoid read() on pts to block */
 	SAFE_WRITE(SAFE_WRITE_ALL, ptmx, "A\n", 2);
-	SAFE_READ(1, pts, &c, 1);
+	SAFE_READ(SAFE_READ_ALL, pts, &c, 1);
 
 	tst_res(TINFO, "Calling FIONREAD, this will hang in n_tty_ioctl() if the bug is present...");
 	SAFE_IOCTL(pts, FIONREAD, &nbytes);
diff --git a/testcases/kernel/security/dirtypipe/dirtypipe.c b/testcases/kernel/security/dirtypipe/dirtypipe.c
index 5fd5234bd..8cf389f1f 100644
--- a/testcases/kernel/security/dirtypipe/dirtypipe.c
+++ b/testcases/kernel/security/dirtypipe/dirtypipe.c
@@ -52,7 +52,7 @@ static char *pattern_buf, *read_buf;
 static void check_file_contents(void)
 {
 	SAFE_LSEEK(fd, 0, SEEK_SET);
-	SAFE_READ(1, fd, read_buf, 4096);
+	SAFE_READ(SAFE_READ_ALL, fd, read_buf, 4096);
 
 	if (memcmp(pattern_buf, read_buf, 4096) != 0)
 		tst_res(TFAIL, "read buf data mismatch, bug exists");
@@ -88,7 +88,7 @@ static void prepare_pipe(void)
 	 */
 	for (total = pipe_size; total > 0;) {
 		n = total > sizeof(buffer) ? sizeof(buffer) : total;
-		len = SAFE_READ(1, p[0], buffer, n);
+		len = SAFE_READ(SAFE_READ_ALL, p[0], buffer, n);
 		total -= len;
 	}
 
diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index 692d67786..786261a45 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -170,7 +170,8 @@ static void run(void)
 	acct(NULL);
 
 	do {
-		read_bytes = SAFE_READ(0, fd, &acct_struct, acct_size);
+		read_bytes = SAFE_READ(SAFE_READ_ANY, fd, &acct_struct,
+				       acct_size);
 
 		if (i == 0 && read_bytes == 0) {
 			tst_res(TFAIL, "acct file is empty");
diff --git a/testcases/kernel/syscalls/bind/bind04.c b/testcases/kernel/syscalls/bind/bind04.c
index b987b4e93..54ccc0e9d 100644
--- a/testcases/kernel/syscalls/bind/bind04.c
+++ b/testcases/kernel/syscalls/bind/bind04.c
@@ -93,7 +93,7 @@ static void *peer_thread(void *tc_ptr)
 
 	sock = SAFE_SOCKET(tc->address->sa_family, tc->type, tc->protocol);
 	SAFE_CONNECT(sock, tc->address, tc->addrlen);
-	SAFE_READ(1, sock, &request, sizeof(request));
+	SAFE_READ(SAFE_READ_ALL, sock, &request, sizeof(request));
 
 	if (request < ARRAY_SIZE(testcase_list))
 		response = testcase_list[request].description;
@@ -144,7 +144,7 @@ static void test_bind(unsigned int n)
 	rand_index = rand() % ARRAY_SIZE(testcase_list);
 	SAFE_WRITE(SAFE_WRITE_ALL, sock, &rand_index, sizeof(rand_index));
 
-	size = SAFE_READ(0, sock, buffer, BUFFER_SIZE - 1);
+	size = SAFE_READ(SAFE_READ_ANY, sock, buffer, BUFFER_SIZE - 1);
 	buffer[size] = '\0';
 	exp_data = testcase_list[rand_index].description;
 
diff --git a/testcases/kernel/syscalls/bind/bind05.c b/testcases/kernel/syscalls/bind/bind05.c
index 8bf62f6b7..07b49e893 100644
--- a/testcases/kernel/syscalls/bind/bind05.c
+++ b/testcases/kernel/syscalls/bind/bind05.c
@@ -104,7 +104,7 @@ static void *peer_thread(void *tc_ptr)
 
 	SAFE_CONNECT(sock, tc->address, tc->addrlen);
 	SAFE_WRITE(SAFE_WRITE_ALL, sock, &request, sizeof(request));
-	SAFE_READ(1, sock, &request, sizeof(request));
+	SAFE_READ(SAFE_READ_ALL, sock, &request, sizeof(request));
 
 	if (request < ARRAY_SIZE(testcase_list))
 		response = testcase_list[request].description;
@@ -163,7 +163,7 @@ static void test_bind(unsigned int n)
 	SAFE_SENDTO(1, sock, &rand_index, sizeof(rand_index), 0,
 		(struct sockaddr *)&remote_addr, remote_len);
 
-	size = SAFE_READ(0, sock, buffer, BUFFER_SIZE - 1);
+	size = SAFE_READ(SAFE_READ_ANY, sock, buffer, BUFFER_SIZE - 1);
 	buffer[size] = '\0';
 	exp_data = testcase_list[rand_index].description;
 
diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
index 384662eee..341d04ce9 100644
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -65,7 +65,7 @@ static void run(unsigned int i)
 	}
 
 	memset(buf, 0, sizeof(buf));
-	SAFE_READ(0, fd2, buf, sizeof(buf));
+	SAFE_READ(SAFE_READ_ANY, fd2, buf, sizeof(buf));
 	if (strcmp(buf, filename0) != 0)
 		tst_res(TFAIL, "read from file got bad data");
 	else
diff --git a/testcases/kernel/syscalls/dup2/dup207.c b/testcases/kernel/syscalls/dup2/dup207.c
index c6c6cb480..4f5229969 100644
--- a/testcases/kernel/syscalls/dup2/dup207.c
+++ b/testcases/kernel/syscalls/dup2/dup207.c
@@ -62,7 +62,7 @@ static void run(unsigned int i)
 	if (tc->flag)
 		SAFE_LSEEK(ofd, tc->offset, SEEK_SET);
 
-	SAFE_READ(1, nfd, read_buf, tc->exp_size);
+	SAFE_READ(SAFE_READ_ALL, nfd, read_buf, tc->exp_size);
 	if (strncmp(read_buf, tc->exp_data, tc->exp_size))
 		tst_res(TFAIL, "Expect %s, but get %s.", tc->exp_data, read_buf);
 	else
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
index 25752d8ef..69d38586a 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
@@ -115,7 +115,7 @@ static void check_epoll_ctl(int opt, int exp_num)
 	tst_res(TPASS, "epoll_ctl() succeeds with op %i", opt);
 
 end:
-	SAFE_READ(1, fd[0], read_buf, sizeof(write_buf));
+	SAFE_READ(SAFE_READ_ALL, fd[0], read_buf, sizeof(write_buf));
 }
 
 static void opera_epoll_ctl(int opt, int fd, struct epoll_event *epvs)
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
index 012ba1562..4f9d8fe5c 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
@@ -67,7 +67,7 @@ static void run(unsigned int n)
 
 	testcase_list[n]();
 
-	SAFE_READ(1, sfd[0], &b, 1);
+	SAFE_READ(SAFE_READ_ALL, sfd[0], &b, 1);
 	tst_reap_children();
 }
 
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
index 2485be513..ec0995e07 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
@@ -39,7 +39,7 @@ static int get_writesize(void)
 
 	char read_buf[write_size];
 
-	SAFE_READ(1, fds[0], read_buf, sizeof(read_buf));
+	SAFE_READ(SAFE_READ_ALL, fds[0], read_buf, sizeof(read_buf));
 
 	tst_res(TINFO, "Pipe buffer size is %i bytes", write_size);
 
@@ -164,7 +164,7 @@ static void verify_epollin(void)
 	tst_res(TPASS, "epoll_wait() epollin");
 
 end:
-	SAFE_READ(1, fds[0], read_buf, sizeof(write_buf));
+	SAFE_READ(SAFE_READ_ALL, fds[0], read_buf, sizeof(write_buf));
 }
 
 static void verify_epollio(void)
@@ -211,7 +211,7 @@ static void verify_epollio(void)
 	tst_res(TPASS, "epoll_wait() epollio");
 
 end:
-	SAFE_READ(1, fds[0], read_buf, sizeof(write_buf));
+	SAFE_READ(SAFE_READ_ALL, fds[0], read_buf, sizeof(write_buf));
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
index 0bf8a29da..622830d55 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
@@ -84,13 +84,13 @@ static void run(void)
 	tst_res(TINFO, "Read half bytes from channel: %zu bytes", read_size);
 
 	memset(buff, 0, write_size);
-	SAFE_READ(1, fds[0], buff, read_size);
+	SAFE_READ(SAFE_READ_ALL, fds[0], buff, read_size);
 
 	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 1, 0), 0);
 
 	tst_res(TINFO, "Read remaining bytes from channel: %zu bytes", read_size);
 
-	SAFE_READ(1, fds[0], buff + read_size, read_size);
+	SAFE_READ(SAFE_READ_ALL, fds[0], buff + read_size, read_size);
 	TST_EXP_FAIL(read(fds[0], buff, read_size), EAGAIN, "read() failed");
 
 	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 1, 0), 1);
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
index 329bf2a5c..07ba0e368 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
@@ -52,7 +52,7 @@ static void run(void)
 	TST_EXP_EQ_LI(evt_receive.events & EPOLLIN, EPOLLIN);
 	TST_EXP_EQ_LI(evt_receive.data.fd, fds[0]);
 
-	SAFE_READ(1, fds[0], &buff, 1);
+	SAFE_READ(SAFE_READ_ALL, fds[0], &buff, 1);
 	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 10, 0), 0);
 
 	tst_res(TINFO, "Write channel for the 2nd time. No events expected");
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait09.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait09.c
index 28745278b..0c82fdb27 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait09.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait09.c
@@ -83,7 +83,7 @@ static void run(unsigned int n)
 	tst_res(TPASS, "epoll_wait() with %d nested levels", depth);
 
 end:
-	SAFE_READ(1, fds[0], &buf, 1);
+	SAFE_READ(SAFE_READ_ALL, fds[0], &buf, 1);
 
 	for (i = depth - 1; i >= 0; i--) {
 		if (epfds[i] != -1)
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait10.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait10.c
index aad44b16b..d5f84e5d5 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait10.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait10.c
@@ -62,7 +62,7 @@ static void check_epoll_event(const char *desc)
 
 	/* Re-read /proc/self/mounts to clear the notification */
 	SAFE_LSEEK(mnt_fd, 0, SEEK_SET);
-	while (SAFE_READ(0, mnt_fd, buf, sizeof(buf)) > 0)
+	while (SAFE_READ(SAFE_READ_ANY, mnt_fd, buf, sizeof(buf)) > 0)
 		;
 }
 
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait13.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait13.c
index 53a75ef1a..ab3132656 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait13.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait13.c
@@ -137,7 +137,7 @@ static void run(void)
 			seen[idx] = 1;
 			total++;
 
-			SAFE_READ(1, ready_fds[idx][0], &c, 1);
+			SAFE_READ(SAFE_READ_ALL, ready_fds[idx][0], &c, 1);
 		}
 	}
 
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait16.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait16.c
index f2075d3de..d4a287e08 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait16.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait16.c
@@ -100,7 +100,7 @@ static void run(void)
 			break;
 		}
 
-		SAFE_READ(1, fds[0], &c, 1);
+		SAFE_READ(SAFE_READ_ALL, fds[0], &c, 1);
 	}
 
 	if (round == NWAITERS)
diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
index 4fe209a13..cf7c2d493 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -27,7 +27,7 @@ static void run(void)
 
 	fd = TST_EXP_FD(eventfd(EVENT_COUNT, EFD_NONBLOCK));
 
-	SAFE_READ(0, fd, &val, sizeof(val));
+	SAFE_READ(SAFE_READ_ANY, fd, &val, sizeof(val));
 	TST_EXP_EQ_LI(val, EVENT_COUNT);
 
 	TST_EXP_FAIL(read(fd, &val, sizeof(val)), EAGAIN);
diff --git a/testcases/kernel/syscalls/eventfd/eventfd02.c b/testcases/kernel/syscalls/eventfd/eventfd02.c
index 420df67ac..88b319ae5 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd02.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd02.c
@@ -28,7 +28,7 @@ static void run(void)
 	fd = TST_EXP_FD(eventfd(0, EFD_NONBLOCK));
 
 	SAFE_WRITE(0, fd, &val, sizeof(val));
-	SAFE_READ(0, fd, &buf, sizeof(buf));
+	SAFE_READ(SAFE_READ_ANY, fd, &buf, sizeof(buf));
 	TST_EXP_EQ_LI(buf, val);
 
 	val = UINT64_MAX - 1;
diff --git a/testcases/kernel/syscalls/eventfd/eventfd03.c b/testcases/kernel/syscalls/eventfd/eventfd03.c
index 31761a449..b1e0dcc79 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd03.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd03.c
@@ -36,7 +36,7 @@ static void run(void)
 
 	TST_EXP_EQ_LI(FD_ISSET(fd, &readfds), 1);
 
-	SAFE_READ(0, fd, &val, sizeof(val));
+	SAFE_READ(SAFE_READ_ANY, fd, &val, sizeof(val));
 	TEST(select(fd + 1, &readfds, NULL, NULL, &timeout));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TERRNO, "select");
diff --git a/testcases/kernel/syscalls/eventfd/eventfd04.c b/testcases/kernel/syscalls/eventfd/eventfd04.c
index 4ee67d308..4d255bac6 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd04.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd04.c
@@ -37,7 +37,7 @@ static void run(void)
 
 	TST_EXP_EQ_LI(FD_ISSET(fd, &writefds), 1);
 
-	SAFE_READ(0, fd, &val, sizeof(val));
+	SAFE_READ(SAFE_READ_ANY, fd, &val, sizeof(val));
 	SAFE_WRITE(0, fd, &max, sizeof(max));
 
 	TEST(select(fd + 1, NULL, &writefds, NULL, &timeout));
diff --git a/testcases/kernel/syscalls/eventfd/eventfd05.c b/testcases/kernel/syscalls/eventfd/eventfd05.c
index 76806c6b5..81310718d 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd05.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd05.c
@@ -29,7 +29,7 @@ static void run(void)
 
 	tst_reap_children();
 
-	SAFE_READ(0, fd, &val, sizeof(val));
+	SAFE_READ(SAFE_READ_ANY, fd, &val, sizeof(val));
 	TST_EXP_EQ_LI(val, to_parent);
 
 	SAFE_CLOSE(fd);
diff --git a/testcases/kernel/syscalls/eventfd/eventfd06.c b/testcases/kernel/syscalls/eventfd/eventfd06.c
index 0ac48b2c8..8ee0dd229 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd06.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd06.c
@@ -103,7 +103,7 @@ static void test_select(void)
 
 	TST_EXP_EQ_LI(FD_ISSET(fd, &readfds), 1);
 
-	SAFE_READ(0, evfd, &count, sizeof(count));
+	SAFE_READ(SAFE_READ_ANY, evfd, &count, sizeof(count));
 	TST_EXP_EQ_LI(count, UINT64_MAX);
 }
 
@@ -127,7 +127,7 @@ static void test_poll(void)
 
 	TST_EXP_EQ_LI(pollfd.revents & POLLERR, POLLERR);
 
-	SAFE_READ(0, evfd, &count, sizeof(count));
+	SAFE_READ(SAFE_READ_ANY, evfd, &count, sizeof(count));
 	TST_EXP_EQ_LI(count, UINT64_MAX);
 }
 
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
index 058e5734f..b218385ff 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
@@ -19,7 +19,7 @@ static void xsem_wait(int fd)
 {
 	u_int64_t cntr;
 
-	SAFE_READ(0, fd, &cntr, sizeof(cntr));
+	SAFE_READ(SAFE_READ_ANY, fd, &cntr, sizeof(cntr));
 }
 
 static void xsem_post(int fd, int count)
diff --git a/testcases/kernel/syscalls/exit/exit02.c b/testcases/kernel/syscalls/exit/exit02.c
index 1311ee360..e26b3d040 100644
--- a/testcases/kernel/syscalls/exit/exit02.c
+++ b/testcases/kernel/syscalls/exit/exit02.c
@@ -31,7 +31,7 @@ static void check_file(void)
 	char buf[256];
 
 	fd = SAFE_OPEN(FNAME, O_RDONLY);
-	len = SAFE_READ(0, fd, buf, sizeof(buf));
+	len = SAFE_READ(SAFE_READ_ANY, fd, buf, sizeof(buf));
 
 	if (len != sizeof(FNAME)) {
 		tst_res(TFAIL, "Wrong length %i expected %zu", len, sizeof(buf));
diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index eb3486d31..d0879e794 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -72,7 +72,7 @@ static void check_file_data(const char exp_buf[], size_t size)
 	tst_res(TINFO, "reading the file, compare with expected buffer");
 
 	SAFE_LSEEK(fd, 0, SEEK_SET);
-	SAFE_READ(1, fd, rbuf, size);
+	SAFE_READ(SAFE_READ_ALL, fd, rbuf, size);
 
 	if (memcmp(exp_buf, rbuf, size)) {
 		if (verbose) {
diff --git a/testcases/kernel/syscalls/fallocate/fallocate06.c b/testcases/kernel/syscalls/fallocate/fallocate06.c
index 424576061..39c8592d8 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate06.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate06.c
@@ -223,7 +223,7 @@ static void run(unsigned int n)
 
 	/* Validate that fallocate() cleared the correct file range */
 	SAFE_LSEEK(fd, 0, SEEK_SET);
-	SAFE_READ(1, fd, rbuf, rbuf_size);
+	SAFE_READ(SAFE_READ_ALL, fd, rbuf, rbuf_size);
 
 	for (err = 0, i = offset; i < offset + size; i++) {
 		if (rbuf[i]) {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 4f8679d02..b37d8900e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -121,7 +121,7 @@ static void test_fanotify(unsigned int n)
 	event_set[tst_count] = FAN_OPEN;
 	tst_count++;
 
-	SAFE_READ(0, fd, buf, BUF_SIZE);
+	SAFE_READ(SAFE_READ_ANY, fd, buf, BUF_SIZE);
 	event_set[tst_count] = FAN_ACCESS;
 	tst_count++;
 
@@ -133,7 +133,7 @@ static void test_fanotify(unsigned int n)
 	 * Get list of events so far. We get events here to avoid
 	 * merging of following events with the previous ones.
 	 */
-	ret = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	ret = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf, EVENT_BUF_LEN);
 	len = ret;
 
 	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
@@ -151,7 +151,7 @@ static void test_fanotify(unsigned int n)
 	/*
 	 * get another list of events
 	 */
-	ret = SAFE_READ(0, fd_notify, event_buf + len,
+	ret = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf + len,
 			EVENT_BUF_LEN - len);
 	len += ret;
 
@@ -169,12 +169,12 @@ static void test_fanotify(unsigned int n)
 	tst_count++;
 
 	/* This event should be ignored */
-	SAFE_READ(0, fd, buf, BUF_SIZE);
+	SAFE_READ(SAFE_READ_ANY, fd, buf, BUF_SIZE);
 
 	/*
 	 * get another list of events to verify the last one got ignored
 	 */
-	ret = SAFE_READ(0, fd_notify, event_buf + len,
+	ret = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf + len,
 			EVENT_BUF_LEN - len);
 	len += ret;
 
@@ -188,7 +188,7 @@ static void test_fanotify(unsigned int n)
 	 * This event shouldn't be ignored because previous modification
 	 * should have removed the ignore mask
 	 */
-	SAFE_READ(0, fd, buf, BUF_SIZE);
+	SAFE_READ(SAFE_READ_ANY, fd, buf, BUF_SIZE);
 	event_set[tst_count] = FAN_ACCESS;
 	tst_count++;
 
@@ -197,7 +197,7 @@ static void test_fanotify(unsigned int n)
 	tst_count++;
 
 	/* Read events to verify previous access was properly generated */
-	ret = SAFE_READ(0, fd_notify, event_buf + len,
+	ret = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf + len,
 			EVENT_BUF_LEN - len);
 	len += ret;
 
@@ -223,7 +223,7 @@ static void test_fanotify(unsigned int n)
 	fd = SAFE_OPEN(fname, O_RDWR);
 
 	/* Read events to verify open & close were ignored */
-	ret = SAFE_READ(0, fd_notify, event_buf + len,
+	ret = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf + len,
 			EVENT_BUF_LEN - len);
 	len += ret;
 
@@ -237,7 +237,7 @@ static void test_fanotify(unsigned int n)
 	tst_count++;
 
 	/* Read events to verify close was generated */
-	ret = SAFE_READ(0, fd_notify, event_buf + len,
+	ret = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf + len,
 			EVENT_BUF_LEN - len);
 	len += ret;
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index 9af38f99c..bd6db5dba 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -69,7 +69,7 @@ static void test01(void)
 	 * Get list of events so far. We get events here to avoid
 	 * merging of following events with the previous ones.
 	 */
-	ret = SAFE_READ(0, fd_notify, event_buf,
+	ret = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf,
 			EVENT_BUF_LEN);
 	len = ret;
 
@@ -77,7 +77,7 @@ static void test01(void)
 	event_set[tst_count] = FAN_OPEN;
 	tst_count++;
 
-	SAFE_READ(0, fd, buf, BUF_SIZE);
+	SAFE_READ(SAFE_READ_ANY, fd, buf, BUF_SIZE);
 	event_set[tst_count] = FAN_ACCESS;
 	tst_count++;
 
@@ -88,7 +88,7 @@ static void test01(void)
 	/*
 	 * get next events
 	 */
-	ret = SAFE_READ(0, fd_notify, event_buf + len,
+	ret = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf + len,
 			EVENT_BUF_LEN - len);
 	len += ret;
 
@@ -116,7 +116,7 @@ static void test01(void)
 	/*
 	 * Check events got generated only for the directory
 	 */
-	ret = SAFE_READ(0, fd_notify, event_buf + len,
+	ret = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf + len,
 			EVENT_BUF_LEN - len);
 	len += ret;
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index efdbf416e..ee1d252f5 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -102,7 +102,7 @@ static void verify_event(int mask)
 	struct stat st;
 
 	/* Read the event */
-	SAFE_READ(0, fd_notify, event_buf, EVENT_SIZE);
+	SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf, EVENT_SIZE);
 	event = (struct fanotify_event_metadata *)&event_buf;
 	if (event->mask != FAN_OPEN) {
 		tst_res(TFAIL, "got unexpected event %llx",
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index 2358660a5..a92fcd9b4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -61,7 +61,7 @@ static void generate_events(void)
 	/* Run until killed... */
 	while (1) {
 		SAFE_LSEEK(fd, 0, SEEK_SET);
-		SAFE_READ(0, fd, buf, BUF_SIZE);
+		SAFE_READ(SAFE_READ_ANY, fd, buf, BUF_SIZE);
 	}
 }
 
@@ -129,7 +129,7 @@ static void loose_fanotify_events(void)
 		struct fanotify_response resp;
 
 		/* Get more events */
-		SAFE_READ(1, fd_notify, &event, sizeof(event));
+		SAFE_READ(SAFE_READ_ALL, fd_notify, &event, sizeof(event));
 
 		if (event.mask != FAN_ACCESS_PERM) {
 			tst_res(TFAIL,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
index bfa96fa28..5e5c5953c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify11.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
@@ -76,7 +76,8 @@ static void test01(unsigned int i)
 
 	SAFE_PTHREAD_CREATE(&p_id, NULL, thread_create_file, NULL);
 
-	SAFE_READ(0, fd_notify, &event, sizeof(struct fanotify_event_metadata));
+	SAFE_READ(SAFE_READ_ANY, fd_notify, &event,
+		  sizeof(struct fanotify_event_metadata));
 
 	if ((tcases[i] & FAN_REPORT_TID) && event.pid == tid)
 		tst_res(TPASS, "event.pid == tid");
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index 005daa2b9..19fa2f6df 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -179,7 +179,7 @@ static void do_test(unsigned int n)
 		goto cleanup;
 
 	/* Read available events into buffer */
-	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	len = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf, EVENT_BUF_LEN);
 
 	event = (struct fanotify_event_metadata *) event_buf;
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 0ccb2e17b..a43fae8d6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -280,7 +280,7 @@ static void do_test(unsigned int number)
 		SAFE_UMOUNT(MOUNT_PATH);
 
 	/* Read events from event queue */
-	len = SAFE_READ(0, fanotify_fd, events_buf, BUF_SIZE);
+	len = SAFE_READ(SAFE_READ_ANY, fanotify_fd, events_buf, BUF_SIZE);
 
 	/* Iterate over event queue */
 	for (i = 0, metadata = (struct fanotify_event_metadata *) events_buf;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index deb5c3fce..62974481e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -142,7 +142,7 @@ static void do_test(unsigned int number)
 	SAFE_UNLINK(FILE2);
 
 	/* Read file events from the event queue */
-	len = SAFE_READ(0, fanotify_fd, events_buf, EVENT_BUF_LEN);
+	len = SAFE_READ(SAFE_READ_ANY, fanotify_fd, events_buf, EVENT_BUF_LEN);
 
 	/*
 	 * Generate a sequence of events on a directory. Subsequent events
@@ -180,7 +180,8 @@ static void do_test(unsigned int number)
 	SAFE_RMDIR(DIR2);
 
 	/* Read dir events from the event queue */
-	len += SAFE_READ(0, fanotify_fd, events_buf + len, EVENT_BUF_LEN - len);
+	len += SAFE_READ(SAFE_READ_ANY, fanotify_fd, events_buf + len,
+			 EVENT_BUF_LEN - len);
 
 	/*
 	 * Cleanup the mark
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index f6563aec7..16fa1ef38 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -363,7 +363,8 @@ static void do_test(unsigned int number)
 	SAFE_UNLINK(fname2);
 
 	/* Read events on files in subdir */
-	len += SAFE_READ(0, fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+	len += SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf + len,
+			 EVENT_BUF_LEN - len);
 
 	/*
 	 * FAN_CREATE|FAN_DELETE|FAN_MOVE events with the same name are merged.
@@ -491,7 +492,8 @@ static void do_test(unsigned int number)
 	SAFE_RMDIR(dname2);
 
 	/* Read more events on dirs */
-	len += SAFE_READ(0, fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+	len += SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf + len,
+			 EVENT_BUF_LEN - len);
 
 	/*
 	 * FAN_RENAME event is independent of MOVED_FROM/MOVED_TO and not merged
diff --git a/testcases/kernel/syscalls/fanotify/fanotify19.c b/testcases/kernel/syscalls/fanotify/fanotify19.c
index ab253d236..ac0325a92 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify19.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify19.c
@@ -107,7 +107,7 @@ static void generate_events(void)
 	fd = SAFE_OPEN(TEST_FILE, O_RDWR);
 
 	/* FAN_ACCESS */
-	SAFE_READ(0, fd, buf, BUF_SIZE);
+	SAFE_READ(SAFE_READ_ANY, fd, buf, BUF_SIZE);
 
 	/* FAN_MODIFY */
 	SAFE_WRITE(SAFE_WRITE_ALL, fd, TEST_FILE, 1);
@@ -191,7 +191,8 @@ static void test_fanotify(unsigned int n)
 	}
 
 	/* Read events from queue */
-	len = SAFE_READ(0, fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+	len = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf + len,
+			EVENT_BUF_LEN - len);
 
 	event = event_buf;
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 76e132031..7edf75310 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -319,7 +319,8 @@ static void do_test(unsigned int i)
 			tst_brk(TBROK, "Insufficient buffer space for next event");
 
 		current_pos = event_buf + read_len;
-		ret = SAFE_READ(0, fd_notify, current_pos, BUF_SIZE - read_len);
+		ret = SAFE_READ(SAFE_READ_ANY, fd_notify, current_pos,
+				BUF_SIZE - read_len);
 
 		m = (struct fanotify_event_metadata *)current_pos;
 		while (FAN_EVENT_OK(m, ret)) {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify23.c b/testcases/kernel/syscalls/fanotify/fanotify23.c
index 0b8d08615..041c8ee0d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify23.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify23.c
@@ -133,7 +133,7 @@ static void test_fanotify(void)
 	tst_count++;
 
 	/* Read events so far */
-	ret = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	ret = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf, EVENT_BUF_LEN);
 	len = ret;
 
 	/*
@@ -176,7 +176,8 @@ static void test_fanotify(void)
 	tst_count++;
 
 	/* Read events to verify ATTRIB event was properly generated */
-	ret = SAFE_READ(0, fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+	ret = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf + len,
+			EVENT_BUF_LEN - len);
 	len += ret;
 
 	/*
diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
index ccbec6688..5d25b0ac0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify24.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
@@ -499,7 +499,7 @@ static void test_fanotify(unsigned int n)
 			char c;
 
 			/* Verify that read from event fd does not generate events */
-			SAFE_READ(0, event->fd, &c, 1);
+			SAFE_READ(SAFE_READ_ANY, event->fd, &c, 1);
 			SAFE_CLOSE(event->fd);
 		}
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
index 7c3cea05f..891f60aa6 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl34.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -96,7 +96,7 @@ static void test01(void)
 	tst_res(TINFO, "verifying file's data");
 	SAFE_LSEEK(fd, 0, SEEK_SET);
 	for (i = 0; i < writes_num * thread_cnt; ++i) {
-		SAFE_READ(1, fd, buf, write_size);
+		SAFE_READ(SAFE_READ_ALL, fd, buf, write_size);
 
 		if (buf[0] >= thread_cnt) {
 			tst_res(TFAIL, "unexpected data read");
diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
index 19a5a0303..45eb19099 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl36.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -167,7 +167,7 @@ static void *fn_ofd_r(void *arg)
 
 		/* rlock acquired */
 		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
-		SAFE_READ(1, fd, buf, pa->length);
+		SAFE_READ(SAFE_READ_ALL, fd, buf, pa->length);
 
 		/* Verifying data read */
 		for (i = 0; i < pa->length; i++) {
@@ -227,7 +227,7 @@ static void *fn_posix_r(void *arg)
 
 		/* rlock acquired */
 		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
-		SAFE_READ(1, fd, buf, pa->length);
+		SAFE_READ(SAFE_READ_ALL, fd, buf, pa->length);
 
 		/* Verifying data read */
 		for (i = 0; i < pa->length; i++) {
@@ -332,7 +332,7 @@ static void test_fn(void *f0(void *), void *f1(void *),
 
 	for (i = 0; i < thread_cnt * 4; i++) {
 
-		SAFE_READ(1, fd, buf, write_size/4);
+		SAFE_READ(SAFE_READ_ALL, fd, buf, write_size / 4);
 
 		for (k = 0; k < write_size/4; k++) {
 
diff --git a/testcases/kernel/syscalls/fork/fork07.c b/testcases/kernel/syscalls/fork/fork07.c
index 266f0ffbc..8335f493d 100644
--- a/testcases/kernel/syscalls/fork/fork07.c
+++ b/testcases/kernel/syscalls/fork/fork07.c
@@ -32,7 +32,7 @@ static void run(void)
 	fd = SAFE_OPEN(TESTFILE, O_RDONLY);
 	for (i = 0; i < NFORKS; ++i) {
 		if (!SAFE_FORK()) {
-			SAFE_READ(1, fd, &buf, 1);
+			SAFE_READ(SAFE_READ_ALL, fd, &buf, 1);
 			if (buf != 'a')
 				tst_res(TFAIL, "%6d: read '%c' instead of 'a'",
 					getpid(), buf);
diff --git a/testcases/kernel/syscalls/fork/fork08.c b/testcases/kernel/syscalls/fork/fork08.c
index 6a56cda70..22a0b2c50 100644
--- a/testcases/kernel/syscalls/fork/fork08.c
+++ b/testcases/kernel/syscalls/fork/fork08.c
@@ -30,7 +30,7 @@ static void run(void)
 	}
 
 	if (!SAFE_FORK()) {
-		SAFE_READ(1, fd, &buf, 1);
+		SAFE_READ(SAFE_READ_ALL, fd, &buf, 1);
 		if (buf != 'a')
 			tst_res(TFAIL, "%6d: read '%c' instead of 'a'",
 				getpid(), buf);
diff --git a/testcases/kernel/syscalls/fork/fork10.c b/testcases/kernel/syscalls/fork/fork10.c
index 6751a8f85..39b7a3706 100644
--- a/testcases/kernel/syscalls/fork/fork10.c
+++ b/testcases/kernel/syscalls/fork/fork10.c
@@ -48,14 +48,14 @@ static void run(void)
 	SAFE_WAIT(&status);
 
 	memset(buff, 'b', DATASIZE);
-	SAFE_READ(1, fd, data, DATASIZE);
+	SAFE_READ(SAFE_READ_ALL, fd, data, DATASIZE);
 
 	TST_EXP_EXPR(strncmp(buff, data, DATASIZE) == 0,
 		"read first part of data from parent process");
 
 	if (!SAFE_FORK()) {
 		memset(buff, 'c', DATASIZE);
-		SAFE_READ(1, fd, data, DATASIZE);
+		SAFE_READ(SAFE_READ_ALL, fd, data, DATASIZE);
 
 		TST_EXP_EXPR(strncmp(buff, data, DATASIZE) == 0,
 			"read second part of data from child process");
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate01.c b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
index 13f915bee..a9c9d5bf9 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate01.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
@@ -46,7 +46,7 @@ static void check_and_report(off_t offset, char data, off_t trunc_len)
 	}
 
 	SAFE_LSEEK(fd, offset, SEEK_SET);
-	SAFE_READ(0, fd, buf, sizeof(buf));
+	SAFE_READ(SAFE_READ_ANY, fd, buf, sizeof(buf));
 
 	for (i = 0; i < TRUNC_LEN1; i++) {
 		if (buf[i] != data) {
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index 972b1025e..84b5d2112 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -55,7 +55,7 @@ void verify_inotify(void)
 	event_set[test_cnt] = IN_OPEN;
 	test_cnt++;
 
-	SAFE_READ(0, fd, buf, BUF_SIZE);
+	SAFE_READ(SAFE_READ_ANY, fd, buf, BUF_SIZE);
 	event_set[test_cnt] = IN_ACCESS;
 	test_cnt++;
 
@@ -79,7 +79,7 @@ void verify_inotify(void)
 	 * get list of events
 	 */
 	int len, i = 0, test_num = 0;
-	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	len = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf, EVENT_BUF_LEN);
 
 	/*
 	 * check events
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 314c1bd49..9b6f1cce5 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -112,7 +112,7 @@ void verify_inotify(void)
 	test_cnt++;
 
 	int len, i = 0, test_num = 0;
-	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	len = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf, EVENT_BUF_LEN);
 
 	while (i < len) {
 		struct inotify_event *event;
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index a7974dd57..f8f112451 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -74,7 +74,7 @@ void verify_inotify(void)
 	}
 	mount_flag = 0;
 
-	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	len = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf, EVENT_BUF_LEN);
 
 	/* check events */
 	test_num = 0;
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index 947623952..e465e0293 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -118,7 +118,7 @@ void verify_inotify(void)
 	strcpy(event_set[test_cnt].name, "");
 	test_cnt++;
 
-	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	len = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf, EVENT_BUF_LEN);
 
 	while (i < len) {
 		struct inotify_event *event;
diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index 82a4c7bdc..0ebf4ab4e 100644
--- a/testcases/kernel/syscalls/inotify/inotify05.c
+++ b/testcases/kernel/syscalls/inotify/inotify05.c
@@ -48,7 +48,7 @@ void verify_inotify(void)
 
 	for (i = 0; i < max_events; i++) {
 		SAFE_LSEEK(fd, 0, SEEK_SET);
-		SAFE_READ(1, fd, buf, BUF_SIZE);
+		SAFE_READ(SAFE_READ_ALL, fd, buf, BUF_SIZE);
 		SAFE_LSEEK(fd, 0, SEEK_SET);
 		SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, BUF_SIZE);
 	}
@@ -60,7 +60,8 @@ void verify_inotify(void)
 		/*
 		 * get list on events
 		 */
-		len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+		len = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf,
+				EVENT_BUF_LEN);
 
 		/*
 		 * check events
diff --git a/testcases/kernel/syscalls/inotify/inotify10.c b/testcases/kernel/syscalls/inotify/inotify10.c
index 56acfdc5a..e4d4f4c35 100644
--- a/testcases/kernel/syscalls/inotify/inotify10.c
+++ b/testcases/kernel/syscalls/inotify/inotify10.c
@@ -143,7 +143,7 @@ static void verify_inotify(unsigned int n)
 		test_cnt++;
 	}
 
-	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	len = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf, EVENT_BUF_LEN);
 
 	while (i < len) {
 		struct event_t *expected = &event_set[test_num];
diff --git a/testcases/kernel/syscalls/inotify/inotify11.c b/testcases/kernel/syscalls/inotify/inotify11.c
index ad725b075..4faf2df5b 100644
--- a/testcases/kernel/syscalls/inotify/inotify11.c
+++ b/testcases/kernel/syscalls/inotify/inotify11.c
@@ -73,7 +73,8 @@ static void verify_inotify(void)
 	while (!opened && nevents < CHURN_FILES) {
 		int i, fd, len;
 
-		len = SAFE_READ(0, inotify_fd, event_buf, EVENT_BUF_LEN);
+		len = SAFE_READ(SAFE_READ_ANY, inotify_fd, event_buf,
+				EVENT_BUF_LEN);
 
 		for (i = 0; i < len; i += EVENT_SIZE + event->len) {
 			event = (struct inotify_event *)&event_buf[i];
diff --git a/testcases/kernel/syscalls/inotify/inotify12.c b/testcases/kernel/syscalls/inotify/inotify12.c
index df32f8e15..61407f0fa 100644
--- a/testcases/kernel/syscalls/inotify/inotify12.c
+++ b/testcases/kernel/syscalls/inotify/inotify12.c
@@ -93,7 +93,7 @@ static void verify_inotify(unsigned int n)
 	/*
 	 * Read the 1st IN_MODIFY event
 	 */
-	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	len = SAFE_READ(SAFE_READ_ANY, fd_notify, event_buf, EVENT_BUF_LEN);
 
 	if (len < (int)sizeof(*event)) {
 		tst_res(TFAIL, "Got no events");
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
index 91683396f..97a637bff 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
@@ -61,7 +61,7 @@ static void run(void)
 
 	TST_EXP_EQ_LI(src_stat.st_size, dst_stat.st_size);
 
-	SAFE_READ(0, dst_fd, buff, FILESIZE);
+	SAFE_READ(SAFE_READ_ANY, dst_fd, buff, FILESIZE);
 
 	TST_EXP_EXPR(!strncmp(buff, FILEDATA, FILESIZE),
 		"dst file has the src file content (\"%s\" - %ld bytes)",
@@ -81,7 +81,7 @@ static void run(void)
 
 	TST_EXP_EQ_LI(dst_stat.st_size, src_stat.st_size);
 
-	SAFE_READ(0, src_fd, buff, FILESIZE);
+	SAFE_READ(SAFE_READ_ANY, src_fd, buff, FILESIZE);
 
 	TST_EXP_EXPR(!strncmp(buff, FILEDATA, FILESIZE),
 		"src file content didn't change");
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
index 8dab9f344..e9d5aad1a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
@@ -69,7 +69,7 @@ static void run(void)
 	TST_EXP_EQ_LI(src_stat.st_size, filesize);
 	TST_EXP_EQ_LI(dst_stat.st_size, leftsize);
 
-	SAFE_READ(0, dst_fd, buff, leftsize);
+	SAFE_READ(SAFE_READ_ANY, dst_fd, buff, leftsize);
 
 	TST_EXP_EXPR(!strncmp(buff, data + offset, leftsize),
 		"dst file has been cloned (%d bytes)",
@@ -90,7 +90,7 @@ static void run(void)
 	TST_EXP_EQ_LI(dst_stat.st_size, leftsize);
 
 	SAFE_LSEEK(src_fd, 0, SEEK_SET);
-	SAFE_READ(0, src_fd, buff, filesize);
+	SAFE_READ(SAFE_READ_ANY, src_fd, buff, filesize);
 
 	TST_EXP_EXPR(!strncmp(buff, data, filesize),
 		"src file content didn't change");
diff --git a/testcases/kernel/syscalls/llseek/llseek03.c b/testcases/kernel/syscalls/llseek/llseek03.c
index 3e6749763..eca5da974 100644
--- a/testcases/kernel/syscalls/llseek/llseek03.c
+++ b/testcases/kernel/syscalls/llseek/llseek03.c
@@ -80,7 +80,7 @@ static void verify_lseek(unsigned int n)
 
 	fd = SAFE_OPEN(TEST_FILE, O_RDONLY);
 
-	SAFE_READ(1, fd, read_buf, 4);
+	SAFE_READ(SAFE_READ_ALL, fd, read_buf, 4);
 
 	TEST(lseek(fd, tc->off, tc->whence));
 
@@ -98,7 +98,7 @@ static void verify_lseek(unsigned int n)
 
         memset(read_buf, 0, sizeof(read_buf));
 
-        ret = SAFE_READ(0, fd, read_buf, tc->read);
+	ret = SAFE_READ(SAFE_READ_ANY, fd, read_buf, tc->read);
 
 	if (!tc->read) {
 		if (ret != 0)
diff --git a/testcases/kernel/syscalls/lseek/lseek01.c b/testcases/kernel/syscalls/lseek/lseek01.c
index b4749c58b..9daa3357e 100644
--- a/testcases/kernel/syscalls/lseek/lseek01.c
+++ b/testcases/kernel/syscalls/lseek/lseek01.c
@@ -40,7 +40,7 @@ static void verify_lseek(unsigned int n)
 	struct tcase *tc = &tcases[n];
 
 	// reset the offset to end of file
-	SAFE_READ(0, fd, read_buf, sizeof(read_buf));
+	SAFE_READ(SAFE_READ_ANY, fd, read_buf, sizeof(read_buf));
 
 	memset(read_buf, 0, sizeof(read_buf));
 
@@ -58,7 +58,7 @@ static void verify_lseek(unsigned int n)
 		return;
 	}
 
-	SAFE_READ(1, fd, read_buf, tc->exp_size);
+	SAFE_READ(SAFE_READ_ALL, fd, read_buf, tc->exp_size);
 
 	if (tc->exp_data && strcmp(read_buf, tc->exp_data)) {
 		tst_res(TFAIL, "lseek(%s, %lld, %s) read incorrect data",
diff --git a/testcases/kernel/syscalls/lseek/lseek07.c b/testcases/kernel/syscalls/lseek/lseek07.c
index b83869fa2..366912e4c 100644
--- a/testcases/kernel/syscalls/lseek/lseek07.c
+++ b/testcases/kernel/syscalls/lseek/lseek07.c
@@ -61,7 +61,7 @@ static void verify_lseek(unsigned int n)
 
 	*tc->fd = SAFE_OPEN(tc->fname, O_RDWR);
 
-	SAFE_READ(1, *tc->fd, read_buf, tc->exp_size);
+	SAFE_READ(SAFE_READ_ALL, *tc->fd, read_buf, tc->exp_size);
 
 	if (strcmp(read_buf, tc->exp_data)) {
 		tst_res(TFAIL, "lseek(%s, %lld, SEEK_SET) wrote incorrect data %s",
diff --git a/testcases/kernel/syscalls/lseek/lseek11.c b/testcases/kernel/syscalls/lseek/lseek11.c
index 6dba932d2..ab54639cb 100644
--- a/testcases/kernel/syscalls/lseek/lseek11.c
+++ b/testcases/kernel/syscalls/lseek/lseek11.c
@@ -193,7 +193,7 @@ static void test_lseek(unsigned int n)
 	offset = (tp->startblock * block_size) + tp->offset;
 	offset = SAFE_LSEEK(fd, offset, tp->whence);
 	if (tp->data) {
-		SAFE_READ(1, fd, buf, tp->count);
+		SAFE_READ(SAFE_READ_ALL, fd, buf, tp->count);
 		rc = strcmp(buf, tp->data);
 	} else {
 		if (offset != SAFE_LSEEK(fd, 0, SEEK_END))
diff --git a/testcases/kernel/syscalls/lsm/lsm_list_modules02.c b/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
index 045bbb2a6..17f4a6c24 100644
--- a/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
+++ b/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
@@ -135,7 +135,7 @@ static void setup(void)
 
 	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
 	fd = SAFE_OPEN(LSM_SYS_FILE, O_RDONLY);
-	SAFE_READ(0, fd, data, BUFSIZ);
+	SAFE_READ(SAFE_READ_ANY, fd, data, BUFSIZ);
 	SAFE_CLOSE(fd);
 
 	ptr = strtok(data, ",");
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index 0fe270fb9..507dc2384 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -113,7 +113,7 @@ static int find_sequence(int pid)
 
 	dfd = SAFE_OPEN(dumpname, O_RDONLY);
 
-	read = SAFE_READ(0, dfd, &rbuf, sizeof(rbuf));
+	read = SAFE_READ(SAFE_READ_ANY, dfd, &rbuf, sizeof(rbuf));
 	while (read) {
 		switch (rbuf[pos]) {
 		case 'x':
@@ -140,7 +140,8 @@ static int find_sequence(int pid)
 			expectc = 'x';
 		}
 		if (++pos >= read) {
-			read = SAFE_READ(0, dfd, &rbuf, sizeof(rbuf));
+			read = SAFE_READ(SAFE_READ_ANY, dfd, &rbuf,
+					 sizeof(rbuf));
 			pos = 0;
 		}
 	}
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
index 63e8daac5..27ba09d75 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
@@ -297,7 +297,7 @@ void check_mfd_readable(const char *filename, const int lineno, int fd)
 	char buf[16];
 	void *p;
 
-	safe_read(filename, lineno, NULL, 1, fd, buf, sizeof(buf));
+	safe_read(filename, lineno, NULL, SAFE_READ_ALL, fd, buf, sizeof(buf));
 	tst_res_(filename, lineno, TPASS, "read(%d, %s, %zu) succeeded", fd,
 		buf, sizeof(buf));
 
diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index 9a0c01aa6..b548dd0f5 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -36,7 +36,7 @@ static void check_file(void)
 	ssize_t len;
 
 	fildes = SAFE_OPEN(TEMPFILE, O_RDONLY);
-	len = SAFE_READ(0, fildes, buf, sizeof(buf));
+	len = SAFE_READ(SAFE_READ_ANY, fildes, buf, sizeof(buf));
 	SAFE_CLOSE(fildes);
 
 	if (len != strlen(STRING)) {
diff --git a/testcases/kernel/syscalls/mmap/mmap03.c b/testcases/kernel/syscalls/mmap/mmap03.c
index 2fa9acaf1..665316f59 100644
--- a/testcases/kernel/syscalls/mmap/mmap03.c
+++ b/testcases/kernel/syscalls/mmap/mmap03.c
@@ -41,7 +41,7 @@ static void run_child(void)
 
 	tst_res(TINFO, "Read data back from mapped file");
 
-	SAFE_READ(0, fdesc, data, page_sz);
+	SAFE_READ(SAFE_READ_ANY, fdesc, data, page_sz);
 	SAFE_LSEEK(fdesc, 0, SEEK_SET);
 
 	TST_EXP_EQ_LI(memcmp(data, tmpdata, page_sz), 0);
diff --git a/testcases/kernel/syscalls/mmap/mmap12.c b/testcases/kernel/syscalls/mmap/mmap12.c
index 043218834..38e77f80c 100644
--- a/testcases/kernel/syscalls/mmap/mmap12.c
+++ b/testcases/kernel/syscalls/mmap/mmap12.c
@@ -52,7 +52,7 @@ static void page_check(void)
 		tst_brk(TFAIL | TERRNO, "Reposition offset failed");
 
 	while (i <= num_pages) {
-		SAFE_READ(1, pm, &pagemap, sizeof(uint64_t));
+		SAFE_READ(SAFE_READ_ALL, pm, &pagemap, sizeof(uint64_t));
 
 		/*
 		 * Check if the page is present.
diff --git a/testcases/kernel/syscalls/mmap/mmap21.c b/testcases/kernel/syscalls/mmap/mmap21.c
index ea3ae835a..18b24cbd9 100644
--- a/testcases/kernel/syscalls/mmap/mmap21.c
+++ b/testcases/kernel/syscalls/mmap/mmap21.c
@@ -50,7 +50,7 @@ static void run(void)
 	memset(buff, 0, memory_size);
 
 	SAFE_LSEEK(fd, 0, SEEK_SET);
-	SAFE_READ(0, fd, buff, memory_size);
+	SAFE_READ(SAFE_READ_ANY, fd, buff, memory_size);
 	SAFE_CLOSE(fd);
 
 	for (int i = 0; i < memory_size; i++) {
diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 8dd6f3eed..1cb6f47f8 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -122,7 +122,7 @@ static void test_file_dir_noatime(int update_fatime, int update_datime)
 
 	usleep(1500000);
 
-	SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
+	SAFE_READ(SAFE_READ_ANY, otfd, readbuf, sizeof(readbuf));
 	SAFE_FSTAT(otfd, &st);
 
 	test_dir = SAFE_OPENDIR(dir);
diff --git a/testcases/kernel/syscalls/mremap/mremap07.c b/testcases/kernel/syscalls/mremap/mremap07.c
index a43510bc3..2a33c14b0 100644
--- a/testcases/kernel/syscalls/mremap/mremap07.c
+++ b/testcases/kernel/syscalls/mremap/mremap07.c
@@ -39,7 +39,7 @@ static void *fault_handler_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 	if (poll(&pollfd, 1, -1) == -1)
 		tst_brk(TBROK | TERRNO, "poll() failed");
 
-	SAFE_READ(1, uffd, &msg, sizeof(msg));
+	SAFE_READ(SAFE_READ_ALL, uffd, &msg, sizeof(msg));
 
 	if (msg.event != UFFD_EVENT_PAGEFAULT)
 		tst_brk(TBROK, "Received unexpected UFFD_EVENT: %d", msg.event);
diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 781a49ddb..1251388b6 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -34,7 +34,8 @@ static uint64_t get_dirty_bit(void *data)
 	index = (addr / pagesize) * sizeof(uint64_t);
 	pagemap_fd = SAFE_OPEN("/proc/self/pagemap", O_RDONLY);
 	SAFE_LSEEK(pagemap_fd, index, SEEK_SET);
-	SAFE_READ(1, pagemap_fd, &pagemap_entry, sizeof(pagemap_entry));
+	SAFE_READ(SAFE_READ_ALL, pagemap_fd, &pagemap_entry,
+		  sizeof(pagemap_entry));
 	SAFE_CLOSE(pagemap_fd);
 	pfn = pagemap_entry & ((1ULL << 55) - 1);
 	if (!pfn)
@@ -42,7 +43,8 @@ static uint64_t get_dirty_bit(void *data)
 	pageflags_fd = SAFE_OPEN("/proc/kpageflags", O_RDONLY);
 	index = pfn * sizeof(uint64_t);
 	SAFE_LSEEK(pageflags_fd, index, SEEK_SET);
-	SAFE_READ(1, pageflags_fd, &pageflag_entry, sizeof(pageflag_entry));
+	SAFE_READ(SAFE_READ_ALL, pageflags_fd, &pageflag_entry,
+		  sizeof(pageflag_entry));
 	SAFE_CLOSE(pageflags_fd);
 	return pageflag_entry & (1ULL << 4);
 }
@@ -53,7 +55,7 @@ static void verify_mmaped(void)
 
 	tst_res(TINFO, "Haven't seen dirty bit so we check content of file instead");
 	test_fd = SAFE_OPEN("msync04/testfile", O_RDONLY | O_DIRECT);
-	SAFE_READ(0, test_fd, buffer, getpagesize());
+	SAFE_READ(SAFE_READ_ANY, test_fd, buffer, getpagesize());
 
 	if (buffer[8] == 'B')
 		tst_res(TCONF, "Write was too fast, couldn't test msync()");
diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index 14a9bd47f..ff3f8ebb5 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -89,7 +89,7 @@ static void test_noatime(void)
 	if (!TST_PASS)
 		return;
 
-	SAFE_READ(1, fd, &read_buf, 1);
+	SAFE_READ(SAFE_READ_ALL, fd, &read_buf, 1);
 	SAFE_CLOSE(fd);
 	SAFE_STAT(TEST_FILE, &new_stat);
 
diff --git a/testcases/kernel/syscalls/open/open14.c b/testcases/kernel/syscalls/open/open14.c
index f8cd748ac..7d3a3d55e 100644
--- a/testcases/kernel/syscalls/open/open14.c
+++ b/testcases/kernel/syscalls/open/open14.c
@@ -105,7 +105,7 @@ static int read_file(int fd)
 	SAFE_LSEEK(fd, 0, SEEK_SET);
 
 	for (i = 0; i < blocks_num; ++i) {
-		SAFE_READ(0, fd, tmp, size);
+		SAFE_READ(SAFE_READ_ANY, fd, tmp, size);
 
 		if (memcmp(buf, tmp, size)) {
 			tst_res(TFAIL, "got unexpected data");
diff --git a/testcases/kernel/syscalls/open/open15.c b/testcases/kernel/syscalls/open/open15.c
index eb436278e..ba195359a 100644
--- a/testcases/kernel/syscalls/open/open15.c
+++ b/testcases/kernel/syscalls/open/open15.c
@@ -44,11 +44,11 @@ static void run(void)
 	SAFE_LSEEK(fd_symb, 0, 0);
 
 	tst_res(TINFO, "Read data via file");
-	SAFE_READ(1, fd_file, buff_file, str_size);
+	SAFE_READ(SAFE_READ_ALL, fd_file, buff_file, str_size);
 	SAFE_LSEEK(fd_file, 0, 0);
 
 	tst_res(TINFO, "Read data via symlink");
-	SAFE_READ(1, fd_symb, buff_symb, str_size);
+	SAFE_READ(SAFE_READ_ALL, fd_symb, buff_symb, str_size);
 	SAFE_LSEEK(fd_symb, 0, 0);
 
 	TST_EXP_EXPR(!strncmp(buff_file, BIG_STRING, str_size),
diff --git a/testcases/kernel/syscalls/openat/openat02.c b/testcases/kernel/syscalls/openat/openat02.c
index b283d1bd0..201c0c68d 100644
--- a/testcases/kernel/syscalls/openat/openat02.c
+++ b/testcases/kernel/syscalls/openat/openat02.c
@@ -193,7 +193,7 @@ static void testfunc_noatime(void)
 		return;
 	}
 
-	SAFE_READ(1, TST_RET, &buf, 1);
+	SAFE_READ(SAFE_READ_ALL, TST_RET, &buf, 1);
 
 	SAFE_CLOSE(TST_RET);
 
diff --git a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
index 57e96405c..feb685906 100644
--- a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
+++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
@@ -53,7 +53,7 @@ static void run(void)
 	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
 
 	pidfd = SAFE_PIDFD_OPEN(pid, 0);
-	SAFE_READ(1, fds[0], &targetfd, sizeof(targetfd));
+	SAFE_READ(SAFE_READ_ALL, fds[0], &targetfd, sizeof(targetfd));
 	TST_EXP_FD_SILENT(pidfd_getfd(pidfd, targetfd, 0),
 		"pidfd_getfd(%d, %d , 0)", pidfd, targetfd);
 
diff --git a/testcases/kernel/syscalls/pipe/pipe01.c b/testcases/kernel/syscalls/pipe/pipe01.c
index 05ab7491f..9848c9013 100644
--- a/testcases/kernel/syscalls/pipe/pipe01.c
+++ b/testcases/kernel/syscalls/pipe/pipe01.c
@@ -29,7 +29,7 @@ static void verify_pipe(void)
 	}
 
 	wr_size = SAFE_WRITE(SAFE_WRITE_ALL, fds[1], wrbuf, sizeof(wrbuf));
-	rd_size = SAFE_READ(0, fds[0], rdbuf, sizeof(rdbuf));
+	rd_size = SAFE_READ(SAFE_READ_ANY, fds[0], rdbuf, sizeof(rdbuf));
 
 	if (rd_size != wr_size) {
 		tst_res(TFAIL, "read() returned %d, expected %d",
diff --git a/testcases/kernel/syscalls/pipe/pipe02.c b/testcases/kernel/syscalls/pipe/pipe02.c
index d6cbff92d..db3e6ec86 100644
--- a/testcases/kernel/syscalls/pipe/pipe02.c
+++ b/testcases/kernel/syscalls/pipe/pipe02.c
@@ -54,7 +54,7 @@ static void verify_pipe(void)
 
 	memset(rdbuf, 0, SIZE);
 	SAFE_CLOSE(fd[1]);
-	SAFE_READ(1, fd[0], rdbuf, SIZE);
+	SAFE_READ(SAFE_READ_ALL, fd[0], rdbuf, SIZE);
 
 	if (memcmp(wrbuf, rdbuf, SIZE) != 0) {
 		tst_res(TFAIL, "pipe read data and pipe "
diff --git a/testcases/kernel/syscalls/pipe/pipe10.c b/testcases/kernel/syscalls/pipe/pipe10.c
index 30cd983b2..d97b7a564 100644
--- a/testcases/kernel/syscalls/pipe/pipe10.c
+++ b/testcases/kernel/syscalls/pipe/pipe10.c
@@ -25,7 +25,7 @@ static void run(void)
 	wr_cnt = SAFE_WRITE(SAFE_WRITE_ALL, fds[1], wrbuf, sizeof(wrbuf));
 
 	if (!SAFE_FORK()) {
-		rd_cnt = SAFE_READ(1, fds[0], rdbuf, wr_cnt);
+		rd_cnt = SAFE_READ(SAFE_READ_ALL, fds[0], rdbuf, wr_cnt);
 		TST_EXP_EQ_LU(wr_cnt, rd_cnt);
 	}
 
diff --git a/testcases/kernel/syscalls/pipe/pipe11.c b/testcases/kernel/syscalls/pipe/pipe11.c
index 4280f1eba..df6b15e8c 100644
--- a/testcases/kernel/syscalls/pipe/pipe11.c
+++ b/testcases/kernel/syscalls/pipe/pipe11.c
@@ -30,7 +30,7 @@ void do_child(void)
 
 	SAFE_CLOSE(fds[1]);
 
-	nread = SAFE_READ(0, fds[0], rbuf, sizeof(rbuf));
+	nread = SAFE_READ(SAFE_READ_ANY, fds[0], rbuf, sizeof(rbuf));
 
 	if (nread != read_per_child) {
 		tst_res(TFAIL, "Invalid read size child %i size %zu",
diff --git a/testcases/kernel/syscalls/pipe/pipe12.c b/testcases/kernel/syscalls/pipe/pipe12.c
index e186035ec..b1a71a6d1 100644
--- a/testcases/kernel/syscalls/pipe/pipe12.c
+++ b/testcases/kernel/syscalls/pipe/pipe12.c
@@ -74,7 +74,7 @@ static void verify_pipe(unsigned int n)
 		tst_res(TPASS, "write %d bytes", nbytes);
 
 clean_pipe_buf:
-	SAFE_READ(0, fds[0], rdbuf, max_size);
+	SAFE_READ(SAFE_READ_ANY, fds[0], rdbuf, max_size);
 }
 
 
diff --git a/testcases/kernel/syscalls/pipe/pipe13.c b/testcases/kernel/syscalls/pipe/pipe13.c
index 74dad6e95..e426f7f41 100644
--- a/testcases/kernel/syscalls/pipe/pipe13.c
+++ b/testcases/kernel/syscalls/pipe/pipe13.c
@@ -55,7 +55,7 @@ static void do_child(unsigned int i)
 
 	SAFE_CLOSE(fds[1]);
 	TST_CHECKPOINT_WAKE(i);
-	int ret = SAFE_READ(0, fds[0], &buf, 1);
+	int ret = SAFE_READ(SAFE_READ_ANY, fds[0], &buf, 1);
 	if (ret != 0)
 		tst_res(TFAIL, "Wrong return from read %i", ret);
 	exit(0);
diff --git a/testcases/kernel/syscalls/pipe/pipe14.c b/testcases/kernel/syscalls/pipe/pipe14.c
index 66d94cffa..087592461 100644
--- a/testcases/kernel/syscalls/pipe/pipe14.c
+++ b/testcases/kernel/syscalls/pipe/pipe14.c
@@ -24,9 +24,9 @@ static void run(void)
 	SAFE_WRITE(SAFE_WRITE_ALL, fds[1], wrbuf, sizeof(wrbuf));
 	SAFE_CLOSE(fds[1]);
 
-	SAFE_READ(0, fds[0], rdbuf, sizeof(wrbuf));
+	SAFE_READ(SAFE_READ_ANY, fds[0], rdbuf, sizeof(wrbuf));
 
-	TST_EXP_VAL(SAFE_READ(0, fds[0], rdbuf, 1), 0);
+	TST_EXP_VAL(SAFE_READ(SAFE_READ_ANY, fds[0], rdbuf, 1), 0);
 	SAFE_CLOSE(fds[0]);
 }
 
diff --git a/testcases/kernel/syscalls/pipe/pipe15.c b/testcases/kernel/syscalls/pipe/pipe15.c
index 680a5ee04..b7a87ec3a 100644
--- a/testcases/kernel/syscalls/pipe/pipe15.c
+++ b/testcases/kernel/syscalls/pipe/pipe15.c
@@ -31,11 +31,11 @@ static void run(void)
 
 	tst_res(TINFO, "Soft-limited buffer size: %d bytes", buffer_size);
 	SAFE_WRITE(1, pipe[1], buffer, buffer_size);
-	SAFE_READ(1, pipe[0], buffer, buffer_size - 1);
+	SAFE_READ(SAFE_READ_ALL, pipe[0], buffer, buffer_size - 1);
 	SAFE_WRITE(1, pipe[1], buffer, 1);
 	tst_res(TPASS, "Pipe operation did not block");
 
-	SAFE_READ(1, pipe[0], buffer, 2);
+	SAFE_READ(SAFE_READ_ALL, pipe[0], buffer, 2);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/poll/poll01.c b/testcases/kernel/syscalls/poll/poll01.c
index c03b1c683..a0c0866e5 100644
--- a/testcases/kernel/syscalls/poll/poll01.c
+++ b/testcases/kernel/syscalls/poll/poll01.c
@@ -54,7 +54,7 @@ static void verify_pollin(void)
 	TST_EXP_EXPR((infds[0].revents & ~POLLIN) == 0);
 
 end:
-	SAFE_READ(1, fildes[0], read_buf, sizeof(write_buf));
+	SAFE_READ(SAFE_READ_ALL, fildes[0], read_buf, sizeof(write_buf));
 }
 
 static void verify_poll(unsigned int n)
diff --git a/testcases/kernel/syscalls/pread/pread01.c b/testcases/kernel/syscalls/pread/pread01.c
index 36a93a3f9..1d1056873 100644
--- a/testcases/kernel/syscalls/pread/pread01.c
+++ b/testcases/kernel/syscalls/pread/pread01.c
@@ -63,7 +63,7 @@ static void verify_pread(void)
 	SAFE_PREAD(1, fildes, read_buf[3], K1, K3);
 	l_seek(fildes, 0, SEEK_CUR, 0);
 
-	SAFE_READ(1, fildes, read_buf[0], K1);
+	SAFE_READ(SAFE_READ_ALL, fildes, read_buf[0], K1);
 	l_seek(fildes, 0, SEEK_CUR, K1);
 
 	SAFE_PREAD(1, fildes, read_buf[1], K1, K1);
diff --git a/testcases/kernel/syscalls/pwrite/pwrite01.c b/testcases/kernel/syscalls/pwrite/pwrite01.c
index 0c3689ce0..968b251d4 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite01.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite01.c
@@ -46,7 +46,7 @@ static void check_file_contents(void)
 	for (count = 0; count < NBUFS; count++) {
 		l_seek(fildes, count * K1, SEEK_SET, count * K1);
 
-		SAFE_READ(1, fildes, read_buf[count], K1);
+		SAFE_READ(SAFE_READ_ALL, fildes, read_buf[count], K1);
 
 		if (memcmp(write_buf[count], read_buf[count], K1) != 0) {
 			tst_res(TFAIL, "read/write buffer[%d] data mismatch", count);
diff --git a/testcases/kernel/syscalls/seccomp/seccomp01.c b/testcases/kernel/syscalls/seccomp/seccomp01.c
index 88f2fbef8..35b5388f8 100644
--- a/testcases/kernel/syscalls/seccomp/seccomp01.c
+++ b/testcases/kernel/syscalls/seccomp/seccomp01.c
@@ -147,7 +147,7 @@ static void check_strict_mode(int val)
 	break;
 	case 2:
 		SAFE_WRITE(SAFE_WRITE_ALL, fd, "a", 1);
-		SAFE_READ(0, fd, buf, 1);
+		SAFE_READ(SAFE_READ_ANY, fd, buf, 1);
 		tst_res(TPASS,
 			"SECCOMP_MODE_STRICT permits read(2) write(2) and _exit(2)");
 	break;
diff --git a/testcases/kernel/syscalls/sendfile/sendfile08.c b/testcases/kernel/syscalls/sendfile/sendfile08.c
index 058b42ebb..28c30b1bb 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile08.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile08.c
@@ -36,7 +36,7 @@ static void run(void)
 	char buf[BUFSIZ];
 
 	SAFE_LSEEK(out_fd, 0, SEEK_SET);
-	SAFE_READ(0, out_fd, buf, BUFSIZ);
+	SAFE_READ(SAFE_READ_ANY, out_fd, buf, BUFSIZ);
 
 	if (!strncmp(buf, TEST_MSG_ALL, strlen(TEST_MSG_ALL))) {
 		tst_res(TPASS, "sendfile() copies data correctly");
diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
index 47f5eed75..2d633e949 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd01.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
@@ -25,7 +25,7 @@ static void check_signal(int fd, uint32_t signal)
 	struct signalfd_siginfo siginfo;
 
 	SAFE_KILL(pid, signal);
-	bytes = SAFE_READ(0, fd, &siginfo, sizeof(siginfo));
+	bytes = SAFE_READ(SAFE_READ_ANY, fd, &siginfo, sizeof(siginfo));
 	TST_EXP_EQ_LI(bytes, sizeof(siginfo));
 	TST_EXP_EQ_LI(siginfo.ssi_signo, signal);
 }
diff --git a/testcases/kernel/syscalls/splice/splice01.c b/testcases/kernel/syscalls/splice/splice01.c
index 508ccdeb7..8d0b79abb 100644
--- a/testcases/kernel/syscalls/splice/splice01.c
+++ b/testcases/kernel/syscalls/splice/splice01.c
@@ -35,7 +35,7 @@ static void check_file(void)
 	char splicebuffer[TEST_BLOCK_SIZE];
 
 	fd_out = SAFE_OPEN(TESTFILE2, O_RDONLY);
-	SAFE_READ(1, fd_out, splicebuffer, TEST_BLOCK_SIZE);
+	SAFE_READ(SAFE_READ_ALL, fd_out, splicebuffer, TEST_BLOCK_SIZE);
 
 	for (i = 0; i < TEST_BLOCK_SIZE; i++) {
 		if (buffer[i] != splicebuffer[i])
diff --git a/testcases/kernel/syscalls/splice/splice04.c b/testcases/kernel/syscalls/splice/splice04.c
index 5e6e8df05..edfab922b 100644
--- a/testcases/kernel/syscalls/splice/splice04.c
+++ b/testcases/kernel/syscalls/splice/splice04.c
@@ -56,7 +56,8 @@ static void pipe_pipe(void)
 			tst_res(TFAIL | TERRNO, "splice error");
 			goto exit;
 		}
-		SAFE_READ(1, pp2[0], arr_out + num_len_data - i, ret);
+		SAFE_READ(SAFE_READ_ALL, pp2[0], arr_out + num_len_data - i,
+			  ret);
 	}
 
 	for (i = 0; i < num_len_data; i++) {
diff --git a/testcases/kernel/syscalls/splice/splice05.c b/testcases/kernel/syscalls/splice/splice05.c
index 501df10f6..c001afbf8 100644
--- a/testcases/kernel/syscalls/splice/splice05.c
+++ b/testcases/kernel/syscalls/splice/splice05.c
@@ -81,7 +81,8 @@ static void pipe_socket(void)
 			}
 			goto exit;
 		}
-		SAFE_READ(1, pp2[0], arr_out + num_len_data - i, ret);
+		SAFE_READ(SAFE_READ_ALL, pp2[0], arr_out + num_len_data - i,
+			  ret);
 	}
 
 	for (i = 0; i < num_len_data; i++) {
diff --git a/testcases/kernel/syscalls/splice/splice06.c b/testcases/kernel/syscalls/splice/splice06.c
index c7434979b..35a3741d9 100644
--- a/testcases/kernel/syscalls/splice/splice06.c
+++ b/testcases/kernel/syscalls/splice/splice06.c
@@ -57,7 +57,7 @@ static int splice_read_num(const char *file)
 	if (ret < 0)
 		tst_brk(TBROK | TERRNO, "splice(fd_in, pipe) failed");
 
-	SAFE_READ(0, pipes[0], buf, BUF_SIZE);
+	SAFE_READ(SAFE_READ_ANY, pipes[0], buf, BUF_SIZE);
 
 	/* Search for the first nonnumeric character and replace it with \0 */
 	format_str(buf);
@@ -85,7 +85,7 @@ static char *splice_read_str(const char *file, char *dest)
 	if (ret < 0)
 		tst_brk(TBROK | TERRNO, "splice(fd_in, pipe) failed");
 
-	SAFE_READ(0, pipes[0], dest, BUF_SIZE);
+	SAFE_READ(SAFE_READ_ANY, pipes[0], dest, BUF_SIZE);
 
 	SAFE_CLOSE(fd_in);
 	SAFE_CLOSE(pipes[0]);
diff --git a/testcases/kernel/syscalls/splice/splice08.c b/testcases/kernel/syscalls/splice/splice08.c
index 3f9a070b7..bd635ee7e 100644
--- a/testcases/kernel/syscalls/splice/splice08.c
+++ b/testcases/kernel/syscalls/splice/splice08.c
@@ -41,7 +41,7 @@ static void test_splice(unsigned int bytes, int dev_fd)
 		goto ret;
 	}
 
-	SAFE_READ(1, pipefd[0], buf, sizeof(buf));
+	SAFE_READ(SAFE_READ_ALL, pipefd[0], buf, sizeof(buf));
 
 	for (i = 0; i < sizeof(buf); i++) {
 		if (buf[i])
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index 40a0d4a47..d188cb4a8 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -72,7 +72,7 @@ static void read_file(void)
 {
 	char data[SIZE];
 
-	SAFE_READ(0, fd, data, sizeof(data));
+	SAFE_READ(SAFE_READ_ANY, fd, data, sizeof(data));
 }
 
 static void change_mode(void)
diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index 436c52a20..22edcba17 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -31,7 +31,7 @@ static void check_file(void)
 	char teebuffer[TEST_BLOCK_SIZE];
 
 	fd_out = SAFE_OPEN(TESTFILE2, O_RDONLY);
-	SAFE_READ(1, fd_out, teebuffer, TEST_BLOCK_SIZE);
+	SAFE_READ(SAFE_READ_ALL, fd_out, teebuffer, TEST_BLOCK_SIZE);
 
 	for (i = 0; i < TEST_BLOCK_SIZE; i++) {
 		if (buffer[i] != teebuffer[i])
diff --git a/testcases/kernel/syscalls/timerfd/timerfd01.c b/testcases/kernel/syscalls/timerfd/timerfd01.c
index 4461c4fd4..80fc0223a 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd01.c
@@ -80,7 +80,7 @@ static void waittmr(int tfd, unsigned int exp_ticks)
 		tst_res(TFAIL, "no ticks happened");
 		return;
 	}
-	SAFE_READ(0, tfd, &ticks, sizeof(ticks));
+	SAFE_READ(SAFE_READ_ANY, tfd, &ticks, sizeof(ticks));
 
 	if (ticks != exp_ticks) {
 		tst_res(TFAIL, "got %u tick(s) expected %u",
diff --git a/testcases/kernel/syscalls/timerfd/timerfd04.c b/testcases/kernel/syscalls/timerfd/timerfd04.c
index b24b4874e..baf9773e6 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd04.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd04.c
@@ -83,7 +83,7 @@ static void verify_timerfd(unsigned int n)
 			return;
 		}
 
-		SAFE_READ(1, fd, &exp, sizeof(exp));
+		SAFE_READ(SAFE_READ_ALL, fd, &exp, sizeof(exp));
 
 		if (exp != 1)
 			tst_res(TFAIL, "Got %llu expirations", (long long unsigned)exp);
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
index 3af0e8240..7ec07bc41 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
@@ -79,7 +79,7 @@ static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 	if (nready == -1)
 		tst_brk(TBROK | TERRNO, "Error on poll");
 
-	SAFE_READ(1, uffd, &msg, sizeof(msg));
+	SAFE_READ(SAFE_READ_ALL, uffd, &msg, sizeof(msg));
 
 	if (msg.event != UFFD_EVENT_PAGEFAULT)
 		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
index 70dd844b3..a42d0ca04 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd02.c
@@ -49,7 +49,7 @@ static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 	static struct uffd_msg msg;
 	struct uffdio_move uffdio_move = {};
 
-	SAFE_READ(1, uffd, &msg, sizeof(msg));
+	SAFE_READ(SAFE_READ_ALL, uffd, &msg, sizeof(msg));
 
 	if (msg.event != UFFD_EVENT_PAGEFAULT)
 		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
index 8a720e41a..59ab11311 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
@@ -83,7 +83,7 @@ static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 	if (nready == -1)
 		tst_brk(TBROK | TERRNO, "Error on poll");
 
-	SAFE_READ(1, uffd, &msg, sizeof(msg));
+	SAFE_READ(SAFE_READ_ALL, uffd, &msg, sizeof(msg));
 
 	if (msg.event != UFFD_EVENT_PAGEFAULT)
 		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
index dce082eef..1952a7d1f 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
@@ -52,7 +52,7 @@ static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 	if (nready == -1)
 		tst_brk(TBROK | TERRNO, "Error on poll");
 
-	SAFE_READ(1, uffd, &msg, sizeof(msg));
+	SAFE_READ(SAFE_READ_ALL, uffd, &msg, sizeof(msg));
 
 	if (msg.event != UFFD_EVENT_PAGEFAULT)
 		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
index e36f9c321..0573af29d 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
@@ -60,7 +60,7 @@ static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 	if (nready == -1)
 		tst_brk(TBROK | TERRNO, "Error on poll");
 
-	SAFE_READ(1, uffd, &msg, sizeof(msg));
+	SAFE_READ(SAFE_READ_ALL, uffd, &msg, sizeof(msg));
 
 	if (msg.event != UFFD_EVENT_PAGEFAULT)
 		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
index 1ab288e64..136fc1dce 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
@@ -75,7 +75,7 @@ static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 	if (nready == -1)
 		tst_brk(TBROK | TERRNO, "Error on poll");
 
-	SAFE_READ(1, uffd, &msg, sizeof(msg));
+	SAFE_READ(SAFE_READ_ALL, uffd, &msg, sizeof(msg));
 
 	if (msg.event != UFFD_EVENT_PAGEFAULT)
 		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
index 7a1dff8a1..e0a1b0d23 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
@@ -79,7 +79,7 @@ static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 	if (nready == -1)
 		tst_brk(TBROK | TERRNO, "Error on poll");
 
-	SAFE_READ(1, uffd, &msg, sizeof(msg));
+	SAFE_READ(SAFE_READ_ALL, uffd, &msg, sizeof(msg));
 
 	if (msg.event != UFFD_EVENT_PAGEFAULT)
 		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
index 64eed8391..23f8556c9 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -31,7 +31,7 @@ static void check_file(void)
 	char vmsplicebuffer[TEST_BLOCK_SIZE];
 
 	fd_out = SAFE_OPEN(TESTFILE, O_RDONLY);
-	SAFE_READ(1, fd_out, vmsplicebuffer, TEST_BLOCK_SIZE);
+	SAFE_READ(SAFE_READ_ALL, fd_out, vmsplicebuffer, TEST_BLOCK_SIZE);
 
 	for (i = 0; i < TEST_BLOCK_SIZE; i++) {
 		if (buffer[i] != vmsplicebuffer[i])
diff --git a/testcases/kernel/syscalls/write/write03.c b/testcases/kernel/syscalls/write/write03.c
index 4eaa1e083..52d97039c 100644
--- a/testcases/kernel/syscalls/write/write03.c
+++ b/testcases/kernel/syscalls/write/write03.c
@@ -43,7 +43,7 @@ static void verify_write(void)
 
 	memset(rbuf, 0, BUFSIZ);
 
-	SAFE_READ(0, fd, rbuf, 100);
+	SAFE_READ(SAFE_READ_ANY, fd, rbuf, 100);
 
 	if (memcmp(wbuf, rbuf, 100) == 0)
 		tst_res(TPASS, "failure of write() did not corrupt the file");
diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index 6084733ef..c5ec84047 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -95,8 +95,9 @@ static void run(void)
 		tst_fzsync_start_race_a(&fzsync_pair);
 
 		for (total_read = 0; total_read < tst_atomic_load(&written);) {
-			total_read += SAFE_READ(0, readfd, readbuf+total_read,
-				BUF_SIZE + 1 - total_read);
+			total_read += SAFE_READ(SAFE_READ_ANY, readfd,
+						readbuf + total_read,
+						BUF_SIZE + 1 - total_read);
 		}
 
 		tst_fzsync_end_race_a(&fzsync_pair);
diff --git a/testcases/kernel/syscalls/writev/writev07.c b/testcases/kernel/syscalls/writev/writev07.c
index 8fa4f7868..87ced098d 100644
--- a/testcases/kernel/syscalls/writev/writev07.c
+++ b/testcases/kernel/syscalls/writev/writev07.c
@@ -77,7 +77,7 @@ static void test_partially_valid_iovec(int initial_file_offset)
 		tst_res(TINFO, "got EFAULT");
 		/* initial file content remains untouched */
 		SAFE_LSEEK(fd, 0, SEEK_SET);
-		SAFE_READ(1, fd, tmp, BUFSIZE);
+		SAFE_READ(SAFE_READ_ALL, fd, tmp, BUFSIZE);
 		if (memcmp(tmp, fpattern, BUFSIZE))
 			tst_res(TFAIL, "file was written to");
 		else
@@ -104,7 +104,7 @@ static void test_partially_valid_iovec(int initial_file_offset)
 
 	/* file content matches written bytes */
 	SAFE_LSEEK(fd, initial_file_offset, SEEK_SET);
-	SAFE_READ(1, fd, tmp, TST_RET);
+	SAFE_READ(SAFE_READ_ALL, fd, tmp, TST_RET);
 	if (memcmp(tmp, wr_iovec[0].iov_base, TST_RET) == 0) {
 		tst_res(TPASS, "file has expected content");
 	} else {
diff --git a/testcases/kernel/watchqueue/common.h b/testcases/kernel/watchqueue/common.h
index 639dd4a7c..c84191c86 100644
--- a/testcases/kernel/watchqueue/common.h
+++ b/testcases/kernel/watchqueue/common.h
@@ -131,7 +131,7 @@ static void wqueue_consumer(int fd, wqueue_callback cb)
 
 	tst_res(TINFO, "Reading watch queue events");
 
-	buf_len = SAFE_READ(0, fd, buffer, sizeof(buffer));
+	buf_len = SAFE_READ(SAFE_READ_ANY, fd, buffer, sizeof(buffer));
 
 	p = buffer;
 	end = buffer + buf_len;
diff --git a/testcases/network/can/filter-tests/can_filter.c b/testcases/network/can/filter-tests/can_filter.c
index 8b4f2fc05..babc20524 100644
--- a/testcases/network/can/filter-tests/can_filter.c
+++ b/testcases/network/can/filter-tests/can_filter.c
@@ -128,7 +128,8 @@ static void run(unsigned int n)
 
 		if (FD_ISSET(s, &rdfs)) {
 			have_rx = 1;
-			SAFE_READ(1, s, &frame, sizeof(struct can_frame));
+			SAFE_READ(SAFE_READ_ALL, s, &frame,
+				  sizeof(struct can_frame));
 
 			if ((frame.can_id & CAN_SFF_MASK) != ID)
 				tst_res(TFAIL, "received wrong can_id!");
diff --git a/testcases/network/can/filter-tests/can_rcv_own_msgs.c b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
index 2c0acecf9..975b481f5 100644
--- a/testcases/network/can/filter-tests/can_rcv_own_msgs.c
+++ b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
@@ -42,7 +42,8 @@ static void test_sockets(canid_t can_id, int expect_rxs, int expect_rxt)
 		if (FD_ISSET(s, &rdfs)) {
 
 			have_rx = 1;
-			SAFE_READ(1, s, &frame, sizeof(struct can_frame));
+			SAFE_READ(SAFE_READ_ALL, s, &frame,
+				  sizeof(struct can_frame));
 
 			if (frame.can_id != can_id)
 				tst_res(TFAIL, "received wrong can_id!");
@@ -53,7 +54,8 @@ static void test_sockets(canid_t can_id, int expect_rxs, int expect_rxt)
 		if (FD_ISSET(t, &rdfs)) {
 
 			have_rx = 1;
-			SAFE_READ(1, t, &frame, sizeof(struct can_frame));
+			SAFE_READ(SAFE_READ_ALL, t, &frame,
+				  sizeof(struct can_frame));
 
 			if (frame.can_id != can_id)
 				tst_res(TFAIL, "received wrong can_id!");
diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
index 0c2df5614..52cfb5436 100644
--- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
+++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
@@ -84,7 +84,7 @@ static void run_targets(const char *dirname, char *cfile, pid_t tid)
 			tst_cmd(cmd_run, output_file, NULL, 0);
 
 			fd = SAFE_OPEN(output_file, O_RDONLY);
-			SAFE_READ(1, fd, buf, 11);
+			SAFE_READ(SAFE_READ_ALL, fd, buf, 11);
 			if (strncmp(buf, "hello world", 11))
 				tst_brk(TFAIL, "command printed wrong message");
 			SAFE_CLOSE(fd);
diff --git a/testcases/network/sockets/xfrm01.c b/testcases/network/sockets/xfrm01.c
index a02d506e6..f76b99042 100644
--- a/testcases/network/sockets/xfrm01.c
+++ b/testcases/network/sockets/xfrm01.c
@@ -223,7 +223,7 @@ static void run(void)
 	SAFE_CLOSE(file_fd);
 
 	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
-	SAFE_READ(1, file_fd, readback, sizeof(readback));
+	SAFE_READ(SAFE_READ_ALL, file_fd, readback, sizeof(readback));
 	SAFE_CLOSE(file_fd);
 
 	if (memcmp(readback, original, DATA_SIZE) != 0)
diff --git a/testcases/network/sockets/xfrm02.c b/testcases/network/sockets/xfrm02.c
index cef9e7060..41f782515 100644
--- a/testcases/network/sockets/xfrm02.c
+++ b/testcases/network/sockets/xfrm02.c
@@ -225,7 +225,7 @@ static void run(void)
 	SAFE_CLOSE(file_fd);
 
 	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
-	SAFE_READ(1, file_fd, readback, sizeof(readback));
+	SAFE_READ(SAFE_READ_ALL, file_fd, readback, sizeof(readback));
 	SAFE_CLOSE(file_fd);
 
 	if (memcmp(readback, original, DATA_SIZE) != 0)
diff --git a/testcases/network/sockets/xfrm03.c b/testcases/network/sockets/xfrm03.c
index 676c76e2b..37a03e484 100644
--- a/testcases/network/sockets/xfrm03.c
+++ b/testcases/network/sockets/xfrm03.c
@@ -307,7 +307,7 @@ static void run(void)
 	SAFE_CLOSE(file_fd);
 
 	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
-	SAFE_READ(1, file_fd, readback, sizeof(readback));
+	SAFE_READ(SAFE_READ_ALL, file_fd, readback, sizeof(readback));
 	SAFE_CLOSE(file_fd);
 
 	if (memcmp(readback, original, DATA_SIZE) != 0)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
