Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FB9C77B60
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 08:49:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C72453CBA62
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 10:49:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D964A3CBA25
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 10:49:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 755B820090A
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 10:49:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682671768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f/VGEAaBLoNBFp7OFFqdC3Ido2h1JVStk9UEit+7Gmw=;
 b=QNAh1WRGZfAN2NspFGo0J+WIz7hCDKf9cGBeHd0XRsSXImPohan6DkvE/HML9xdJAYI/Qo
 AEBM2Ws7jss7eH64tT0qBudIshGcUHogS9CTWQh2NmX9GwO10tiV3xoFg+ckXIDyzy4ZNO
 qn+TzMrf7xUi7nzHtdXH1h8B0CkAr5U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-XV0FPD1yMAa2h7Gos77nPA-1; Fri, 28 Apr 2023 04:49:26 -0400
X-MC-Unique: XV0FPD1yMAa2h7Gos77nPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E0D9886063;
 Fri, 28 Apr 2023 08:49:25 +0000 (UTC)
Received: from fedora-laptop.nay.redhat.com (unknown [10.66.80.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10E5C1121314;
 Fri, 28 Apr 2023 08:49:23 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 28 Apr 2023 16:49:22 +0800
Message-Id: <20230428084922.9834-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH] tst_cgroup: Avoid mixing mounts V1 and V2
 simultaneously
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

There is a tiny problem with the test logic of this tst_cgroup library,
that it potentially mixes Cgroup V1 and V2 together to be mounted at
the same time. The scenario happens once people just requests CTRL_BASE
(or a V2 controller not enabled) on a only V1-mounted system.

Cgroup community always objected to enabling Cgroup like that (V1&V2),
which may bring unexpected issues along the way.

So this patch cancels LTP mount V1&V2 simultaneously even if there is
no overlap in specific controller files.

Note:
  This patch is a follow-up on GAO Wei's work about adding CTRL_BASE.
  So we need to apply after that patchset.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Richard Palethorpe <rpalethorpe@suse.de>
Cc: Wei Gao <wegao@suse.com>
---
 lib/tst_cgroup.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index d08a31651..bceb10d1d 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -786,6 +786,10 @@ static void cgroup_copy_cpuset(const struct cgroup_root *const root)
  * If we can't mount V2 or the controller is not on V2, then we try
  * mounting it on its own V1 tree.
  *
+ * The worth mentioning here is that once there detect V1 mounted,
+ * we skip mounting V2 because LTP doesn't allow V1 and V2 mixes to
+ * be tested in any scenario, and vice versa.
+ *
  * Once we have mounted the controller somehow, we create a hierarchy
  * of cgroups. If we are on V2 we first need to enable the controller
  * for all children of root. Then we create hierarchy described in
@@ -828,13 +832,14 @@ void tst_cg_require(const char *const ctrl_name,
 	if (ctrl->ctrl_root)
 		goto mkdirs;
 
-	if (!cgroup_v2_mounted() && options->needs_ver != TST_CG_V1)
+	if (!cgroup_v2_mounted() && options->needs_ver != TST_CG_V1
+			&& !cgroup_v1_mounted())
 		cgroup_mount_v2();
 
 	if (ctrl->ctrl_root)
 		goto mkdirs;
 
-	if (options->needs_ver != TST_CG_V2)
+	if (options->needs_ver != TST_CG_V2 && !cgroup_v2_mounted())
 		cgroup_mount_v1(ctrl);
 
 	if (base)
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
