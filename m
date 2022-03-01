Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47EFC433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 12:29:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8FD13CA305
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 13:29:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 937063C0487
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 13:29:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D047214012A9
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 13:29:25 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E56751F39D;
 Tue,  1 Mar 2022 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1646137764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nlkGJzp2bkcGGWbHNKpWTL+K9sPifN3Dq1MELoeR4Bs=;
 b=Bn52LHxMby2OW2a8Qr+DeRBWL0AvDlpcKrQ2i9e+jTu1RGh+1hNk+HgcW6s+OMsxJsl+0e
 woutOsqB+DTxtYnPp/bPpDlRP/7SJmE0LUMWgtTE6WFYp7yR/ncqPWIk7NwSrPzTqF0KKr
 5fy45k6Wk1qf7QjbE6K2kOZfoA8NS1A=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id 9D66FA3B85;
 Tue,  1 Mar 2022 12:29:24 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  1 Mar 2022 12:23:53 +0000
Message-Id: <20220301122353.16137-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] API/cgroup: Try to mount V2 with memory_recursiveprot
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

Moving forwards system managers should always mount with
memory_recursiveprot. So we should test with this by default when it
is available.

This change will only effect SUTs which do not already have CGroups
mounted.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index dc090b70a..8cca0654d 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -471,6 +471,7 @@ void tst_cg_scan(void)
 
 static void cgroup_mount_v2(void)
 {
+	int ret;
 	char mnt_path[PATH_MAX];
 
 	sprintf(mnt_path, "%s%s", cgroup_mount_ltp_prefix, cgroup_v2_ltp_mount);
@@ -494,7 +495,13 @@ static void cgroup_mount_v2(void)
 	return;
 
 mount:
-	if (!mount("cgroup2", mnt_path, "cgroup2", 0, NULL)) {
+	ret = mount("cgroup2", mnt_path, "cgroup2",
+		    0, "memory_recursiveprot");
+
+	if (ret && errno == EINVAL)
+		ret = mount("cgroup2", mnt_path, "cgroup2", 0, NULL);
+
+	if (!ret) {
 		tst_res(TINFO, "Mounted V2 CGroups on %s", mnt_path);
 		tst_cg_scan();
 		roots[0].we_mounted_it = 1;
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
