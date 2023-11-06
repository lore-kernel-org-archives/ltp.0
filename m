Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F2CC4332F
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 09:31:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EC503CE871
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 10:31:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FC723CC72A
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 10:30:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B49FC10011C3
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 10:30:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699263044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4CLBaYy/njdz8+jsl4dFMlMIxI5HcKd3ltaHx30t54=;
 b=Ya8FlmYtvihjbFzWBq5JZ3oA8QImgA2qWYiu8hTl6iPWOsHoOWwHsieG24Vm7TdmGyofJd
 5jDBtz+yXiT0UfN6iIabqzVz7hbmo90rm6bSSKvj9v2dA96Zjei6YiKER9MPk5qeoh+ENG
 8C6WS5uNVdQEvVEmJAeTsPX93JgBsMU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-LM7z2pHvNEWuzePMKfxePw-1; Mon,
 06 Nov 2023 04:30:39 -0500
X-MC-Unique: LM7z2pHvNEWuzePMKfxePw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9FEE3C100A2
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 09:30:38 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDF411C060AE
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 09:30:37 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  6 Nov 2023 17:30:30 +0800
Message-Id: <20231106093031.1844129-3-liwang@redhat.com>
In-Reply-To: <20231106093031.1844129-1-liwang@redhat.com>
References: <20231106093031.1844129-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] hugemmap32: improvement test
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap32.c  | 59 +------------------
 1 file changed, 2 insertions(+), 57 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
index d27e5b8b2..8f57a79ac 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
@@ -18,67 +18,13 @@
 
 #define _GNU_SOURCE
 #include <dirent.h>
-
 #include <stdio.h>
 
 #include "hugetlb.h"
 
-#define PATH_HUGEPAGE "/sys/kernel/mm/hugepages"
-#define GIGANTIC_MIN_ORDER 10
-
-static int org_g_hpages;
-static char g_hpage_path[4096];
-
 static void run_test(void)
 {
-	if (FILE_PRINTF(g_hpage_path, "%d", 1))
-		tst_brk(TCONF, "Can't update the gigantic hugepages.");
-	SAFE_FILE_PRINTF(g_hpage_path, "%d", 0);
-
-	if (tst_taint_check())
-		tst_res(TFAIL, "Freeing Gigantic pages resulted in Bad Page State bug.");
-	else
-		tst_res(TPASS, "Successfully freed the gigantic hugepages");
-}
-
-static void setup(void)
-{
-	DIR *dir;
-	struct dirent *ent;
-	unsigned long hpage_size;
-
-	if (access(PATH_HUGEPAGE, F_OK))
-		tst_brk(TCONF, "hugetlbfs is not supported");
-
-	dir = SAFE_OPENDIR(PATH_HUGEPAGE);
-	while ((ent = SAFE_READDIR(dir))) {
-		if ((sscanf(ent->d_name, "hugepages-%lukB", &hpage_size) == 1) &&
-			is_hugetlb_gigantic(hpage_size * 1024)) {
-			sprintf(g_hpage_path, "%s/%s/%s", PATH_HUGEPAGE,
-					ent->d_name, "nr_hugepages");
-			break;
-		}
-	}
-	if (!g_hpage_path[0])
-		tst_brk(TCONF, "Gigantic hugepages not supported");
-
-	SAFE_CLOSEDIR(dir);
-
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
-	SAFE_FILE_PRINTF("/proc/sys/vm/compact_memory", "1");
-
-	if (tst_available_mem() < (long long)hpage_size) {
-		g_hpage_path[0] = '\0';
-		tst_brk(TCONF, "No enough memory for gigantic hugepage reservation");
-	}
-
-	SAFE_FILE_LINES_SCANF(g_hpage_path, "%d", &org_g_hpages);
-}
-
-static void cleanup(void)
-{
-	if (g_hpage_path[0])
-		SAFE_FILE_PRINTF(g_hpage_path, "%d", org_g_hpages);
+	tst_res(TPASS, "If reserved & freed the gigantic page completely, then regard as pass");
 }
 
 static struct tst_test test = {
@@ -88,8 +34,7 @@ static struct tst_test test = {
 	    {}
 	},
 	.needs_root = 1,
-	.setup = setup,
-	.cleanup = cleanup,
+	.hugepages = {1, TST_NEEDS, TST_GIGANTIC},
 	.test_all = run_test,
 	.taint_check = TST_TAINT_B,
 };
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
