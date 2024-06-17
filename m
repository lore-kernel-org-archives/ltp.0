Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90179C27C53
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 03:13:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B2413D0D06
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 05:13:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66DDF3CD7F4
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 05:13:37 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 93779601223
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 05:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718594014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SxMvZ5RrUHuoElRxiG/OjXTl0iU1YYK6s4CpMEijkM0=;
 b=e0CI9F7cdN16LT4ONFNN//oNKWitp1KJMksbpP51kza3fJL9jOU+db6nzuo/Dlz5Vk/HqV
 dxTG4HD8WB2XggXiX7OsLhixXNuqRkqTApSEPW6bYm+cSw0LlSmj+2frStsTbpKYXfUySB
 qaZxnK9Po7hw9ZgRFJKeFwjnVIyVXIE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-O5TJ55xpMvK5k0fVulL9og-1; Sun,
 16 Jun 2024 23:13:32 -0400
X-MC-Unique: O5TJ55xpMvK5k0fVulL9og-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82D4719560AD
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 03:13:31 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21B7B1956048
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 03:13:29 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 17 Jun 2024 11:13:24 +0800
Message-ID: <20240617031324.298353-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] libswap: Fix tst_max_swapfiles() for c9s-latest
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

Code change (merged in -441.el9) removes the `CONFIG_PTE_MARKER`,
so that configuration impacts the 'SWP_PTE_MAKER_NUM' judgement
inside that testcase, so we need to do is adjust the swapon03
testcase to get correct numbers of MAX_SWAPFILES to test.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 libs/libltpswap/libswap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index ce419a76e..5edc848a3 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -255,6 +255,12 @@ int tst_max_swapfiles(void)
 		{ NULL, NULL},
 	};
 
+	struct tst_kern_exv kvers_marker_migration2[] = {
+		/* RHEL9 kernel has patch ca92ea3dc5a since 5.14.0-441 */
+		{ "RHEL9", "5.14.0-441" },
+		{ NULL, NULL},
+	};
+
 	struct tst_kern_exv kvers_device[] = {
 		/* SLES12-SP4 has patch 5042db43cc26 since 4.12.14-5.5 */
 		{ "SLES", "4.12.14-5.5" },
@@ -285,7 +291,7 @@ int tst_max_swapfiles(void)
 
 	if ((marker.choice == 'y' &&
 	     tst_kvercmp2(5, 19, 0, kvers_marker_migration) >= 0)
-	    || tst_kvercmp(6, 2, 0) >= 0) {
+	    || tst_kvercmp2(6, 2, 0, kvers_marker_migration2) >= 0) {
 		swp_pte_marker_num = 1;
 	}
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
