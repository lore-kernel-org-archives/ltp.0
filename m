Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A812C433FE
	for <ltp@archiver.kernel.org>; Wed,  5 Oct 2022 14:26:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A12183CAE0A
	for <ltp@archiver.kernel.org>; Wed,  5 Oct 2022 16:26:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B9713CAE11
 for <ltp@lists.linux.it>; Wed,  5 Oct 2022 16:26:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E2DA6009E5
 for <ltp@lists.linux.it>; Wed,  5 Oct 2022 16:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664979957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdJSuLZDDl4A2pn1GPCBR59kTYTuXt+15AY2njnekFU=;
 b=YCTITKohuosCE9/8x7qURwOMVSEBtdMCPcsSdhJNUjcudO/LMOfAj6YcCw7EgRulR6wPBA
 xj+iLsKkAPh055wZAyhfJkri/1mo97wzgLfY8p+SYcIkWESNGKmutyOyITDXHjIvr8F2DM
 n8p8giJ3d4g1L2HSGEBzMaS1WWhFO4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-WrbgZBvxPeWgOPo-sK6aFQ-1; Wed, 05 Oct 2022 10:25:54 -0400
X-MC-Unique: WrbgZBvxPeWgOPo-sK6aFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA3F88630CE;
 Wed,  5 Oct 2022 14:25:53 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.193.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC3E218EB4;
 Wed,  5 Oct 2022 14:25:52 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Wed,  5 Oct 2022 16:25:45 +0200
Message-Id: <75b528baa58724ff96ad47fa0ed84b4b801266d5.1664979933.git.jstancek@redhat.com>
In-Reply-To: <cf13ddfffdb08e0771be253ac6911febb96a47c4.1664979933.git.jstancek@redhat.com>
References: <cf13ddfffdb08e0771be253ac6911febb96a47c4.1664979933.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] update all call sites of SAFE_WRITE()
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

And use new enum values.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 libs/libltpuinput/tst_uinput.c                         |  2 +-
 testcases/cve/cve-2014-0196.c                          | 10 +++++-----
 testcases/kernel/containers/userns/common.h            |  2 +-
 testcases/kernel/containers/userns/userns03.c          |  4 ++--
 testcases/kernel/containers/userns/userns06.c          |  4 ++--
 testcases/kernel/containers/userns/userns_helper.h     |  2 +-
 testcases/kernel/controllers/io/io_control01.c         |  2 +-
 testcases/kernel/controllers/memcg/memcontrol_common.h |  2 +-
 testcases/kernel/crypto/af_alg04.c                     |  2 +-
 testcases/kernel/crypto/af_alg05.c                     |  2 +-
 testcases/kernel/input/input_helper.c                  |  4 ++--
 testcases/kernel/io/direct_io/diotest1.c               |  4 ++--
 testcases/kernel/io/ltp-aiodio/common.h                |  2 +-
 testcases/kernel/io/ltp-aiodio/dio_sparse.c            |  2 +-
 testcases/kernel/mem/mtest06/mmap1.c                   |  4 ++--
 testcases/kernel/mem/mtest06/mmap3.c                   |  2 +-
 testcases/kernel/mem/thp/thp04.c                       |  2 +-
 testcases/kernel/pty/pty02.c                           |  2 +-
 testcases/kernel/pty/pty05.c                           |  2 +-
 testcases/kernel/security/dirtyc0w/dirtyc0w.c          |  2 +-
 testcases/kernel/security/dirtypipe/dirtypipe.c        |  4 ++--
 testcases/kernel/syscalls/bind/bind04.c                |  4 ++--
 testcases/kernel/syscalls/bind/bind05.c                |  4 ++--
 testcases/kernel/syscalls/bpf/bpf_common.c             |  2 +-
 .../kernel/syscalls/copy_file_range/copy_file_range.h  |  2 +-
 .../syscalls/copy_file_range/copy_file_range02.c       |  2 +-
 .../syscalls/copy_file_range/copy_file_range03.c       |  2 +-
 testcases/kernel/syscalls/dup2/dup203.c                |  4 ++--
 testcases/kernel/syscalls/dup2/dup207.c                |  2 +-
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c      |  2 +-
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c  |  2 +-
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c  |  2 +-
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c  |  2 +-
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c  |  2 +-
 testcases/kernel/syscalls/epoll_wait/epoll_wait01.c    |  6 +++---
 testcases/kernel/syscalls/exit/exit02.c                |  2 +-
 testcases/kernel/syscalls/fallocate/fallocate02.c      |  2 +-
 testcases/kernel/syscalls/fallocate/fallocate04.c      |  2 +-
 testcases/kernel/syscalls/fallocate/fallocate06.c      |  2 +-
 testcases/kernel/syscalls/fanotify/fanotify01.c        |  6 +++---
 testcases/kernel/syscalls/fanotify/fanotify02.c        |  2 +-
 testcases/kernel/syscalls/fanotify/fanotify03.c        |  4 ++--
 testcases/kernel/syscalls/fanotify/fanotify07.c        |  2 +-
 testcases/kernel/syscalls/fanotify/fanotify16.c        |  2 +-
 testcases/kernel/syscalls/fanotify/fanotify19.c        |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl11.c              |  6 +++---
 testcases/kernel/syscalls/fcntl/fcntl15.c              |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl20.c              |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl34.c              |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl36.c              |  4 ++--
 testcases/kernel/syscalls/fcntl/fcntl37.c              |  2 +-
 testcases/kernel/syscalls/fsync/fsync01.c              |  2 +-
 testcases/kernel/syscalls/fsync/fsync02.c              |  4 ++--
 testcases/kernel/syscalls/inotify/inotify05.c          |  4 ++--
 testcases/kernel/syscalls/inotify/inotify09.c          |  2 +-
 testcases/kernel/syscalls/inotify/inotify12.c          |  4 ++--
 testcases/kernel/syscalls/ioctl/ioctl08.c              |  4 ++--
 testcases/kernel/syscalls/linkat/linkat01.c            |  3 ++-
 testcases/kernel/syscalls/llseek/llseek01.c            |  2 +-
 testcases/kernel/syscalls/llseek/llseek03.c            |  2 +-
 testcases/kernel/syscalls/lseek/lseek01.c              |  2 +-
 testcases/kernel/syscalls/lseek/lseek07.c              |  6 +++---
 testcases/kernel/syscalls/lseek/lseek11.c              |  2 +-
 testcases/kernel/syscalls/madvise/madvise01.c          |  2 +-
 testcases/kernel/syscalls/madvise/madvise02.c          |  2 +-
 testcases/kernel/syscalls/mincore/mincore01.c          |  2 +-
 testcases/kernel/syscalls/mmap/mmap16.c                |  2 +-
 testcases/kernel/syscalls/mmap/mmap17.c                |  4 ++--
 testcases/kernel/syscalls/mmap/mmap19.c                |  4 ++--
 testcases/kernel/syscalls/mprotect/mprotect02.c        |  3 ++-
 testcases/kernel/syscalls/mprotect/mprotect03.c        |  2 +-
 testcases/kernel/syscalls/msync/msync03.c              |  2 +-
 testcases/kernel/syscalls/msync/msync04.c              |  2 +-
 testcases/kernel/syscalls/open/open12.c                |  6 ++++--
 testcases/kernel/syscalls/open/open14.c                |  2 +-
 testcases/kernel/syscalls/openat/openat02.c            |  4 ++--
 testcases/kernel/syscalls/openat/openat03.c            |  2 +-
 testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c  |  2 +-
 testcases/kernel/syscalls/pipe/pipe01.c                |  2 +-
 testcases/kernel/syscalls/pipe/pipe02.c                |  4 ++--
 testcases/kernel/syscalls/pipe/pipe11.c                |  2 +-
 testcases/kernel/syscalls/pipe/pipe12.c                |  4 ++--
 testcases/kernel/syscalls/pipe2/pipe2_04.c             |  4 ++--
 testcases/kernel/syscalls/pkeys/pkey01.c               |  2 +-
 testcases/kernel/syscalls/poll/poll01.c                |  2 +-
 testcases/kernel/syscalls/prctl/prctl04.c              |  2 +-
 testcases/kernel/syscalls/pread/pread02.c              |  2 +-
 testcases/kernel/syscalls/preadv/preadv01.c            |  4 ++--
 testcases/kernel/syscalls/preadv/preadv03.c            |  4 ++--
 testcases/kernel/syscalls/preadv2/preadv201.c          |  4 ++--
 testcases/kernel/syscalls/pwrite/pwrite01.c            |  2 +-
 testcases/kernel/syscalls/read/read01.c                |  2 +-
 testcases/kernel/syscalls/read/read04.c                |  2 +-
 testcases/kernel/syscalls/readahead/readahead02.c      |  2 +-
 testcases/kernel/syscalls/readdir/readdir01.c          |  2 +-
 testcases/kernel/syscalls/readv/readv01.c              |  2 +-
 testcases/kernel/syscalls/select/select01.c            |  2 +-
 testcases/kernel/syscalls/sendfile/sendfile02.c        |  2 +-
 testcases/kernel/syscalls/sendfile/sendfile06.c        |  2 +-
 testcases/kernel/syscalls/sendfile/sendfile08.c        |  4 ++--
 testcases/kernel/syscalls/sendfile/sendfile09.c        |  2 +-
 testcases/kernel/syscalls/splice/splice01.c            |  2 +-
 testcases/kernel/syscalls/splice/splice02.c            |  2 +-
 testcases/kernel/syscalls/splice/splice03.c            |  2 +-
 testcases/kernel/syscalls/splice/splice04.c            |  2 +-
 testcases/kernel/syscalls/splice/splice05.c            |  2 +-
 testcases/kernel/syscalls/stat/stat02.c                |  2 +-
 testcases/kernel/syscalls/statx/statx01.c              |  2 +-
 testcases/kernel/syscalls/statx/statx02.c              |  2 +-
 testcases/kernel/syscalls/statx/statx06.c              |  2 +-
 testcases/kernel/syscalls/symlinkat/symlinkat01.c      |  3 ++-
 testcases/kernel/syscalls/tee/tee01.c                  |  2 +-
 testcases/kernel/syscalls/tee/tee02.c                  |  2 +-
 testcases/kernel/syscalls/umount2/umount2_01.c         |  2 +-
 testcases/kernel/syscalls/vmsplice/vmsplice03.c        |  2 +-
 testcases/kernel/syscalls/write/write03.c              |  2 +-
 testcases/kernel/syscalls/write/write04.c              |  2 +-
 testcases/kernel/syscalls/write/write06.c              |  4 ++--
 testcases/kernel/syscalls/writev/writev03.c            |  2 +-
 testcases/network/can/filter-tests/can_filter.c        |  8 ++++----
 testcases/network/can/filter-tests/can_rcv_own_msgs.c  |  2 +-
 testcases/network/lib6/getaddrinfo_01.c                |  2 +-
 testcases/network/nfs/nfs_stress/nfs05_make_tree.c     |  6 +++---
 123 files changed, 172 insertions(+), 167 deletions(-)

diff --git a/libs/libltpuinput/tst_uinput.c b/libs/libltpuinput/tst_uinput.c
index f4eee07b88bc..6dc8a7d4ec41 100644
--- a/libs/libltpuinput/tst_uinput.c
+++ b/libs/libltpuinput/tst_uinput.c
@@ -140,7 +140,7 @@ void create_input_device(int fd)
 		}
 	};
 
