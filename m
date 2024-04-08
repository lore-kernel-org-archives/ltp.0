Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E391CD1296
	for <ltp@archiver.kernel.org>; Mon,  8 Apr 2024 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712562518; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=TLSmtFNMPI8zqC0kOtH4ke0QNAGELGg4aTs/ijUpO6k=;
 b=CFGplVbcxoTU/7ZhYDJVMyr84P518UyomylS1QVpZA22hnNhY0tt/zaBfo7yoFXNJuRzA
 juEihuVDtX95VQ2fZkVtvDctFMrQhBWcft/7rmWtZ0A1MSVfqOJywqP1Q9quAW4n4w8icXq
 Jf9toN3aXXir8QTO2Ej+qaryptBjGl8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5CB73CF542
	for <ltp@archiver.kernel.org>; Mon,  8 Apr 2024 09:48:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D85F53CF448
 for <ltp@lists.linux.it>; Mon,  8 Apr 2024 09:48:16 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=andestech.com (client-ip=60.248.80.70; helo=atcsqr.andestech.com;
 envelope-from=minachou@andestech.com; receiver=lists.linux.it)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8FF4E2001D2
 for <ltp@lists.linux.it>; Mon,  8 Apr 2024 09:48:12 +0200 (CEST)
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 4387Jdem076086
 for <ltp@lists.linux.it>; Mon, 8 Apr 2024 15:19:39 +0800 (+08)
 (envelope-from minachou@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 4387IxVS075503;
 Mon, 8 Apr 2024 15:18:59 +0800 (+08)
 (envelope-from minachou@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 8 Apr 2024 15:18:55 +0800
To: <ltp@lists.linux.it>
Date: Mon, 8 Apr 2024 15:18:48 +0800
Message-ID: <20240408071848.80862-1-minachou@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4387Jdem076086
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] waitid10: Add .needs_tmpdir=1 to run test in
 temporary directory
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
From: Hui Min Mina Chou via ltp <ltp@lists.linux.it>
Reply-To: Hui Min Mina Chou <minachou@andestech.com>
Cc: Hui Min Mina Chou <minachou@andestech.com>, tim609@andestech.com,
 cynthia@andestech.com, az70021@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When testing via NFS mount LTP folder on the board, with the NFS server
configured using 'anonuid' and 'anongid' options to set specific
uid/gid, waitid10 fails. This is due to a uid mismatch during core dump
file creation, leading to an aborted dump, resulting in the child
process receiving the signal CLD_KILLED instead of CLD_DUMPED.

  # ./waitid10
  tst_buffers.c:56: TINFO: Test is using guarded buffers
  tst_test.c:1732: TINFO: LTP version: 20240129
  tst_test.c:1616: TINFO: Timeout per run is 0h 05m 00s
  waitid10.c:64: TINFO: Raising RLIMIT_CORE rlim_cur=0 -> 0
  [  296.482665] mnt_uid= 1036, curr_uid= 0
  [  296.483041] Core dump to core aborted: cannot preserve file owner
  waitid10.c:36: TPASS: waitid(P_ALL, 0, infop, WEXITED) passed
  waitid10.c:37: TPASS: infop->si_pid == pidchild (149)
  waitid10.c:38: TPASS: infop->si_status == SIGFPE (8)
  waitid10.c:39: TPASS: infop->si_signo == SIGCHLD (17)
  waitid10.c:42: TFAIL: infop->si_code (2) != CLD_DUMPED (3)

Therefore, add .needs_tmpdir = 1 relocates the working directory to
temporary directory, preventing core file creation failures due to
NFS server settings.

Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
---
 testcases/kernel/syscalls/waitid/waitid10.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
index e55e88c2325e..9100cc2d7a54 100644
--- a/testcases/kernel/syscalls/waitid/waitid10.c
+++ b/testcases/kernel/syscalls/waitid/waitid10.c
@@ -76,4 +76,5 @@ static struct tst_test test = {
 		{&infop, .size = sizeof(*infop)},
 		{},
 	},
+	.needs_tmpdir = 1,
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
