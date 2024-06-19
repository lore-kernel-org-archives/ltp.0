Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FF2C27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 07:34:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D8723D0DB0
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 09:34:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D17393D0D99
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 09:33:58 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A76BD14011BF
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 09:33:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718782435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NfSfpC6658KyPm4vvRRh9bYXHpVI5YyGWL6s3aHT/7Q=;
 b=QWF6XnVtC41aSL3o1c88ja0TKibo4hYXuj3065F/jYthOnIGf0aIcdhZpFCkUb3OkYhNJM
 ZodQXdsbiBvgp0psd3BxMyBD34SKZmoXrJYl6Sax7mdlCbSN4ySWfPdQbPi7VC5642E/bO
 Kqq3XEOKi7uKPNNawFlR0pr9kRxQLLg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-cqSIZvKrP6uS7ButKWTukw-1; Wed,
 19 Jun 2024 03:33:53 -0400
X-MC-Unique: cqSIZvKrP6uS7ButKWTukw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B85619560AD; Wed, 19 Jun 2024 07:33:52 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BB8A19560B2; Wed, 19 Jun 2024 07:33:49 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Wed, 19 Jun 2024 15:33:45 +0800
Message-ID: <20240619073345.326108-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_kconfig: Avoid buffer overflow when parsing
 /proc/cmdline
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

When the test is run with a kernel booting with many parameters, the
buffer size is often not large enough to store the complete command
line. This results in a buffer overflow and the test complains with
the following message:

  tst_kconfig.c:609: TWARN: Buffer overflowed while parsing /proc/cmdline

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_kconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index e16ca1400..be3842c2d 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -569,7 +569,7 @@ char tst_kconfig_get(const char *confname)
 
 void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len)
 {
-	char buf[128], line[512];
+	char buf[512], line[512];
 	size_t b_pos = 0,l_pos =0, i;
 	int var_id = -1;
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
