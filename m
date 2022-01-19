Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE79C433EF
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:45:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 456EB3C96B2
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:45:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 715143C90E7
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:26 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 40B18200AE3
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:25 +0100 (CET)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4449E3F323
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603463;
 bh=zb6FHBlfcWZAMAhKimzjlwpIxTPTnlx9/44TqoJ7xYg=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=brJev8rqzW+dfmZyZjxXnK/3+Iks+PNon6M/7rfK5RBR8vROO+3Au8EawQOEPlv2c
 UjvbJuYUSt4MTYrFAS//rWMF25hq3ujvbugVHVvrUeSiw+GrZocWYALEYEn1jNwaha
 PImdFw0JEtwb9TfKl7WZWX+p6I6Z/4XGWyn4aF8UIrjcQb7j0mAVCcGPReatczHkcZ
 8K622Vp91+JVXsDw0SyH9xDXvIw3L8KoNRArkHPiD2fWcPB0V+CdiPoURrg06koxP7
 nzMC8C+LhuMOjLamQDb+1trf6107insThrk1Ef2/SzW7V8rOtu2j+xav+EhaKCIh48
 5b3KlzD8Zoo+g==
Received: by mail-lf1-f72.google.com with SMTP id
 u1-20020ac258c1000000b004304234f41aso1754778lfo.8
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zb6FHBlfcWZAMAhKimzjlwpIxTPTnlx9/44TqoJ7xYg=;
 b=aaGs81yHsM0Pv/glqqc0rhlcXnZU60EGuSplC8fNm0ZDXdsU45tblXjLjcKWfJXe1y
 cpCO7a/1Xdnj46dI7bRkkM/2SCwU+pQ/7UihskRGWjnuAMVMzSA+4ESejDmp3s6rhUd8
 15lvE7bnT8q4H0aHg7LWd8mosJ2+WukMdxdDg5xfw8F+OKNmq9+cFiwSQy8FhgsjvoM9
 Ct2k/a4J3wPiYK58uWF4hP3sXftA5P++3UBWnpaTmBBXXPTzzxVo+3MF0IvmcUtATDGn
 aCvzYHQcqHevQgn/rxv0ekugdgjUdThTPHNo+jOBFz/O8fgzNio/398F6uu7UY2Q1uB3
 r9LA==
X-Gm-Message-State: AOAM532lcK5P4srPk8Id9gzPOLmKXbQ92wP/QnpnalNq8VVu7/+kitX7
 84S0f3KHWr8MgLTc+s3RC8lwnlZXPZUZ3EoUqUncpF5QLi4XcY+PLFMpjqF6U9NaqRCvuis9udl
 PrUAXqdsLIp/lp8E5A0xfP26iwcXC
X-Received: by 2002:a05:6512:2039:: with SMTP id
 s25mr27472208lfs.41.1642603462040; 
 Wed, 19 Jan 2022 06:44:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEF6VXoklk2mIfqFps1DvOuheF5OR6AExLEauDQXKSqB1J5uoUp8bPof8mTFss8jTaadOe+A==
X-Received: by 2002:a05:6512:2039:: with SMTP id
 s25mr27472191lfs.41.1642603461834; 
 Wed, 19 Jan 2022 06:44:21 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:21 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:03 -0800
Message-Id: <3e412686c9cd82cd58697b8200b6d961d7fe4af9.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 01/16] API/cgroup: Modify tst_cgroup_print_config
 for easier parsing and consumption
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
v2: Remove "mounted_drain_dir" as mounting ltp dir and drain dir happen
at the same time

 lib/tst_cgroup.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 2ef599d9e..704e64030 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -301,12 +301,26 @@ opendir:
 				  O_PATH | O_DIRECTORY);
 }
 
+#define CONFIG_LTPDIR_KEY "Created_Ltp_Dir"
+#define CONFIG_MOUNTROOT_KEY "Mounted_Root"
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
@@ -314,11 +328,24 @@ void tst_cgroup_print_config(void)
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
+		printf("%s %s=%s %s=%s %s=%s\n",
+			root->mnt_path,
+			CONFIG_MOUNTROOT_KEY,
+			root->we_mounted_it ? "yes" : "no",
+			CONFIG_LTPDIR_KEY,
+			root->ltp_dir.we_created_it ? "yes" : "no",
+			CONFIG_TESTID_KEY,
+			root->test_dir.dir_name ? root->test_dir.dir_name : "NULL");
 	}
 }
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
