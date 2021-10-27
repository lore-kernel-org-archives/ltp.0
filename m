Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21215C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:27:34 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A23B60EDF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A23B60EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 360E83C6A37
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:27:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5C9A3C6BE6
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:26:44 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 776AC60083E
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337602; i=@fujitsu.com;
 bh=+ugbAx3cIgORdBmzRf9qTdjAfpfT2UvToV9PIGVVgrQ=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=OMuxgW3tkLfFxoO0oECeD+EOTuWyutgL1Mgb7V7zlKyQbCGLuEVwGGHU2zrk/mBOE
 OaTsKuZVnMLAjc1JOWfh0KVSPpbmbGFpUHtBSvWqcn1acPzqfQtNA2R4Hg66TNBD2d
 +U9audhMmd0N+9iH0FgTqQw1LsP+em4kTOo96pk7nZMubTfdQjoTUziSolYEfzWjMH
 ebY6QPgsDV1c0aXxbLOjG4Pa1c0mGbu/YyInQiW+oa86brc4Q0ePOFfrXe4/LACJxV
 7AG2bhBsE392Mz2HoubTYkLJOhk/AaOczVsBH75uEas2ZaxP8jSrEhhHozTDGt+mnZ
 5xCm/jhSFz8Pg==
Received: from [100.113.6.252] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-b.eu-central-1.aws.symcld.net id B9/25-14220-28549716;
 Wed, 27 Oct 2021 12:26:42 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRWlGSWpSXmKPExsViZ8MxVbfJtTL
 R4O9rQYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNWP/fp6Cr/oV2x50sjYw3tXqYuTiEBJoYZKY
 eGEiG4Szh1Gib+9api5GTg42AU2JZ50LmEFsEQEJiY6Gt+wgNrOAusTySb/AaoQFvCWeNv4Aq
 2ERUJXouLmSFcTmFfCQmPz9CAuILSGgIDHl4XuwGk4BT4lJuxaB1QgB1Uy4/owZol5Q4uTMJy
 wQ8yUkDr54wQzRqyhxqeMbI4RdITFrVhvTBEb+WUhaZiFpWcDItIrRMqkoMz2jJDcxM0fX0MB
 A19DQWNdU18jYQi+xSjdJL7VUNzk1r6QoESirl1herFdcmZuck6KXl1qyiREYkCmFrO92MD57
 /UHvEKMkB5OSKG+ATmWiEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQneM45AOcGi1PTUirTMHGB0w
 KQlOHiURHgNQdK8xQWJucWZ6RCpU4zGHJevz1vEzPHu5+JFzEIsefl5qVLivBwuQKUCIKUZpX
 lwg2BRe4lRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMK+9M9AUnsy8Erh9r4BOYQI6hVmpAuS
 UkkSElFQDU/YT+7D4ij0db7V+Rgicvv7y1Wlej8wdDIlnN1W42160U3rfFeIRf1t6u7zmpqcP
 95kvSxPul2VfG78+7O1vwbyH2435lbcEsu76+m5Bu3lmwgmRSouzu5Pj/nE9Zn5QLXk04W/tp
 iazxia9HUvl00yXrez42MH6fe1RloS/vs857n9OZ8gL3uO1/0zTUVU12+5m3s8uHEvWSMSrnF
 A9YzDzZYS3TsgsyZaariuByz/MCC53va8u+W2dT7FbsOILrR6+7sNCWvOdgt/0StRsknKR+/i
 gfVrJ11TtyyGvPszcqe+kynh4U6Wrwapzxi5Cmy0m5qh8XncoYd6STv37HXIX3xps+uoZdJpr
 gl6+EktxRqKhFnNRcSIAHtMLhFUDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-248.messagelabs.com!1635337601!682091!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30703 invoked from network); 27 Oct 2021 12:26:42 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
 by server-16.tower-248.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:26:42 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 19RCQXUU027351
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:26:41 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:26:31 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:26:01 +0800
Message-ID: <1635337569-4634-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 05/13] lapi/syscalls: Add syscall number for
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
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
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
