Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35467606A31A
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=YOsXbqnc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792723484; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=a5YCb1zVYv5cAlDixsXK6iHRor3y4ER2K9EG/fOeuQE=;
 b=YOsXbqncx2BBFmvKOmoUUd+EEPeqRCDW5gut52K9vHjY198G34mHG7qo5qJTnafC3U4oi
 puedhSbgvZ4ZnodWlMAinJcPihbulbo7Znz6nl6Jel1wD8+xNzyDdAD4VQqQU+wtgQ2mhdv
 av5v8/DHEexvb8HbBZb7GNqe020SCjE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CBFC3E2D94
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 04:44:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9B9C3CFD68
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 04:44:22 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E37B1601F78
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 04:44:13 +0200 (CEST)
Received: from mail.andestech.com (atcpcs54.andestech.com [10.0.1.154])
 by Atcsqr.andestech.com with ESMTPS id 69N2i4Hu047310
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Oct 2026 10:44:04 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs54.andestech.com
 (10.0.1.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 23 Oct
 2026 10:44:04 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Oct
 2026 10:44:03 +0800
To: <ltp@lists.linux.it>
Date: Fri, 23 Oct 2026 10:43:38 +0800
Message-ID: <20261023024338.2056856-1-cyyang772@andestech.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs54.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 69N2i4Hu047310
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Update call sites of SAFE_WRITE() to use the enum
 values
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Victor Cheng-Yen Yang via ltp <ltp@lists.linux.it>
Reply-To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Victor Cheng-Yen Yang <cyyang772@andestech.com>

SAFE_WRITE_ANY (0) and SAFE_WRITE_ALL (1) exist so that the len_strict
parameter is not a nameless boolean. Replace the remaining magic numbers
in the tests so that the intent of every call site is visible without
looking up the prototype.

The conversion is mechanical: 0 becomes SAFE_WRITE_ANY and 1 becomes
SAFE_WRITE_ALL. No functional change.

Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
---
Changes in v2:
- Rebased on master. v1 was based on top of the SAFE_READ() call-site
  patch [1], which was not merged yet, so it did not apply. That patch
  is now in master as 7205b418b7, and the diff is unchanged.

[1] https://lore.kernel.org/20261006020331.3791608-2-cyyang772@andestech.com

Link to v1: https://lore.kernel.org/20261008074428.480353-1-cyyang772@andestech.com

 testcases/cve/refluxfs.c                            | 2 +-
 testcases/kernel/fs/fsplough/fsplough.c             | 2 +-
 testcases/kernel/io/ltp-aiodio/aiocp.c              | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c  | 2 +-
 testcases/kernel/mem/mmapstress/mmapstress01.c      | 2 +-
 testcases/kernel/syscalls/cachestat/cachestat01.c   | 2 +-
 testcases/kernel/syscalls/cachestat/cachestat02.c   | 2 +-
 testcases/kernel/syscalls/epoll_wait/epoll_wait07.c | 4 ++--
 testcases/kernel/syscalls/eventfd/eventfd02.c       | 4 ++--
 testcases/kernel/syscalls/eventfd/eventfd03.c       | 2 +-
 testcases/kernel/syscalls/eventfd/eventfd04.c       | 4 ++--
 testcases/kernel/syscalls/eventfd/eventfd05.c       | 2 +-
 testcases/kernel/syscalls/eventfd/eventfd06.c       | 2 +-
 testcases/kernel/syscalls/eventfd2/eventfd2_03.c    | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify25.c     | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c   | 2 +-
 testcases/kernel/syscalls/madvise/madvise11.c       | 4 ++--
 testcases/kernel/syscalls/mount/mount03.c           | 2 +-
 testcases/kernel/syscalls/open/open12.c             | 4 ++--
 testcases/kernel/syscalls/open/open14.c             | 2 +-
 testcases/kernel/syscalls/pipe/pipe15.c             | 4 ++--
 testcases/kernel/syscalls/splice/splice09.c         | 2 +-
 22 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/testcases/cve/refluxfs.c b/testcases/cve/refluxfs.c
index bdf5d32c99..384082861d 100644
--- a/testcases/cve/refluxfs.c
+++ b/testcases/cve/refluxfs.c
@@ -109,7 +109,7 @@ static void setup(void)
 	SAFE_CHMOD(WORKDIR, 0777);
 
 	target_fd = SAFE_OPEN(TARGET, O_RDWR | O_CREAT | O_TRUNC, 0644);
-	SAFE_WRITE(1, target_fd, tbuf, blksize);
+	SAFE_WRITE(SAFE_WRITE_ALL, target_fd, tbuf, blksize);
 	SAFE_FSYNC(target_fd);
 	SAFE_CLOSE(target_fd);
 
diff --git a/testcases/kernel/fs/fsplough/fsplough.c b/testcases/kernel/fs/fsplough/fsplough.c
index 590c7a7341..2b789b9e81 100644
--- a/testcases/kernel/fs/fsplough/fsplough.c
+++ b/testcases/kernel/fs/fsplough/fsplough.c
@@ -94,7 +94,7 @@ static void update_filedata(const void *buf, size_t offset, size_t size)
 static void do_write(void *buf, size_t offset, size_t size)
 {
 	SAFE_LSEEK(write_fd, offset, SEEK_SET);
-	SAFE_WRITE(1, write_fd, buf, size);
+	SAFE_WRITE(SAFE_WRITE_ALL, write_fd, buf, size);
 }
 
 static void do_pwrite(void *buf, size_t offset, size_t size)
diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
index adfee63b7a..5742c24d87 100644
--- a/testcases/kernel/io/ltp-aiodio/aiocp.c
+++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
@@ -58,7 +58,7 @@ static void fill_with_rand_data(int fd, long long size)
 	long long i = size;
 
 	while (i > 0) {
-		SAFE_WRITE(1, fd, tst_rand_data,
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, tst_rand_data,
 			   MIN((long long)tst_rand_data_len, i));
 		i -= tst_rand_data_len;
 	}
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
index fa25251e27..5c0d1f7e72 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
@@ -37,7 +37,7 @@ static void run_test(void)
 	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
 	memcpy(p, P0, 8);
 
-	SAFE_WRITE(1, nfd, p, IOSZ);
+	SAFE_WRITE(SAFE_WRITE_ALL, nfd, p, IOSZ);
 	SAFE_LSEEK(nfd, 0, SEEK_SET);
 
 	SAFE_READ(SAFE_READ_ALL, nfd, buf, IOSZ);
diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index bdf8425c4f..36635c25bb 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -291,7 +291,7 @@ static void run(void)
 	SAFE_LSEEK(fd, (off_t)sparseoffset, SEEK_SET);
 	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
 		write_cnt = MIN((long long)pagesize, (long long)bytes_left);
-		c = SAFE_WRITE(1, fd, buf, write_cnt);
+		c = SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, write_cnt);
 	}
 	SAFE_CLOSE(fd);
 
diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
index 0663f40990..4402eab270 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat01.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -39,7 +39,7 @@ static void test_cached_pages(const unsigned int use_sync, const int num_pages)
 	fd = SAFE_OPEN(FILENAME, O_RDWR | O_CREAT, 0600);
 
 	for (int i = 0; i < num_pages; i++)
-		SAFE_WRITE(0, fd, page_data, page_size);
+		SAFE_WRITE(SAFE_WRITE_ANY, fd, page_data, page_size);
 
 	if (use_sync)
 		SAFE_FSYNC(fd);
diff --git a/testcases/kernel/syscalls/cachestat/cachestat02.c b/testcases/kernel/syscalls/cachestat/cachestat02.c
index d6505c4a4f..2582479402 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat02.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat02.c
@@ -43,7 +43,7 @@ static void test_cached_pages(const int num_pages)
 
 	SAFE_FTRUNCATE(fd, file_size);
 	for (int i = 0; i < num_pages; i++)
-		SAFE_WRITE(0, fd, page_data, page_size);
+		SAFE_WRITE(SAFE_WRITE_ANY, fd, page_data, page_size);
 
 	memset(cs, 0xff, sizeof(*cs));
 
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
index 07ba0e368d..1e5225f50d 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
@@ -47,7 +47,7 @@ static void run(void)
 
 	tst_res(TINFO, "Write channel for the 1st time. EPOLLIN expected");
 
