Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E6CC433F5
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 10:52:53 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01B161107
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 10:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D01B161107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7564A3C8F3E
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 12:52:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5E503C848C
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 12:52:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 46E956013E9
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 12:52:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632480759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ngsB6JVPRrJl8r/EJsfUVxGYyE/tN9fvJkJVaIwauc=;
 b=bicX2k3JyubzuwOzaj4QrMXYG70hRtzHPnpLV8Oc5wvjJywEtRGNiYo8HIzqMBIUuMtjAU
 owYzw9yViUA+A0kapNXbhdsbK9CmnR9bZM5mQ+NABQik1Oi+ruVmOIyEm05WgMqNadjE2k
 H9cXG9gg1V0StkvFGi15vRbubRPGd0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-BdZIXXNZNwaC4Y4p4qlTqQ-1; Fri, 24 Sep 2021 06:52:38 -0400
X-MC-Unique: BdZIXXNZNwaC4Y4p4qlTqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35FAB835DE2;
 Fri, 24 Sep 2021 10:52:37 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7AF21017E27;
 Fri, 24 Sep 2021 10:52:35 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 24 Sep 2021 18:52:34 +0800
Message-Id: <20210924105234.3927811-1-liwang@redhat.com>
In-Reply-To: <20210924070756.3916953-3-liwang@redhat.com>
References: <20210924070756.3916953-3-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] lib: adjust the tmpfs size according to
 .dev_min_size and MemAvailable
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

Since commit c305a53c5 (lib: limit the size of tmpfs in LTP, Jul 9)
Ltp set tmpfs mount size according to the tdev.size. This cause a
new problem on small RAM system, which consume too much memory and
finally trigger OOM.

To fix this, let's adjust the tmpfs-size according to both free memory
and .dev_min_size:

 - if .dev_min_size is defined and system has enough free memory,
   set tmpfs-size to tdev.size

 - if .dev_min_size is defined and there is not enough free
   memory -> TCONF

 - if the test not define .dev_min_size, set the size for tmpfs to
   be really small 32MB

 - if .dev_min_size is not define and there is not even 64MB of free
   memory (for 32MB limit) -> TCONF

Reported-by: Ralph Siemsen <ralph.siemsen@linaro.org>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_test.h |  1 +
 lib/tst_test.c     | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 5e3619698..3dcb45de0 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -42,6 +42,7 @@
 #include "tst_lockdown.h"
 #include "tst_fips.h"
 #include "tst_taint.h"
+#include "tst_memutils.h"
 
 /*
  * Reports testcase result.
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 4224353da..ec80e17a6 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -892,15 +892,25 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
 static const char *limit_tmpfs_mount_size(const char *mnt_data,
 		char *buf, size_t buf_size, const char *fs_type)
 {
+	unsigned int tmpfs_size;
+
 	if (strcmp(fs_type, "tmpfs"))
 		return mnt_data;
 
+	if (!tst_test->dev_min_size)
+		tmpfs_size = 32;
+	else
+		tmpfs_size = tdev.size;
+
+	if ((tst_available_mem() / 1024) < (tmpfs_size * 2))
+		tst_brk(TCONF, "No enough memory for tmpfs use");
+
 	if (mnt_data)
-		snprintf(buf, buf_size, "%s,size=%luM", mnt_data, tdev.size);
+		snprintf(buf, buf_size, "%s,size=%luM", mnt_data, tmpfs_size);
 	else
-		snprintf(buf, buf_size, "size=%luM", tdev.size);
+		snprintf(buf, buf_size, "size=%luM", tmpfs_size);
 
-	tst_res(TINFO, "Limiting tmpfs size to %luMB", tdev.size);
+	tst_res(TINFO, "Limiting tmpfs size to %luMB", tmpfs_size);
 
 	return buf;
 }
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
