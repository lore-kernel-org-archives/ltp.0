Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F5C433FE
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 07:08:31 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6B66124C
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 07:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA6B66124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CABA3C8F29
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 09:08:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C5F63C1B72
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 09:08:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E752820119E
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 09:08:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632467287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYpnlsjapoeL0wfI8tK5nov/Fc8wTVmcPsb7YD0Rcz8=;
 b=Aq+aDOhBljJLctqLhX8Zdfbo4GSnOh8E5qjTGlSnVFfPtOpBwiPbbonWnhLFtiOFAyD+7P
 C4l75TWXluHb9G9Az7nUSQapvkmLU3NEVcLWpusscJ+R+1GjppxlKrtTue1OagOpZJmZ31
 zk/HPDOuTMxIV5mD6dZ/YiK+BkHwLRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-_tekr_EgOo-G_X08l7KlbA-1; Fri, 24 Sep 2021 03:08:06 -0400
X-MC-Unique: _tekr_EgOo-G_X08l7KlbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CBC51006AA2;
 Fri, 24 Sep 2021 07:08:05 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6240519724;
 Fri, 24 Sep 2021 07:08:04 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 24 Sep 2021 15:07:56 +0800
Message-Id: <20210924070756.3916953-3-liwang@redhat.com>
In-Reply-To: <20210924070756.3916953-1-liwang@redhat.com>
References: <20210924070756.3916953-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] lib: unlimit the tmpfs size when test on small
 systems
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

To fix this, let's cancel the tmpfs size limitation when MemAvailable
is less than twofold of tdev.size.

Reported-by: Ralph Siemsen <ralph.siemsen@linaro.org>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_test.h | 1 +
 lib/tst_test.c     | 3 +++
 2 files changed, 4 insertions(+)

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
index 4224353da..b50856f20 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -895,6 +895,9 @@ static const char *limit_tmpfs_mount_size(const char *mnt_data,
 	if (strcmp(fs_type, "tmpfs"))
 		return mnt_data;
 
+	if ((tst_available_mem() / 1024) < (tdev.size * 2))
+		return mnt_data;
+
 	if (mnt_data)
 		snprintf(buf, buf_size, "%s,size=%luM", mnt_data, tdev.size);
 	else
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
