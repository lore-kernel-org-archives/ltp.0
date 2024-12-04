Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA675E7716E
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 14:18:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA1B13DF098
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 15:18:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7E963DF047
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 15:18:31 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 25DDF143242B
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 15:18:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733321909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gDe+WialbmEeogzBRZST9msU0iRnCe7Xk9TGhcUprqg=;
 b=a0d+mUYr8tmRUYzw5sV2e+AzayRpvBn/qvL8Nri2inAkm+zzJCKF/WojEWOvNncCct6trF
 xenotVf6TWzevKe6Kou2TXUznnY5smlcHZWN/Kh84D+LOdcRZW7avLGEuhzO3NGrEMBuMq
 Bp5d1j6PFmMfdkFBMVSPBtRmuOj2b4Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-ZaRE8z0POHSHXHsMC5Anqw-1; Wed,
 04 Dec 2024 09:18:28 -0500
X-MC-Unique: ZaRE8z0POHSHXHsMC5Anqw-1
X-Mimecast-MFC-AGG-ID: ZaRE8z0POHSHXHsMC5Anqw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0FF21955E90
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 14:18:26 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F71B1956052; Wed,  4 Dec 2024 14:18:25 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Wed,  4 Dec 2024 15:18:17 +0100
Message-ID: <e1dc1e7f686bfed84f048294b3f3608e2f3e9491.1733321853.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G3nBgcccCoDZ7-bXhu-oTDaxHvI7BdIU43hiKvJGNxs_1733321907
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/getrandom05: use tst_syscall
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
Cc: liwan@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

With glibc-2.40 and recent kernel (6.12) the test uses
vdso implementation which runs into SIGSEGV for EFAULT test:

  #0  __arch_chacha20_blocks_nostack () at arch/x86/entry/vdso/vgetrandom-chacha.S:146
  146             movups          state0,0x00(output)

  (gdb) bt
  #0  __arch_chacha20_blocks_nostack () at arch/x86/entry/vdso/vgetrandom-chacha.S:146
  #1  0x00007fcd3ce6417a in __cvdso_getrandom_data (rng_info=0x7fcd3ce5f280, buffer=0xffffffffffffffff, len=64, flags=1, opaque_state=0x7fcd3ce5df00,
      opaque_len=<optimized out>) at arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:237
  #2  __cvdso_getrandom (buffer=<optimized out>, len=64, flags=1, opaque_state=0x7fcd3ce5df00, opaque_len=<optimized out>)
      at arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:259
  #3  __vdso_getrandom (buffer=0xffffffffffffffff, len=64, flags=1, opaque_state=0x7fcd3ce5df00, opaque_len=<optimized out>)
      at arch/x86/entry/vdso/vgetrandom.c:11
  #4  0x00007fcd3cc7faf3 in getrandom_vdso (buffer=0xffffffffffffffff, length=64, flags=0, cancel=<optimized out>)
      at ../sysdeps/unix/sysv/linux/getrandom.c:204
  #5  0x0000000000401ff7 in verify_getrandom (i=0) at getrandom05.c:40

Change the test to use syscall implementation of getrandom().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/getrandom/getrandom05.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getrandom/getrandom05.c b/testcases/kernel/syscalls/getrandom/getrandom05.c
index 92098deb723d..8f7ce45785c5 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom05.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom05.c
@@ -16,6 +16,7 @@
 
 #include "tst_test.h"
 #include "lapi/getrandom.h"
+#include "lapi/syscalls.h"
 
 static char buff_efault[64];
 static char buff_einval[64];
@@ -36,7 +37,7 @@ static void verify_getrandom(unsigned int i)
 {
 	struct test_case_t *tc = &tcases[i];
 
-	TST_EXP_FAIL2(getrandom(tc->buff, tc->size, tc->flag),
+	TST_EXP_FAIL2(tst_syscall(__NR_getrandom, tc->buff, tc->size, tc->flag),
 		tc->expected_errno, "%s", tc->desc);
 }
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
