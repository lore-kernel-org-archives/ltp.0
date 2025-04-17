Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AFDC369C7
	for <ltp@archiver.kernel.org>; Thu, 17 Apr 2025 09:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744880738; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Ma+lUdajcIGIipNPkBiPp5Ep1BDV7hiADWRSL6+EyYw=;
 b=lnIGbhe0Q9r9fYVb81Loi8DPc/8He9ZTNFYRlslTvrgBXkz4OOrU8mNBO3srFTzb1apjo
 +xw7S60Q6wj5dpQBKCZonh6lw/e/hdwtXIUgsX6OVBsgt1CCRS/3dd31/DrvEVyKGbr1Xnz
 3WJMw4IKdCNi1fmbdtjpurk1DFul7wE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C10B83CB9E0
	for <ltp@archiver.kernel.org>; Thu, 17 Apr 2025 11:05:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E8CF3CB9BE
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 11:05:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F1851600055
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 11:05:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744880714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=K5uIHrztNU8cWqugNhQ80/8EamxKxgJwana+yG/r6Wo=;
 b=PGPYfUsNAupLjlx7KAzrJdcqp/0DzL4IkMn55CzX1odo+32P//sbDWXUIMbKxtpJxvFHN4
 5eQSQ+7LlVVg8ufmhAgtKO7dU1btxUA6MGPtRqMe0eL3MEHVRyCWlBrup32DgIHgH7mdaZ
 clx6JPukigY1PxZDSObFIx+JIYLZoUU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-n2CZ6azgM1Gn6eatufZC2g-1; Thu,
 17 Apr 2025 05:05:13 -0400
X-MC-Unique: n2CZ6azgM1Gn6eatufZC2g-1
X-Mimecast-MFC-AGG-ID: n2CZ6azgM1Gn6eatufZC2g_1744880712
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E7161801A04
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 09:05:12 +0000 (UTC)
Received: from t14ultra.redhat.com (unknown [10.44.32.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25B77180045B
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 09:05:10 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 17 Apr 2025 11:05:29 +0200
Message-ID: <a2bdb9dc2d4160f11751053c4c047bb302d0c1a1.1744880683.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fxzBqPJrVEmvQoJW46PL1lpCoUtiPRYJF_NTMTdGAq8_1744880712
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/setsockopt10: handle explicit disallow of
 disconnect
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since commit 5071a1e606b3 ("net: tls: explicitly disallow disconnect") in
6.15 kernel, disconnect is now explicitly disallowed.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/setsockopt/setsockopt10.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt10.c b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
index e52c6cd9338f..f955f4e83a44 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt10.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
@@ -145,7 +145,16 @@ static void run(void)
 	TST_CHECKPOINT_WAKE(1);
 
 	tst_res(TINFO, "parent: Disconnect by setting unspec address");
-	SAFE_CONNECT(tcp1_sk, &unspec_addr, sizeof(unspec_addr));
+	TEST(connect(tcp1_sk, &unspec_addr, sizeof(unspec_addr)));
+	if (TST_RET == -1) {
+		if (TST_ERR == EOPNOTSUPP)
+			tst_res(TPASS | TTERRNO, "parent: tls disallows disconnect");
+		else
+			tst_res(TFAIL | TTERRNO, "parent: unexpected errno from connect");
+		TST_CHECKPOINT_WAKE(2);
+		tst_reap_children();
+		return;
+	}
 	SAFE_BIND(tcp1_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr));
 
 	TEST(listen(tcp1_sk, 1));
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