-	SAFE_WRITE(1, fd, &uidev, sizeof(uidev));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, &uidev, sizeof(uidev));
 	SAFE_IOCTL(fd, UI_DEV_CREATE, NULL);
 
 	for (nb = 100; nb > 0; nb--) {
diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index 1937d566c3e4..9d20a398606e 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -70,9 +70,9 @@ static void *overwrite_thread_fn(void *p LTP_ATTRIBUTE_UNUSED)
 {
 	while(tst_fzsync_run_b(&fzsync_pair)) {
 		tst_fzsync_start_race_b(&fzsync_pair);
-		SAFE_WRITE(0, slave_fd, buf, BUFLEN - 1);
-		SAFE_WRITE(0, slave_fd, buf, BUFLEN - 1);
-		SAFE_WRITE(0, slave_fd, buf, BUFLEN);
+		SAFE_WRITE(SAFE_WRITE_ANY, slave_fd, buf, BUFLEN - 1);
+		SAFE_WRITE(SAFE_WRITE_ANY, slave_fd, buf, BUFLEN - 1);
+		SAFE_WRITE(SAFE_WRITE_ANY, slave_fd, buf, BUFLEN);
 		tst_fzsync_end_race_b(&fzsync_pair);
 	}
 	return 0;
@@ -95,7 +95,7 @@ static void run(void)
 		SAFE_CLOSE(target_ptys[RUN_ALLOCS / 2]);
 		SAFE_CLOSE(target_ptys[RUN_ALLOCS / 2 + RUN_ALLOCS]);
 
-		SAFE_WRITE(0, slave_fd, buf, 1);
+		SAFE_WRITE(SAFE_WRITE_ANY, slave_fd, buf, 1);
 
 		tcgetattr(master_fd, &t);
 		t.c_oflag &= ~OPOST;
@@ -103,7 +103,7 @@ static void run(void)
 		tcsetattr(master_fd, TCSANOW, &t);
 
 		tst_fzsync_start_race_a(&fzsync_pair);
-		SAFE_WRITE(0, master_fd, "A", 1);
+		SAFE_WRITE(SAFE_WRITE_ANY, master_fd, "A", 1);
 		tst_fzsync_end_race_a(&fzsync_pair);
 
 		for (j = 0; j < RUN_ALLOCS; j++) {
diff --git a/testcases/kernel/containers/userns/common.h b/testcases/kernel/containers/userns/common.h
index aed4aa521df8..d3bdcc53fc14 100644
--- a/testcases/kernel/containers/userns/common.h
+++ b/testcases/kernel/containers/userns/common.h
@@ -51,7 +51,7 @@ static inline void updatemap(int cpid, int type, int idnum, int parentmappid)
 	sprintf(content, "%d %d 1", idnum, parentmappid);
 
 	fd = SAFE_OPEN(path, O_WRONLY, 0644);
-	SAFE_WRITE(1, fd, content, strlen(content));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, content, strlen(content));
 	SAFE_CLOSE(fd);
 }
 
diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
index d329a2b7c9e0..b90cc09ba614 100644
--- a/testcases/kernel/containers/userns/userns03.c
+++ b/testcases/kernel/containers/userns/userns03.c
@@ -158,7 +158,7 @@ static void run(void)
 		sprintf(path, "/proc/%d/setgroups", cpid1);
 
 		fd = SAFE_OPEN(path, O_WRONLY, 0644);
-		SAFE_WRITE(1, fd, "deny", 4);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, "deny", 4);
 		SAFE_CLOSE(fd);
 
 		/* If the setgroups file has the value "deny",
@@ -184,7 +184,7 @@ static void run(void)
 		sprintf(path, "/proc/%d/setgroups", cpid2);
 
 		fd = SAFE_OPEN(path, O_WRONLY, 0644);
-		SAFE_WRITE(1, fd, "deny", 4);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, "deny", 4);
 		SAFE_CLOSE(fd);
 	}
 
diff --git a/testcases/kernel/containers/userns/userns06.c b/testcases/kernel/containers/userns/userns06.c
index 002c7290705a..39f02e38ac25 100644
--- a/testcases/kernel/containers/userns/userns06.c
+++ b/testcases/kernel/containers/userns/userns06.c
@@ -96,13 +96,13 @@ static void run(void)
 		sprintf(path, "/proc/%d/setgroups", cpid1);
 
 		fd = SAFE_OPEN(path, O_WRONLY, 0644);
-		SAFE_WRITE(1, fd, "deny", 4);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, "deny", 4);
 		SAFE_CLOSE(fd);
 
 		sprintf(path, "/proc/%d/setgroups", cpid2);
 
 		fd = SAFE_OPEN(path, O_WRONLY, 0644);
-		SAFE_WRITE(1, fd, "deny", 4);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, "deny", 4);
 		SAFE_CLOSE(fd);
 	}
 
diff --git a/testcases/kernel/containers/userns/userns_helper.h b/testcases/kernel/containers/userns/userns_helper.h
index 12b491f62c18..2759d32c252e 100644
--- a/testcases/kernel/containers/userns/userns_helper.h
+++ b/testcases/kernel/containers/userns/userns_helper.h
@@ -56,7 +56,7 @@ LTP_ATTRIBUTE_UNUSED static int updatemap(int cpid, bool type, int idnum,
 
 	sprintf(content, "%d %d 1", idnum, parentmappid);
 	fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
-	SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
+	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, content, strlen(content));
 	SAFE_CLOSE(cleanup, fd);
 	return 0;
 }
diff --git a/testcases/kernel/controllers/io/io_control01.c b/testcases/kernel/controllers/io/io_control01.c
index dd7f802b5485..c4e171af5ca3 100644
--- a/testcases/kernel/controllers/io/io_control01.c
+++ b/testcases/kernel/controllers/io/io_control01.c
@@ -80,7 +80,7 @@ static void run(void)
 	fd = SAFE_OPEN("mnt/dat", O_WRONLY | O_CREAT, 0600);
 
 	for (i = 0; i < 4; i++) {
-		SAFE_WRITE(1, fd, buf, pgsz);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, pgsz);
 		SAFE_FSYNC(fd);
 		TST_EXP_PASS_SILENT(posix_fadvise(fd, pgsz * i, pgsz, POSIX_FADV_DONTNEED));
 	}
diff --git a/testcases/kernel/controllers/memcg/memcontrol_common.h b/testcases/kernel/controllers/memcg/memcontrol_common.h
index 63df719a6c97..adb6fafb3338 100644
--- a/testcases/kernel/controllers/memcg/memcontrol_common.h
+++ b/testcases/kernel/controllers/memcg/memcontrol_common.h
@@ -31,7 +31,7 @@ static inline void alloc_pagecache(const int fd, size_t size)
 	SAFE_LSEEK(fd, 0, SEEK_END);
 
 	for (i = 0; i < size; i += sizeof(buf))
-		SAFE_WRITE(1, fd, buf, sizeof(buf));
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, sizeof(buf));
 }
 
 static inline void alloc_anon(const size_t size)
diff --git a/testcases/kernel/crypto/af_alg04.c b/testcases/kernel/crypto/af_alg04.c
index 7b665f89a360..10975068e7a5 100644
--- a/testcases/kernel/crypto/af_alg04.c
+++ b/testcases/kernel/crypto/af_alg04.c
@@ -41,7 +41,7 @@ static void test_with_symm_enc_algs(const char *symm_enc_algname)
 	reqfd = tst_alg_accept(algfd);
 
 	for (i = 0; i < 500000; i++)
-		SAFE_WRITE(1, reqfd, buf, sizeof(buf));
+		SAFE_WRITE(SAFE_WRITE_ALL, reqfd, buf, sizeof(buf));
 
 	close(reqfd);
 
diff --git a/testcases/kernel/crypto/af_alg05.c b/testcases/kernel/crypto/af_alg05.c
index e835b8a1f780..5237bea6015c 100644
--- a/testcases/kernel/crypto/af_alg05.c
+++ b/testcases/kernel/crypto/af_alg05.c
@@ -30,7 +30,7 @@ static void run(void)
 
 	reqfd = tst_alg_setup_reqfd("skcipher", "cbc(aes-generic)", NULL, 16);
 
-	SAFE_WRITE(1, reqfd, buffer, 15);
+	SAFE_WRITE(SAFE_WRITE_ALL, reqfd, buffer, 15);
 	/* with the bug, this crashed the kernel on some architectures */
 	TEST(read(reqfd, buffer, 15));
 
diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
index a014861da6e7..c4736eadd7a1 100644
--- a/testcases/kernel/input/input_helper.c
+++ b/testcases/kernel/input/input_helper.c
@@ -175,7 +175,7 @@ void send_event(int fd, int event, int code, int value)
 		.value = value,
 	};
 
-	SAFE_WRITE(NULL, 1, fd, &ev, sizeof(ev));
+	SAFE_WRITE(NULL, SAFE_WRITE_ALL, fd, &ev, sizeof(ev));
 }
 
 void send_rel_move(int fd, int x, int y)
@@ -198,7 +198,7 @@ void create_device(int fd)
 		}
 	};
 
-	SAFE_WRITE(NULL, 1, fd, &uidev, sizeof(uidev));
+	SAFE_WRITE(NULL, SAFE_WRITE_ALL, fd, &uidev, sizeof(uidev));
 	SAFE_IOCTL(NULL, fd, UI_DEV_CREATE, NULL);
 
 	for (nb = 100; nb > 0; nb--) {
diff --git a/testcases/kernel/io/direct_io/diotest1.c b/testcases/kernel/io/direct_io/diotest1.c
index 327df6ced68b..03a054b4cc7d 100644
--- a/testcases/kernel/io/direct_io/diotest1.c
+++ b/testcases/kernel/io/direct_io/diotest1.c
@@ -137,7 +137,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < numblks; i++) {
 		fillbuf(buf, bufsize, (char)(i % 256));
-		SAFE_WRITE(cleanup, 1, fd1, buf, bufsize);
+		SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd1, buf, bufsize);
 	}
 
 	/* Copy infile to outfile using direct read and direct write */
@@ -147,7 +147,7 @@ int main(int argc, char *argv[])
 	while ((n = read(fd1, buf, bufsize)) > 0) {
 		SAFE_LSEEK(cleanup, fd2, offset, SEEK_SET);
 
-		SAFE_WRITE(cleanup, 1, fd2, buf, n);
+		SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd2, buf, n);
 
 		offset += n;
 		SAFE_LSEEK(cleanup, fd1, offset, SEEK_SET);
diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
index 3a604f8f72d1..200bbe18e873 100644
--- a/testcases/kernel/io/ltp-aiodio/common.h
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -45,7 +45,7 @@ static inline void io_append(const char *path, char pattern, int flags, size_t b
 	fd = SAFE_OPEN(path, flags, 0666);
 
 	for (i = 0; i < bcount; i++) {
-		SAFE_WRITE(1, fd, bufptr, bs);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, bufptr, bs);
 
 		if (!tst_remaining_runtime())
 			break;
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 1b5834ed4edc..04b93ff2b3fe 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -55,7 +55,7 @@ static void dio_sparse(int fd, int align, long long fs, int ws, long long off)
 			tst_res(TINFO, "Test runtime is over, exiting");
 			return;
 		}
-		w = SAFE_WRITE(0, fd, bufptr, ws);
+		w = SAFE_WRITE(SAFE_WRITE_ANY, fd, bufptr, ws);
 		i += w;
 	}
 }
diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 6726f11ddcfb..907597d16c3f 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -171,8 +171,8 @@ int mkfile(int size)
 	SAFE_UNLINK(TEST_FILENAME);
 
 	for (i = 0; i < size; i++)
-		SAFE_WRITE(1, fd, "a", 1);
-	SAFE_WRITE(1, fd, "\0", 1);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, "a", 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, "\0", 1);
 
 	if (fsync(fd) == -1)
 		tst_brk(TBROK | TERRNO, "fsync()");
diff --git a/testcases/kernel/mem/mtest06/mmap3.c b/testcases/kernel/mem/mtest06/mmap3.c
index ec125b115693..19f4e33df53e 100644
--- a/testcases/kernel/mem/mtest06/mmap3.c
+++ b/testcases/kernel/mem/mtest06/mmap3.c
@@ -47,7 +47,7 @@ static int mkfile(int *size)
 
 	while (index < *size) {
 		index += sizeof(buf);
-		SAFE_WRITE(1, fd, buf, sizeof(buf));
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, sizeof(buf));
 	}
 
 	fsync(fd);
diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index c93da54e68b4..7cab5d76bd9c 100644
--- a/testcases/kernel/mem/thp/thp04.c
+++ b/testcases/kernel/mem/thp/thp04.c
@@ -128,7 +128,7 @@ static void run(void)
 		tst_fzsync_start_race_a(&fzsync_pair);
 		SAFE_LSEEK(writefd, (off_t)write_ptr, SEEK_SET);
 		madvise(write_thp, thp_size, MADV_DONTNEED);
-		SAFE_WRITE(1, writefd, &c, sizeof(int));
+		SAFE_WRITE(SAFE_WRITE_ALL, writefd, &c, sizeof(int));
 		tst_fzsync_end_race_a(&fzsync_pair);
 
 		/* Check the other huge zero page for pollution */
