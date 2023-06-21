Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28313EB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 00:29:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DF1C3CD404
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 02:29:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E1E33C9E39
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 02:29:20 +0200 (CEST)
Received: from smtp.priv.miraclelinux.com
 (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 43706140043C
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 02:29:18 +0200 (CEST)
Received: from localhost.localdomain (21A0035i-SL7B460.priv.miraclelinux.com
 [10.2.1.161])
 by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 76E3614006E;
 Wed, 21 Jun 2023 09:29:11 +0900 (JST)
From: Souta Kawahara <souta.kawahara@miraclelinux.com>
To: ltp@lists.linux.it
Date: Wed, 21 Jun 2023 09:20:57 +0900
Message-Id: <7ac34b5102d65e6bb7112234f6ad685e98d066f2.1687306661.git.souta.kawahara@miraclelinux.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <80595ab205ea7b3f633bf4228bb43ee999aef3a1.1687247273.git.souta.kawahara@miraclelinux.com>
References: <80595ab205ea7b3f633bf4228bb43ee999aef3a1.1687247273.git.souta.kawahara@miraclelinux.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] runtest/cve: Add some existing CVE tests to
 runtest file
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

Signed-off-by: Souta Kawahara <souta.kawahara@miraclelinux.com>
---
 runtest/cve | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index f9a449fe7..bbc552bea 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -24,6 +24,7 @@ cve-2017-6951 request_key05
 cve-2017-7308 setsockopt02
 cve-2017-7472 keyctl04
 cve-2017-7616 set_mempolicy05
+cve-2017-8890 accept02
 cve-2017-10661 timerfd_settime02
 cve-2017-12192 keyctl07
 cve-2017-12193 add_key04
@@ -41,16 +42,19 @@ cve-2017-17805 af_alg02
 cve-2017-17806 af_alg01
 cve-2017-17807 request_key04
 cve-2017-18075 pcrypt_aead01
+cve-2017-18344 timer_create03
 cve-2017-1000111 setsockopt07
 cve-2017-1000112 setsockopt05
 cve-2017-1000364 stack_clash
 cve-2017-1000380 snd_timer01
 cve-2017-1000405 thp04
 cve-2018-5803 sctp_big_chunk
+cve-2018-6927 futex_cmp_requeue02
 cve-2018-7566 snd_seq01
 cve-2018-8897 ptrace09
 cve-2018-9568 connect02
 cve-2018-10124 kill13
+cve-2018-11508 adjtimex03
 cve-2018-12896 timer_settime03
 cve-2018-13405 creat09
 cve-2018-18445 bpf_prog04
@@ -66,15 +70,23 @@ cve-2020-14386 sendto03
 cve-2020-14416 pty03
 cve-2020-25705 icmp_rate_limit01
 cve-2020-29373 io_uring02
+cve-2020-36557 pty06
 cve-2021-3444 bpf_prog05
 cve-2021-3609 can_bcm01
+cve-2021-3653 kvm_svm01
+cve-2021-3656 kvm_svm02
 cve-2021-4034 execve06
+cve-2021-4197_1 cgroup_core01
+cve-2021-4197_2 cgroup_core02
+cve-2021-4204 bpf_prog06
 cve-2021-22555 setsockopt08 -i 100
 cve-2021-26708 vsock01
 cve-2021-22600 setsockopt09
+cve-2021-38198 kvm_pagefault01
 cve-2021-38604 mq_notify03
 cve-2022-0847 dirtypipe
 cve-2022-2590 dirtyc0w_shmem
+cve-2022-23222 bpf_prog07
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
 cve-2022-0185 fsconfig03
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
