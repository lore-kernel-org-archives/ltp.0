Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F415D5E130
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 05:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731044264; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=iEh855ZbLIfdxJ2hw+nPpzIyrxS3PzREBqDEygcERC4=;
 b=lPqqvc8QSwNkH2NO6nc8UCCK0Wz/UVyM9bNUR2gc4OcR3mUpfKn1QAfg8Ct75NpVel3It
 smorC4gAN0Gf097c94HvC61JImT1rPFRxwh7HsvXtQD7LlFw2BrtflBstqZBtGD+P3U2HJE
 GYteaVriJtLqyZ4tQ7ewLPRbTBSngXo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C22583D46F4
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 06:37:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00DF73D46D6
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 06:37:24 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8A106100861F
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 06:37:22 +0100 (CET)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso269433766b.1
 for <ltp@lists.linux.it>; Thu, 07 Nov 2024 21:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731044241; x=1731649041; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6MtlBgH9BPpKz+Ovu/i9TWDSZHUsnPHnApGNyZc6H/E=;
 b=L3JDfv4dV7XIuRzigMMBVSFdez8zLqf0uqXZP9XynNObSZH0x60Ogbf6IpoZA3mLtw
 A7/Yc3efBlYHEi23KEtZrxxASEjnDcuVyrJJ6bSMmK4XTAm0VGsczQFdB7oTZ8z+Hk3P
 OYazhNym7MxAwFZghm0iOM8hZ6YTDMSnzo0Pj0kbqYBB82zV9zCCnDLtRucIx2KKpI6g
 Basgy7X5GoZq6A/1Oi9L/25lNnYmh3NJQk85s11pWG9qNShT2/CFa9dofARyRhGf/gYL
 8J/LjL1i1KQXvL2hlYS3j2tEtoSkAUWQctboCQj6AOgPshekjocCQPSFawG4JnwrM+Rw
 lI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731044241; x=1731649041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6MtlBgH9BPpKz+Ovu/i9TWDSZHUsnPHnApGNyZc6H/E=;
 b=KP8x4k8hH8DbUgFHpNkydtY6dYSgoMHK8/4bcKI8HIZfH+PSbiNcOW/lN5d5ocwZJH
 8hMpu/AapwDjkjVlMhsUFi2INQtaSnhNF5TpzL7huH23auBZmm4plwtZ6Hn+WLFhH+p0
 FB2YVBnPIM9EDFrP3YyKNLacfmK+eVvN9Jx0CxDuGbzUwwhxRcXciQRWlArKWo1FvP7c
 j95cMVnij86O4tTQ4uA43N6TthuagOABvV9mEs75WELPBMceA/cwXP6VURm3KLuDfTgz
 T5Nz4/dm4nDHi8cNdVrZLE66FdTxsbB/FAqB/w7JrdvUe+7I41uSAKjlcYExliuOaD8P
 JYhg==
X-Gm-Message-State: AOJu0Yx2uE5n2U+a1b3gUp+vdlldgWNWKmqbaVw8BRl3zNAuP1DT5b5g
 fjV6zKhNwTK7SO1IOsZbtfd5OfCkzohu/iVpIgtcf690yI9sJdasUgVDpxISyDEugnBQgws9Vxs
 =
X-Google-Smtp-Source: AGHT+IF3igPnXCNYRgBYMuG3zhYJQDXH5+7H9M3qZWeoYG9tFI53d2hyGR8LEK4Fobr4PbRgd8NAoQ==
X-Received: by 2002:a17:907:e93:b0:a99:d308:926 with SMTP id
 a640c23a62f3a-a9ef0009df1mr112487566b.57.1731044241023; 
 Thu, 07 Nov 2024 21:37:21 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c4ed43sm1581211a12.65.2024.11.07.21.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 21:37:20 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri,  8 Nov 2024 00:37:10 -0500
Message-Id: <20241108053710.8639-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] tst_cgroup.c: Force tst_cg_scan only scan specific
 cgroup version if needs_ver exist
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tst_cgroup.c will scan cgroup mount point and check system's cgroup support status, both
cgroupv1 and cgroupv2, if your case only need check cgroupv1(such as needs_cgroup_ver = TST_CG_V1)
but your system contain cgroupv2 mount point, then TCONF will happen tell you your system already
mount cgroupv2, so test case will be skipped.

This change will fix above scenario, force check specific version of cgroup once you set needs_ver,
then test will continue try to create needs_ver of cgroup mount point.

