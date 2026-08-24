Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFECC5DF94
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 08:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787559911; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=+3MkscC7TUs6n8AcRnwMbqwD1UYqHoShM8MBQ2Uo1V0=;
 b=rkAgW3zt8/sy3UD00Ot+4WMC/idXir5JfP0/ct33QV9Pfp2pRUicjy0X5fs/cjr707+KY
 46uD4s5T56Oy6uQtTl836qIW9ZSKsrm1m+1vRsJnkfDd+C3s/VdkRt/PoLhFK6ADYFQHtyY
 U3ZpVtVkkXiEPJ4OnDksDUurDjDC0vc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A40223D02EF
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 10:25:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 469B33C062E
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 10:24:51 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CD50760072A
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 10:24:44 +0200 (CEST)
Received: from mail.andestech.com (atcpcs55.andestech.com [10.0.1.155])
 by Atcsqr.andestech.com with ESMTPS id 67O8OYVW090645
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 16:24:34 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs55.andestech.com
 (10.0.1.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Mon, 24 Aug
 2026 16:24:34 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Aug
 2026 16:24:34 +0800
To: <ltp@lists.linux.it>
Date: Mon, 24 Aug 2026 16:23:50 +0800
Message-ID: <20260824082350.70245-1-cyyang772@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs55.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 67O8OYVW090645
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap24: Exclude RISC-V from the powerpc slice
 layout
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
From: Victor Cheng-Yen Yang via ltp <ltp@lists.linux.it>
Reply-To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Exclude RISC-V with the same way loongarch is excluded from the powerpc
1TB slices branch.

Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index 0de44d58a..882752792 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -28,7 +28,8 @@ static int init_slice_boundary(int fd)
 	unsigned long slice_size;
 	void *p, *heap;
 	int i;
-#if defined(__LP64__) && !defined(__aarch64__) && !defined(__loongarch__)
+#if defined(__LP64__) && !defined(__aarch64__) && !defined(__loongarch__) && \
+	!defined(__riscv)
 	/* powerpc: 1TB slices starting at 1 TB */
 	slice_boundary = 0x10000000000;
 	slice_size = 0x10000000000;
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
