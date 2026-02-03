Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87B6E83040
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 02:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770086659; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=MbFR41/J17KdTKag7wlq8U92mkT6dTrFZTGGksYiqsI=;
 b=lInuvNT+E3MvJYTqsL3D5mhhPJ2PulezwIWu0Ss6dhejxIgc6P0J14svulG4A7PYX65p3
 95K6B/d7RpvT+izxDTKZ9ilPzeGBy8I6Mq7akhjZZWVpIrpXpY/PALYGSNuMBzsSa/0dhIJ
 hRCg5HoZugNeFoem/sm8fqGGLVGb5LE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F3433CCFB0
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 03:44:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5236D3CC5F6
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 03:43:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 99FFD1A0098C
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 03:43:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770086610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E1QEGPElWViM5JPB3Ddts/YQPIcT32Fe8uKbynbPYB8=;
 b=NuvN6EW7i/+8+J12eTXoJZRVd2asSogqfGu13C2AQAsWqQM5pMTGIyaEm4vN93PoYAtVHr
 ncjBxyIM3fvQ9QS7iSC5Cu/ZEbcK6szN0TfkxB3vogew0TxGq/uOV8Lt1y18CQKbuoXbFj
 VG3qY2rcfFxC+Z/lk+bWjoxXO182mQc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-KjQWtCAFO_OAQqGAfcNuNQ-1; Mon,
 02 Feb 2026 21:43:29 -0500
X-MC-Unique: KjQWtCAFO_OAQqGAfcNuNQ-1
X-Mimecast-MFC-AGG-ID: KjQWtCAFO_OAQqGAfcNuNQ_1770086608
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D51E195608F
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 02:43:28 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 552B91956053
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 02:43:26 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  3 Feb 2026 10:43:20 +0800
Message-ID: <20260203024320.227453-2-liwang@redhat.com>
In-Reply-To: <20260203024320.227453-1-liwang@redhat.com>
References: <20260203024320.227453-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ehV6Oebs9D0wk2m49rjB-utCrF1rPfBnQQ53BdeClfU_1770086608
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] newlib_tests: add tst_filesystems01 to
 .gitignore
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/newlib_tests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index a4984d2ec..1586e0ad6 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -46,6 +46,7 @@ test_macros03
 test_macros04
 test_macros05
 test_macros06
+tst_filesystems01
 tst_fuzzy_sync01
 tst_fuzzy_sync02
 tst_fuzzy_sync03
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
