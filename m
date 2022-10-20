Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4054C4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 03:42:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2617D3CB13B
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 05:42:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E3013CAE89
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 05:41:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5F016600C63
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 05:41:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666237311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pqWhgZh2sU42hiG11rFKz1taVZXWan68ouKs0jD9zq4=;
 b=aQBKpG8+OtiAMcNm7aNm4UhJ/b1d0bddCDxCX9Mtl7ZJguMpbk9KwZdvs6gbCOKFNa7++9
 JZvoVyI9OESjgI8xLhva9pjJ6mcyBT5VeCEq7Z+hqUo8BekMqafHa6TdqLqXTfSPUb1hQn
 mfh5L780tPrBlWAy4ySgo1RNVG4h2PI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-h67CrESCNliaXs5OP3KDQw-1; Wed, 19 Oct 2022 23:41:49 -0400
X-MC-Unique: h67CrESCNliaXs5OP3KDQw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CBEA185A7AD
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 03:41:48 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1CC1C15BB4;
 Thu, 20 Oct 2022 03:41:44 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 20 Oct 2022 11:41:40 +0800
Message-Id: <20221020034140.3472638-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kconfig: adding new config path
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
Cc: Brian Grech <bgrech@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To make kconfig parsing on RHIVOS(Red Hat In-Vehicle Operating System) correctly.

Before:
  # ./sendto03
  tst_kconfig.c:65: TINFO: Couldn't locate kernel config!
  tst_kconfig.c:201: TBROK: Cannot parse kernel .config

After:
  # ./sendto03
  tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/5.14.0-174.137.el9iv.aarch64/config'
  tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
  sendto03.c:91: TPASS: setsockopt(PACKET_RESERVE) value is capped: EINVAL (22)
  sendto03.c:197: TPASS: Nothing bad happened, probably

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Brian Grech <bgrech@redhat.com>
---
 lib/tst_kconfig.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index ac13866e8..a97489564 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -47,6 +47,12 @@ static const char *kconfig_path(char *path_buf, size_t path_buf_len)
 	/* Common install module path */
 	snprintf(path_buf, path_buf_len, "/lib/modules/%s/build/.config", un.release);
 
+	if (!access(path_buf, F_OK))
+		return path_buf;
+
+	/* RHIVOS config path */
+	snprintf(path_buf, path_buf_len, "/lib/modules/%s/config", un.release);
+
 	if (!access(path_buf, F_OK))
 		return path_buf;
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
