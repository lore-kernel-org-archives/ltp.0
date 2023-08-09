Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF744C0015E
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 12:06:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EA9E3CD061
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 14:06:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A8193C62DB
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 10:56:16 +0200 (CEST)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 804E11000DB1
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 10:56:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PLjX6
 8cf8g1oI5Rs6ytAcWBaDC6QBZt2Iy4iDWxliUY=; b=kYxUmEh940FCBfZjsbzqM
 IN5rhEUyJgMiPhFg5v4XIogasZylShaZmJ0T/kifz3yjGhOcjy21kTfPrTMz2/1v
 4jluVv6NDMNASVfG9Pn8g2MpqynhpUeWsGZ1O1szRzwjyzQw3NdbNMed9gHmifag
 zm/T1KIO+qc4t8LeCvRc4I=
Received: from wxw-QiTianM428-N000.. (unknown [39.156.73.12])
 by zwqz-smtp-mta-g3-2 (Coremail) with SMTP id _____wC336+eVNNkbRurCg--.22249S4;
 Wed, 09 Aug 2023 16:55:58 +0800 (CST)
From: 18810879172@163.com
To: ltp@lists.linux.it
Date: Wed,  9 Aug 2023 16:55:56 +0800
Message-Id: <20230809085556.103828-1-18810879172@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CM-TRANSID: _____wC336+eVNNkbRurCg--.22249S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrykKw4DGw43ZF4rKw45KFg_yoW7JFW8pF
 1DA395GF4ruryrC3y29F1xKFWIy3yUKr12qw4UurnYyw13tFW0qr4DXa45GF1xArZ2grWa
 gFn7Wr95Ww1DXFUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2eHDUUUUU=
X-Originating-IP: [39.156.73.12]
X-CM-SenderInfo: rprymiyqyxmiixs6il2tof0z/xtbBEQTG9VaEPCHL8AAAsS
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 11 Aug 2023 14:06:13 +0200
Subject: [LTP] [PATCH] lapi/syscalls: Add some syscall numbers
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
Cc: wangxuewen <wangxuewen@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: wangxuewen <wangxuewen@kylinos.cn>

Signed-off-by: wangxuewen <wangxuewen@kylinos.cn>
---
 include/lapi/syscalls/aarch64.in  | 1 +
 include/lapi/syscalls/arc.in      | 1 +
 include/lapi/syscalls/arm.in      | 1 +
 include/lapi/syscalls/i386.in     | 1 +
 include/lapi/syscalls/mips_n32.in | 1 +
 include/lapi/syscalls/mips_n64.in | 1 +
 include/lapi/syscalls/mips_o32.in | 1 +
 include/lapi/syscalls/powerpc.in  | 1 +
 include/lapi/syscalls/s390.in     | 1 +
 include/lapi/syscalls/sh.in       | 1 +
 include/lapi/syscalls/sparc.in    | 1 +
 include/lapi/syscalls/x86_64.in   | 2 ++
 12 files changed, 13 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index de4ed5fb1..ae513a4de 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -296,4 +296,5 @@ pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+set_mempolicy_home_node 450
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 9f11381db..63202fdf0 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -316,3 +316,4 @@ pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+set_mempolicy_home_node 450
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 4b0f63a28..5aa6e0d7d 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -394,3 +394,4 @@ pidfd_getfd (__NR_SYSCALL_BASE+438)
 epoll_pwait2 (__NR_SYSCALL_BASE+441)
 quotactl_fd (__NR_SYSCALL_BASE+443)
 futex_waitv (__NR_SYSCALL_BASE+449)
+set_mempolicy_home_node (__NR_SYSCALL_BASE+450)
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index d0e6e9a4b..dd0649198 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -430,3 +430,4 @@ pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+set_mempolicy_home_node 450
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index e818c9d92..785cae76d 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -371,3 +371,4 @@ epoll_pwait2 6441
 mount_setattr 6442
 quotactl_fd 6443
 futex_waitv 6449
+set_mempolicy_home_node 6450
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index 6e15f43b3..62e484487 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -347,3 +347,4 @@ epoll_pwait2 5441
 mount_setattr 5442
 quotactl_fd 5443
 futex_waitv 5449
+set_mempolicy_home_node 5450
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 921d5d331..4157a7620 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -417,3 +417,4 @@ epoll_pwait2 4441
 mount_setattr 4442
 quotactl_fd 4443
 futex_waitv 4449
+set_mempolicy_home_node 4450
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index d5de621e1..0ee900ebe 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -423,3 +423,4 @@ pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+set_mempolicy_home_node 450
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 6505f3822..36ea1c585 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -410,3 +410,4 @@ pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+set_mempolicy_home_node 450
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 316ffe5f1..5c44e5d66 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -404,3 +404,4 @@ pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+set_mempolicy_home_node 450
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index e0c60a360..dc02e654f 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -409,3 +409,4 @@ pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+set_mempolicy_home_node 450
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 1863e1df7..03087ce1d 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -351,6 +351,8 @@ pidfd_getfd 438
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+set_mempolicy_home_node 450
+cachestat 451
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514

base-commit: 419452d1b3948aad09ffccfe61f845fafcb0cc37
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
