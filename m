Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C448C02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 08:23:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E4DE3C26B2
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 09:23:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E31A83C232A
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 09:22:48 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1FF40643D4C
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 09:22:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737447766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QL60ctAsapZVYyiZ9b3byHc0S26MuhsSPzYYYCbFwec=;
 b=FSmrdehMpjPLQh9pjO+57wRb6qXvhhvD8zQYP0PuxqMeu6YifT/kJC2NwlVWXaCHAljlGy
 M3V7Hl6Dvk/hQQiK/2wOnEE/wKa3Ig0wEAYx7kh+yvoGNOfwflgusthytWQNDo8yvSCqB/
 ArJIEtRb8o4WlgUSTngRJZdSe6SSRzE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-Kf-uxXuZNcaXsI3mc0jCVA-1; Tue,
 21 Jan 2025 03:22:44 -0500
X-MC-Unique: Kf-uxXuZNcaXsI3mc0jCVA-1
X-Mimecast-MFC-AGG-ID: Kf-uxXuZNcaXsI3mc0jCVA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2F491955E88
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 08:22:42 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9F10195608E
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 08:22:41 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 16:22:36 +0800
Message-ID: <20250121082236.5247-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4hxWjIzdW-yIHIqsLCgLMcEkq6_P06w5APlx41jW1Vc_1737447763
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] eventfd06: add AIO support check
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

Just like what we did for io_setup01.c to avoid ENOSYS error:
  eventfd06.c:140: TBROK: io_setup() failed: ENOSYS

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/eventfd/eventfd06.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/eventfd/eventfd06.c b/testcases/kernel/syscalls/eventfd/eventfd06.c
index 7339dd471..46d7f73d3 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd06.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd06.c
@@ -136,6 +136,8 @@ static void test_poll(void)
 static void setup(void)
 {
 	TEST(io_setup(MAXEVENTS, &ctx));
+	if (TST_RET == -ENOSYS)
+		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by kernel");
 	if (TST_RET < 0)
 		tst_brk(TBROK, "io_setup() failed: %s", tst_strerrno(-TST_RET));
 
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
