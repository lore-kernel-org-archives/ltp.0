Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C60C433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:10:58 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B50C60F44
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B50C60F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3219B3C2E5D
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:10:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B3B93C2E34
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:10:28 +0200 (CEST)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D215A1400550
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:10:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634562625; i=@fujitsu.com;
 bh=VT5hsWps7FTTfXZBkQ+dJ3KFSfRelXGor6IITW6CVJI=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=mmiiB8mOrP+pH/ITdq108IMrl3SKv9eYt1egGtTSD2mfssgmvbLYsy2pu8oK8XiGU
 MJyM7Pap3WEN2LMhdMEweyG3EBVLStPSmTPrvKWIUK/xpYoB/Ye3bwHIc0y4E3kqmF
 Lh7qeadci/yWus87CvdrCa881TjaG5NahX1JcId3g1HWCAE1Mso/tvocdulVo4ulT4
 bY8Ng+nD+1638eCJgmz/dTo8V5p/a4qLcejVdRXT6GSZ7lJriplwQUSYbG32PpxFcO
 EgWUEdYO1Xg7DoX+Vz++5KzxON8QFQMErgQ9UsCJEYJvcpbI+jlDMu5xNu2+pHEyoV
 d1DpLUvQW86eg==
Received: from [100.112.196.123] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-b.eu-west-1.aws.symcld.net id C8/F2-20159-1427D616;
 Mon, 18 Oct 2021 13:10:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRWlGSWpSXmKPExsViZ8MxSdexKDf
 R4PY0aYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNeP25uVsBSf1K7quvWNtYNyq1cXIxSEkcJZR
 4tuXc4wQzk4miT8X30I5exgl/u74wNTFyMnBJqAp8axzATOILSIgIdHR8JYdxGYWUJdYPukXW
 I2wgLfEr5f/WEFsFgFViQuft4DV8wp4SFyb380IYksIKEhMefgeLM4p4Clx9fUaMFsIqObezd
 tQ9YISJ2c+YYGYLyFx8MULZoheRYlLHd+g5lRIzJrVxgRhq0lcPbeJeQKj4Cwk7bOQtC9gZFr
 FaJFUlJmeUZKbmJmja2hgoGtoaKRraGmua2RiqZdYpZukl1qqW55aXKJrqJdYXqxXXJmbnJOi
 l5dasokRGMIpBUd/7mB8+PqD3iFGSQ4mJVHefqXcRCG+pPyUyozE4oz4otKc1OJDjDIcHEoSv
 KfzgXKCRanpqRVpmTnAeIJJS3DwKInwVhUCpXmLCxJzizPTIVKnGI05Ll+ft4iZ493PxYuYhV
 jy8vNSpcR5WQuASgVASjNK8+AGweL8EqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3miQhTy
 ZeSVw+14BncIEdMpV5xyQU0oSEVJSDUzFZmc+n/WrKbcVuFEcdc31T0374ykF3QvWp56a0HyY
 85L7m/mLLm+Skap7ppl4IVph0WRjxn+FWwKXrf91VG/eju6y2RPZg6enb90nIv1bmXf1nf1bG
 OU2/bhRsO3sdkHzT3eYki+lzzy730FHLuBv6TzmQL9d1WWNjd8PnljQMkX003uOUL86q9DgLp
 P7CxuPar183FUasPDjRraDe89VPeXSid4sPnWHe3zYyspZ4b6L4rlkg1iVH2w6eemCTDrnAd7
 a3YlrqgXtb5uUdbI+nn99kbDZpEWXfVvE/s/VXL0t71+fk6Kow7LG/Bd3xHZ+sNg/kbnIaJX4
 E/f/66P3uyVOO7bAx//Vwes5khcvK7EUZyQaajEXFScCAL86xW9uAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-19.tower-287.messagelabs.com!1634562625!1977413!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17150 invoked from network); 18 Oct 2021 13:10:25 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-19.tower-287.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Oct 2021 13:10:25 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 0462910045E
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:10:25 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id EBBA4100452
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:10:24 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Oct 2021 14:10:03 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 18 Oct 2021 21:09:45 +0800
Message-ID: <1634562591-5830-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 05/11] lapi/syscalls: Add syscall number for
 quotactl_fd
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