This patch can be used by following cpuset02 case:
https://patchwork.ozlabs.org/project/ltp/patch/20240930135809.9300-1-wegao@suse.com/

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_cgroup.h            |  2 +-
 lib/newlib_tests/tst_cgroup01.c |  2 +-
 lib/newlib_tests/tst_cgroup02.c |  2 +-
 lib/tst_cgroup.c                | 15 +++++++--------
 testcases/lib/tst_cgctl.c       |  4 ++--
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index d23a8e652..ff1c4ece0 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -117,7 +117,7 @@ extern const struct tst_cg_group *const tst_cg_drain;
 /* Search the system for mounted cgroups and available
  * controllers. Called automatically by tst_cg_require.
  */
-void tst_cg_scan(void);
+void tst_cg_scan(enum tst_cg_ver needs_ver);
 /* Print the config detected by tst_cg_scan and print the internal
  * state associated with each controller. Output can be passed to
  * tst_cg_load_config to configure the internal state to that of the
diff --git a/lib/newlib_tests/tst_cgroup01.c b/lib/newlib_tests/tst_cgroup01.c
index eda0c548d..00bced72b 100644
--- a/lib/newlib_tests/tst_cgroup01.c
+++ b/lib/newlib_tests/tst_cgroup01.c
@@ -23,7 +23,7 @@ static void setup(void)
 {
 	cgopts.needs_ver = !!only_mount_v1 ? TST_CG_V1 : 0;
 
-	tst_cg_scan();
+	tst_cg_scan(0);
 	tst_cg_print_config();
 
 	tst_cg_require("memory", &cgopts);
diff --git a/lib/newlib_tests/tst_cgroup02.c b/lib/newlib_tests/tst_cgroup02.c
index de2ca1812..47d1c6b2a 100644
--- a/lib/newlib_tests/tst_cgroup02.c
+++ b/lib/newlib_tests/tst_cgroup02.c
@@ -58,7 +58,7 @@ static void setup(void)
 {
 	cgopts.needs_ver = !!only_mount_v1 ? TST_CG_V1 : 0;
 
-	tst_cg_scan();
+	tst_cg_scan(0);
 	tst_cg_print_config();
 
 	tst_cg_require("memory", &cgopts);
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 1404116a5..652bb70b5 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -657,7 +657,7 @@ discard:
 	close(mnt_dfd);
 }
 
-void tst_cg_scan(void)
+void tst_cg_scan(enum tst_cg_ver needs_ver)
 {
 	struct mntent *mnt;
 	FILE *f = setmntent("/proc/self/mounts", "r");
@@ -674,10 +674,9 @@ void tst_cg_scan(void)
 	}
 
 	do {
-		if (strncmp(mnt->mnt_type, "cgroup", 6))
-			continue;
-
-		cgroup_root_scan(mnt->mnt_type, mnt->mnt_dir, mnt->mnt_opts);
+		if ((!strcmp(mnt->mnt_type, "cgroup") && (needs_ver != TST_CG_V2)) ||
+			(!strcmp(mnt->mnt_type, "cgroup2") && (needs_ver != TST_CG_V1)))
+			cgroup_root_scan(mnt->mnt_type, mnt->mnt_dir, mnt->mnt_opts);
 	} while ((mnt = getmntent(f)));
 }
 
@@ -717,7 +716,7 @@ mount:
 
 	if (!ret) {
 		tst_res(TINFO, "Mounted V2 CGroups on %s", mnt_path);
-		tst_cg_scan();
+		tst_cg_scan(TST_CG_V2);
 		roots[0].we_mounted_it = 1;
 		return;
 	}
@@ -775,7 +774,7 @@ mount:
 	}
 
 	tst_res(TINFO, "Mounted V1 %s CGroup on %s", ctrl->ctrl_name, mnt_path);
-	tst_cg_scan();
+	tst_cg_scan(TST_CG_V1);
 	if (!ctrl->ctrl_root)
 		return;
 
@@ -856,7 +855,7 @@ void tst_cg_require(const char *const ctrl_name,
 	if (ctrl->ctrl_root)
 		goto mkdirs;
 
-	tst_cg_scan();
+	tst_cg_scan(options->needs_ver);
 
 	if (ctrl->ctrl_root)
 		goto mkdirs;
diff --git a/testcases/lib/tst_cgctl.c b/testcases/lib/tst_cgctl.c
index 2685bef81..6f324f780 100644
--- a/testcases/lib/tst_cgctl.c
+++ b/testcases/lib/tst_cgctl.c
@@ -30,7 +30,7 @@ static int cgctl_require(const char *ctrl, int test_pid)
 
 static int cgctl_cleanup(const char *const config)
 {
-	tst_cg_scan();
+	tst_cg_scan(0);
 	tst_cg_load_config(config);
 	tst_cg_cleanup();
 
@@ -39,7 +39,7 @@ static int cgctl_cleanup(const char *const config)
 
 static int cgctl_print(void)
 {
-	tst_cg_scan();
+	tst_cg_scan(0);
 	tst_cg_print_config();
 
 	return 0;
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
