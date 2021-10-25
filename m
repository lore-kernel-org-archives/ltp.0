Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DADBC433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 13:26:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B311B61002
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 13:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B311B61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 513F73C65EF
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 15:26:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 176A93C0958
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 15:26:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA98F6019A6
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 15:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635168382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eiBSYmXQRu7x2VYjMjsAZWoNDOf4PPHULplW8aaODng=;
 b=N2eYdQ+8DsjS5UjKF9OUP7CkmAgNQT2jfaNi+KH1XOArY1sTSxZudV1D9HJ2WyNKSu/YP7
 LBNjw6dfsVbM3HhhDG0J6zW8782lmEhqIZEqyg4HA0Vt6C2D2bfUEZvXdOwvK19J0tcMz1
 Ed3GWhypqV5cXOCMthskU8dwL97fPdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-SkznIOpFOPKGBXjhQSqnqQ-1; Mon, 25 Oct 2021 09:26:20 -0400
X-MC-Unique: SkznIOpFOPKGBXjhQSqnqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E7D78026AD
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 13:26:19 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.192.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BED660FB8
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 13:26:17 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 25 Oct 2021 15:25:42 +0200
Message-Id: <04692b4000ee415add41128173e395f830ea3e56.1635168255.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] finit_module02: fix exp. errno for O_WRONLY testcase
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

commit 032146cda855 ("vfs: check fd has read access in
kernel_read_file_from_fd()") changed errno back to EBADF,
which is correct value according to man page, so tweak
the test to expect it for kernels >= 5.15.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/finit_module/finit_module02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index 0d2bf917ea64..9b5d3563b74e 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -52,7 +52,7 @@ static void bad_fd_setup(struct tcase *tc)
 
 static void wo_file_setup(struct tcase *tc)
 {
-	if (tst_kvercmp(4, 6, 0) < 0)
+	if (tst_kvercmp(4, 6, 0) < 0 || tst_kvercmp(5, 15, 0) >= 0)
 		tc->exp_errno = EBADF;
 	else
 		tc->exp_errno = ETXTBSY;
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