diff --git a/testcases/kernel/pty/pty02.c b/testcases/kernel/pty/pty02.c
index 050a9f7eadc8..4551c4e8097f 100644
--- a/testcases/kernel/pty/pty02.c
+++ b/testcases/kernel/pty/pty02.c
@@ -47,7 +47,7 @@ static void do_test(void)
 
 	pts = SAFE_OPEN(ptsname(ptmx), O_RDONLY);
 	/* write newline to ptmx to avoid read() on pts to block */
-	SAFE_WRITE(1, ptmx, "A\n", 2);
+	SAFE_WRITE(SAFE_WRITE_ALL, ptmx, "A\n", 2);
 	SAFE_READ(1, pts, &c, 1);
 
 	tst_res(TINFO, "Calling FIONREAD, this will hang in n_tty_ioctl() if the bug is present...");
diff --git a/testcases/kernel/pty/pty05.c b/testcases/kernel/pty/pty05.c
index 35ecce922ed0..925ce3854e62 100644
--- a/testcases/kernel/pty/pty05.c
+++ b/testcases/kernel/pty/pty05.c
@@ -67,7 +67,7 @@ static void run(void)
 		}
 
 		SAFE_IOCTL(ptmx, TCXONC, TCOOFF);
-		SAFE_WRITE(1, ptmx, buf, BUF_SIZE);
+		SAFE_WRITE(SAFE_WRITE_ALL, ptmx, buf, BUF_SIZE);
 
 		tst_fzsync_start_race_a(&fzsync_pair);
 		ioctl(ptmx, TCXONC, TCOON);
diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
index 7924285a7a18..487a52601e8a 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
@@ -62,7 +62,7 @@ void dirtyc0w_test(void)
 
 	/* Create file */
 	fd = SAFE_OPEN(FNAME, O_WRONLY|O_CREAT|O_EXCL, 0444);
-	SAFE_WRITE(1, fd, STR, sizeof(STR)-1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, STR, sizeof(STR)-1);
 	SAFE_CLOSE(fd);
 
 	pid = SAFE_FORK();
diff --git a/testcases/kernel/security/dirtypipe/dirtypipe.c b/testcases/kernel/security/dirtypipe/dirtypipe.c
index b318a8d0a290..9568a9b847b4 100644
--- a/testcases/kernel/security/dirtypipe/dirtypipe.c
+++ b/testcases/kernel/security/dirtypipe/dirtypipe.c
@@ -80,7 +80,7 @@ static void prepare_pipe(void)
 	 */
 	for (total = pipe_size; total > 0;) {
 		n = total > sizeof(buffer) ? sizeof(buffer) : total;
-		len = SAFE_WRITE(1, p[1], buffer, n);
+		len = SAFE_WRITE(SAFE_WRITE_ALL, p[1], buffer, n);
 		total -= len;
 	}
 
@@ -128,7 +128,7 @@ static void run(void)
 	 * will instead write into the page cache, because of the
 	 * PIPE_BUF_FLAG_CAN_MERGE flag
 	 */
-	len = SAFE_WRITE(1, p[1], TEXT, data_size);
+	len = SAFE_WRITE(SAFE_WRITE_ALL, p[1], TEXT, data_size);
 	if (len < nbytes)
 		tst_brk(TFAIL, "short write");
 
diff --git a/testcases/kernel/syscalls/bind/bind04.c b/testcases/kernel/syscalls/bind/bind04.c
index de43b6c13982..d8456e739a94 100644
--- a/testcases/kernel/syscalls/bind/bind04.c
+++ b/testcases/kernel/syscalls/bind/bind04.c
@@ -97,7 +97,7 @@ static void *peer_thread(void *tc_ptr)
 	else
 		response = "Invalid request value";
 
-	SAFE_WRITE(1, sock, response, strlen(response) + 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, sock, response, strlen(response) + 1);
 	SAFE_CLOSE(sock);
 	return NULL;
 }
@@ -139,7 +139,7 @@ static void test_bind(unsigned int n)
 		&remote_len);
 
 	rand_index = rand() % ARRAY_SIZE(testcase_list);
-	SAFE_WRITE(1, sock, &rand_index, sizeof(rand_index));
+	SAFE_WRITE(SAFE_WRITE_ALL, sock, &rand_index, sizeof(rand_index));
 
 	size = SAFE_READ(0, sock, buffer, BUFFER_SIZE - 1);
 	buffer[size] = '\0';
diff --git a/testcases/kernel/syscalls/bind/bind05.c b/testcases/kernel/syscalls/bind/bind05.c
index c43593fe1c25..a94985573cf3 100644
--- a/testcases/kernel/syscalls/bind/bind05.c
+++ b/testcases/kernel/syscalls/bind/bind05.c
@@ -99,7 +99,7 @@ static void *peer_thread(void *tc_ptr)
 			sizeof(struct sockaddr_un));
 
 	SAFE_CONNECT(sock, tc->address, tc->addrlen);
-	SAFE_WRITE(1, sock, &request, sizeof(request));
+	SAFE_WRITE(SAFE_WRITE_ALL, sock, &request, sizeof(request));
 	SAFE_READ(1, sock, &request, sizeof(request));
 
 	if (request < ARRAY_SIZE(testcase_list))
@@ -107,7 +107,7 @@ static void *peer_thread(void *tc_ptr)
 	else
 		response = "Invalid request value";
 
-	SAFE_WRITE(1, sock, response, strlen(response) + 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, sock, response, strlen(response) + 1);
 	SAFE_CLOSE(sock);
 
 	if (tc->address->sa_family == AF_UNIX)
diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
index c2331ab567d2..95b5bc12eaa4 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.c
+++ b/testcases/kernel/syscalls/bpf/bpf_common.c
@@ -136,7 +136,7 @@ void bpf_run_prog(const int prog_fd,
 	SAFE_SETSOCKOPT(sk[1], SOL_SOCKET, SO_ATTACH_BPF,
 			&prog_fd, sizeof(prog_fd));
 
-	SAFE_WRITE(1, sk[0], msg, msg_len);
+	SAFE_WRITE(SAFE_WRITE_ALL, sk[0], msg, msg_len);
 
 	SAFE_CLOSE(sk[0]);
 	SAFE_CLOSE(sk[1]);
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
index 1d80ab0f79ce..8e52954eddb5 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
@@ -67,7 +67,7 @@ static inline int verify_cross_fs_copy_support(const char *path_in, const char *
 	fd = SAFE_OPEN(path_in, O_RDWR | O_CREAT, 0664);
 	/* Writing page_size * 4 of data into test file */
 	for (i = 0; i < (int)(getpagesize() * 4); i++)
-		SAFE_WRITE(1, fd, CONTENT, CONTSIZE);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, CONTENT, CONTSIZE);
 
 	fd_test = SAFE_OPEN(path_out, O_RDWR | O_CREAT, 0664);
 	TEST(sys_copy_file_range(fd, 0, fd_test, 0, CONTSIZE, 0));
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index bc27fbe57cac..704f91bc6b19 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -220,7 +220,7 @@ static void setup(void)
 
 	SAFE_PIPE(fd_pipe);
 
-	SAFE_WRITE(1, fd_src, CONTENT, CONTSIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_src, CONTENT, CONTSIZE);
 	close(fd_src);
 	fd_src = SAFE_OPEN(FILE_SRC_PATH, O_RDONLY, 0664);
 	fd_dup = SAFE_OPEN(FILE_SRC_PATH, O_WRONLY|O_CREAT, 0666);
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
index 21a5d553b48e..21e625f48a83 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
@@ -66,7 +66,7 @@ static void setup(void)
 
 	fd_dest = SAFE_OPEN(FILE_DEST_PATH, O_RDWR | O_CREAT, 0664);
 	fd_src  = SAFE_OPEN(FILE_SRC_PATH,  O_RDWR | O_CREAT, 0664);
-	SAFE_WRITE(1, fd_src,  CONTENT,  CONTSIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_src,  CONTENT,  CONTSIZE);
 	SAFE_CLOSE(fd_src);
 	fd_src = SAFE_OPEN(FILE_SRC_PATH, O_RDONLY);
 }
diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
index c76f125a1bd5..c8d1095f38af 100644
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -40,11 +40,11 @@ static void run(unsigned int i)
 	tst_res(TINFO, "%s", tc->desc);
 
 	fd0 = SAFE_CREAT(filename0, 0666);
-	SAFE_WRITE(1, fd0, filename0, strlen(filename0));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd0, filename0, strlen(filename0));
 	SAFE_CLOSE(fd0);
 
 	fd1 = SAFE_CREAT(filename1, 0666);
-	SAFE_WRITE(1, fd1, filename1, strlen(filename1));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd1, filename1, strlen(filename1));
 
 	fd0 = SAFE_OPEN(filename0, O_RDONLY);
 	SAFE_FCNTL(fd0, F_SETFD, 1);
diff --git a/testcases/kernel/syscalls/dup2/dup207.c b/testcases/kernel/syscalls/dup2/dup207.c
index d11b78b0a26b..f1b184f5b230 100644
--- a/testcases/kernel/syscalls/dup2/dup207.c
+++ b/testcases/kernel/syscalls/dup2/dup207.c
@@ -35,7 +35,7 @@ static struct tcase {
 static void setup(void)
 {
 	ofd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0644);
-	SAFE_WRITE(1, ofd, WRITE_STR, sizeof(WRITE_STR) - 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, ofd, WRITE_STR, sizeof(WRITE_STR) - 1);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
index 099a0f8dd44f..298ed89cb2ea 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
@@ -81,7 +81,7 @@ static void check_epoll_ctl(int opt, int exp_num)
 	if (exp_num == 2)
 		events |= EPOLLOUT;
 
-	SAFE_WRITE(1, fd[1], write_buf, sizeof(write_buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd[1], write_buf, sizeof(write_buf));
 
 	while (events) {
 		int events_matched = 0;
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
index 3097dc3e3c1f..f4a55e008407 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
@@ -63,7 +63,7 @@ static void run(unsigned int n)
 		SAFE_KILL(pid, SIGUSR1);
 
 		usleep(10000);
-		SAFE_WRITE(1, sfd[1], "w", 1);
+		SAFE_WRITE(SAFE_WRITE_ALL, sfd[1], "w", 1);
 		exit(0);
 	}
 
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
index 281800814e69..7914f1c50c7c 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
@@ -43,7 +43,7 @@ static void setup(void)
 	e.events = EPOLLIN;
 	if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e))
 		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
-	SAFE_WRITE(1, sfd[1], "w", 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, sfd[1], "w", 1);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
index 88a9b93d25b3..54b9be9752c1 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
@@ -39,7 +39,7 @@ static void setup(void)
 	e.events = EPOLLIN;
 	if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e))
 		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
-	SAFE_WRITE(1, sfd[1], "w", 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, sfd[1], "w", 1);
 
 	bad_addr = tst_get_bad_addr(NULL);
 }
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
index 1373c36e5c5c..4c4aeb77dd55 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
@@ -47,7 +47,7 @@ static void setup(void)
 	e.events = EPOLLIN;
 	if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e))
 		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
-	SAFE_WRITE(1, sfd[1], "w", 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, sfd[1], "w", 1);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
index 1807bec8a766..4f8438488065 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
@@ -33,7 +33,7 @@ static int get_writesize(void)
 	memset(buf, 'a', sizeof(buf));
 
 	do {
-		write_size += SAFE_WRITE(0, fds[1], buf, sizeof(buf));
+		write_size += SAFE_WRITE(SAFE_WRITE_ANY, fds[1], buf, sizeof(buf));
 		nfd = poll(pfd, 1, 1);
 		if (nfd == -1)
 			tst_brk(TBROK | TERRNO, "poll() failed");
@@ -136,7 +136,7 @@ static void verify_epollin(void)
 
 	memset(write_buf, 'a', sizeof(write_buf));
 
-	SAFE_WRITE(1, fds[1], write_buf, sizeof(write_buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, fds[1], write_buf, sizeof(write_buf));
 
 	TEST(epoll_wait(epfd, &ret_evs, 1, -1));
 
@@ -176,7 +176,7 @@ static void verify_epollio(void)
 	uint32_t events = EPOLLIN | EPOLLOUT;
 	struct epoll_event ret_evs[2];
 
-	SAFE_WRITE(1, fds[1], write_buf, sizeof(write_buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, fds[1], write_buf, sizeof(write_buf));
 
 	while (events) {
 		int events_matched = 0;
diff --git a/testcases/kernel/syscalls/exit/exit02.c b/testcases/kernel/syscalls/exit/exit02.c
index 826ab1fb5bf8..1311ee36095a 100644
--- a/testcases/kernel/syscalls/exit/exit02.c
+++ b/testcases/kernel/syscalls/exit/exit02.c
@@ -21,7 +21,7 @@ static void child_write(void)
 	int fd;
 
 	fd = SAFE_CREAT(FNAME, 0666);
-	SAFE_WRITE(1, fd, FNAME, sizeof(FNAME));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, FNAME, sizeof(FNAME));
 	exit(0);
 }
 
diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index 750ef4e49881..bb719d78f235 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -124,7 +124,7 @@ static void setup(void)
 	char buf[BLOCK_SIZE];
 	memset(buf, 'A', BLOCK_SIZE);
 	for (i = 0; i < BLOCKS_WRITTEN; i++)
-		SAFE_WRITE(cleanup, 1, fdw, buf, BLOCK_SIZE);
+		SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fdw, buf, BLOCK_SIZE);
 }
 
 static void fallocate_verify(int i)
diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 29de5886ebea..568a9e3f16df 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -91,7 +91,7 @@ static void test01(void)
 
 	fill_tst_buf(buf);
 
-	SAFE_WRITE(1, fd, buf, buf_size);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, buf_size);
 
 	tst_res(TPASS, "test-case succeeded");
 }
diff --git a/testcases/kernel/syscalls/fallocate/fallocate06.c b/testcases/kernel/syscalls/fallocate/fallocate06.c
index 25b27e41da8f..16f9db0667e5 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate06.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate06.c
@@ -184,7 +184,7 @@ static void run(unsigned int n)
 
 	/* Prepare test data for deallocation test */
 	size = WRITE_BLOCKS * blocksize;
-	SAFE_WRITE(1, fd, wbuf, size);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, wbuf, size);
 
 	/* Allocation test */
 	offset = size + block_offset;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 23b88cd5261a..3538335c9ab0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -132,7 +132,7 @@ static void test_fanotify(unsigned int n)
 	event_set[tst_count] = FAN_OPEN;
 	tst_count++;
 
-	SAFE_WRITE(1, fd, fname, strlen(fname));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, fname, strlen(fname));
 	event_set[tst_count] = FAN_MODIFY;
 	tst_count++;
 
@@ -172,7 +172,7 @@ static void test_fanotify(unsigned int n)
 
 	SAFE_LSEEK(fd, 0, SEEK_SET);
 	/* Generate modify event to clear ignore mask */
-	SAFE_WRITE(1, fd, fname, 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, fname, 1);
 	event_set[tst_count] = FAN_MODIFY;
 	tst_count++;
 
@@ -204,7 +204,7 @@ static void test_fanotify(unsigned int n)
 	/* This event should be ignored */
 	fd = SAFE_OPEN(fname, O_RDWR);
 
-	SAFE_WRITE(1, fd, fname, 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, fname, 1);
 	event_set[tst_count] = FAN_MODIFY;
 	tst_count++;
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index 9132e1a74737..3321e55264b6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -58,7 +58,7 @@ static void test01(void)
 	event_set[tst_count] = FAN_OPEN;
 	tst_count++;
 
-	SAFE_WRITE(1, fd, fname, strlen(fname));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, fname, strlen(fname));
 	event_set[tst_count] = FAN_MODIFY;
 	tst_count++;
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index a3b9d5c375c3..0bd61587a9eb 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -133,7 +133,7 @@ static void generate_events(void)
 	 */
 	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
 
-	SAFE_WRITE(0, fd, fname, 1);
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, fname, 1);
 	SAFE_LSEEK(fd, 0, SEEK_SET);
 
 	if (read(fd, buf, BUF_SIZE) != -1)
@@ -295,7 +295,7 @@ static void test_fanotify(unsigned int n)
 
 			resp.fd = event->fd;
 			resp.response = event_set[test_num].response;
-			SAFE_WRITE(1, fd_notify, &resp, sizeof(resp));
+			SAFE_WRITE(SAFE_WRITE_ALL, fd_notify, &resp, sizeof(resp));
 		}
 
 		i += event->event_len;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index 1d3c0802362a..396c8490eeda 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -146,7 +146,7 @@ static void loose_fanotify_events(void)
 			/* Write response to permission event */
 			resp.fd = event.fd;
 			resp.response = FAN_ALLOW;
-			SAFE_WRITE(1, fd_notify, &resp, sizeof(resp));
+			SAFE_WRITE(SAFE_WRITE_ALL, fd_notify, &resp, sizeof(resp));
 		} else {
 			not_responded++;
 		}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index d33e945adfab..d45270a9a06e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -336,7 +336,7 @@ static void do_test(unsigned int number)
 	if (report_target_fid)
 		child_fid = &file_fid;
 
-	SAFE_WRITE(1, fd, "1", 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, "1", 1);
 	SAFE_RENAME(fname1, fname2);
 
 	SAFE_CLOSE(fd);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify19.c b/testcases/kernel/syscalls/fanotify/fanotify19.c
index ec5b54bcd6e5..63fc4ee0c0a2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify19.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify19.c
@@ -111,7 +111,7 @@ static void generate_events(void)
 	SAFE_READ(0, fd, buf, BUF_SIZE);
 
 	/* FAN_MODIFY */
-	SAFE_WRITE(1, fd, TEST_FILE, 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, TEST_FILE, 1);
 
 	/* FAN_CLOSE */
 	SAFE_CLOSE(fd);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl11.c b/testcases/kernel/syscalls/fcntl/fcntl11.c
index 2de2b6c5b50f..b66fa84213d7 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl11.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl11.c
@@ -100,7 +100,7 @@ void setup(void)
 	if ((fd = mkstemp(template)) < 0)
 		tst_resm(TFAIL, "Couldn't open temp file! errno = %d", errno);
 
-	SAFE_WRITE(cleanup, 0, fd, buf, STRINGSIZE);
+	SAFE_WRITE(cleanup, SAFE_WRITE_ANY, fd, buf, STRINGSIZE);
 
 	memset(&act, 0, sizeof(act));
 	act.sa_handler = catch_child;
@@ -203,7 +203,7 @@ char *str_type(int type)
 
 void parent_put(struct flock *l)
 {
-	SAFE_WRITE(cleanup, 1, parent_pipe[1], l, sizeof(*l));
+	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, parent_pipe[1], l, sizeof(*l));
 }
 
 void parent_get(struct flock *l)
@@ -213,7 +213,7 @@ void parent_get(struct flock *l)
 
 void child_put(struct flock *l)
 {
-	SAFE_WRITE(NULL, 1, child_pipe[1], l, sizeof(*l));
+	SAFE_WRITE(NULL, SAFE_WRITE_ALL, child_pipe[1], l, sizeof(*l));
 }
 
 void child_get(struct flock *l)
diff --git a/testcases/kernel/syscalls/fcntl/fcntl15.c b/testcases/kernel/syscalls/fcntl/fcntl15.c
index 82dee4b21ee2..8c17144fb2fa 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl15.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl15.c
@@ -124,7 +124,7 @@ static void do_test(int file_flag, int file_mode, int dup_flag)
 static int run_test(int file_flag, int file_mode, int dup_flag)
 {
 	fd[0] = SAFE_OPEN(tmpname, file_flag, file_mode);
-	SAFE_WRITE(1, fd[0], DATA, 10);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd[0], DATA, 10);
 
 	switch (dup_flag) {
 	case FORK_:
diff --git a/testcases/kernel/syscalls/fcntl/fcntl20.c b/testcases/kernel/syscalls/fcntl/fcntl20.c
index 99fd78313fae..b671af8a9bea 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl20.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl20.c
@@ -104,7 +104,7 @@ void setup(void)
 	if ((fd = mkstemp(template)) == -1)
 		tst_resm(TFAIL | TERRNO, "mkstemp failed");
 
-	SAFE_WRITE(cleanup, 0, fd, buf, STRINGSIZE);
+	SAFE_WRITE(cleanup, SAFE_WRITE_ANY, fd, buf, STRINGSIZE);
 
 	memset(&act, 0, sizeof(act));
 	act.sa_handler = catch_child;
diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
index 3442114ffb17..bdd8f60d3c6a 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl34.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -65,7 +65,7 @@ void *thread_fn_01(void *arg)
 		my_fcntl(fd, F_OFD_SETLKW, &lck);
 
 		SAFE_LSEEK(fd, 0, SEEK_END);
-		SAFE_WRITE(1, fd, buf, write_size);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, write_size);
 
 		lck.l_type = F_UNLCK;
 		my_fcntl(fd, F_OFD_SETLKW, &lck);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
index d6b07fc41abe..f4ce2a8861fb 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl36.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -87,7 +87,7 @@ static void *fn_ofd_w(void *arg)
 		my_fcntl(fd, F_OFD_SETLKW, &lck);
 
 		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
-		SAFE_WRITE(1, fd, buf, pa->length);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, pa->length);
 
 		lck.l_type = F_UNLCK;
 		my_fcntl(fd, F_OFD_SETLKW, &lck);
@@ -126,7 +126,7 @@ static void *fn_posix_w(void *arg)
 		SAFE_FCNTL(fd, F_SETLKW, &lck);
 
 		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
-		SAFE_WRITE(1, fd, buf, pa->length);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, pa->length);
 
 		lck.l_type = F_UNLCK;
 		SAFE_FCNTL(fd, F_SETLKW, &lck);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl37.c b/testcases/kernel/syscalls/fcntl/fcntl37.c
index a624554c5507..36f462954f19 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl37.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl37.c
@@ -67,7 +67,7 @@ static void setup(void)
 
 	wrbuf = SAFE_MALLOC(orig_value);
 	memset(wrbuf, 'x', orig_value);
-	SAFE_WRITE(1, fds[1], wrbuf, orig_value);
+	SAFE_WRITE(SAFE_WRITE_ALL, fds[1], wrbuf, orig_value);
 	free(wrbuf);
 
 	SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &sys_value);
diff --git a/testcases/kernel/syscalls/fsync/fsync01.c b/testcases/kernel/syscalls/fsync/fsync01.c
index 4e2281b05517..072245fc83ca 100644
--- a/testcases/kernel/syscalls/fsync/fsync01.c
+++ b/testcases/kernel/syscalls/fsync/fsync01.c
@@ -20,7 +20,7 @@ static void verify_fsync(void)
 	unsigned int i;
 
 	for (i = 0; i < 10; i++) {
-		SAFE_WRITE(1, fd, BUF, sizeof(BUF));
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, BUF, sizeof(BUF));
 
 		TEST(fsync(fd));
 
diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
index 55c7a71c1d65..c9de5c7296fe 100644
--- a/testcases/kernel/syscalls/fsync/fsync02.c
+++ b/testcases/kernel/syscalls/fsync/fsync02.c
@@ -53,7 +53,7 @@ static void setup(void) {
 
 #ifdef LARGEFILE
 	SAFE_FCNTL(fd, F_SETFL, O_LARGEFILE);
-	SAFE_WRITE(1, fd, pbuf, BUF_SIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, pbuf, BUF_SIZE);
 #endif
 }
 
@@ -74,7 +74,7 @@ static void run(void) {
 		offset = i * ((BLOCKSIZE * max_block) / data_blocks);
 		offset -= BUF_SIZE;
 		SAFE_LSEEK(fd, offset, SEEK_SET);
-		SAFE_WRITE(1, fd, pbuf, BUF_SIZE);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, pbuf, BUF_SIZE);
 	}
 	time_start = time(0);
 
diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index 15dc5b569e45..c83ff45a1c8e 100644
--- a/testcases/kernel/syscalls/inotify/inotify05.c
+++ b/testcases/kernel/syscalls/inotify/inotify05.c
@@ -52,7 +52,7 @@ void verify_inotify(void)
 		SAFE_LSEEK(fd, 0, SEEK_SET);
 		SAFE_READ(1, fd, buf, BUF_SIZE);
 		SAFE_LSEEK(fd, 0, SEEK_SET);
-		SAFE_WRITE(1, fd, buf, BUF_SIZE);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, BUF_SIZE);
 	}
 
 	SAFE_CLOSE(fd);