-	SAFE_WRITE(0, fds[1], &buff, 1);
+	SAFE_WRITE(SAFE_WRITE_ANY, fds[1], &buff, 1);
 	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 10, 0), 1);
 	TST_EXP_EQ_LI(evt_receive.events & EPOLLIN, EPOLLIN);
 	TST_EXP_EQ_LI(evt_receive.data.fd, fds[0]);
@@ -57,7 +57,7 @@ static void run(void)
 
 	tst_res(TINFO, "Write channel for the 2nd time. No events expected");
 
-	SAFE_WRITE(0, fds[1], &buff, 1);
+	SAFE_WRITE(SAFE_WRITE_ANY, fds[1], &buff, 1);
 	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 10, 0), 0);
 
 	SAFE_CLOSE(epfd);
diff --git a/testcases/kernel/syscalls/eventfd/eventfd02.c b/testcases/kernel/syscalls/eventfd/eventfd02.c
index 88b319ae50..ac19df6597 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd02.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd02.c
@@ -27,12 +27,12 @@ static void run(void)
 
 	fd = TST_EXP_FD(eventfd(0, EFD_NONBLOCK));
 
-	SAFE_WRITE(0, fd, &val, sizeof(val));
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, &val, sizeof(val));
 	SAFE_READ(SAFE_READ_ANY, fd, &buf, sizeof(buf));
 	TST_EXP_EQ_LI(buf, val);
 
 	val = UINT64_MAX - 1;
-	SAFE_WRITE(0, fd, &val, sizeof(val));
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, &val, sizeof(val));
 	TST_EXP_FAIL(write(fd, &val, sizeof(val)), EAGAIN);
 	TST_EXP_FAIL(write(fd, &invalid, sizeof(invalid)), EINVAL);
 
diff --git a/testcases/kernel/syscalls/eventfd/eventfd03.c b/testcases/kernel/syscalls/eventfd/eventfd03.c
index b1e0dcc799..6abdd9d72a 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd03.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd03.c
@@ -29,7 +29,7 @@ static void run(void)
 	FD_ZERO(&readfds);
 	FD_SET(fd, &readfds);
 
-	SAFE_WRITE(0, fd, &non_zero, sizeof(non_zero));
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, &non_zero, sizeof(non_zero));
 	TEST(select(fd + 1, &readfds, NULL, NULL, &timeout));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TERRNO, "select");
diff --git a/testcases/kernel/syscalls/eventfd/eventfd04.c b/testcases/kernel/syscalls/eventfd/eventfd04.c
index 4d255bac63..f5fe2a9d1e 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd04.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd04.c
@@ -30,7 +30,7 @@ static void run(void)
 	FD_ZERO(&writefds);
 	FD_SET(fd, &writefds);
 
-	SAFE_WRITE(0, fd, &non_max, sizeof(non_max));
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, &non_max, sizeof(non_max));
 	TEST(select(fd + 1, NULL, &writefds, NULL, &timeout));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TERRNO, "select");
@@ -38,7 +38,7 @@ static void run(void)
 	TST_EXP_EQ_LI(FD_ISSET(fd, &writefds), 1);
 
 	SAFE_READ(SAFE_READ_ANY, fd, &val, sizeof(val));
-	SAFE_WRITE(0, fd, &max, sizeof(max));
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, &max, sizeof(max));
 
 	TEST(select(fd + 1, NULL, &writefds, NULL, &timeout));
 	if (TST_RET == -1)
