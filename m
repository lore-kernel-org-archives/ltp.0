Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154FBC433EF
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 01:38:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 146723CA99D
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 03:38:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F01F3CA988
 for <ltp@lists.linux.it>; Thu, 12 May 2022 03:38:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C1424600ACB
 for <ltp@lists.linux.it>; Thu, 12 May 2022 03:38:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652319513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDDabYY8a+Q5tBeqZKXMCQQBzWv/QKrca15NTrr/LYI=;
 b=bM5kQsa6DnycW366vdupXoAf+ua7Op4KQHIFEvdO3aKewCed0s8C/qa832MgkYFWD9o7/8
 ji89BOws0mbC2clgzhT4AhcSzvT6M8bVEdVtC3xlCPtplrkf8iYLlS/9qiGeFKOIY4gM4z
 Le2s2GMqr6xWWz7husRywnJWB4Vea/w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-lQiHM-V2NY-IJfMIt3ddLg-1; Wed, 11 May 2022 21:38:31 -0400
X-MC-Unique: lQiHM-V2NY-IJfMIt3ddLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A3AE100BAAC;
 Thu, 12 May 2022 01:38:31 +0000 (UTC)
Received: from mail (unknown [10.22.8.118])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE8BAC28122;
 Thu, 12 May 2022 01:38:30 +0000 (UTC)
From: Andrea Arcangeli <aarcange@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 11 May 2022 21:38:30 -0400
Message-Id: <20220512013830.8534-2-aarcange@redhat.com>
In-Reply-To: <20220512013830.8534-1-aarcange@redhat.com>
References: <20220512013830.8534-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=aarcange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ksm: fix occasional page_volatile false positives
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
Cc: Eirik Fuller <efuller@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The KSM scan keeps running while checking the KSM status in sysfs, but
during the KSM scan the the rmap_items in the stale unstable tree of
the old pass are removed from it and are later reinserted in the new
unstable tree of the current pass, leading to some page_volatile
false positives.

The fix is stop the KSM scan temporarily while the KSM status is being
read from sysfs.

For reference here's an instance of the fixed false positives:

mem.c:255: TFAIL: pages_volatile is not 0 but 1.
mem.c:255: TFAIL: pages_unshared is not 1 but 0.

Reported-by: Eirik Fuller <efuller@redhat.com>
Co-developed-by: Li Wang <liwan@redhat.com>
Tested-by: Li Wang <liwan@redhat.com>
Tested-by: Eirik Fuller <efuller@redhat.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 090569ebb..8ddd7adf7 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -261,14 +261,31 @@ static void final_group_check(int run, int pages_shared, int pages_sharing,
 			  int pages_volatile, int pages_unshared,
 			  int sleep_millisecs, int pages_to_scan)
 {
+	int ksm_run_orig;
+
 	tst_res(TINFO, "check!");
 	check("run", run);
+
+	/*
+	 * Temporarily stop the KSM scan during the checks: during the
+	 * KSM scan the rmap_items in the stale unstable tree of the
+	 * old pass are removed from it and are later reinserted in
+	 * the new unstable tree of the current pass. So if the checks
+	 * run in the race window between removal and re-insertion, it
+	 * can lead to unexpected false positives where page_volatile
+	 * is elevated and page_unshared is recessed.
+	 */
+	SAFE_FILE_SCANF(PATH_KSM "run", "%d", &ksm_run_orig);
+	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
+
 	check("pages_shared", pages_shared);
 	check("pages_sharing", pages_sharing);
 	check("pages_volatile", pages_volatile);
 	check("pages_unshared", pages_unshared);
 	check("sleep_millisecs", sleep_millisecs);
 	check("pages_to_scan", pages_to_scan);
+
+	SAFE_FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
 }
 
 void ksm_group_check(int run, int pages_shared, int pages_sharing,


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
