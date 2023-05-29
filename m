Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E609CC77B7A
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 06:11:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B400C3CCFE5
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 08:11:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 260813CA128
 for <ltp@lists.linux.it>; Mon, 29 May 2023 08:11:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BFD9E1A002EE
 for <ltp@lists.linux.it>; Mon, 29 May 2023 08:11:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685340700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pWHRNIcG52E1kCBWP3VJEpQYJrQVuIOIzA/DMIF07Tg=;
 b=fm7F7ewnq8m1Gfq7GlKdT1ghG9Zq6ta4n3fO1Xohb/VciPQmJULVEFQ/wL7rUU7ycWASKi
 15caJg2CFxssQR1eFLm4Ca3kYkyZftijzwdnaiys93fJWC1prgcF2GAbwPxbsVLUpofhja
 CtVRJK33fFaU906h/O9ILp5EdXDDGuo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-lgoY_ZfONFe9we5w8UdnBw-1; Mon, 29 May 2023 02:11:38 -0400
X-MC-Unique: lgoY_ZfONFe9we5w8UdnBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1477185A78E
 for <ltp@lists.linux.it>; Mon, 29 May 2023 06:11:38 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B05173543C
 for <ltp@lists.linux.it>; Mon, 29 May 2023 06:11:37 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 29 May 2023 14:11:34 +0800
Message-Id: <20230529061135.24261-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] hugemmap32: release mem caches and prepare for
 hugepage
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

As Martin pointed that mem caches count as available, we'd better
release them for huge page use.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
index 36a426a09..76b790a95 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
@@ -64,6 +64,7 @@ static void setup(void)
 
 	SAFE_CLOSEDIR(dir);
 
+	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
 	if (tst_available_mem() < (long long)hpage_size) {
 		g_hpage_path[0] = '\0';
 		tst_brk(TCONF, "No enough memory for gigantic hugepage reservation");
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