@@ -125,7 +125,7 @@ static void setup(void)
 {
 	sprintf(fname, "tfile_%d", getpid());
 	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
-	SAFE_WRITE(1, fd, buf, BUF_SIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, BUF_SIZE);
 	SAFE_CLOSE(fd);
 
 	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index a187507949a4..4ce8e51da931 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -46,7 +46,7 @@ static void *write_seek(void *unused)
 
 	while (tst_fzsync_run_b(&fzsync_pair)) {
 		tst_fzsync_start_race_b(&fzsync_pair);
-		SAFE_WRITE(0, fd, buf, sizeof(buf));
+		SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, sizeof(buf));
 		SAFE_LSEEK(fd, 0, SEEK_SET);
 		tst_fzsync_end_race_b(&fzsync_pair);
 	}
diff --git a/testcases/kernel/syscalls/inotify/inotify12.c b/testcases/kernel/syscalls/inotify/inotify12.c
index f63c33d50203..e658f4ae7298 100644
--- a/testcases/kernel/syscalls/inotify/inotify12.c
+++ b/testcases/kernel/syscalls/inotify/inotify12.c
@@ -89,7 +89,7 @@ static void verify_inotify(unsigned int n)
 	}
 
 	fd = SAFE_OPEN(TEST_FILE, O_RDWR);
-	SAFE_WRITE(1, fd, "2", 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, "2", 1);
 
 	/*
 	 * Read the 1st IN_MODIFY event
@@ -111,7 +111,7 @@ static void verify_inotify(unsigned int n)
 	 * was already generated.
 	 */
 	SAFE_UNLINK(TEST_FILE);
-	SAFE_WRITE(1, fd, "3", 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, "3", 1);
 	SAFE_CLOSE(fd);
 
 	/*
diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
index f7d11815dbe0..b877bf2ad304 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl08.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -55,8 +55,8 @@ static void verify_ioctl(unsigned int n)
 	fd_src  = SAFE_OPEN(FILE_SRC_PATH,  O_RDWR | O_CREAT, 0664);
 	fd_dest = SAFE_OPEN(FILE_DEST_PATH, O_RDWR | O_CREAT, 0664);
 
-	SAFE_WRITE(1, fd_src,  tc->src_fcontents,  strlen(tc->src_fcontents));
-	SAFE_WRITE(1, fd_dest, tc->dest_fcontents, strlen(tc->dest_fcontents));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_src,  tc->src_fcontents,  strlen(tc->src_fcontents));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_dest, tc->dest_fcontents, strlen(tc->dest_fcontents));
 
 	memset(fdr, 0, sizeof(struct file_dedupe_range) +
 			sizeof(struct file_dedupe_range_info));
diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
index 70feb6b037d3..044a275ae8c5 100644
--- a/testcases/kernel/syscalls/linkat/linkat01.c
+++ b/testcases/kernel/syscalls/linkat/linkat01.c
@@ -249,7 +249,8 @@ static void mylinkat_test(struct test_struct *desc)
 			int tnum = rand(), vnum = ~tnum;
 			fd = SAFE_OPEN(cleanup, desc->referencefn1,
 				       O_RDWR);
-			SAFE_WRITE(cleanup, 1, fd, &tnum, sizeof(tnum));
+			SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, &tnum,
+				sizeof(tnum));
 			SAFE_CLOSE(cleanup, fd);
 
 			fd = SAFE_OPEN(cleanup, desc->referencefn2,
diff --git a/testcases/kernel/syscalls/llseek/llseek01.c b/testcases/kernel/syscalls/llseek/llseek01.c
index 50f35493dc81..f5a94d7bf51c 100644
--- a/testcases/kernel/syscalls/llseek/llseek01.c
+++ b/testcases/kernel/syscalls/llseek/llseek01.c
@@ -70,7 +70,7 @@ static void setup(void)
 
 	fildes = SAFE_OPEN(TEMP_FILE, O_RDWR | O_CREAT, FILE_MODE);
 
-	SAFE_WRITE(1, fildes, write_buff, BUFSIZ);
+	SAFE_WRITE(SAFE_WRITE_ALL, fildes, write_buff, BUFSIZ);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/llseek/llseek03.c b/testcases/kernel/syscalls/llseek/llseek03.c
index d780f2af628e..e3d4716a8fa0 100644
--- a/testcases/kernel/syscalls/llseek/llseek03.c
+++ b/testcases/kernel/syscalls/llseek/llseek03.c
@@ -30,7 +30,7 @@ static void setup(void)
 
 	fd = SAFE_CREAT(TEST_FILE, 0644);
 
-	SAFE_WRITE(1, fd, STR, sizeof(STR) - 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, STR, sizeof(STR) - 1);
 
 	SAFE_CLOSE(fd);
 }
diff --git a/testcases/kernel/syscalls/lseek/lseek01.c b/testcases/kernel/syscalls/lseek/lseek01.c
index 22d9fbfd7d25..dcf0e11c52d2 100644
--- a/testcases/kernel/syscalls/lseek/lseek01.c
+++ b/testcases/kernel/syscalls/lseek/lseek01.c
@@ -72,7 +72,7 @@ static void setup(void)
 {
 	fd = SAFE_OPEN(TFILE, O_RDWR | O_CREAT, 0644);
 
-	SAFE_WRITE(1, fd, WRITE_STR, sizeof(WRITE_STR) - 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, WRITE_STR, sizeof(WRITE_STR) - 1);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/lseek/lseek07.c b/testcases/kernel/syscalls/lseek/lseek07.c
index ae6f48f3714e..c258a33a8904 100644
--- a/testcases/kernel/syscalls/lseek/lseek07.c
+++ b/testcases/kernel/syscalls/lseek/lseek07.c
@@ -54,7 +54,7 @@ static void verify_lseek(unsigned int n)
 		return;
 	}
 
-	SAFE_WRITE(1, *tc->fd, WR_STR2, sizeof(WR_STR2) - 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, *tc->fd, WR_STR2, sizeof(WR_STR2) - 1);
 
 	SAFE_CLOSE(*tc->fd);
 
@@ -76,8 +76,8 @@ static void setup(void)
 	fd1 = SAFE_OPEN(TFILE1, O_RDWR | O_CREAT, 0644);
 	fd2 = SAFE_OPEN(TFILE2, O_RDWR | O_CREAT, 0644);
 
-	SAFE_WRITE(1, fd1, WR_STR1, sizeof(WR_STR1) - 1);
-	SAFE_WRITE(1, fd2, WR_STR1, sizeof(WR_STR1) - 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd1, WR_STR1, sizeof(WR_STR1) - 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd2, WR_STR1, sizeof(WR_STR1) - 1);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/lseek/lseek11.c b/testcases/kernel/syscalls/lseek/lseek11.c
index 14435f617094..ea51bae3a958 100644
--- a/testcases/kernel/syscalls/lseek/lseek11.c
+++ b/testcases/kernel/syscalls/lseek/lseek11.c
@@ -145,7 +145,7 @@ static void write_data(int fd, int num)
 	char buf[64];
 
 	sprintf(buf, "data%02dsuffix", num);
-	SAFE_WRITE(1, fd, buf, strlen(buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, strlen(buf));
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index de5daf34a259..cf2dd7cb947e 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -70,7 +70,7 @@ static void setup(void)
 
 	/* Writing 40 KB of random data into this file [32 * 1280 = 40960] */
 	for (i = 0; i < 1280; i++)
-		SAFE_WRITE(1, fd, STR, strlen(STR));
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, STR, strlen(STR));
 
 	SAFE_FSTAT(fd, &st);
 
diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index bbc99e8aff7c..29e0ace0049f 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -142,7 +142,7 @@ static void setup(void)
 
 	/* Writing 16 pages of random data into this file */
 	for (i = 0; i < (pagesize / 2); i++)
-		SAFE_WRITE(1, fd, STR, sizeof(STR) - 1);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, STR, sizeof(STR) - 1);
 
 	SAFE_FSTAT(fd, &st);
 
diff --git a/testcases/kernel/syscalls/mincore/mincore01.c b/testcases/kernel/syscalls/mincore/mincore01.c
index 1632c72abc8b..e2dfe04cf4d6 100644
--- a/testcases/kernel/syscalls/mincore/mincore01.c
+++ b/testcases/kernel/syscalls/mincore/mincore01.c
@@ -175,7 +175,7 @@ static void setup(void)
 	fd = SAFE_OPEN(cleanup, "mincore01", O_CREAT | O_RDWR,
 		       S_IRUSR | S_IWUSR);
 
-	SAFE_WRITE(cleanup, 1, fd, buf, global_len);
+	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, buf, global_len);
 
 	free(buf);
 
diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index a5d041ac3eef..4e0d8a3f4249 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -55,7 +55,7 @@ static void do_child(void)
 	childfd = SAFE_OPEN(FILE_CHILD, O_RDWR | O_CREAT, 0666);
 
 	memset(buf, 'a', FS_BLOCKSIZE);
