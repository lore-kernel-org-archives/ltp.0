Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A796FC433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 10:00:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5841C3C9237
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 11:00:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE55A3C1D3C
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:15 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3F3876008E6
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:14 +0100 (CET)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 27B393F163
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 10:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641376813;
 bh=agK00NeJh8dCovIVH6wLsLm36yS9eBQ/no/p0kJCcN8=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=CO0Gr/vOlxFG/ve3bd5Ux6l/Njef/+NWuInCqOQwnm6dVF8zsPK/aeFKTKFq0NV+3
 SLe/5uH27TP7v7TPM2HtfBMM2AoMQy0QTr9qEiDgdl92cMqskgm/feeIAj0KEZx5HH
 u1GsyKJuBfsG4qQM3BK6RwE5wCRyr4rWVYeE8hX3H3E1uc6c+g1F7bDOBBUo8SV1C2
 MdjEQVDfOuEJYA/6uWV7Nrtk7N/4GQ/RzZ3R0UN07Sp7CIo3jZDxj/xmRzR63npvKM
 qwG6B8fuheuy96oGwiF+Ef1tH0Ah2n4zMuT7wh8Nqn2K7LPDVeOCzjgdHtkvWkYqTE
 o/2Dl73yfMuVA==
Received: by mail-lf1-f69.google.com with SMTP id
 o2-20020a198c02000000b00425d146a32bso9084446lfd.15
 for <ltp@lists.linux.it>; Wed, 05 Jan 2022 02:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=agK00NeJh8dCovIVH6wLsLm36yS9eBQ/no/p0kJCcN8=;
 b=bnz0YslonxAZEEJam/E5nvtxttEvt9F3uatk5GfuxASOYJndqJvwN8YAyLq0yymHcw
 gxP8PuJIA8WvwyPCHw+XpHJ8SVyY3uA2+p7nDmAtFWCnK8cLl+rXrTJA1PODGGOsAmZh
 D3mmt3ln+bRf+dCWVaTAv0i+iXtaESxE3QLucAEHZiQI9eQdsJXvvULwsS1akDy1z5cD
 d4gnk1o0OT7pXwbdO1ubWWjSb/3LnshR7aTYK7w5pUfd90WPkZOwCa7uBnoJXlKGdldO
 dLjOKqiFeGDEB7/JiYYwuBv7ZJRE+oFQVd1MeHfM3m7ycRyv8jiX4Zt9JczDgKEs1SoI
 HcqA==
X-Gm-Message-State: AOAM532bdqLFBn3D7hHdp71Ez63/HOuJXkFy3yOUiYJuU6f4S+QoWkG3
 esVncpOexZwiZ2MEr/lUKqpQzhhfPe/YSQbB1HE4EBrakievPigYXCx6j4CyBVbAC5wGC5Wo9hH
 PpRGKp3rVUpxuhg+/Qp6AkZjqoazh
X-Received: by 2002:a05:6512:2397:: with SMTP id
 c23mr49127500lfv.655.1641376812055; 
 Wed, 05 Jan 2022 02:00:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyyPVPx1etMIxwv382inXrNyfp5oAAALkrVDfKqHHyzzmu02dh38qie+xKfQNleC9TDh9qCg==
X-Received: by 2002:a05:6512:2397:: with SMTP id
 c23mr49127485lfv.655.1641376811805; 
 Wed, 05 Jan 2022 02:00:11 -0800 (PST)
Received: from lukenow-XPS-13-9380.home (159-205-75-251.adsl.inetia.pl.
 [159.205.75.251])
 by smtp.gmail.com with ESMTPSA id z25sm4152527lfq.20.2022.01.05.02.00.10
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jan 2022 02:00:11 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Wed,  5 Jan 2022 02:00:02 -0800
Message-Id: <c31b0e459cc70eeb53fd5772e0893f695812635e.1641376050.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] API/cgroup: Modify tst_cgroup_print_config for
 easier parsing and consumption
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

Prepare tst_cgroup_print_config to be more easily parsed and consumed by
shell scripts and other programs.

Also add any detected root information as well as the relevant state
associated with the roots that would be needed by the test to properly
cleanup.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 lib/tst_cgroup.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index c08ff2f20..166d0f97e 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -300,12 +300,27 @@ opendir:
 				  O_PATH | O_DIRECTORY);
 }
 
+#define CONFIG_LTPDIR_KEY "Created_Ltp_Dir"
+#define CONFIG_MOUNTROOT_KEY "Mounted_Root"
+#define CONFIG_DRAINDIR_KEY "Created_Drain_Dir"
+#define CONFIG_TESTID_KEY "Test_Id"
+#define CONFIG_CTRL_REQUIRED "Required"
+#define CONFIG_CTRL_HEADER "Detected Controllers:"
+#define CONFIG_ROOT_HEADER "Detected Roots:"
+
+/* Prints out the minimal internal state of the test to be consumed
+ * by tst_cgroup_load_config().
+ *
+ * The config keeps track of the minimal state needed for tst_cgroup_cleanup
+ * to cleanup after a test and does not keep track of the creation of
+ * test cgroups that might be created through tst_cgroup_group_mk().
+ */
 void tst_cgroup_print_config(void)
 {
 	struct cgroup_root *root;
 	const struct cgroup_ctrl *ctrl;
 
-	tst_res(TINFO, "Detected Controllers:");
+	printf("%s\n", CONFIG_CTRL_HEADER);
 
 	for_each_ctrl(ctrl) {
 		root = ctrl->ctrl_root;
@@ -313,11 +328,26 @@ void tst_cgroup_print_config(void)
 		if (!root)
 			continue;
 
-		tst_res(TINFO, "\t%.10s %s @ %s:%s",
+		printf("%s %s @ %s %s\n",
 			ctrl->ctrl_name,
-			root->no_cpuset_prefix ? "[noprefix]" : "",
 			root->ver == TST_CGROUP_V1 ? "V1" : "V2",
-			root->mnt_path);
+			root->mnt_path,
+			ctrl->we_require_it ? CONFIG_CTRL_REQUIRED : "");
+	}
+
+	printf("%s\n", CONFIG_ROOT_HEADER);
+
+	for_each_root(root) {
+		printf("%s %s=%s %s=%s %s=%s %s=%s\n",
+			root->mnt_path,
+			CONFIG_MOUNTROOT_KEY,
+			root->we_mounted_it ? "yes" : "no",
+			CONFIG_LTPDIR_KEY,
+			root->ltp_dir.we_created_it ? "yes" : "no",
+			CONFIG_DRAINDIR_KEY,
+			root->drain_dir.we_created_it ? "yes" : "no",
+			CONFIG_TESTID_KEY,
+			root->test_dir.dir_name ? root->test_dir.dir_name : "NULL");
 	}
 }
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
