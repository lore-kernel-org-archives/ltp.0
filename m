Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB0DEB64DC
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 10:54:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FAA93CCA78
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 12:54:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EEB23C99AD
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 12:54:17 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 014C9200925
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 12:54:11 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 35RAs0bL032548;
 Tue, 27 Jun 2023 18:54:00 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atcsi01.andestech.com (10.0.15.167) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 27 Jun 2023
 18:53:58 +0800
From: Randolph Lin <randolph@andestech.com>
To: <ltp@lists.linux.it>
Date: Tue, 27 Jun 2023 18:53:34 +0800
Message-ID: <20230627105334.2358121-1-randolph@andestech.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.167]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 35RAs0bL032548
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/prctl04: Allow __NR_waitid in the syscall
 filter
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
Cc: minachou@andestech.com, tim609@andestech.com, kester.tw@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Randolph <randolph@andestech.com>

The __NR_wait4 syscall is not available in y2038 safe 32-bit systems,
waitid should be used instead. In the 32ABI system, the __NR_waitid
must be allowed as well in the filter.

refer:
https://sourceware.org/git/gitweb.cgi?p=glibc.git;h=9b2cf9482a9397c4711c9e7f42f8d718b6306bdc
linux: Use waitid on wait4 if __NR_wait4 is not defined

Signed-off-by: Randolph <randolph@andestech.com>
Signed-off-by: Dylan Jhong <dylan@andestech.com>
---
 testcases/kernel/syscalls/prctl/prctl04.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
index f6e1f0fea..8b135d611 100644
--- a/testcases/kernel/syscalls/prctl/prctl04.c
+++ b/testcases/kernel/syscalls/prctl/prctl04.c
@@ -45,6 +45,7 @@
 static const struct sock_filter  strict_filter[] = {
 	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, (offsetof(struct seccomp_data, nr))),
 
+	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_waitid, 7, 0),
 	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_rt_sigprocmask, 6, 0),
 	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_close, 5, 0),
 	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_exit,  4, 0),
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
