Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E84C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:53:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB78961054
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB78961054
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1192F3C0889
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:53:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1F6F3C08C7
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:53:03 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 860991001199
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:53:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636455181; i=@fujitsu.com;
 bh=+ugbAx3cIgORdBmzRf9qTdjAfpfT2UvToV9PIGVVgrQ=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=lovNCnNAC+E6bp7jT7o93fFl5Z++bbjTK59K1KNc6kk/aBctqhPXLnEIyIy24aRO4
 Xc9iI0YPsG972RueuCqVI1V7/kJmCstVNJ3s6a/qwr6LL4rWQSspq2kCmb2/VzeRkt
 fy2Xmex3Xr+4X/KBGpsbCWazQOlOhpCxtIhg1Ogno6fEfQpNRhvhU/G28DDNYxYBoK
 2s1pNOYcwzKb3lHUwC6LQcQERusNTuuwcfzH9KeatkM5q1vZm/hzaOduL0vqN2U9Sz
 gQu7PdSQEnXB4JTNwkF90peDZdjBwOfKjf74DCnbWk5uM8o7NEWsjoiUSbimt4+kpR
 BH3qMC/J6hjVA==
Received: from [100.113.7.62] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 7D/BB-30139-D035A816;
 Tue, 09 Nov 2021 10:53:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRWlGSWpSXmKPExsViZ8ORqMsT3JV
 ocP+klsWK7zsYHRg99v1exxrAGMWamZeUX5HAmrF/P0/BV/2KbQ86WRsY72p1MXJxCAmcZZTo
 ePeTtYuRE8jZySRxvM0CIrGbUeLZ5IOMIAk2AU2JZ50LmEFsEQEJiY6Gt+wgNrOAusTySb+YQ
 GxhAW+Ju10rwOIsAioSO889YwOxeQU8JOY9XMUCYksIKEhMefgeaA4HB6eAp8Tfj64Qez0kdj
 z/zAhRLihxcuYTFojxEhIHX7xghmhVlLjU8Y0Rwq6QmDWrjQnCVpO4em4T8wRGwVlI2mchaV/
 AyLSK0TKpKDM9oyQ3MTNH19DAQNfQ0FjXTNfIxEAvsUo3SS+1VDc5Na+kKBEoq5dYXqxXXJmb
 nJOil5dasokRGL4phWwfdjBOefNB7xCjJAeTkijvZbGuRCG+pPyUyozE4oz4otKc1OJDjDIcH
 EoSvAn+QDnBotT01Iq0zBxgLMGkJTh4lER49XyA0rzFBYm5xZnpEKlTjMYcl6/PW8TM8e7n4k
 XMQix5+XmpUuK8jYFApQIgpRmleXCDYDF+iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5IwbyX
 IFJ7MvBK4fa+ATmECOuXgl3aQU0oSEVJSDUyzlBo2WyQbnf3W52cbziIvt2KP5MaTwkYKG5+r
 uZ7llWLve2W8Kjac8bfbC0m1BhaBFZp+Vvmvyh/1tr+6XBT6t7jp6qLt3xVNj7yY2bcpoOVJe
 EhcR29+D5PhrVv+fD7b1y6f21X/bZP3vjsHTq6feu5Z+eeIm19jpz5lelrBn3Swc5H48+DERx
 /+P8lOvcm3/uqpq23rsvNVV9m84a9svTxXfJ6xb9BDsR03U49EOC7Qv7Jl7+I7ogUxSW4e2UV
 L9x7L+cK1/7XFJovPnDOsmu+ci/zEPvt2XdPR5Ale6ypbW2Map39cyTVzzqb+q5+Pyh3n6X20
 f93L3PwP7te63m/8capHgsffvOF8fmCVEktxRqKhFnNRcSIAidcKF2wDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-245.messagelabs.com!1636455180!378731!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14353 invoked from network); 9 Nov 2021 10:53:00 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-14.tower-245.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Nov 2021 10:53:00 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 332A7100241
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:53:00 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 269C1100231
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:53:00 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 10:52:49 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Nov 2021 18:52:40 +0800
Message-ID: <1636455161-8278-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1636455161-8278-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1636455161-8278-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 05/12] lapi/syscalls: Add syscall number for
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
