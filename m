Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AE7FA3741
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 18:15:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 914E13CA96D
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 20:15:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 949CB3C04BF
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 20:15:42 +0200 (CEST)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CE7AD600678
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 20:15:41 +0200 (CEST)
Received: by mail-pl1-x64a.google.com with SMTP id
 y1-20020a17090322c100b001853a004c1bso1522056plg.19
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 11:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hwJUqs0F6hMCEC5nhcJdWIHZRbJIeiZDcl0zDFpBqps=;
 b=QRD/SiFsUNGLIa9kMRA3OqgahVU7NhJxx7UGkSTCmFPsztFAwjBPRQeX71812by4pw
 UXwse8IdAZxTxCU1QaeT+BEQFl2VGXtm43PSSZzSjYxrRw4sWdkz7dJyRPuJU7qX/w1l
 SF/nfIFB+IAnSS95HXJVbTue1X7/d9l1EWtelpltR40mvRmS8kqepb+ixM8nAb/lXag3
 o4z0VjZtS1wojb/oGacBpPJY8/OUyGZGd5N8nbdgVqmUw6FR0EBOQQK1KWVlCgGK2qEA
 O7wdurJikyIih2wyIEGcrz11fUKNuvdlsezsGZaxVrwZAhGSW0dKG7HlP5+/U9LBjLpw
 PIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hwJUqs0F6hMCEC5nhcJdWIHZRbJIeiZDcl0zDFpBqps=;
 b=RfDCMKmrd2y9BE9A7NhI+UCBU9j5LKGHzaGVa2XASTi6p7p5x06kPsh3Ah54JZ3oqk
 JUUOP4KjV6DaqSWZyntOQ1AtELTQnQn2m3J3IEPolxrG8xMOTrUkfGz7RcZW1lWugw/K
 1iO19fdRyHQxzsfrFT2c0NYR/EXJzuW8CFqRidgaZvB3XyLAbOpzQjC2WEJLQuCYsJPi
 TQHWA8VBq3if4QuTkpBq7EimMfV1Z1y+L3e3hJDG9/u2Ma4y5qVqezFsT34DGJf6n+ic
 RBfUUOkOqePSrviKQfhxCGtmHKHzfTuIRyewwloq2AfncX4Y+w7bxUTuj6lXuBGnlZ5T
 I+sA==
X-Gm-Message-State: ACrzQf19u2YTyjq62eMEKPnm0hlNCnRgbQp3SP0l/g6D0GTzqPvQ8QIe
 2+FyzhlOpo7jJ7WjeXlXSgQynQu5r4+F5vURYY2LQFDe7RBj5inimzuq78QxUdejZRI1Z6Z4SIx
 yMLyC8n6cgFIW+dQTnBy2TucR/x/m3+zSzQr8cNa6qDq356on8bFD8kdH
X-Google-Smtp-Source: AMsMyM451x0N6pdbEEWBTsNbGHU39p7H2w8AxC2TD2DytAd+Vl8aZ4qb9vgI8UR3zQBH3JM4V+RED8XHpHQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:e0b:b0:56c:8c13:2a54 with SMTP id
 bq11-20020a056a000e0b00b0056c8c132a54mr5553472pfb.17.1666894540015; Thu, 27
 Oct 2022 11:15:40 -0700 (PDT)
Date: Thu, 27 Oct 2022 18:15:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221027181531.3686476-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] tst_cgroup: use tmpdir
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Use tmpdir instead of hardcoded /tmp path.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 lib/tst_cgroup.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 6c015e4f8..458b823f2 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -290,7 +290,7 @@ static struct cgroup_ctrl controllers[] = {
 static const char *cgroup_ltp_dir = "ltp";
 static const char *cgroup_ltp_drain_dir = "drain";
 static char cgroup_test_dir[NAME_MAX + 1];
-static const char *cgroup_mount_ltp_prefix = "/tmp/cgroup_";
+static const char *cgroup_mount_ltp_prefix = "cgroup_";
 static const char *cgroup_v2_ltp_mount = "unified";
 
 #define first_root				\
@@ -645,8 +645,12 @@ static void cgroup_mount_v2(void)
 {
 	int ret;
 	char mnt_path[PATH_MAX];
+	const char *tmpdir = getenv("TMPDIR");
+	if (!tmpdir)
+		tmpdir = "/tmp";
 
-	sprintf(mnt_path, "%s%s", cgroup_mount_ltp_prefix, cgroup_v2_ltp_mount);
+	sprintf(mnt_path, "%s/%s%s",
+		tmpdir, cgroup_mount_ltp_prefix, cgroup_v2_ltp_mount);
 
 	if (!mkdir(mnt_path, 0777)) {
 		roots[0].mnt_dir.we_created_it = 1;
@@ -693,6 +697,9 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const ctrl)
 {
 	char mnt_path[PATH_MAX];
 	int made_dir = 0;
+	const char *tmpdir = getenv("TMPDIR");
+	if (!tmpdir)
+		tmpdir = "/tmp";
 
 	if (ctrl->ctrl_indx == CTRL_BLKIO && controllers[CTRL_IO].ctrl_root) {
 		tst_res(TCONF,
@@ -700,7 +707,8 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const ctrl)
 		return;
 	}
 
-	sprintf(mnt_path, "%s%s", cgroup_mount_ltp_prefix, ctrl->ctrl_name);
+	sprintf(mnt_path, "%s/%s%s",
+		tmpdir, cgroup_mount_ltp_prefix, ctrl->ctrl_name);
 
 	if (!mkdir(mnt_path, 0777)) {
 		made_dir = 1;
-- 
2.38.1.273.g43a17bfeac-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
