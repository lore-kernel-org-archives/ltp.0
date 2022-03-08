Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0CCC433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 07:37:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6552D3C1C61
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 08:37:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F10D73C1B93
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 08:37:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 78EC2600069
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 08:37:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646725036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8t3HkUUvAq3bVVPpbAwjU9yHLzLN7fQw5F86P8POcQM=;
 b=IJ7HxcKU8AUEC4W/b02re9U3UFhs5O37U3Th6sYUdYGUviTb8k52TbeAaYGxuTtdLMNtQN
 +2QgGYiO7Nb4x8emgYUtqpAAYejUDv7wBbJ1Q9pWK5mmTpgRqhwqcEgFKKYP9g5x303dSW
 LtqPjyK5qYmcQdI+gpF40JsRr2/losM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-5WvtxF4eM8Kzw8DE2YMq-A-1; Tue, 08 Mar 2022 02:37:14 -0500
X-MC-Unique: 5WvtxF4eM8Kzw8DE2YMq-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A75FF1091DA0
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 07:37:13 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0DA9101E68B
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 07:37:12 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  8 Mar 2022 15:37:06 +0800
Message-Id: <20220308073709.4125677-2-liwang@redhat.com>
In-Reply-To: <20220308073709.4125677-1-liwang@redhat.com>
References: <20220308073709.4125677-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] lib: move struct tst_sys_conf to internal
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

As it only used in tst_sys_conf library interanlly, there is
unnecessary to put in header file.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_sys_conf.h | 6 ------
 lib/tst_sys_conf.c     | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/tst_sys_conf.h b/include/tst_sys_conf.h
index 323e29a27..507a552e8 100644
--- a/include/tst_sys_conf.h
+++ b/include/tst_sys_conf.h
@@ -5,12 +5,6 @@
 #ifndef TST_SYS_CONF_H__
 #define TST_SYS_CONF_H__
 
-struct tst_sys_conf {
-	char path[PATH_MAX];
-	char value[PATH_MAX];
-	struct tst_sys_conf *next;
-};
-
 int tst_sys_conf_save_str(const char *path, const char *value);
 int tst_sys_conf_save(const char *path);
 void tst_sys_conf_restore(int verbose);
diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
index 4ad9f8b9b..d7118f15f 100644
--- a/lib/tst_sys_conf.c
+++ b/lib/tst_sys_conf.c
@@ -12,6 +12,12 @@
 #include "tst_test.h"
 #include "tst_sys_conf.h"
 
+struct tst_sys_conf {
+	char path[PATH_MAX];
+	char value[PATH_MAX];
+	struct tst_sys_conf *next;
+};
+
 static struct tst_sys_conf *save_restore_data;
 
 void tst_sys_conf_dump(void)
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
