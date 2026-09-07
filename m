Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD84FC79F9F
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 01:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788745610; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=fecB621cfE1Prw+kDsbHQSMW9zGmDDygqHomYsilGI0=;
 b=GZvUjMp7xrMz9t9RJjfHZ/i6hA3CQEcrmPvd5LXQKzzWlXD0U/Ok0Iv01mJpjFQqT80ro
 xBlxnxBylI+5fDFUFQVtVIFks4YFUgwNIvmTfEcPPjoUf74p0tVyTHy+x59m5VdtMygHGgI
 w7fXadhHWV6hRc8ifoj9PlhBkexEcRc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55E6B3E49F7
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 03:46:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED2973C83A9
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 03:46:23 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AED1B140010B
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 03:46:20 +0200 (CEST)
Received: from mail.andestech.com (atcpcs54.andestech.com [10.0.1.154])
 by Atcsqr.andestech.com with ESMTPS id 6871kBbO021691
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Sep 2026 09:46:11 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs54.andestech.com
 (10.0.1.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Mon, 7 Sep
 2026 09:46:11 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Sep
 2026 09:46:11 +0800
To: <ltp@lists.linux.it>
Date: Mon, 7 Sep 2026 09:45:17 +0800
Message-ID: <20260907014516.450196-2-cyyang772@andestech.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs54.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 6871kBbO021691
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] hugemmap24: Restrict the 1TB slice layout to
 64-bit powerpc
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

The 1TB-slice branch of init_slice_boundary() is guarded by __LP64__
minus a blocklist of architectures that do not have powerpc slices.
Every new 64-bit architecture has to be added to that blocklist, and rv64
is the next one to trip over it.

The virtual address space of an rv64 kernel in Sv39 MMU mode is split in
half between user and kernel, leaving TASK_SIZE = 0x4000000000 (256 GB).
Every candidate boundary from 1 TB up is above the end of the user
address space, so the MAP_FIXED mmap() fails with ENOMEM on all
iterations and the test reports a bogus failure:

  hugemmap24.c:62: TINFO: can't use slice_boundary: 0x100000000000: ENOMEM (12)
  hugemmap24.c:71: TFAIL: couldn't find 2 free neighbour slices: ENOMEM (12)

Invert the check instead of extending the blocklist. 1 TB slices only
exist on 64-bit powerpc. Every other architecture falls back to the
256 MB layout at low addresses. Sv48 and Sv57 do provide a large enough
user range, but the test must also pass on Sv39, so RISC-V takes the
fallback unconditionally.

Suggested-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
---
v2: Invert the exclusion into a 64-bit powerpc allowlist, per Andrea.
Link to v1: https://lore.kernel.org/ltp/20260824082350.70245-1-cyyang772@andestech.com/
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index 0de44d58a..9e23c253f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -28,12 +28,12 @@ static int init_slice_boundary(int fd)
 	unsigned long slice_size;
 	void *p, *heap;
 	int i;
-#if defined(__LP64__) && !defined(__aarch64__) && !defined(__loongarch__)
+#if defined(__powerpc64__) || (defined(__powerpc__) && defined(__LP64__))
 	/* powerpc: 1TB slices starting at 1 TB */
 	slice_boundary = 0x10000000000;
 	slice_size = 0x10000000000;
 #else
-	/* powerpc: 256MB slices up to 4GB */
+	/* powerpc (32-bit) and other arches: 256MB slices up to 4GB */
 	slice_boundary = 0x00000000;
 	slice_size = 0x10000000;
 #endif
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
