Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A8EC433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:41:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E70913CA71C
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:41:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 945483C8972
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:35 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 19C0E600462
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:34 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9B8AC3F325
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178433;
 bh=dDpJvewNqnM25hwd5JWT4YYJuPvIQFEc3gqOUS8tpAw=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=t2AX6Iqd/nvc8NHBsrS/yPX35O6OneL04odMXGAJm6uxGSfGpIn/N6x05R/8Xr1oJ
 ieCxGSWr1KJoAwX+21cNxOxFxW0QN5UlIR3/rdwLI256mdSRzTjrNPofVej86EtTxP
 fRSehI3I4XiH3N+g66ZWT4MgmXqD7E3lTd9fG4jJcnPmILdadl1YZb+nAoPFnUucwG
 cET6Qt4hDZh+O6BLGf5vc/BOeWK7QJaY0ldmPLGzDdzhiVLnd9XS5aiya9V5fRfMCQ
 Nh3Mgy5BtDigqx9IV+bmUQFeZjYVce3sduUOTsqb4dZ45+m7fhKa+Wt4fDxaDBMcrP
 JSC/z07073ipg==
Received: by mail-pl1-f200.google.com with SMTP id
 s2-20020a17090302c200b00158ea215fa2so3273021plk.3
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dDpJvewNqnM25hwd5JWT4YYJuPvIQFEc3gqOUS8tpAw=;
 b=PcSyN3GLn+axxmEJcrK9FUQUtFGvaGOs5BLkNwcOJDXHZnmgPn09S0LQw9qFgnZ0SR
 2A5+WsWBKHv0G8JaP162eNql3QWO84+dG+zAv0n7m/HYY2LTAFevp0cTXlT1MFB8P0aL
 0IUGrU/a4B6/eajoRRZ1NW9pj5tmD2vDX3xLzaTinULa1X58tda+4LhZWWHRqY0uGM+D
 WzrfWFmkICeIaD76HU3BQBOlw4WCsrXjg5YdpgYobbMUKUe0LIaM8llMC9gEQ8rBi3OS
 k87E4GbBVWfvmOsb1GQwIb6Y0oaNp6eOkTDp+OxZOoXJQFWNkGafvfP5Jhdqi10NH6gj
 ZQQw==
X-Gm-Message-State: AOAM531d2LslAPgu58LGhFdBAXYEU+O9xH26b2sabItACPw3y6JPvfk0
 7NPUSpul1rt0VS+b3jg059p1s2Q2GsZmJBnGxzaTdYT+61GHr+7mB9ncJYoVqNdf+ymGv+nOSgT
 Yua0E9X/mqnDQub1w7NsorygxbVtt
X-Received: by 2002:a17:902:be13:b0:159:8e2:b72d with SMTP id
 r19-20020a170902be1300b0015908e2b72dmr34859671pls.79.1651178431416; 
 Thu, 28 Apr 2022 13:40:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyJJZOAriJOovkBO7Pg3D9JQCSEaR6CXCYK7ut1t11btsoKsRyK8d7moU3JZHCa9cvNG4+2w==
X-Received: by 2002:a17:902:be13:b0:159:8e2:b72d with SMTP id
 r19-20020a170902be1300b0015908e2b72dmr34859650pls.79.1651178431122; 
 Thu, 28 Apr 2022 13:40:31 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:30 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:26 -0700
Message-Id: <9a92c45342df4268ca810beb2a3bee5aac88aa9b.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 01/19] API/cgroup: Modify tst_cg_print_config for
 parsing and consumption
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

Modify tst_cg_print_config to be easily parsed by sscanf so that it can
later be consumed by tst_cg_load_config.

Prints out root info of each controller found as well as the minimal
associated state needed to cleanup mounts and dirs made my tst_cg_require.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: Remove "mounted_drain_dir" as mounting ltp dir and drain dir happen
at the same time
v3: Print config to be scanf friendly to be much easier to consume.
Rename variables to reflect the variables used in the library for
simplicity.

 include/tst_cgroup.h |  6 +++++-
 lib/tst_cgroup.c     | 25 ++++++++++++++++++-------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index d32d62399..6ba3727f3 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -110,7 +110,11 @@ extern const struct tst_cg_group *const tst_cg_drain;
  * controllers. Called automatically by tst_cg_require.
  */
 void tst_cg_scan(void);
-/* Print the config detected by tst_cg_scan */
+/* Print the config detected by tst_cg_scan and print the internal
+ * state associated with each controller. Output can be passed to
+ * tst_cg_load_config to configure the internal state to that of the
+ * config between program invocations.
+ */
 void tst_cg_print_config(void);
 
 /* Ensure the specified controller is available in the test's default
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index feb5b3d07..1abcbaf5a 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -318,24 +318,35 @@ opendir:
 				  O_PATH | O_DIRECTORY);
 }
 
+#define CONFIG_HEADER "ctrl_name ver we_require_it mnt_path we_mounted_it ltp_dir.we_created_it test_dir.dir_name"
+#define CONFIG_FORMAT "%s\t%d\t%d\t%s\t%d\t%d\t%s"
+/* Prints out the state associated with each controller to be consumed by
+ * tst_cg_load_config.
+ *
+ * The config keeps track of the minimal state needed for tst_cg_cleanup
+ * to cleanup mounts and directories made by tst_cg_require.
+ */
 void tst_cg_print_config(void)
 {
-	struct cgroup_root *root;
 	const struct cgroup_ctrl *ctrl;
 
-	tst_res(TINFO, "Detected Controllers:");
+	printf("%s\n", CONFIG_HEADER);
 
 	for_each_ctrl(ctrl) {
-		root = ctrl->ctrl_root;
+		struct cgroup_root *root = ctrl->ctrl_root;
 
 		if (!root)
 			continue;
 
-		tst_res(TINFO, "\t%.10s %s @ %s:%s",
+		printf(CONFIG_FORMAT,
 			ctrl->ctrl_name,
-			root->no_cpuset_prefix ? "[noprefix]" : "",
-			root->ver == TST_CG_V1 ? "V1" : "V2",
-			root->mnt_path);
+			root->ver,
+			ctrl->we_require_it,
+			root->mnt_path,
+			root->we_mounted_it,
+			root->ltp_dir.we_created_it,
+			root->test_dir.dir_name ? root->test_dir.dir_name : "NULL");
+		printf("\n");
 	}
 }
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
