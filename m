Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5306FD6CFAD
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 05:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769146896; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=YzALlHQp5doHRFdExZ042qIDIJ4y4sWVwBI8fY7IQHQ=;
 b=oyW5krdEHEcVxo+ysk/MDXQkbAkxpX39ICkEpQo9Qx9Oa/nm3WKFEv5w82zP/+ZvSSx9n
 H3HXVbN7ABVzZSK7PmrNyKxLRfYEmm7ajcCz4AOxSRGiGO55dHCUqxR9BbWcNvX/qYpajkg
 pDuBJAOg+x948YfOcy9dgT0Xpa8XdOA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 049143CAFBB
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 06:41:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82C0A3C5A8C
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 06:41:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 006916008DB
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 06:41:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769146867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=23+0HLrmDlJjNz3I+1lqbsm1xPaRGa75bm/iV+5k4p0=;
 b=auanTypmVmZbBvSrM+Nzk3obVD20HZXgG10oG4IyY/cloiN9ib0LRBD6DeZ8Q5P5SkGuoD
 gsKIeJw4PDYK9PHHv602czWdAE2old9MfsYj27SvRH510XMIKepqTRRxcC3twGPsi5i4Io
 IzqzJMnC02oWNpEioW+3B6KVQheQfWM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-SCuoetoXOKWsViBXLXb1Sw-1; Fri,
 23 Jan 2026 00:41:03 -0500
X-MC-Unique: SCuoetoXOKWsViBXLXb1Sw-1
X-Mimecast-MFC-AGG-ID: SCuoetoXOKWsViBXLXb1Sw_1769146863
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCE6218003FD; Fri, 23 Jan 2026 05:41:02 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.34])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4777F1958DC1; Fri, 23 Jan 2026 05:41:00 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 23 Jan 2026 13:40:56 +0800
Message-ID: <20260123054056.131992-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s878M80G1jByMgmViLPtpqfA692dCBV3GR_fKAI_FBI_1769146863
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] userfaultfd05: handle kernels rejecting WP feature in
 UFFDIO_API
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
Cc: Ricardo Branco <rbranco@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Commit 485a4cd2ba3 ("userfaultfd05: allow TCONF when UFFD-WP is unsupported")
added a TCONF path for missing UFFD-WP, but it relied on checking
uffdio_api.features after a failed ioctl (on RHEL-10).

That is not sufficient: it did not handle the case where UFFDIO_API
succeeds but the kernel does not advertise UFFD_FEATURE_PAGEFAULT_FLAG_WP
in the returned features mask.

So userfaultfd05 still fails on RHEL-9 s390x platform:

    userfaultfd05.c:106: TBROK: ioctl(3,((((2U|1U) << (((0+8)+8)+14)) |
		    (((0xAA)) << (0+8)) | ((((0x00))) << 0) |
		    ((((sizeof(struct uffdio_register)))) << ((0+8)+8)))),...)
		    failed: EINVAL (22)

Now, let's handle both behaviours by retrying UFFDIO_API with features=0
on EINVAL and treating a successful retry as "WP unsupported" (TCONF).
Also check the returned features mask after a successful UFFDIO_API and
skip when WP is not advertised.

And preserve the original errno so real UFFDIO_API failures are still
reported as 'TBROK | TERRNO'.

Follow-up: 485a4cd2ba3 ("userfaultfd05: allow TCONF when UFFD-WP is unsupported")
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Ricardo Branco <rbranco@suse.com>
---
 .../kernel/syscalls/userfaultfd/userfaultfd05.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
index 6cae45f20..4158b7b46 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
@@ -92,13 +92,24 @@ static void run(void)
 
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+
 	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
-		if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
-			tst_brk(TCONF, "UFFD write-protect unsupported");
+		int err = errno;
+		if (err == EINVAL) {
+			uffdio_api.api = UFFD_API;
+			uffdio_api.features = 0;
+
+			if (ioctl(uffd, UFFDIO_API, &uffdio_api) == 0)
+				tst_brk(TCONF, "UFFD write-protect unsupported");
+		}
 
-		tst_brk(TBROK | TERRNO, "ioctl() on userfaultfd failed");
+		errno = err;
+		tst_brk(TBROK | TERRNO, "ioctl(UFFDIO_API) failed");
 	}
 
+	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
+		tst_brk(TCONF, "UFFD write-protect unsupported");
+
 	uffdio_register.range.start = (unsigned long) page;
 	uffdio_register.range.len = page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
