Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C885CC433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:18:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F408B3CA3F9
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:18:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFCAA3CA3A7
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:35 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F086C6011F6
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:34 +0100 (CET)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A2FFE3F5F9
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435913;
 bh=E+ERNqSAmRML3PTqr0wGTQzAhfVpv8MSEDOKinli2as=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=AXWLMOpgdWoNUCb+GLyvHf9n13BeFoC3cHB4avrqjpi7cH0h447S9nOD09N2ryRyu
 hy7rmKEZdpF+gb5p7dFgmK7i6hjZOQ8hiZaabxsNeGDk4Vl7tHYQFT0RLMgwY995ZU
 60kH/SfXZt5q9qXPi6meOY7e5fBJqXgNlcCZ+z8RMukKfd5AV9p6gDtQ1yzLeOHiNm
 LuImnCuDURWl4eXU8iZWNKrzmgJjetMKITdt871jwRqFjc7mY6WHGDeJHJkgPza1Hw
 P0C9zR/7SD1G+QDc/NnN0TZl/ZiyDnRQrG7uj+TZ+NhxHCf4Iz4waqya4A6p8E7Gkh
 KZNS8L72IA6VA==
Received: by mail-pl1-f198.google.com with SMTP id
 d4-20020a170902f14400b001518350e5c7so5346746plb.13
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E+ERNqSAmRML3PTqr0wGTQzAhfVpv8MSEDOKinli2as=;
 b=qoxoUIObmicPYBb1VZRhQumfNWQj7M7HdL346MvOA7OsT5/wwC3s8mNpN8nn15lYth
 EPfs9KfSea9vtQyUnrLT8qpn8dTpDAHKq30kTSeANFHnzohunYgxvbDuPbP6i94ix2iP
 XL0CMPmqJq68AxpcEOWCZbyV3/bpIliWTLmSFFYCtDo85jJYnSER7M0vjJ7hyGdjRd8T
 gCpOQ9mn6AgT8S9XQxQZPstLOEAWzHEVVoXmwqvl1zfd717ni2fO4OB0uzNqOeGJylxA
 YmcCravRittgnZc/ZHdaucttJGiMeDuUyMJOJtnb4FvUDkNWMp8iZ3Op628Wg5UHSBEx
 KURw==
X-Gm-Message-State: AOAM533EFURotjTC0tO7yeZi3bpZnIaQz1CLTrcSrZgq5A8XvkJyjZnv
 t99BWHXHg2DAUSV8LsoGqsXjwtPl6tbhWAO8A/VbH0JJf1ZEP4vRH2uGJFJvuAo1skjszsZMMZX
 HIBCSjfsAk8W8K/nLpqXk/CnekBQF
X-Received: by 2002:a17:90a:2e04:b0:1bc:a5db:bcdb with SMTP id
 q4-20020a17090a2e0400b001bca5dbbcdbmr13150777pjd.116.1646435911270; 
 Fri, 04 Mar 2022 15:18:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9TjHXAYuCaHbSLu68Gr4rAxO2sts22Yz+BesmUbRq/kriMwCIhw91XQU60OFT4YiQhurTAg==
X-Received: by 2002:a17:90a:2e04:b0:1bc:a5db:bcdb with SMTP id
 q4-20020a17090a2e0400b001bca5dbbcdbmr13150754pjd.116.1646435910821; 
 Fri, 04 Mar 2022 15:18:30 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:30 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:11 -0800
Message-Id: <64fa1a611c3c345236600401dfc71b8484bbb544.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 01/16] API/cgroup: Modify tst_cg_print_config for
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
index dc090b70a..68f3609cf 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -309,24 +309,35 @@ opendir:
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