Add syscall number for quotactl_fd, refer to glibc's submission[1].

[1]https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=89dc0372a9055e7ef86fe19be6201fa0b16b2f0e

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/syscalls/aarch64.in   | 1 +
 include/lapi/syscalls/arc.in       | 1 +
 include/lapi/syscalls/arm.in       | 1 +
 include/lapi/syscalls/hppa.in      | 1 +
 include/lapi/syscalls/i386.in      | 1 +
 include/lapi/syscalls/ia64.in      | 1 +
 include/lapi/syscalls/mips_n32.in  | 1 +
 include/lapi/syscalls/mips_n64.in  | 1 +
 include/lapi/syscalls/mips_o32.in  | 1 +
 include/lapi/syscalls/powerpc.in   | 1 +
 include/lapi/syscalls/powerpc64.in | 1 +
 include/lapi/syscalls/s390.in      | 1 +
 include/lapi/syscalls/s390x.in     | 1 +
 include/lapi/syscalls/sh.in        | 1 +
 include/lapi/syscalls/sparc.in     | 1 +
 include/lapi/syscalls/sparc64.in   | 1 +
 include/lapi/syscalls/x86_64.in    | 1 +
 17 files changed, 17 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index a47185954..89b63ee4b 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -294,4 +294,5 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
+quotactl_fd 443
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 9c1654b0b..72420754a 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -314,3 +314,4 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
+quotactl_fd 443
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index ded2f5e03..2a78d7c3c 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -392,3 +392,4 @@ close_range (__NR_SYSCALL_BASE+436)
 openat2 (__NR_SYSCALL_BASE+437)
 pidfd_getfd (__NR_SYSCALL_BASE+438)
 epoll_pwait2 (__NR_SYSCALL_BASE+441)
+quotactl_fd (__NR_SYSCALL_BASE+443)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index d8f142b6a..2f0fc8153 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -41,3 +41,4 @@ fspick 433
 pidfd_open 434
 close_range 436
 epoll_pwait2 441
+quotactl_fd 443
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index f69268e10..34a8a621f 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -428,3 +428,4 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
+quotactl_fd 443
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 3ba2406c4..b729cd3f0 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -341,3 +341,4 @@ close_range 1460
 openat2 1461
 pidfd_getfd 1462
 epoll_pwait2 1465
+quotactl_fd 1467
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index dad8107f4..46098a616 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -369,3 +369,4 @@ faccessat2 6439
 process_madvise 6440
 epoll_pwait2 6441
 mount_setattr 6442
+quotactl_fd 6443
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index a6c0c8cdd..07f96ac5d 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -345,3 +345,4 @@ faccessat2 5439
 process_madvise 5440
 epoll_pwait2 5441
 mount_setattr 5442
+quotactl_fd 5443
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 238f77009..5e64a4a1c 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -415,3 +415,4 @@ faccessat2 4439
 process_madvise 4440
 epoll_pwait2 4441
 mount_setattr 4442
+quotactl_fd 4443
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index a4ed2169c..f4e85940c 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -421,3 +421,4 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
+quotactl_fd 443
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index a4ed2169c..f4e85940c 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -421,3 +421,4 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
+quotactl_fd 443
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index d99e5fd9e..3e16d8475 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -408,3 +408,4 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
+quotactl_fd 443
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index f26cdaaae..beb0819af 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -356,3 +356,4 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
+quotactl_fd 443
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 20ee61ccc..a81cf8297 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -402,3 +402,4 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
+quotactl_fd 443
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 86decdd82..6a7817ae5 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -407,3 +407,4 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
+quotactl_fd 443
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 02dfe473a..d3995181c 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -372,3 +372,4 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
+quotactl_fd 443
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index cf6d78bf6..a5b2a24fe 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -349,6 +349,7 @@ close_range 436
 openat2 437
 pidfd_getfd 438
 epoll_pwait2 441
+quotactl_fd 443
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