-	SAFE_WRITE(1, childfd, buf, FS_BLOCKSIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, childfd, buf, FS_BLOCKSIZE);
 
 	/*
 	 * In case mremap() may fail because that memory area can not be
diff --git a/testcases/kernel/syscalls/mmap/mmap17.c b/testcases/kernel/syscalls/mmap/mmap17.c
index 0001c3794f6f..a8136a0b2d29 100644
--- a/testcases/kernel/syscalls/mmap/mmap17.c
+++ b/testcases/kernel/syscalls/mmap/mmap17.c
@@ -61,11 +61,11 @@ static void test_mmap(void)
 
 	str_len = strlen(str);
 
-	SAFE_WRITE(1, fd_file1, str, str_len);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_file1, str, str_len);
 	mapped_address = SAFE_MMAP(NULL, str_len, PROT_WRITE,
 				   MAP_PRIVATE, fd_file1, 0);
 
-	SAFE_WRITE(1, fd_file2, str, str_len);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_file2, str, str_len);
 
 	address = mmap(mapped_address, str_len, PROT_WRITE,
 		  MAP_PRIVATE | MAP_FIXED_NOREPLACE, fd_file2, 0);
diff --git a/testcases/kernel/syscalls/mmap/mmap19.c b/testcases/kernel/syscalls/mmap/mmap19.c
index 734a3a23ea4c..90b3f45b1f63 100644
--- a/testcases/kernel/syscalls/mmap/mmap19.c
+++ b/testcases/kernel/syscalls/mmap/mmap19.c
@@ -72,8 +72,8 @@ static void setup(void)
 	f1 = SAFE_OPEN(tmp1, O_RDWR | O_CREAT, S_IREAD | S_IWRITE);
 	f2 = SAFE_OPEN(tmp2, O_RDWR | O_CREAT, S_IREAD | S_IWRITE);
 
-	SAFE_WRITE(1, f1, str1, strlen(str1));
-	SAFE_WRITE(1, f2, str2, strlen(str2));
+	SAFE_WRITE(SAFE_WRITE_ALL, f1, str1, strlen(str1));
+	SAFE_WRITE(SAFE_WRITE_ALL, f2, str2, strlen(str2));
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
index a79c194cae2c..af282bba7b03 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect02.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
@@ -80,7 +80,8 @@ int main(int ac, char **av)
 			bytes_to_write = MIN(strlen(buf), num_bytes);
 
 			num_bytes -=
-			    SAFE_WRITE(cleanup, 1, fd, buf, bytes_to_write);
+			    SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, buf,
+				bytes_to_write);
 
 		} while (0 < num_bytes);
 
diff --git a/testcases/kernel/syscalls/mprotect/mprotect03.c b/testcases/kernel/syscalls/mprotect/mprotect03.c
index 28f54c9ae45a..ed0c1a7dea0c 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect03.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect03.c
@@ -79,7 +79,7 @@ int main(int ac, char **av)
 		if ((fd = open(file1, O_RDWR | O_CREAT, 0777)) < 0)
 			tst_brkm(TBROK, cleanup, "open failed");
 
-		SAFE_WRITE(cleanup, 1, fd, buf, strlen(buf));
+		SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, buf, strlen(buf));
 
 		/*
 		 * mmap the PAGESIZE bytes as read only.
diff --git a/testcases/kernel/syscalls/msync/msync03.c b/testcases/kernel/syscalls/msync/msync03.c
index f504ed13064e..f79458b9bef3 100644
--- a/testcases/kernel/syscalls/msync/msync03.c
+++ b/testcases/kernel/syscalls/msync/msync03.c
@@ -116,7 +116,7 @@ static void setup(void)
 
 	memset(write_buf, 'a', BUF_SIZE);
 	while (nwrite < page_sz) {
-		SAFE_WRITE(cleanup, 1, fd, write_buf, BUF_SIZE);
+		SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, write_buf, BUF_SIZE);
 		nwrite += BUF_SIZE;
 	}
 
diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 4a564a3d1d25..abe8f16594f7 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -49,7 +49,7 @@ static void test_msync(void)
 
 	test_fd = SAFE_OPEN("msync04/testfile", O_CREAT | O_TRUNC | O_RDWR,
 		0644);
-	SAFE_WRITE(0, test_fd, STRING_TO_WRITE, sizeof(STRING_TO_WRITE) - 1);
+	SAFE_WRITE(SAFE_WRITE_ANY, test_fd, STRING_TO_WRITE, sizeof(STRING_TO_WRITE) - 1);
 	mmaped_area = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
 			MAP_SHARED, test_fd, 0);
 	SAFE_CLOSE(test_fd);
diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index bdf29a9a86e2..02ef5b5b0285 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -128,7 +128,8 @@ static void test_append(void)
 	}
 
 	len1 = SAFE_LSEEK(cleanup, TEST_RETURN, 0, SEEK_CUR);
-	SAFE_WRITE(cleanup, 1, TEST_RETURN, TEST_FILE, sizeof(TEST_FILE));
+	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, TEST_RETURN, TEST_FILE,
+		sizeof(TEST_FILE));
 	len2 = SAFE_LSEEK(cleanup, TEST_RETURN, 0, SEEK_CUR);
 	SAFE_CLOSE(cleanup, TEST_RETURN);
 
@@ -242,7 +243,8 @@ static void test_largefile(void)
 	if (offset == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "lseek64 failed");
 
-	SAFE_WRITE(cleanup, 1, fd, LARGE_FILE, sizeof(LARGE_FILE));
+	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, LARGE_FILE,
+		sizeof(LARGE_FILE));
 
 	SAFE_CLOSE(cleanup, fd);
 
diff --git a/testcases/kernel/syscalls/open/open14.c b/testcases/kernel/syscalls/open/open14.c
index f78a3643ce58..3ecb7e4fb74d 100644
--- a/testcases/kernel/syscalls/open/open14.c
+++ b/testcases/kernel/syscalls/open/open14.c
@@ -65,7 +65,7 @@ static void write_file(int fd)
 	int i;
 
 	for (i = 0; i < blocks_num; ++i)
-		SAFE_WRITE(cleanup, 1, fd, buf, size);
+		SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, buf, size);
 }
 
 void test01(void)
diff --git a/testcases/kernel/syscalls/openat/openat02.c b/testcases/kernel/syscalls/openat/openat02.c
index 2ce119033113..b0a6ff78f66b 100644
--- a/testcases/kernel/syscalls/openat/openat02.c
+++ b/testcases/kernel/syscalls/openat/openat02.c
@@ -126,7 +126,7 @@ void testfunc_append(void)
 		return;
 	}
 
-	SAFE_WRITE(cleanup, 1, TEST_RETURN, STR, sizeof(STR) - 1);
+	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, TEST_RETURN, STR, sizeof(STR) - 1);
 
 	file_offset = SAFE_LSEEK(cleanup, TEST_RETURN, 0, SEEK_CUR);
 
@@ -202,7 +202,7 @@ void testfunc_largefile(void)
 	if (offset == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "lseek64 failed");
 
-	SAFE_WRITE(cleanup, 1, fd, STR, sizeof(STR) - 1);
+	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, STR, sizeof(STR) - 1);
 
 	SAFE_CLOSE(cleanup, fd);
 
diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
index 2846fd07fa44..90bcff5d7abf 100644
--- a/testcases/kernel/syscalls/openat/openat03.c
+++ b/testcases/kernel/syscalls/openat/openat03.c
@@ -76,7 +76,7 @@ static void write_file(int fd)
 	int i;
 
 	for (i = 0; i < blocks_num; ++i)
-		SAFE_WRITE(cleanup, 1, fd, buf, size);
+		SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, buf, size);
 }
 
 void test01(void)
diff --git a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
index 50def035b547..60cf6702d10b 100644
--- a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
+++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
@@ -35,7 +35,7 @@ static void do_child(void)
 
 	SAFE_CLOSE(fds[0]);
 	fd = SAFE_CREAT(TESTFILE, 0644);
-	SAFE_WRITE(1, fds[1], &fd, sizeof(fd));
+	SAFE_WRITE(SAFE_WRITE_ALL, fds[1], &fd, sizeof(fd));
 	TST_CHECKPOINT_WAIT(0);
 	SAFE_CLOSE(fd);
 	SAFE_CLOSE(fds[1]);
diff --git a/testcases/kernel/syscalls/pipe/pipe01.c b/testcases/kernel/syscalls/pipe/pipe01.c
index 8767cf450cfa..05ab7491f936 100644
--- a/testcases/kernel/syscalls/pipe/pipe01.c
+++ b/testcases/kernel/syscalls/pipe/pipe01.c
@@ -28,7 +28,7 @@ static void verify_pipe(void)
 		return;
 	}
 
-	wr_size = SAFE_WRITE(1, fds[1], wrbuf, sizeof(wrbuf));
+	wr_size = SAFE_WRITE(SAFE_WRITE_ALL, fds[1], wrbuf, sizeof(wrbuf));
 	rd_size = SAFE_READ(0, fds[0], rdbuf, sizeof(rdbuf));
 
 	if (rd_size != wr_size) {
diff --git a/testcases/kernel/syscalls/pipe/pipe02.c b/testcases/kernel/syscalls/pipe/pipe02.c
index bf81c1899de6..2247037b1fc7 100644
--- a/testcases/kernel/syscalls/pipe/pipe02.c
+++ b/testcases/kernel/syscalls/pipe/pipe02.c
@@ -25,11 +25,11 @@ static void do_child(void)
 {
 	SAFE_SIGNAL(SIGPIPE, SIG_DFL);
 	SAFE_CLOSE(fd[0]);
-	SAFE_WRITE(1, fd[1], wrbuf, SIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd[1], wrbuf, SIZE);
 
 	TST_CHECKPOINT_WAIT(0);
 
-	SAFE_WRITE(1, fd[1], wrbuf, SIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd[1], wrbuf, SIZE);
 	exit(0);
 }
 
diff --git a/testcases/kernel/syscalls/pipe/pipe11.c b/testcases/kernel/syscalls/pipe/pipe11.c
index 771709161f3b..4280f1ebad8f 100644
--- a/testcases/kernel/syscalls/pipe/pipe11.c
+++ b/testcases/kernel/syscalls/pipe/pipe11.c
@@ -77,7 +77,7 @@ static void run(unsigned int tcase)
 
 	SAFE_PIPE(fds);
 
-	SAFE_WRITE(1, fds[1], buf, read_per_child * nchilds);
+	SAFE_WRITE(SAFE_WRITE_ALL, fds[1], buf, read_per_child * nchilds);
 
 	for (i = 0; i < nchilds; i++) {
 		pid = SAFE_FORK();
diff --git a/testcases/kernel/syscalls/pipe/pipe12.c b/testcases/kernel/syscalls/pipe/pipe12.c
index f5240401a076..e186035ec4ed 100644
--- a/testcases/kernel/syscalls/pipe/pipe12.c
+++ b/testcases/kernel/syscalls/pipe/pipe12.c
@@ -44,7 +44,7 @@ static void verify_pipe(unsigned int n)
 
 	tst_res(TINFO, "%s", tc->message);
 	if (tc->full_flag) {
-		SAFE_WRITE(1, fds[1], wrbuf, max_size);
+		SAFE_WRITE(SAFE_WRITE_ALL, fds[1], wrbuf, max_size);
 		TEST(write(fds[1], "x", 1));
 		if (TST_RET != -1) {
 			tst_res(TFAIL, "write succeeded unexpectedly");
@@ -55,7 +55,7 @@ static void verify_pipe(unsigned int n)
 		else
 			tst_res(TFAIL | TTERRNO, "write failed, expected EAGAIN but got");
 	} else {
-		SAFE_WRITE(1, fds[1], "x", tc->offset);
+		SAFE_WRITE(SAFE_WRITE_ALL, fds[1], "x", tc->offset);
 		TEST(write(fds[1], wrbuf, invalid_size));
 		if (TST_RET == -1) {
 			tst_res(TFAIL, "write failed unexpectedly");
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_04.c b/testcases/kernel/syscalls/pipe2/pipe2_04.c
index 37894351f300..45e0f075b950 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_04.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_04.c
@@ -43,7 +43,7 @@ static void test_pipe2(void)
 	pid = SAFE_FORK();
 	if (!pid) {
 		SAFE_FCNTL(fds[1], F_SETFL, flags & ~O_NONBLOCK);
-		SAFE_WRITE(1, fds[1], "x", 1);
+		SAFE_WRITE(SAFE_WRITE_ALL, fds[1], "x", 1);
 	}
 
 	if (TST_PROCESS_STATE_WAIT(pid, 'S', 1000) < 0)
@@ -84,7 +84,7 @@ static void setup(void)
 
 	write_buffer = SAFE_MALLOC(pipe_size);
 	memset(write_buffer, 'x', pipe_size);
-	SAFE_WRITE(1, fds[1], write_buffer, pipe_size);
+	SAFE_WRITE(SAFE_WRITE_ALL, fds[1], write_buffer, pipe_size);
 	free(write_buffer);
 }
 
diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index b47e7006bac9..0159822e1e75 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -59,7 +59,7 @@ static void setup(void)
 
 	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0664);
 	for (i = 0; i < 128; i++)
-		SAFE_WRITE(1, fd, STR, strlen(STR));
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, STR, strlen(STR));
 
 	SAFE_CLOSE(fd);
 }
diff --git a/testcases/kernel/syscalls/poll/poll01.c b/testcases/kernel/syscalls/poll/poll01.c
index 11665c404f1f..b05e809ab305 100644
--- a/testcases/kernel/syscalls/poll/poll01.c
+++ b/testcases/kernel/syscalls/poll/poll01.c
@@ -51,7 +51,7 @@ static void verify_pollin(void)
 		{.fd = fildes[0], .events = POLLIN},
 	};
 
-	SAFE_WRITE(1, fildes[1], write_buf, sizeof(write_buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, fildes[1], write_buf, sizeof(write_buf));
 
 	TEST(poll(infds, 1, -1));
 
diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
index 2f7e9a1acbf0..b9f4c2a106c5 100644
--- a/testcases/kernel/syscalls/prctl/prctl04.c
+++ b/testcases/kernel/syscalls/prctl/prctl04.c
@@ -135,7 +135,7 @@ static void check_strict_mode(int val)
 		tst_res(TFAIL, "prctl(PR_GET_SECCOMP) succeed unexpectedly");
 	break;
 	case 2:
-		SAFE_WRITE(1, fd, "a", 1);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, "a", 1);
 		SAFE_READ(0, fd, buf, 1);
 		tst_res(TPASS,
 			"SECCOMP_MODE_STRICT permits read(2) write(2) and _exit(2)");
diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
index 5fa011ef218b..04c7d0371aed 100644
--- a/testcases/kernel/syscalls/pread/pread02.c
+++ b/testcases/kernel/syscalls/pread/pread02.c
@@ -48,7 +48,7 @@ static void verify_pread(unsigned int n)
 static void setup(void)
 {
 	SAFE_PIPE(pipe_fd);
-	SAFE_WRITE(1, pipe_fd[1], "x", 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, pipe_fd[1], "x", 1);
 
 	fd = SAFE_OPEN(PREAD_TEMPFILE, O_RDWR | O_CREAT, 0666);
 
diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index 95431bc60730..4b257968dec3 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
@@ -88,10 +88,10 @@ void setup(void)
 	fd = SAFE_OPEN("file", O_RDWR | O_CREAT, 0644);
 
 	memset(buf, 'a', sizeof(buf));
-	SAFE_WRITE(1, fd, buf, sizeof(buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, sizeof(buf));
 
 	memset(buf, 'b', sizeof(buf));
-	SAFE_WRITE(1, fd, buf, sizeof(buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, sizeof(buf));
 }
 
 void cleanup(void)
diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
index 59c3b84f7a4d..00b25c5491b7 100644
--- a/testcases/kernel/syscalls/preadv/preadv03.c
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -108,10 +108,10 @@ static void setup(void)
 
 	pop_buf = SAFE_MEMALIGN(blksz, blksz);
 	memset(pop_buf, 0x61, blksz);
-	SAFE_WRITE(1, fd, pop_buf, blksz);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, pop_buf, blksz);
 
 	memset(pop_buf, 0x62, blksz);
-	SAFE_WRITE(1, fd, pop_buf, blksz);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, pop_buf, blksz);
 
 	rd_iovec[0].iov_base = SAFE_MEMALIGN(blksz, blksz);
 	rd_iovec[0].iov_len = blksz;
diff --git a/testcases/kernel/syscalls/preadv2/preadv201.c b/testcases/kernel/syscalls/preadv2/preadv201.c
index 91e2b9889637..110977290d14 100644
--- a/testcases/kernel/syscalls/preadv2/preadv201.c
+++ b/testcases/kernel/syscalls/preadv2/preadv201.c
@@ -98,10 +98,10 @@ static void setup(void)
 	fd = SAFE_OPEN("file", O_RDWR | O_CREAT, 0644);
 
 	memset(buf, 'a', sizeof(buf));
-	SAFE_WRITE(1, fd, buf, sizeof(buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, sizeof(buf));
 
 	memset(buf, 'b', sizeof(buf));
-	SAFE_WRITE(1, fd, buf, sizeof(buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, sizeof(buf));
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/pwrite/pwrite01.c b/testcases/kernel/syscalls/pwrite/pwrite01.c
index c517ec2074b7..8f7ad2fb84aa 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite01.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite01.c
@@ -70,7 +70,7 @@ static void verify_pwrite(void)
 	l_seek(fildes, 0, SEEK_CUR, K1 / 2);
 	l_seek(fildes, K3, SEEK_SET, K3);
 
-	SAFE_WRITE(1, fildes, write_buf[3], K1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fildes, write_buf[3], K1);
 	l_seek(fildes, 0, SEEK_CUR, K4);
 
 	SAFE_PWRITE(1, fildes, write_buf[1], K1, K1);
diff --git a/testcases/kernel/syscalls/read/read01.c b/testcases/kernel/syscalls/read/read01.c
index 0bae2ee2fc15..68d6346c5347 100644
--- a/testcases/kernel/syscalls/read/read01.c
+++ b/testcases/kernel/syscalls/read/read01.c
@@ -28,7 +28,7 @@ static void setup(void)
 {
 	memset(buf, '*', SIZE);
 	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0700);
-	SAFE_WRITE(1, fd, buf, SIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, SIZE);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/read/read04.c b/testcases/kernel/syscalls/read/read04.c
index 47875c034137..154cbf47df58 100644
--- a/testcases/kernel/syscalls/read/read04.c
+++ b/testcases/kernel/syscalls/read/read04.c
@@ -49,7 +49,7 @@ static void setup(void)
 	int fd;
 
 	fd = SAFE_CREAT(fname, 0777);
-	SAFE_WRITE(1, fd, palfa, PALFA_LEN);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, palfa, PALFA_LEN);
 	SAFE_CLOSE(fd);
 }
 
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 02e866e8265c..3ed88c0057ca 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -133,7 +133,7 @@ static void create_testfile(int use_overlay)
 
 	fd = SAFE_CREAT(testfile, 0644);
 	for (i = 0; i < testfile_size; i += pagesize)
-		SAFE_WRITE(1, fd, tmp, pagesize);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, tmp, pagesize);
 	SAFE_FSYNC(fd);
 	SAFE_CLOSE(fd);
 	free(tmp);
diff --git a/testcases/kernel/syscalls/readdir/readdir01.c b/testcases/kernel/syscalls/readdir/readdir01.c
index d200145eac99..1bf70fd1f8c1 100644
--- a/testcases/kernel/syscalls/readdir/readdir01.c
+++ b/testcases/kernel/syscalls/readdir/readdir01.c
@@ -34,7 +34,7 @@ static void setup(void)
 	for (i = 0; i < nfiles; i++) {
 		sprintf(fname, "%s_%d", prefix, i);
 		fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
-		SAFE_WRITE(1, fd, "hello\n", 6);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, "hello\n", 6);
 		SAFE_CLOSE(fd);
 	}
 }
diff --git a/testcases/kernel/syscalls/readv/readv01.c b/testcases/kernel/syscalls/readv/readv01.c
index 2bd3fd5eb97a..334faf388b9f 100644
--- a/testcases/kernel/syscalls/readv/readv01.c
+++ b/testcases/kernel/syscalls/readv/readv01.c
@@ -93,7 +93,7 @@ static void setup(void)
 	memset(buf, 0x42, sizeof(buf));
 
 	fd = SAFE_OPEN("data_file", O_WRONLY | O_CREAT | O_TRUNC, 0666);
-	SAFE_WRITE(1, fd, buf, sizeof(buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, sizeof(buf));
 	SAFE_CLOSE(fd);
 	fd = SAFE_OPEN("data_file", O_RDONLY);
 }
diff --git a/testcases/kernel/syscalls/select/select01.c b/testcases/kernel/syscalls/select/select01.c
index 4bf386160fb5..a90aeb897fe2 100644
--- a/testcases/kernel/syscalls/select/select01.c
+++ b/testcases/kernel/syscalls/select/select01.c
@@ -45,7 +45,7 @@ static void run(unsigned int n)
 	timeout.tv_usec = 100000;
 
 	if (tc->writefd) {
-		SAFE_WRITE(0, *tc->writefd, &buf, sizeof(buf));
+		SAFE_WRITE(SAFE_WRITE_ANY, *tc->writefd, &buf, sizeof(buf));
 		exp_ret++;
 	}
 
diff --git a/testcases/kernel/syscalls/sendfile/sendfile02.c b/testcases/kernel/syscalls/sendfile/sendfile02.c
index ffd654885b1d..8e88dec20f3b 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile02.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile02.c
@@ -44,7 +44,7 @@ static void setup(void)
 
 	fd = SAFE_CREAT(IN_FILE, 00700);
 	sprintf(buf, "abcdefghijklmnopqrstuvwxyz");
-	SAFE_WRITE(1, fd, buf, strlen(buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, strlen(buf));
 	SAFE_CLOSE(fd);
 
 	fd = SAFE_CREAT(OUT_FILE, 00700);
diff --git a/testcases/kernel/syscalls/sendfile/sendfile06.c b/testcases/kernel/syscalls/sendfile/sendfile06.c
index 6133be4d0bb4..2168da7279f8 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile06.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile06.c
@@ -31,7 +31,7 @@ static void setup(void)
 
 	fd = SAFE_CREAT(IN_FILE, 00700);
 	sprintf(buf, "abcdefghijklmnopqrstuvwxyz");
-	SAFE_WRITE(1, fd, buf, strlen(buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, strlen(buf));
 	SAFE_FSTAT(fd, &sb);
 	SAFE_CLOSE(fd);
 
diff --git a/testcases/kernel/syscalls/sendfile/sendfile08.c b/testcases/kernel/syscalls/sendfile/sendfile08.c
index 48a971bfbd0d..da334f1f593f 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile08.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile08.c
@@ -52,12 +52,12 @@ static void run(void)
 static void setup(void)
 {
 	in_fd = SAFE_CREAT(IN_FILE, 0700);
-	SAFE_WRITE(1, in_fd, TEST_MSG_IN, strlen(TEST_MSG_IN));
+	SAFE_WRITE(SAFE_WRITE_ALL, in_fd, TEST_MSG_IN, strlen(TEST_MSG_IN));
 	SAFE_CLOSE(in_fd);
 	in_fd = SAFE_OPEN(IN_FILE, O_RDONLY);
 
 	out_fd = SAFE_OPEN(OUT_FILE, O_TRUNC | O_CREAT | O_RDWR, 0777);
-	SAFE_WRITE(1, out_fd, TEST_MSG_OUT, strlen(TEST_MSG_OUT));
+	SAFE_WRITE(SAFE_WRITE_ALL, out_fd, TEST_MSG_OUT, strlen(TEST_MSG_OUT));
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
index 07c43eb592d3..66d5f31a90a2 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile09.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -51,7 +51,7 @@ static void setup(void)
 	fd = SAFE_CREAT(IN_FILE, 00700);
 	for (i = 1; i <= (4 * 1024); ++i) {
 		SAFE_LSEEK(fd, 1024 * 1024 - 1, SEEK_CUR);
-		SAFE_WRITE(1, fd, "C", 1);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, "C", 1);
 	}
 	SAFE_CLOSE(fd);
 
diff --git a/testcases/kernel/syscalls/splice/splice01.c b/testcases/kernel/syscalls/splice/splice01.c
index e1c60f556b50..82407743f6e9 100644
--- a/testcases/kernel/syscalls/splice/splice01.c
+++ b/testcases/kernel/syscalls/splice/splice01.c
@@ -89,7 +89,7 @@ static void setup(void)
 		buffer[i] = i & 0xff;
 
 	fd_in = SAFE_OPEN(TESTFILE1, O_WRONLY | O_CREAT | O_TRUNC, 0777);
-	SAFE_WRITE(1, fd_in, buffer, TEST_BLOCK_SIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_in, buffer, TEST_BLOCK_SIZE);
 	SAFE_CLOSE(fd_in);
 }
 
diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
index c81195102ec8..b29415a8adbe 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -140,7 +140,7 @@ static void run(void)
 		for (i = 0; i < size; i++)
 			buf[i] = get_letter(file_size - to_write + i);
 
-		written = SAFE_WRITE(1, pipe_fd[1], &buf, size);
+		written = SAFE_WRITE(SAFE_WRITE_ALL, pipe_fd[1], &buf, size);
 		to_write -= written;
 	}
 
diff --git a/testcases/kernel/syscalls/splice/splice03.c b/testcases/kernel/syscalls/splice/splice03.c
index 85bc1ba1ce9b..f3c135dee6e1 100644
--- a/testcases/kernel/syscalls/splice/splice03.c
+++ b/testcases/kernel/syscalls/splice/splice03.c
@@ -73,7 +73,7 @@ static void setup(void)
 
 	SAFE_PIPE(pipes);
 
-	SAFE_WRITE(1, pipes[1], STR, sizeof(STR) - 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, pipes[1], STR, sizeof(STR) - 1);
 }
 
 static void splice_verify(unsigned int n)
diff --git a/testcases/kernel/syscalls/splice/splice04.c b/testcases/kernel/syscalls/splice/splice04.c
index 1189afcde354..896f45839587 100644
--- a/testcases/kernel/syscalls/splice/splice04.c
+++ b/testcases/kernel/syscalls/splice/splice04.c
@@ -49,7 +49,7 @@ static void pipe_pipe(void)
 
 	SAFE_PIPE(pp1);
 	SAFE_PIPE(pp2);
-	SAFE_WRITE(1, pp1[1], arr_in, num_len_data);
+	SAFE_WRITE(SAFE_WRITE_ALL, pp1[1], arr_in, num_len_data);
 	for (i = num_len_data; i > 0; i = i - ret) {
 		ret = splice(pp1[0], NULL, pp2[1], NULL, i, 0);
 		if (ret == -1) {
diff --git a/testcases/kernel/syscalls/splice/splice05.c b/testcases/kernel/syscalls/splice/splice05.c
index 306f3c60efee..d77dc887e6a0 100644
--- a/testcases/kernel/syscalls/splice/splice05.c
+++ b/testcases/kernel/syscalls/splice/splice05.c
@@ -62,7 +62,7 @@ static void pipe_socket(void)
 	SAFE_PIPE(pp2);
 	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sv);
 
-	SAFE_WRITE(1, pp1[1], arr_in, num_len_data);
+	SAFE_WRITE(SAFE_WRITE_ALL, pp1[1], arr_in, num_len_data);
 	for (i = num_len_data; i > 0; i = i - ret) {
 		ret = splice(pp1[0], NULL, sv[0], 0, i, 0);
 		if (ret == -1) {
diff --git a/testcases/kernel/syscalls/stat/stat02.c b/testcases/kernel/syscalls/stat/stat02.c
index c330cfece6d1..a83bf8fac899 100644
--- a/testcases/kernel/syscalls/stat/stat02.c
+++ b/testcases/kernel/syscalls/stat/stat02.c
@@ -44,7 +44,7 @@ void verify(const char *fname, size_t bytes, size_t decrement)
 	fd = SAFE_OPEN(fname, O_CREAT | O_TRUNC | O_RDWR, 0777);
 	while (bytes > 0) {
 		for (i = 0; i < NUM_WRITES; i++) {
-			SAFE_WRITE(1, fd, buffer, bytes);
+			SAFE_WRITE(SAFE_WRITE_ALL, fd, buffer, bytes);
 			bytes_written += bytes;
 		}
 		bytes -= bytes > decrement ? decrement : bytes;
diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 98e1dfcda8ce..24c5e9758927 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -198,7 +198,7 @@ static void setup(void)
 	memset(data_buff, '@', sizeof(data_buff));
 
 	file_fd =  SAFE_OPEN(TESTFILE, O_RDWR|O_CREAT, MODE);
-	SAFE_WRITE(1, file_fd, data_buff, sizeof(data_buff));
+	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, data_buff, sizeof(data_buff));
 
 	SAFE_MKNOD(DEVICEFILE, S_IFBLK | 0777, makedev(MAJOR, MINOR));
 }
diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
index c96859f4483a..a8e868d7aab7 100644
--- a/testcases/kernel/syscalls/statx/statx02.c
+++ b/testcases/kernel/syscalls/statx/statx02.c
@@ -107,7 +107,7 @@ static void setup(void)
 	char data_buf[SIZE] = "LinusTorvalds";
 
 	file_fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, MODE);
-	SAFE_WRITE(0, file_fd, data_buf, sizeof(data_buf));
+	SAFE_WRITE(SAFE_WRITE_ANY, file_fd, data_buf, sizeof(data_buf));
 
 	SAFE_SYMLINK(TESTFILE, LINK_FILE);
 }
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index 58a7094f81ee..ce82b905bebd 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -67,7 +67,7 @@ static void write_file(void)
 {
 	char data[SIZE] = "hi";
 
-	SAFE_WRITE(0, fd, data, sizeof(data));
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, data, sizeof(data));
 }
 
 static void read_file(void)
diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
index 1687ea157750..711f10aec187 100644
--- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
+++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
@@ -183,7 +183,8 @@ static void mysymlinkat_test(struct test_struct *desc)
 			int tnum = rand(), vnum = ~tnum;
 
 			fd = SAFE_OPEN(cleanup, desc->referencefn1, O_RDWR);
-			SAFE_WRITE(cleanup, 1, fd, &tnum, sizeof(tnum));
+			SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, &tnum,
+				sizeof(tnum));
 			SAFE_CLOSE(cleanup, fd);
 
 			fd = SAFE_OPEN(cleanup, desc->referencefn2, O_RDONLY);
diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index cee6ed7d924d..dd4d8bfa5c2f 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -94,7 +94,7 @@ static void setup(void)
 		buffer[i] = i & 0xff;
 
 	fd_in = SAFE_OPEN(TESTFILE1, O_WRONLY | O_CREAT | O_TRUNC, 0777);
-	SAFE_WRITE(1, fd_in, buffer, TEST_BLOCK_SIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_in, buffer, TEST_BLOCK_SIZE);
 	SAFE_CLOSE(fd_in);
 }
 
diff --git a/testcases/kernel/syscalls/tee/tee02.c b/testcases/kernel/syscalls/tee/tee02.c
index 899e93e5f8ad..885877d1f705 100644
--- a/testcases/kernel/syscalls/tee/tee02.c
+++ b/testcases/kernel/syscalls/tee/tee02.c
@@ -46,7 +46,7 @@ static void setup(void)
 {
 	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0644);
 	SAFE_PIPE(pipes);
-	SAFE_WRITE(1, pipes[1], STR, sizeof(STR) - 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, pipes[1], STR, sizeof(STR) - 1);
 }
 
 static void tee_verify(unsigned int n)
diff --git a/testcases/kernel/syscalls/umount2/umount2_01.c b/testcases/kernel/syscalls/umount2/umount2_01.c
index 53817bf686bc..5696270d6ca4 100644
--- a/testcases/kernel/syscalls/umount2/umount2_01.c
+++ b/testcases/kernel/syscalls/umount2/umount2_01.c
@@ -117,7 +117,7 @@ static void umount2_verify(void)
 	 * check the old fd still points to the file
 	 * in previous mount point and is available
 	 */
