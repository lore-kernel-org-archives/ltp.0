Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA582C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 09:08:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E2013C8BAA
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 10:08:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B6693C2FF6
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 10:07:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C28F11401391
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 10:07:33 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2DDF61F3C5;
 Tue, 14 Dec 2021 09:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639472853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wShGmfe40mU3FCM486AfxSK+p+TS4vW9Vi9BDC+rGiA=;
 b=SyvWneNL+Ht4ebyAbk/SmDJELWjKg45DjMc0a+g5l36a5AMu4aWB6GD6du/N1I1qdJSTkP
 oJjK5L5fXJqot+QuKGWs2JDCJtAjJnh5UV92Ps14QIGWuVke1Tbjh5TbCJWGISbXbndh/i
 Cx0gEUoBbloV43sKzQfo4TYdspq3eNg=
Received: from g78.suse.de (unknown [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id E74F7A3B81;
 Tue, 14 Dec 2021 09:07:32 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Dec 2021 09:06:48 +0000
Message-Id: <20211214090648.14292-5-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211214090648.14292-1-rpalethorpe@suse.com>
References: <20211214090648.14292-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] scripts/coccinelle: Helper for converting CGroup
 selftests
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Helps with bulk rewriting.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../coccinelle/kselftest-cgroup-to-ltp.cocci  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 scripts/coccinelle/kselftest-cgroup-to-ltp.cocci

diff --git a/scripts/coccinelle/kselftest-cgroup-to-ltp.cocci b/scripts/coccinelle/kselftest-cgroup-to-ltp.cocci
new file mode 100644
index 000000000..f91c2c467
--- /dev/null
+++ b/scripts/coccinelle/kselftest-cgroup-to-ltp.cocci
@@ -0,0 +1,40 @@
+@@
+expression cgn, cgns;
+@@
+
+- cgn = cg_name(..., cgns);
++ cgn = tst_cgroup_group_mk(cg_test, cgns);
+
+@@
+expression cg, fname, data;
+@@
+
+- if (cg_write(cg, fname, data)) {
+-    ...
+- }
++ SAFE_CGROUP_PRINT(cg, fname, data);
+
+@@
+expression cg;
+@@
+
+... when != TST_CGROUP_VER(...)
+
+- SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");
++ if (TST_CGROUP_VER(cg, "memory") != TST_CGROUP_V1)
++    SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");
+
+@@
+expression cg, fname, needle;
+@@
+
+- cg_read_strstr(cg, fname, needle)
++ !SAFE_CGROUP_OCCURSIN(cg, fname, needle)
+
+@@
+identifier l;
+expression cg, fname;
+@@
+
+- l = cg_read_long(cg, fname);
++ SAFE_CGROUP_SCANF(cg, fname, "%ld", &l);
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
