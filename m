Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00247C43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:53:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 214AD3C98CE
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:53:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8ED193C98C8
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:12 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B9AC4140035C
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:11 +0200 (CEST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EC7B03F12C
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436790;
 bh=pC5S+gXxN2HablN3p5AjAVngjsShIFfJM2azW3dv3cQ=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=YiAbNBxyMD+U3KVefr93xjggoOmseXgq4XmPJbxKnQSoMM8L8zWef293dE67xNDQK
 0+x3cZv0hsmoBTxn2opT47b8S3xTeWuRYvkD23bAz1DiT47JAs44SZwUYUSQ3jYrdx
 3htVIimH85WpJb9PACRI9dg2fSFiCZwi4gPodSNAj1pFmdM6qc0oyu3tJwCOrZorid
 bnjcpkqmK5EopIPS0QtGSOiTOHtFqVj4CV0zvZT+huFZulvgXWkuKlOuZhRGZYQuu0
 6DnC8EU9VMOSMtZovpqBqJcUOYkWv8q+azBzKldVvL1ERvQminFdqm3JGFMyhg+5XT
 CWOMtsSrn/lsA==
Received: by mail-pf1-f199.google.com with SMTP id
 r17-20020a056a00217100b0052ab8271e11so1115695pff.22
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pC5S+gXxN2HablN3p5AjAVngjsShIFfJM2azW3dv3cQ=;
 b=mNEamImH8HX7kEM/B7IEEdDGIx8fNNfrhFlx2GK7CdYoF4yU8jFV7e1MfsTqNqvsxp
 FBwBFskSFPaNPdWMCAriOJL5OW8O+OnOUlz/AvH8OnnNDFP4akLAAyOrRS7xTN/kqbQW
 ComIrRp55DL6MNIWyX/G4L5O/zJzyFYiXB+8in0CqpDaTede7EokSG+Jg4fo49vps9uR
 YwjG84rt7qM7wAxQpxST/r2AXYSgBXxqk2Vmi+nN2/BCc6h9zM9zfCkUlAWJphcBxvt6
 c0vN9ODQsZ4IXzdKkzA5xAh63BYKe47k/nvUG5fI0JGH2kSQzEAFprPAiLlR1FWZ3Jzt
 EzFg==
X-Gm-Message-State: AJIora//P/KR/PP1+Kn1GN9t7LpiDoLUO/F3sAh2wTt4ykccunBejLp1
 yFrdJ7PAa9pHdf4lsHpsbyyEEwRI1zH4ffBFX9E3LmeMCIbxTrcPwwrUf/j+LiyzYI+iaRpezWD
 Q5S2Z6OBpU6e3EeIGQ/JK1Osuf0it
X-Received: by 2002:a17:903:32c3:b0:16d:328f:8988 with SMTP id
 i3-20020a17090332c300b0016d328f8988mr135227plr.108.1658436788877; 
 Thu, 21 Jul 2022 13:53:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ss9dSJpcI6IWkr5duigalJjzPq1+JfG36QmyHnArkajcxgstq4CQjX/GwjuEA5oBLHOZ/+8w==
X-Received: by 2002:a17:903:32c3:b0:16d:328f:8988 with SMTP id
 i3-20020a17090332c300b0016d328f8988mr135208plr.108.1658436788583; 
 Thu, 21 Jul 2022 13:53:08 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:08 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:11 -0700
Message-Id: <9e49f9fb1660bb8687a6c3bacf38959a80726897.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 01/18] API/cgroup: Modify tst_cg_print_config for
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
index c4bc7ae1c..7ebc2a624 100644
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
index 081dfa9c6..c56a7c6b9 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -317,24 +317,35 @@ opendir:
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
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
