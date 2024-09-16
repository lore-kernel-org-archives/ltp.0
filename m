Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECADC3ABB2
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 08:30:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05E5B3C2B62
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 10:30:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12D2E3C2B1D
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 10:30:33 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 057B81A00EAC
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 10:30:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726475431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4Gqv0AsZ3ee4DKzfO0fijMwyPanfp1jCzRC0R3RyqnE=;
 b=AOBweQh5I8I5/v01sFHNSPvSDFRTrurlMuWU9QMuGMci2OUJgw6wP7HKS43C87A3IR6hsG
 HsaARR6i3PH3C/itVGzcK/g0V8Nc94Zqfj/J8pJv6OdSy/9zjKPAvBIfVNQ68KKPZKV9cb
 NglceDCTFASh4y7ZptgIZXaxky56ajU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-_JZxccFvPlql2SdSFvT4Rw-1; Mon,
 16 Sep 2024 04:30:30 -0400
X-MC-Unique: _JZxccFvPlql2SdSFvT4Rw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16F511956089
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 08:30:28 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.226.2])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40A97195605A
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 08:30:26 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 16 Sep 2024 10:30:24 +0200
Message-ID: <b35bcb5fb9a87e218ddccd3944b961568a831aa4.1726475265.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/getdents02: reserve big enough buffer
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

The test sporadically fails EFAULT testcase because kernel can iterate over
directory entries in different order. In most runs the first entry it finds
is '.', but in others it can be 'lost+found' or directory/file created by test.

Test currently only reserves space for buffer via tst_dirp_size(),
which uses sizeof() and doesn't take into account number of entries or
the size of d_name.

Since sizeof returns the aligned size, in some runs there's just enough
space for '.' entry, and test fails as expected on EFAULT. But if there's
entry with larger d_name we hit EINVAL check first and test fails.

Reserve large enough buffer.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/getdents/getdents02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index 805a8bc481e6..d17410c52afc 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -60,7 +60,8 @@ static void setup(void)
 {
 	getdents_info();
 
-	size = tst_dirp_size();
+	/* reserve big enough buffer for all entries we might find */
+	size = 4096;
 	dirp = tst_alloc(size);
 
 	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
