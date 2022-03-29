Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12516C433EF
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 07:45:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FCE43C9E93
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 09:45:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CF373C9BD2
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 09:44:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF0051A00E0F
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 09:44:48 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9629D1F872;
 Tue, 29 Mar 2022 07:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1648539887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HY9uFId2Q3x3FdFyezX1Mb88Ir/+paHSBTjAYPejBpA=;
 b=SlG3JlchR7nKdV3vv6s7aZI9qAWRgOGO+DosSR8Zfte0mrPkcKxWXO48eEmZrNQEj/1jFr
 2rSl756Yv1lwBxXaLYWZcUAFlXsmU+6AeXbcMAjKMfsT3V6UJ05IoYmN6U0eGT5KZ3SLhC
 HrVGrFqkSygXFtlKIGKH2jjzzNzjF8k=
Received: from g78.suse.de (unknown [10.163.24.182])
 by relay2.suse.de (Postfix) with ESMTP id 5CD35A3B83;
 Tue, 29 Mar 2022 07:44:47 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 29 Mar 2022 08:44:38 +0100
Message-Id: <20220329074440.26214-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] API/cgroup: Add io controller
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

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V2:
* Fix doc format
* abstract reading io.stat
* abstract stating the underlying device

 lib/tst_cgroup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 57940ba09..feb5b3d07 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -83,6 +83,7 @@ enum cgroup_ctrl_indx {
 	CTRL_MEMORY = 1,
 	CTRL_CPU,
 	CTRL_CPUSET,
+	CTRL_IO,
 };
 #define CTRLS_MAX CTRL_CPUSET
 
@@ -191,6 +192,11 @@ static const struct cgroup_file cpuset_ctrl_files[] = {
 	{ }
 };
 
+static const struct cgroup_file io_ctrl_files[] = {
+	{ "io.stat", NULL, CTRL_IO },
+	{ }
+};
+
 /* Lookup tree for item names. */
 static struct cgroup_ctrl controllers[] = {
 	[0] = { "cgroup", cgroup_ctrl_files, 0, NULL, 0 },
@@ -203,6 +209,9 @@ static struct cgroup_ctrl controllers[] = {
 	[CTRL_CPUSET] = {
 		"cpuset", cpuset_ctrl_files, CTRL_CPUSET, NULL, 0
 	},
+	[CTRL_IO] = {
+		"io", io_ctrl_files, CTRL_IO, NULL, 0
+	},
 	{ }
 };
 
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
