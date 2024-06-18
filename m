Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8B3C27C4F
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 09:10:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85AA13D0D35
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 11:10:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EF6A3C02E7
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 11:09:59 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=toshiba.co.jp (client-ip=210.130.202.132;
 helo=mo-csw.securemx.jp; envelope-from=nobuhiro1.iwamatsu@toshiba.co.jp;
 receiver=lists.linux.it)
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 07EF71002039
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 11:09:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toshiba.co.jp;
 h=From:To:Cc
 :Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
 1718701789; x=1719911389; bh=22rDbj2uUxAKtXpP1r73nQQfzeAbLWfMqEd5yFlyUlo=;
 b=BAh
 FzIoTtCcVZNcJVThCGCFM1DSSyOdlsr9iq0xQ3kEn1QsQBdVhFRVfDTSlhAAsy7ksLuSTt1UtWuJP
 eLASCGas2h6ClCOpIUeccXAL0b7lEZvC+ZMv+C3rD5vL7W3CBmDIRdTNYr0fWwhEIG1VHD3OZbY1Q
 BDxwE3V7E1I9HqiYLMrU6e8PvL0Ms0V95UysAgInTvueWqzq07ybkjJDr7UU+ckpPMaTtgcpQxZcx
 8v+430AUwrjXcX8K6KnTO1Dms3P3JZ7FWfPw4Ygr9itxISa2mRpYsRJxt7MHm0JiVkB7ptj0KDcrt
 O5kQVhnyqHV4fmzu9wz4IUJnDc6EHRQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 45I99mCL1926247;
 Tue, 18 Jun 2024 18:09:49 +0900
X-Iguazu-Qid: 2rWhGbqYjXvP6FZZ6i
X-Iguazu-QSIG: v=2; s=0; t=1718701788; q=2rWhGbqYjXvP6FZZ6i;
 m=EjzZGlAazqojNXiztMf4n1eOQbseT6R0u6cWakAjg2M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
 by relay.securemx.jp (mx-mr1122) id 45I99lb7058588
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 18:09:47 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: ltp@lists.linux.it
Date: Tue, 18 Jun 2024 18:09:42 +0900
X-TSB-HOP2: ON
Message-Id: <1718701782-18077-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: tst_fd: Add kernel version check to memfd_secret
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

memfd_secret is a syscall added since 5.14. On earlier kernels, tests such
as accept03, readahead01 and splice07 that use memfd_secret fail.
This adds a kernel version check to the tst_fd library when running tests using
memfd_secret.

Test log on linux-5.10.162/arm32 with version 20240524:
```
$ ./testcases/kernel/syscalls/accept/accept03
tst_test.c:1733: TINFO: LTP version: 20240524
tst_test.c:1617: TINFO: Timeout per run is 0h 00m 30s
accept03.c:58: TPASS: accept() on file : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on O_PATH file : EBADF (9)
accept03.c:58: TPASS: accept() on directory : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on /dev/zero : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on /proc/self/maps : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on pipe read end : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on pipe write end : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on epoll : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on eventfd : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on signalfd : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on timerfd : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on pidfd : ENOTSOCK (88)
tst_fd.c:151: TCONF: Skipping fanotify: ENOSYS (38)
accept03.c:58: TPASS: accept() on inotify : ENOTSOCK (88)
tst_fd.c:170: TCONF: Skipping userfaultfd: ENOSYS (38)
accept03.c:58: TPASS: accept() on perf event : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on io uring : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on bpf map : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on fsopen : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on fspick : ENOTSOCK (88)
accept03.c:58: TPASS: accept() on open_tree : EBADF (9)
accept03.c:58: TPASS: accept() on memfd : ENOTSOCK (88)
tst_test.c:1677: TBROK: Test killed by SIGILL!

Summary:
passed   20
failed   0
broken   1
skipped  2
warnings 0
```

Closed: #1145
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 lib/tst_fd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/tst_fd.c b/lib/tst_fd.c
index 6538a098c..53f583fa0 100644
--- a/lib/tst_fd.c
+++ b/lib/tst_fd.c
@@ -255,8 +255,16 @@ static void open_memfd(struct tst_fd *fd)
 
 static void open_memfd_secret(struct tst_fd *fd)
 {
+	if ((tst_kvercmp(5, 14, 0)) < 0) {
+		tst_res(TINFO, "accept() on %s: Linux kernel version is before than v5.14", tst_fd_desc(fd));
+		errno = ENOSYS;
+		goto skip;
+	}
+
 	fd->fd = syscall(__NR_memfd_secret, 0);
+
 	if (fd->fd < 0) {
+skip:
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
 	}
-- 
2.43.0



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