-	SAFE_WRITE(cleanup, 1, fd, str, strlen(str));
+	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, str, strlen(str));
 
 	SAFE_CLOSE(cleanup, fd);
 
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice03.c b/testcases/kernel/syscalls/vmsplice/vmsplice03.c
index ae4ceaa9b7eb..622c11017db3 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice03.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice03.c
@@ -27,7 +27,7 @@ static void vmsplice_test(void)
 	memset(iov->iov_base, 0, iov->iov_len);
 
 	SAFE_PIPE(pipes);
-	SAFE_WRITE(1, pipes[1], buffer, TEST_BLOCK_SIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, pipes[1], buffer, TEST_BLOCK_SIZE);
 	written = vmsplice(pipes[0], iov, 1, 0);
 
 	if (written < 0)
diff --git a/testcases/kernel/syscalls/write/write03.c b/testcases/kernel/syscalls/write/write03.c
index 538079fec9e4..4eaa1e08322c 100644
--- a/testcases/kernel/syscalls/write/write03.c
+++ b/testcases/kernel/syscalls/write/write03.c
@@ -29,7 +29,7 @@ static void verify_write(void)
 {
 	fd = SAFE_CREAT("testfile", 0644);
 
-	SAFE_WRITE(1, fd, wbuf, 100);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, wbuf, 100);
 
 	if (write(fd, bad_addr, 100) != -1) {
 		tst_res(TFAIL, "write() failed to fail");
diff --git a/testcases/kernel/syscalls/write/write04.c b/testcases/kernel/syscalls/write/write04.c
index 41f5e67b66ab..afbac0f09201 100644
--- a/testcases/kernel/syscalls/write/write04.c
+++ b/testcases/kernel/syscalls/write/write04.c
@@ -44,7 +44,7 @@ static void setup(void)
 	rfd = SAFE_OPEN(fifo, O_RDONLY | O_NONBLOCK);
 	wfd = SAFE_OPEN(fifo, O_WRONLY | O_NONBLOCK);
 
-	SAFE_WRITE(0, wfd, wbuf, sizeof(wbuf));
+	SAFE_WRITE(SAFE_WRITE_ANY, wfd, wbuf, sizeof(wbuf));
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/write/write06.c b/testcases/kernel/syscalls/write/write06.c
index c17554811f5d..aac1e6f7c962 100644
--- a/testcases/kernel/syscalls/write/write06.c
+++ b/testcases/kernel/syscalls/write/write06.c
@@ -38,7 +38,7 @@ static void verify_write(void)
 	struct stat statbuf;
 
 	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_CREAT | O_TRUNC, 0666);