diff --git a/testcases/kernel/syscalls/eventfd/eventfd05.c b/testcases/kernel/syscalls/eventfd/eventfd05.c
index 81310718d9..a82120bcde 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd05.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd05.c
@@ -23,7 +23,7 @@ static void run(void)
 	fd = TST_EXP_FD(eventfd(0, EFD_NONBLOCK));
 
 	if (!SAFE_FORK()) {
-		SAFE_WRITE(0, fd, &to_parent, sizeof(to_parent));
+		SAFE_WRITE(SAFE_WRITE_ANY, fd, &to_parent, sizeof(to_parent));
 		exit(0);
 	}
 
diff --git a/testcases/kernel/syscalls/eventfd/eventfd06.c b/testcases/kernel/syscalls/eventfd/eventfd06.c
index 8ee0dd229a..97f82f808e 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd06.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd06.c
@@ -80,7 +80,7 @@ static void clear_counter(void)
 	if (TST_RET == -1 && TST_ERR != EAGAIN)
 		tst_brk(TBROK | TERRNO, "read");
 
-	SAFE_WRITE(0, evfd, &max, sizeof(max));
+	SAFE_WRITE(SAFE_WRITE_ANY, evfd, &max, sizeof(max));
 }
 
 static void test_select(void)
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
index b218385ffd..a8d8f0a52d 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
@@ -26,7 +26,7 @@ static void xsem_post(int fd, int count)
 {
 	u_int64_t cntr = count;
 
-	SAFE_WRITE(0, fd, &cntr, sizeof(cntr));
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, &cntr, sizeof(cntr));
 }
 
 static void sem_player(int fd1, int fd2)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify25.c b/testcases/kernel/syscalls/fanotify/fanotify25.c
index 733270ad8f..713ee4ac78 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify25.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify25.c
@@ -62,7 +62,7 @@ static void do_child(void)
 
 	for (i = 0, events = 0; trace_cmds[i].filename; i++) {
 		fd = SAFE_OPEN(trace_cmds[i].filename, O_WRONLY, 0644);
-		SAFE_WRITE(1, fd, trace_cmds[i].wdata,
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, trace_cmds[i].wdata,
 			strlen(trace_cmds[i].wdata));
 		SAFE_CLOSE(fd);
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
index 97a637bffc..d8dc361db0 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
@@ -40,7 +40,7 @@ static void run(void)
 
 	tst_res(TINFO, "Writing data inside src file");
 
-	SAFE_WRITE(1, src_fd, FILEDATA, FILESIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, src_fd, FILEDATA, FILESIZE);
 	SAFE_FSYNC(src_fd);
 
 	TST_EXP_PASS(ioctl(dst_fd, FICLONE, src_fd));
diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index c19d67127b..6c778f8baf 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -287,7 +287,7 @@ static void unpoison_this_pfn(unsigned long pfn, int fd)
 	char pfn_str[19];
 
 	snprintf(pfn_str, sizeof(pfn_str), "0x%lx", pfn);
-	SAFE_WRITE(0, fd, pfn_str, strlen(pfn_str));
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, pfn_str, strlen(pfn_str));
 }
 
 /* Find and open the <debugfs>/hwpoison/unpoison-pfn special file */
@@ -382,7 +382,7 @@ static void write_beginning_tag_to_kmsg(void)
 	snprintf(beginning_tag, sizeof(beginning_tag),
 		 "Soft-offlining pages test starting (pid: %ld)",
 		 (long)getpid());
-	SAFE_WRITE(1, fd, beginning_tag, strlen(beginning_tag));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, beginning_tag, strlen(beginning_tag));
 	SAFE_CLOSE(fd);
 }
 
diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 1cb6f47f8e..a901792be6 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -110,7 +110,7 @@ static void test_file_dir_noatime(int update_fatime, int update_datime)
 	if (access(dir, F_OK) == -1 && errno == ENOENT)
 		SAFE_MKDIR(dir, 0700);
 
-	SAFE_WRITE(1, otfd, TEST_STR, strlen(TEST_STR));
+	SAFE_WRITE(SAFE_WRITE_ALL, otfd, TEST_STR, strlen(TEST_STR));
 	SAFE_FSTAT(otfd, &st);
 	atime = st.st_atime;
 
diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index ff3f8ebb57..809a717bd4 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -61,7 +61,7 @@ static void test_append(void)
 
 	SAFE_FSTAT(fd, &statbuf);
 	len1 = strlen(TEST_FILE);
-	SAFE_WRITE(1, fd, TEST_FILE, len1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, TEST_FILE, len1);
 	len2 = SAFE_LSEEK(fd, 0, SEEK_CUR);
 	SAFE_CLOSE(fd);
 	len1 += statbuf.st_size;
@@ -161,7 +161,7 @@ static void test_largefile(void)
 		return;
 	}
 
-	SAFE_WRITE(1, fd, LARGE_FILE, strlen(LARGE_FILE));
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, LARGE_FILE, strlen(LARGE_FILE));
 	SAFE_CLOSE(fd);
 	fd = open(LARGE_FILE, O_LARGEFILE | O_RDONLY, 0644);
 
diff --git a/testcases/kernel/syscalls/open/open14.c b/testcases/kernel/syscalls/open/open14.c
index 7d3a3d55ee..db2771a78c 100644
--- a/testcases/kernel/syscalls/open/open14.c
+++ b/testcases/kernel/syscalls/open/open14.c
@@ -51,7 +51,7 @@ static void write_file(int fd)
 	int i;
 
 	for (i = 0; i < blocks_num; ++i)
-		SAFE_WRITE(1, fd, buf, size);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, size);
 }
 
 static void test01(void)
diff --git a/testcases/kernel/syscalls/pipe/pipe15.c b/testcases/kernel/syscalls/pipe/pipe15.c
index b7a87ec3ae..cf2fa01b8b 100644
--- a/testcases/kernel/syscalls/pipe/pipe15.c
+++ b/testcases/kernel/syscalls/pipe/pipe15.c
@@ -30,9 +30,9 @@ static void run(void)
 	const int buffer_size = SAFE_FCNTL(pipe[1], F_GETPIPE_SZ);
 
 	tst_res(TINFO, "Soft-limited buffer size: %d bytes", buffer_size);
-	SAFE_WRITE(1, pipe[1], buffer, buffer_size);
+	SAFE_WRITE(SAFE_WRITE_ALL, pipe[1], buffer, buffer_size);
 	SAFE_READ(SAFE_READ_ALL, pipe[0], buffer, buffer_size - 1);
-	SAFE_WRITE(1, pipe[1], buffer, 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, pipe[1], buffer, 1);
 	tst_res(TPASS, "Pipe operation did not block");
 
 	SAFE_READ(SAFE_READ_ALL, pipe[0], buffer, 2);
diff --git a/testcases/kernel/syscalls/splice/splice09.c b/testcases/kernel/syscalls/splice/splice09.c
index 8863a01342..d4404edeee 100644
--- a/testcases/kernel/syscalls/splice/splice09.c
+++ b/testcases/kernel/syscalls/splice/splice09.c
@@ -32,7 +32,7 @@ static void verify_splice(unsigned int n)
 	dev_fd = SAFE_OPEN(test_devices[n], O_WRONLY);
 
 	SAFE_PIPE(pipefd);
-	SAFE_WRITE(1, pipefd[1], buf, sizeof(buf));
+	SAFE_WRITE(SAFE_WRITE_ALL, pipefd[1], buf, sizeof(buf));
 
 	TST_EXP_POSITIVE(splice(pipefd[0], NULL, dev_fd, NULL, sizeof(buf), 0));
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
