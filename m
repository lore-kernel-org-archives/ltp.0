Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7A2ECAAD8
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 03:10:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B726B3CAC1D
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 05:10:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 061943C1B85
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 05:10:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DF4DC601AF3
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 05:10:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663211425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+6zrHnrAwc2vB8S4O3J1oeUhyNB1Q1Uad6FNBnz0C60=;
 b=cQSXE3Kf/DfM11OnZWaOq8g4dLVIbU2obj/bTWivc1KErmdT2w+fKWkdL0s8mjQKIK7d1i
 Fv4+Uhn0ILqHuyEfCuPqx0xLH5Td9br3AacdUZXs5OjYlIMMmmx+BNEPRVZ7PWtcullfJq
 pOWUS2yzQvKMVi0mBewpbESVCCmtApc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-c3nBaTY0OTexDcBaC_aoxg-1; Wed, 14 Sep 2022 23:10:23 -0400
X-MC-Unique: c3nBaTY0OTexDcBaC_aoxg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 999EE3C0D851
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 03:10:23 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3E9449BB60
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 03:10:22 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 15 Sep 2022 11:10:20 +0800
Message-Id: <20220915031020.2633347-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open04: add EMFILE check
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

[pre-release testing fix]

Test in automation easily get EMFILE error before reaching the fds_limit,
but hard to reproduce it again manually. The possible reason is that some
shared fd being opened in the parent shell and occupying the fd numbers
which inherited by test then results in open failed with EMFILE early.

This patch adds back of the EMFILE check in the open() loops, to flexible
test fd limitation.

  open04.c:36: TBROK: open(open04.1020,66,0777) failed: EMFILE (24)
  open04.c:53: TWARN: close(0) failed: EBADF (9)

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/open/open04.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
index d452405d4..01a8b12d6 100644
--- a/testcases/kernel/syscalls/open/open04.c
+++ b/testcases/kernel/syscalls/open/open04.c
@@ -33,7 +33,12 @@ static void setup(void)
 
 	for (i = first + 1; i < fds_limit; i++) {
 		sprintf(fname, FNAME ".%d", i);
-		fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0777);
+		fd = open(fname, O_RDWR | O_CREAT, 0777);
+		if (fd == -1) {
+			if (errno != EMFILE)
+				tst_brk(TBROK, "Expected EMFILE but got %d", errno);
+			break;
+		}
 		fds[i - first] = fd;
 	}
 }
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
