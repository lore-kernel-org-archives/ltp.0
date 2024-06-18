Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADBBC27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:00:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E89A3CFE8B
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:00:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E03B3C02E7
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 10:49:24 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=toshiba.co.jp (client-ip=210.130.202.158;
 helo=mo-csw.securemx.jp; envelope-from=nobuhiro1.iwamatsu@toshiba.co.jp;
 receiver=lists.linux.it)
Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AD964609A4C
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 10:49:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toshiba.co.jp;
 h=From:To:Cc
 :Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
 1718700553; x=1719910153; bh=22rDbj2uUxAKtXpP1r73nQQfzeAbLWfMqEd5yFlyUlo=;
 b=Dc2
 BL3Gci1H2YJN596CoGMHfg327XAaE2yZtvPldD0QUTGoToLzPP36rd9FakaXSSihP9JSSCT//XbsQ
 nUuDOjJ5uDdAkvABveW5nQ151OpNYvE4NC5hS3wLPU/5t0c9ckTTHSoGP7MT05didHBKeXp6vLMvr
 /Jp8q3sz79itGHPNW9DsqPG6PHkAJi1OSxxr9baEbt8g/qpQgLX3nMrQ71jVFvyEJnScxL+32Xdos
 cy1u2GWGnNbBUQUy0xx6YjWwvHRJeoSKQp/C19EwX7dIPlXB0vKkzyvKTlABUSizKoQZ0eIC/L/Rw
 CFU2plzxatAicoCD1GcOOzWLjXtJ2VQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 45I8nBqO2311352;
 Tue, 18 Jun 2024 17:49:13 +0900
X-Iguazu-Qid: 2rWhYYPQFmWE2Srhvs
X-Iguazu-QSIG: v=2; s=0; t=1718700550; q=2rWhYYPQFmWE2Srhvs;
 m=2ZPxrgQCg4sMCAVQNAu2gRiHT+ijGZOTyz3fYlTWgSk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
 by relay.securemx.jp (mx-mr1121) id 45I8n8Sa3896642
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 17:49:10 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: ltp@lists.linux.it
Date: Tue, 18 Jun 2024 17:49:04 +0900
X-TSB-HOP2: ON
Message-Id: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Jun 2024 11:00:08 +0200
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
