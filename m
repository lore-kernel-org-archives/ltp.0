Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD483D690ED
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 09:50:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CE493DBB60
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 10:50:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 054573D8700
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 11:14:16 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=xiubli@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 43244640759
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 11:14:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732011254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ueASQKJafuwZGIhDR5ZXwdNvgqXWFXHgTxgMIzhnJvE=;
 b=DzDfxQB/cERU8yqoPNrdf0CRL/tFv0bwGZzE6uLTEX+PUS1As4RTYXV+dPU/fipMn1DQgk
 w7cmWthAtCme9ylHoP0XBPgnjcfAzkf+CAjOKEoSoIVjcxmedgSnOCiI3VnSlCjL2NkcgN
 I5MX9LJFgtC2QHIJYMoNx171i0jQshA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-brqBwNqKMSq91r47n6S4vg-1; Tue,
 19 Nov 2024 05:14:10 -0500
X-MC-Unique: brqBwNqKMSq91r47n6S4vg-1
X-Mimecast-MFC-AGG-ID: brqBwNqKMSq91r47n6S4vg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A93EF1955BD2; Tue, 19 Nov 2024 10:14:09 +0000 (UTC)
Received: from xiubli-thinkpadp16vgen1.rmtcn.com (unknown [10.72.112.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 383391955F40; Tue, 19 Nov 2024 10:14:06 +0000 (UTC)
From: xiubli@redhat.com
To: ltp@lists.linux.it
Date: Tue, 19 Nov 2024 18:13:57 +0800
Message-ID: <20241119101357.951813-1-xiubli@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 28 Nov 2024 10:49:51 +0100
Subject: [LTP] [PATCH] doc: correct the build steps for open_posix_testsuite
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

'./configure' is needed just before generating the Makefiles.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 doc/users/quick_start.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
index 1581b1f0c..e80c1c244 100644
--- a/doc/users/quick_start.rst
+++ b/doc/users/quick_start.rst
@@ -54,6 +54,7 @@ generated first:
 .. code-block:: console
 
    $ cd testcases/open_posix_testsuite/
+   $ ./configure
    $ make generate-makefiles
    $ cd conformance/interfaces/foo
    $ make
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
