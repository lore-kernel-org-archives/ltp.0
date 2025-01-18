Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E277C02187
	for <ltp@archiver.kernel.org>; Sat, 18 Jan 2025 10:26:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DD5C3C7C51
	for <ltp@archiver.kernel.org>; Sat, 18 Jan 2025 11:26:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22FC73C5480
 for <ltp@lists.linux.it>; Sat, 18 Jan 2025 11:26:28 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DE7672359BF
 for <ltp@lists.linux.it>; Sat, 18 Jan 2025 11:26:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737195985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FYk7fFCftkck0DgUVwObhfcZpMuuQ8ydWH6AcnX0/Kw=;
 b=P1xMMnJFzq/GIOWg3VjgmtJEqPNekP07CjMbEvLueudFdmPJoAxD6yt+KJt1nvFzkIrJ6o
 Ab4eNb1QlW5iO5oXi7VfUjWpu8kndJdeXZk2/VDePHw1Jtqzd4NkqCphd6768aoJH1jByQ
 IoIy8XNPdWTm3JgtUypeRmqlvD5NY0E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-vaV9to4cPQOi_K-TQcjCBg-1; Sat,
 18 Jan 2025 05:26:23 -0500
X-MC-Unique: vaV9to4cPQOi_K-TQcjCBg-1
X-Mimecast-MFC-AGG-ID: vaV9to4cPQOi_K-TQcjCBg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9344195608A; Sat, 18 Jan 2025 10:26:22 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17EDD19560A3; Sat, 18 Jan 2025 10:26:20 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sat, 18 Jan 2025 18:26:15 +0800
Message-ID: <20250118102615.127485-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6hGV2s-GWlN96_ynm-cmJJt3xsL754mXtqyWMTFomxk_1737195983
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: switch cgroup bit-fields from signed to unsigned
 int
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

There is a problem in cgroup lib that the declearation int
can lead to -1 during the | operation.

Becasue if the field contains uninitialized garbage data,
a bit-field declared as int could interpret 0b1 as -1 due
to signed arithmetic.

By changing the type to unsigned int, the issue is avoided
since unsigned fields cannot represent negative values.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Jin Guojie <guojie.jin@gmail.com>
---

Notes:
    @Cyril, Petr, I vote to merge this patch before the release.
    @Guojie, Could you plz repost your memcontrol04 patch based on this change?

 include/tst_test.h |  2 +-
 lib/tst_cgroup.c   | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 5b3889e64..eb73cd593 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -610,7 +610,7 @@ struct tst_fs {
 
 	const char *const *needs_cgroup_ctrls;
 
-	int needs_cgroup_nsdelegate:1;
+	unsigned int needs_cgroup_nsdelegate:1;
 };
 
 /**
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 6055015eb..aa13ac8ec 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -44,7 +44,7 @@ struct cgroup_dir {
 	 */
 	int dir_fd;
 
-	int we_created_it:1;
+	unsigned int we_created_it:1;
 };
 
 /* The root of a CGroup hierarchy/tree */
@@ -71,11 +71,11 @@ struct cgroup_root {
 	/* CGroup for current test. Which may have children. */
 	struct cgroup_dir test_dir;
 
-	int nsdelegate:1;
+	unsigned int nsdelegate:1;
 
-	int we_mounted_it:1;
+	unsigned int we_mounted_it:1;
 	/* cpuset is in compatability mode */
-	int no_cpuset_prefix:1;
+	unsigned int no_cpuset_prefix:1;
 };
 
 /* Controller sub-systems */
@@ -138,7 +138,7 @@ struct cgroup_ctrl {
 	/* Runtime; hierarchy the controller is attached to */
 	struct cgroup_root *ctrl_root;
 	/* Runtime; whether we required the controller */
-	int we_require_it:1;
+	unsigned int we_require_it:1;
 };
 
 struct tst_cg_group {
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
