Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D2FD7497D
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 08:46:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 389143CAA18
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 09:46:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 231233C7270
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 09:46:11 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6F3741000D46
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 09:46:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730277968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4rkHw19snWo2Nj5F1dlCTR7JjY2gbg0JWRp/GwaXVmg=;
 b=UT4Ld9FPp41tkSaMYKqZ8bUzavJmlknMJJuW4sRHp2A6FQ82pzsNiOLNgpvlz9kfFIGAtB
 vfFydGCzw5VyU1avfLvld7NFHdY5hVeg54xudx/LmRoh0n+3tdv/C9AsjFaOXj69mQxwOI
 /nwBDZ46w5GPM0OP2hSklcAw0vklfJA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-QCnXJQ39MYi6z8YycVxqwA-1; Wed,
 30 Oct 2024 04:46:07 -0400
X-MC-Unique: QCnXJQ39MYi6z8YycVxqwA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2BDD1955F67; Wed, 30 Oct 2024 08:46:05 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FE7F19560AA; Wed, 30 Oct 2024 08:46:03 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 30 Oct 2024 16:45:58 +0800
Message-ID: <20241030084558.195297-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: Print failure hints only once to reduce log
 duplication
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

The LTP test currently prints failure hints multiple times if a test
encounters several TFAIL or TBROK results. This leads to unnecessarily
verbose and duplicated logs.

This patch modifies the `print_failure_hints()` function to ensure that
failure hints are printed only once per test run. By setting `show_failure_hints`
to 0 after the first print, subsequent calls to `print_failure_hints()`
will not produce redundant output.

Fixes: 701212f08 ("Disable failure hints before we actually run the test")
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index d942a91f1..8db554dea 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -911,6 +911,8 @@ static void print_failure_hints(void)
 	print_failure_hint("musl-git", "missing musl fixes", MUSL_GIT_URL);
 	print_failure_hint("CVE", "vulnerable to CVE(s)", CVE_DB_URL);
 	print_failure_hint("known-fail", "hit by known kernel failures", NULL);
+
+	show_failure_hints = 0;
 }
 
 static void do_exit(int ret)
-- 
2.46.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
