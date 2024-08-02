Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825E8C3DA4A
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 08:12:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0E943D1F42
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 10:12:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A1D63D1D69
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:11:51 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 19CAA600C4A
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722586308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GiaefJ/taETNuLBlSzhUhhw7B1MEvBjncrRSP31UUr0=;
 b=NUHHNW4xZKCViiOd5i8gIM+1RHdueuFgNVOyP/v+S6QenCFe45sEhCzbNV4/KcpjIqqLXq
 +uCBjHkt3lK/o1wLuf7U0/C07B9uxyP7WpSB6McW8/asK61fgRECr096odbIVyWUh0r2h3
 Eqd8BnGzGvBAwpNzYUoM3xfEfw01Fqc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-yO9zvkobNYmUouceJzOTZw-1; Fri,
 02 Aug 2024 04:11:45 -0400
X-MC-Unique: yO9zvkobNYmUouceJzOTZw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB1081955D42; Fri,  2 Aug 2024 08:11:43 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDAEC1955D42; Fri,  2 Aug 2024 08:11:41 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it,
	andrea.cervesato@suse.de
Date: Fri,  2 Aug 2024 16:11:36 +0800
Message-ID: <20240802081136.271850-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] catchestat01: skip some tests loop with large pagesize
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
Cc: Bruno Goncalves <bgoncalv@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To avoid errors with ENOSPC on systems with large page sizes (e.g., ppc64le
with 64kB page size), this patch updates the test_cached_pages function to
check the total memory requirement against the available device size before
running the test. If the required memory exceeds the available device size,
the test is skipped with a message indicating that the device size is not
sufficient for testing.

Also, loosen 45MB for XFS filesystem because it needs a bit of space
for inodes or others.

This prevents errors like the following:

  83  cachestat01.c:39: TINFO: Number of pages: 8192
  84  cachestat01.c:46: TBROK: write(3,0x10037180be0,65536) failed: ENOSPC (28)

Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/cachestat/cachestat01.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
index f7f6275cb..44cbc1f23 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat01.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -36,7 +36,10 @@ static void test_cached_pages(const unsigned int use_sync, const int num_pages)
 	int fd;
 
 	tst_res(TINFO, "%s file synchronization", use_sync ? "Enable" : "Disable");
-	tst_res(TINFO, "Number of pages: %d", num_pages);
+	tst_res(TINFO, "Number of pages: %d, Page_size: %d", num_pages, page_size);
+
+	if ((uint64_t)page_size * num_pages >= (tst_device->size - 64) * 1024 * 1024)
+		tst_brk(TCONF, "Device size (%luMB) is not enough for testing", tst_device->size);
 
 	memset(cs, 0, sizeof(struct cachestat));
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
