Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706A2C433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 03:05:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C4FC3C5AA4
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 04:04:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CB093C1FED
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 04:04:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1270F200C1C
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 04:04:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646795086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2faflGVHP9Wg+TnKjKAZR3dUkvh+RaDtVALngSmdeV0=;
 b=G1IL+dhM5fRPycle9Wim4qWLWXZPJmqmETpr6gNRPgd1iWgl21EAZekhod+ThtGR2pwz7h
 7PoFBVTiXjldQQnhvfflfb4HGdcKDN86n9Du/TqzPSouiwL39mqnTtOSAUE2A7AeVFKAV/
 x+6Ty6mmaihb6Y852Jjd6M+ylWVZCVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-4AxWdQ9QMXq0e8T2NuY5gQ-1; Tue, 08 Mar 2022 22:04:45 -0500
X-MC-Unique: 4AxWdQ9QMXq0e8T2NuY5gQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECC8B801DDC;
 Wed,  9 Mar 2022 03:04:43 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC00E56F7C;
 Wed,  9 Mar 2022 03:04:42 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed,  9 Mar 2022 11:04:38 +0800
Message-Id: <20220309030440.4166954-1-liwang@redhat.com>
In-Reply-To: <20220308073709.4125677-1-liwang@redhat.com>
References: <20220308073709.4125677-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] lib: move struct tst_sys_conf to internal
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

As it only used in tst_sys_conf library internally, there is
unnecessary to put in header file.

Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
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
