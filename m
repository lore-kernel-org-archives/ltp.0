Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF193E7717F
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 01:17:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B93C3E94BF
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 02:17:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 424083E9497
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 02:16:51 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=xiubli@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6F276631990
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 02:16:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733879807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oHGpBCqgacuTgNAdPBHWAn7Y5cTUtS6u2zviZxXY3hc=;
 b=PhFin5NOKJp1eyV0CpwtxILVet5Sten4NoRIX5+IqAv+xxJCoh72js0CN+ItWrwjFCIVwF
 Cl4cbPwkjOZFeC8saMZ+ntuEKTV8wBBXSoYaDwxrnHPm62bn4IBjdxf8zDIKfQsubsQJDp
 u1S3zF5LsZuaLDLMPWtce/ID45Mlliw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-iTHrxjH9NPCTYES_9HihwA-1; Tue,
 10 Dec 2024 20:16:45 -0500
X-MC-Unique: iTHrxjH9NPCTYES_9HihwA-1
X-Mimecast-MFC-AGG-ID: iTHrxjH9NPCTYES_9HihwA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3024219560AE; Wed, 11 Dec 2024 01:16:44 +0000 (UTC)
Received: from xiubli-thinkpadp16vgen1.rmtcn.com (unknown [10.72.112.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A28B19560A2; Wed, 11 Dec 2024 01:16:40 +0000 (UTC)
From: xiubli@redhat.com
To: ltp@lists.linux.it
Date: Wed, 11 Dec 2024 09:16:36 +0800
Message-ID: <20241211011636.499499-1-xiubli@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] doc: correct the build steps for
 open_posix_testsuite
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
Cc: linux-integrity@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Xiubo Li <xiubli@redhat.com>

'./configure --with-open-posix-testsuite' is needed just before
generating the Makefiles.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---

V3:
- switch to use --with-open-posix-testsuite option instead.

V2:
- a minor fixing about the order, thanks Cyril.


 doc/users/quick_start.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
index 1581b1f0c..8a25b9129 100644
--- a/doc/users/quick_start.rst
+++ b/doc/users/quick_start.rst
@@ -53,6 +53,7 @@ generated first:
 
 .. code-block:: console
 
+   $ ./configure --with-open-posix-testsuite
    $ cd testcases/open_posix_testsuite/
    $ make generate-makefiles
    $ cd conformance/interfaces/foo
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
