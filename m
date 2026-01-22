Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254F6C44500
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769077369; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=YA9p/9zb4Z3PU10/rAUEqtyz3yVq4wM3vtxbYIDjEQA=;
 b=d5+JHqnN+aSLrVDXMwrWF/gac+moTo4hosYGiI+aX/IvxC0to3WRVOq6oO/ExeO6cThXg
 cbQuRQWQJy03FmV7OcjhlFeHrZYm5lmohXAzSwkz2m7NAw+RduoT6mlecW4fU1Qq5xTTsR0
 V4Kb3HoVinOy2TV0SIbr+pIRmaEcMcQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B75763CB3C9
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 11:22:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE9823CAFD9
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 11:22:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D80731400DFC
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 11:22:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769077342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oVOOIoL8iFqAKcc0OimknbcRtCoZADh79VWql0V+QBo=;
 b=ePMBCaCHlDMHquVkdJ4tjp+pC+Cyg8GDgpBeiz+PwaA19EeHXLeMAGQfptqkk/WOlKAYtc
 mjDTaiap9yxCTQperSBiesXaKVUrJ6MphtYgW1uKAOC05WXxfHIHQkz2ihyH+qDiMhQ7NO
 u1GPPr7valGr5P5M9Mda8MjFlWkBwUg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-9hekLAuKO1W2FjDmi_gscg-1; Thu,
 22 Jan 2026 05:22:18 -0500
X-MC-Unique: 9hekLAuKO1W2FjDmi_gscg-1
X-Mimecast-MFC-AGG-ID: 9hekLAuKO1W2FjDmi_gscg_1769077338
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86C931800378; Thu, 22 Jan 2026 10:22:17 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.167])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EF98180099A; Thu, 22 Jan 2026 10:22:15 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 22 Jan 2026 18:22:10 +0800
Message-ID: <20260122102210.87453-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QwSksfZ6iHRzEnJks_1nZUqt6oT0I0XULwQFiBex3x4_1769077338
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] userfaultfd05: allow TCONF when UFFD-WP is unsupported
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
Cc: Christian Amann <camann@suse.com>, Ricardo Branco <rbranco@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On system without enable CONFIG_HAVE_ARCH_USERFAULTFD_WP kernel option,
test will fail like below:

  userfaultfd05.c:95: TBROK: ioctl(3,((((2U|1U) << (((0+8)+8)+14)) |
    (((0xAA)) << (0+8)) | ((((0x3F))) << 0) |
    ((((sizeof(struct uffdio_api)))) << ((0+8)+8)))),...)
   	 failed: EINVAL (22)

The original test uses SAFE_IOCTL macro, which prematurely triggers
TBROK and prevents the test from verifying UFFD_FEATURE_PAGEFAULT_FLAG_WP.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Christian Amann <camann@suse.com>
Cc: Ricardo Branco <rbranco@suse.com>
---
 testcases/kernel/syscalls/userfaultfd/userfaultfd05.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
index c4edc2529..9cb0bb08f 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
@@ -92,11 +92,11 @@ static void run(void)
 
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
-	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
+		if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
+			tst_brk(TCONF, "UFFD write-protect unsupported");
 
-	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
-		tst_brk(TCONF, "UFFD write-protect unsupported");
-		return;
+		tst_brk(TBROK | TERRNO, "ioctl_userfaultfd failed");
 	}
 
 	uffdio_register.range.start = (unsigned long) page;
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