-	SAFE_WRITE(1, fd, write_buf[0], K2);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, write_buf[0], K2);
 	SAFE_CLOSE(fd);
 
 	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_APPEND);
@@ -50,7 +50,7 @@ static void verify_write(void)
 	if (off != K1)
 		tst_brk(TBROK, "Failed to seek to K1");
 
-	SAFE_WRITE(1, fd, write_buf[1], K1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, write_buf[1], K1);
 
 	off = SAFE_LSEEK(fd, 0, SEEK_CUR);
 	if (off != K3)
diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index 5b496203aafa..3575ca4493e8 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -47,7 +47,7 @@ static void setup(void)
 		buf[i] = i & 0xff;
 
 	mapfd = SAFE_OPEN(MAPFILE, O_CREAT|O_RDWR|O_TRUNC, 0644);
-	SAFE_WRITE(1, mapfd, buf, BUF_SIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, mapfd, buf, BUF_SIZE);
 
 	tst_fzsync_pair_init(&fzsync_pair);
 }
diff --git a/testcases/network/can/filter-tests/can_filter.c b/testcases/network/can/filter-tests/can_filter.c
index f2704c26e362..19c7fc48d739 100644
--- a/testcases/network/can/filter-tests/can_filter.c
+++ b/testcases/network/can/filter-tests/can_filter.c
@@ -102,16 +102,16 @@ static void run(unsigned int n)
 	frame.data[0] = testcase;
 
 	frame.can_id = ID;
-	SAFE_WRITE(1, s, &frame, sizeof(frame));
+	SAFE_WRITE(SAFE_WRITE_ALL, s, &frame, sizeof(frame));
 
 	frame.can_id = (ID | CAN_RTR_FLAG);
-	SAFE_WRITE(1, s, &frame, sizeof(frame));
+	SAFE_WRITE(SAFE_WRITE_ALL, s, &frame, sizeof(frame));
 
 	frame.can_id = (ID | CAN_EFF_FLAG);
-	SAFE_WRITE(1, s, &frame, sizeof(frame));
+	SAFE_WRITE(SAFE_WRITE_ALL, s, &frame, sizeof(frame));
 
 	frame.can_id = (ID | CAN_EFF_FLAG | CAN_RTR_FLAG);
-	SAFE_WRITE(1, s, &frame, sizeof(frame));
+	SAFE_WRITE(SAFE_WRITE_ALL, s, &frame, sizeof(frame));
 
 	tst_res(TPASS, "testcase %2d Sent patterns", testcase);
 
diff --git a/testcases/network/can/filter-tests/can_rcv_own_msgs.c b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
index 609ceb6d7e45..6bb2619f48d0 100644
--- a/testcases/network/can/filter-tests/can_rcv_own_msgs.c
+++ b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
@@ -25,7 +25,7 @@ static void test_sockets(canid_t can_id, int expect_rxs, int expect_rxt)
 
 	frame.can_id = can_id;
 	frame.can_dlc = 0;
-	SAFE_WRITE(1, s, &frame, sizeof(frame));
+	SAFE_WRITE(SAFE_WRITE_ALL, s, &frame, sizeof(frame));
 
 	while (have_rx) {
 
diff --git a/testcases/network/lib6/getaddrinfo_01.c b/testcases/network/lib6/getaddrinfo_01.c
index 8c76f5d02159..197402141353 100644
--- a/testcases/network/lib6/getaddrinfo_01.c
+++ b/testcases/network/lib6/getaddrinfo_01.c
@@ -294,7 +294,7 @@ static void setup(void)
 
 		SAFE_ASPRINTF(&entry, "%s %s %s\n",
 			      tcases[i].addr, tcases[i].name, tcases[i].alias);
-		SAFE_WRITE(0, fd, entry, strlen(entry));
+		SAFE_WRITE(SAFE_WRITE_ANY, fd, entry, strlen(entry));
 		free(entry);
 	}
 	SAFE_CLOSE(fd);
diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
index 5456c1bf0de2..e2243ac5ed09 100644
--- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
+++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
@@ -145,9 +145,9 @@ static void *thread_fn(LTP_ATTRIBUTE_UNUSED void *args)
 			tst_brk(TFAIL | TERRNO, "openat(makefile) failed");
 
 		if (i == dirs_num - 1)
-			SAFE_WRITE(1, fd, make_buf_n, sizeof(make_buf_n) - 1);
+			SAFE_WRITE(SAFE_WRITE_ALL, fd, make_buf_n, sizeof(make_buf_n) - 1);
 		else
-			SAFE_WRITE(1, fd, make_buf, sizeof(make_buf) - 1);
+			SAFE_WRITE(SAFE_WRITE_ALL, fd, make_buf, sizeof(make_buf) - 1);
 
 		SAFE_CLOSE(fd);
 
@@ -160,7 +160,7 @@ static void *thread_fn(LTP_ATTRIBUTE_UNUSED void *args)
 					"openat(%s) failed", cfile);
 			}
 
-			SAFE_WRITE(1, fd, prog_buf, sizeof(prog_buf) - 1);
+			SAFE_WRITE(SAFE_WRITE_ALL, fd, prog_buf, sizeof(prog_buf) - 1);
 			SAFE_CLOSE(fd);
 		}
 
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
