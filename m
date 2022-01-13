Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409B1C433EF
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 12:34:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D82F53C9511
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 13:34:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F153B3C821C
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 13:34:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DABD32009AF
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 13:34:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642077263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UgjUgSlqyxFpDxesBLoJx8vGSeahZyH83rklSd/qxlo=;
 b=bZSptKSQSK5SF8mYVkgAhbae3ZBPGYVSJnkAQmga9WUZB8HkOkt0dPu82dq+CUIQVeMEsu
 SagqDAsz96y8z9Ovhw+o1WpI0f67B3JfxT4ybuzrA3LQ+b6NOVooWSsnGqyCrfNTVp52ax
 /ZLFmglDWX0+RtLa1vz3dqfDg0qIESM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-axcFmUaYPdqLVFOSPgeyuw-1; Thu, 13 Jan 2022 07:34:22 -0500
X-MC-Unique: axcFmUaYPdqLVFOSPgeyuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EFA81006AAC;
 Thu, 13 Jan 2022 12:34:21 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C897272FA4;
 Thu, 13 Jan 2022 12:34:19 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 13 Jan 2022 20:34:18 +0800
Message-Id: <20220113123418.1911231-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: rewrite cgroup_find_ctrl with using for_each_ctrl
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
Cc: rpalethorpe@suse.com, luke.nowakowskikrijger@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It is safe to start from controllers[0] to traverse each of
the controller whatever V2 or V1, then we can make use of it
in the cgroup_find_ctrl() function.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_cgroup.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 2ef599d9e..10b65364b 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -214,7 +214,7 @@ static const char *cgroup_v2_ltp_mount = "unified";
 #define for_each_v1_root(r)			\
 	for ((r) = roots + 1; (r)->ver; (r)++)
 #define for_each_ctrl(ctrl)			\
-	for ((ctrl) = controllers + 1; (ctrl)->ctrl_name; (ctrl)++)
+	for ((ctrl) = controllers; (ctrl)->ctrl_name; (ctrl)++)
 
 /* In all cases except one, this only loops once.
  *
@@ -325,15 +325,14 @@ void tst_cgroup_print_config(void)
 __attribute__ ((nonnull, warn_unused_result))
 static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
 {
-	struct cgroup_ctrl *ctrl = controllers;
-
-	while (ctrl->ctrl_name && strcmp(ctrl_name, ctrl->ctrl_name))
-		ctrl++;
+	struct cgroup_ctrl *ctrl;
 
-	if (!ctrl->ctrl_name)
-		ctrl = NULL;
+	for_each_ctrl(ctrl) {
+		if (!strcmp(ctrl_name, ctrl->ctrl_name))
+			return ctrl;
+	}
 
-	return ctrl;
+	return NULL;
 }
 
 /* Determine if a mounted cgroup hierarchy is unique and record it if so.
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
