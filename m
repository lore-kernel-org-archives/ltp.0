Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E137BEC01A1
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 07:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774252126; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=3R/qMkCMm9J86hW9Fzoi+iuNdr77HOWVbgst3vLuYhg=;
 b=HNkZ2WxdhjyWkUWKB1FYFN945SMoDNX3EGuMrYDOLNbYem1Ljybb9ThELaN9HGBJMFpVC
 FdGdJU/0W6vGrGW+gcBfl2SdrPU/PIcj/4WjysdC8XwLo3zhgMsT0wUq9Xwz5cxt+fYBum3
 vKMV9o5m3WVKyoG9ne4aZBridcsid9E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8600B3E17EA
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 08:48:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63A903C6147
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 08:48:21 +0100 (CET)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7D149600AB2
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 08:48:20 +0100 (CET)
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2b059511554so54072705ad.0
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774252099; x=1774856899; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=/x9Ba7YymFzERHWEZslDPbAQsLyj7chTkUVuZ50U0PQ=;
 b=hxDuVnE5dlDiTNFk1qg+i0MzyQVUd3NmSdpLWdHeLns76LQQlXeOIziIHIPvDaSt4N
 bxBGD67+8f/r4mZbnSO2XKES/9DgWOjRnZ7W9koUlCNtKdcqI56j3woikQaefe2S3viy
 QGJC4BWAL+OVHGstCpCuWUceB3vzSiNnNQFOAVMzI3CMIJgGnKKMi+Bm0dcn+EFzr1Zv
 oxidEh6/jAXGAtf6tSAjMG0bt9Yf2zvZx7PfqbLS5GpG2m/uRS8saPFgT91Wu7S4P37P
 +QbI5Rfp/Jjrru2eKEHdNaVmsfA8rp/wD6t5S5hQ74gXpejOutx9RvuMBEG80C3DL2ER
 xJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774252099; x=1774856899;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/x9Ba7YymFzERHWEZslDPbAQsLyj7chTkUVuZ50U0PQ=;
 b=KQ8Pvl9nCvoDozV6cCoL6g3hc6d9X3hmAXT7o8uyU8X5YkfbGZn1GOez2eF0AxQPxz
 DH2Y9EvOgwJEGsk/6Lawsdb+CmVrAa+Ib8FpYTXLST23TThem50Mz1RULqElaToWfgeo
 2qiBDcnO0ifsccxK6hCuiKccriVH4Ctd6gzf1pkyu4IOE6ZHABOvgK+z2bkDdcJzYlqS
 QVm3atVBU8fdmgHubc8QmHCA+f201sKCP8sR158Dk0zkB6Rwrw/EVBRBsn9Y7QkKEzIZ
 5fDwRs/uNmgQVK5dj+RUvZTCYspHGMhmG7DRgIbm/C2Za7eI6sj4bJSCZAPfTZ8F3uAc
 fejw==
X-Gm-Message-State: AOJu0YzQmBbz0gvWa+w0SrEV2H0khvWgNlPiLCXX5ZcNE7rA3EtpOC60
 vxzKthgCIPjiQ9eQeBv/ltbq1hRq4YllbAGgjJz1vRVC1sqk4H8z46rlv9ZXE0XSkOUuPZ9dfCY
 3WHQnsgf3vlQeI9/rokmdzJvj5ysnYohMdpqSSOT71bfVBsAlUwMW00WdKA7rkSKxrNO0XynwdD
 dXAgJ2eLxaEVcCdXkNabLJhVRseA==
X-Received: from plblc4.prod.google.com ([2002:a17:902:fa84:b0:2b0:5c78:84a7])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f984:b0:2ae:c795:6b4a
 with SMTP id d9443c01a7336-2b0826d73f3mr76070305ad.11.1774252098401; Mon, 23
 Mar 2026 00:48:18 -0700 (PDT)
Date: Mon, 23 Mar 2026 07:48:14 +0000
In-Reply-To: <CAOcRiAF3gkD8QDr2L7g7DXpUwUurYDh7k-vBMmw=um5AdnuNMw@mail.gmail.com>
Mime-Version: 1.0
References: <CAOcRiAF3gkD8QDr2L7g7DXpUwUurYDh7k-vBMmw=um5AdnuNMw@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323074814.2930709-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/file_attr01: Dynamically expect
 EOPNOTSUPP on tmpfs without xattr
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The syscalls file_getattr and file_setattr return EOPNOTSUPP instead of
EFAULT when the ufattr argument is NULL on tmpfs without xattr support
(CONFIG_TMPFS_XATTR=n). This is because the kernel checks for the
filesystem operation support before dereferencing the user pointer.

This patch adds a runtime check for CONFIG_TMPFS_XATTR when testing
on tmpfs, ensuring the correct errno is expected based on the kernel
configuration. This prevents hiding potential kernel bugs where
EOPNOTSUPP might be returned even when xattr is supported.

Changes in v2:
- Replaced the TST_EXP_FAIL_ARR approach with a dynamic check in run().
- Included tst_kconfig.h and used tst_kconfig_check() to verify
  CONFIG_TMPFS_XATTR status.
- Expected EOPNOTSUPP only on tmpfs when xattr support is missing,
  otherwise default to EFAULT.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/file_attr/file_attr01.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/file_attr/file_attr01.c b/testcases/kernel/syscalls/file_attr/file_attr01.c
index c9c9288a1..43e0f0503 100644
--- a/testcases/kernel/syscalls/file_attr/file_attr01.c
+++ b/testcases/kernel/syscalls/file_attr/file_attr01.c
@@ -18,6 +18,7 @@
 
 #include <string.h>
 #include "tst_test.h"
+#include "tst_kconfig.h"
 #include "lapi/fs.h"
 #include "lapi/fcntl.h"
 
@@ -115,20 +116,28 @@ static struct tcase {
 static void run(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
+	int exp_errno = tc->exp_errno;
+
+	if (tc->ufattr == (struct file_attr **)(&null_ptr)) {
+		const char *const kconfig[] = {"CONFIG_TMPFS_XATTR=y", NULL};
+
+		if (!strcmp(tst_device->fs_type, "tmpfs") && tst_kconfig_check(kconfig))
+			exp_errno = EOPNOTSUPP;
+	}
 
 	if (tst_variant) {
 		TST_EXP_FAIL(file_getattr(
 			*tc->dfd, *tc->filename,
 			*tc->ufattr, *tc->usize,
 			tc->at_flags),
-			tc->exp_errno,
+			exp_errno,
 			"%s", tc->msg);
 	} else {
 		TST_EXP_FAIL(file_setattr(
 			*tc->dfd, *tc->filename,
 			*tc->ufattr, *tc->usize,
 			tc->at_flags),
-			tc->exp_errno,
+			exp_errno,
 			"%s", tc->msg);
 	}
 }
-- 
2.53.0.983.g0bb29b3bc5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
