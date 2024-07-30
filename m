Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA20C52D54
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 21:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722374394; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=WGdGL3frxzeJ6q21eEVVXVJ0fXhbJOXuWNd4gHQp8Ws=;
 b=Ftj0xr0LSdxxrmAyFeCJW8hYP501z2qBb5KQtfDQ1yZDCFvlNVc5nGYrrNRu2ag2WfPb/
 SBloh4tstCPSlck5PitTflYe4i6Ca8ocXeL4ISmrzF8NZY+kTM6Hlbixs3ns2g9q++1094E
 Zy8he4XjulXbiAhVVfosfz2aT4CQMrk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E6473D1DE9
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 23:19:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6C1E3D15E6
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 23:19:31 +0200 (CEST)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC4A1200929
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 23:19:30 +0200 (CEST)
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-1fc53227f21so43100105ad.2
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722374369; x=1722979169; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=V/8ie3UJAHTtOnfCPYuity4Uu9/q3S7WTds9nS+A0JI=;
 b=wea7HDKBJ4SCJ2oH52Hj3NCHieOpHZRoeHK+jKzGIMCTLXuti5Z/Nnw51rWWj9Ga37
 2gfJVVXlDgCbVfvEGceVhyGtigPO1oCac4DXCyKybQH19uxmU9qvYVdpm/PbmFqMXV9r
 jQbbNmWSkre4OvLvbQMiQEbKDonpOEOpvGoIYeHzg8gf77TYxiRFVTorydJ0v3SbD9SS
 tPCBVzDh13/BBA8ZfJIDLGxunBj4gHFUzYSeLYKcThFOVzQmgANCGMnorHZVDMcXfK+7
 xCe3G/AfxFqdTxxZWGVpgRTOTeBxCaILqCTI+nBdO4ZIK3Hmp5+hi/5M4EJYsttzyU2A
 eqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722374369; x=1722979169;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V/8ie3UJAHTtOnfCPYuity4Uu9/q3S7WTds9nS+A0JI=;
 b=cOv5EhNUDh3kv3EDLcFBFCP1RSYL4NQE3Opq4q8zgnA7Q9/IkKSMmBqNuKq2Mvzsr6
 kvYlJQYiCRIfwoqCnqGOiT4iKFVsn52bLp9YfLwM4ZntwoKtB4QRCgwOw99DjOgr/4Xk
 Z8x/y8Zh8WA5dCDL99JfGQIOweq1lMLUKgoCoVXyxrYivmH14IT78H6TUQ5qjXLNU2FK
 IkPri1v2+0YZKun2BWSp/UgWSJwmJUL0CK0eHR9BXM6UwBe+GCMkY2fwvkQaOiSw6ywP
 vzQDKmBNASt35PVuCJt1OxZNh9jjb4ihh4900kWjVEts4gNOANh0JXe2ObvJG3cf01Gl
 x3ZQ==
X-Gm-Message-State: AOJu0Yx94A5LDCErOtjJJJxPQFwMAfQyiwXr71OX+q5DTAzNAsv0G+Uy
 VkbEGbu72J4/MtQhbrMV77+yyvl8alTwgNkI+vrsMF4CFCv9qGKO2De6Mfm+GPnyQ7NDON9FeZr
 9hJFEt+Uc6XDOU1avfXQuLndswpoHcRQLhRKTUXEbwYAhXnCxjmbz9KhO9SZyehcP5MMr3pzKDu
 LCzdh/W7rSVDkUlPvoqS2yEAXFErY=
X-Google-Smtp-Source: AGHT+IG3hpb4kiYcGERnwAMH/nSZorbOnxdhgSJ8OkrALJ5XmGi+CLhyEjKFamYFN2V6Kibq+70mwdMoyaU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:db11:b0:1f8:44f4:efd9 with SMTP id
 d9443c01a7336-1ff047d0af0mr11969355ad.2.1722374368581; Tue, 30 Jul 2024
 14:19:28 -0700 (PDT)
Date: Tue, 30 Jul 2024 21:19:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240730211922.3648849-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup_core02: Requires cgroup2 mounted with
 nsdelegate
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

If cgroup2 is not mounted with the nsdelegate option, this test will
fail.  It has been patched in kselftests, but has not been ported to LTP
yet.  This adds an additional tst_test configuration option,
needs_cgroup_nsdelegate, to check for the mount option.

Link: https://lore.kernel.org/linux-kernel/Zg2xPtwFvT-lsSJX@slm.duckdns.org/T/
Link: https://www.mail-archive.com/canonical-ubuntu-qa@lists.launchpad.net/msg02400.html
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/tst_cgroup.h                            |  1 +
 include/tst_test.h                              |  2 ++
 lib/tst_cgroup.c                                | 17 +++++++++++++++++
 lib/tst_test.c                                  |  1 +
 .../kernel/controllers/cgroup/cgroup_core02.c   |  1 +
 5 files changed, 22 insertions(+)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index be14d07c6..d23a8e652 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -104,6 +104,7 @@ struct tst_cg_opts {
 	 * directory as opposed to the default pid of the calling process.
 	 */
 	int test_pid;
+	int needs_nsdelegate;
 };
 
 /* A Control Group in LTP's aggregated hierarchy */
diff --git a/include/tst_test.h b/include/tst_test.h
index 6c76f043d..af622e507 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -578,6 +578,8 @@ struct tst_fs {
 	const enum tst_cg_ver needs_cgroup_ver;
 
 	const char *const *needs_cgroup_ctrls;
+
+	int needs_cgroup_nsdelegate:1;
 };
 
 /**
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index f6afb51d6..b18efffed 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -71,6 +71,8 @@ struct cgroup_root {
 	/* CGroup for current test. Which may have children. */
 	struct cgroup_dir test_dir;
 
+	int nsdelegate:1;
+
 	int we_mounted_it:1;
 	/* cpuset is in compatability mode */
 	int no_cpuset_prefix:1;
@@ -344,6 +346,11 @@ static int cgroup_v1_mounted(void)
 	return !!roots[1].ver;
 }
 
+static int cgroup_v2_nsdelegate(void)
+{
+	return !!roots[0].nsdelegate;
+}
+
 static int cgroup_mounted(void)
 {
 	return cgroup_v2_mounted() || cgroup_v1_mounted();
@@ -568,6 +575,7 @@ static void cgroup_root_scan(const char *const mnt_type,
 	struct cgroup_ctrl *ctrl;
 	uint32_t ctrl_field = 0;
 	int no_prefix = 0;
+	int nsdelegate = 0;
 	char buf[BUFSIZ];
 	char *tok;
 	const int mnt_dfd = SAFE_OPEN(mnt_dir, O_PATH | O_DIRECTORY);
@@ -582,6 +590,9 @@ static void cgroup_root_scan(const char *const mnt_type,
 		if (const_ctrl)
 			add_ctrl(&ctrl_field, const_ctrl);
 	}
+	for (tok = strtok(mnt_opts, ","); tok; tok = strtok(NULL, ",")) {
+		nsdelegate |= !strcmp("nsdelegate", tok);
+	}
 
 	if (root->ver && ctrl_field == root->ctrl_field)
 		goto discard;
@@ -632,6 +643,7 @@ backref:
 	root->mnt_dir.dir_fd = mnt_dfd;
 	root->ctrl_field = ctrl_field;
 	root->no_cpuset_prefix = no_prefix;
+	root->nsdelegate = nsdelegate;
 
 	for_each_ctrl(ctrl) {
 		if (has_ctrl(root->ctrl_field, ctrl))
@@ -869,6 +881,11 @@ void tst_cg_require(const char *const ctrl_name,
 
 mkdirs:
 	root = ctrl->ctrl_root;
+
+	if (options->needs_nsdelegate && cgroup_v2_mounted() &&
+		&& !cgroup_v2_nsdelegate())
+		tst_brk(TCONF, "Requires cgroup2 to be mounted with nsdelegate");
+
 	add_ctrl(&root->mnt_dir.ctrl_field, ctrl);
 
 	if (cgroup_ctrl_on_v2(ctrl) && options->needs_ver == TST_CG_V1) {
diff --git a/lib/tst_test.c b/lib/tst_test.c
index e5bc5bf4d..b5aae20ab 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1130,6 +1130,7 @@ static void do_cgroup_requires(void)
 {
 	const struct tst_cg_opts cg_opts = {
 		.needs_ver = tst_test->needs_cgroup_ver,
+		.needs_nsdelegate = tst_test->needs_cgroup_nsdelegate,
 	};
 	const char *const *ctrl_names = tst_test->needs_cgroup_ctrls;
 
diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
index 1872a7dff..733e88ee7 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core02.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
@@ -121,6 +121,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_cgroup_ctrls = (const char *const[]){"memory",  NULL},
 	.needs_cgroup_ver = TST_CG_V2,
+	.needs_cgroup_nsdelegate = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "e57457641613"},
 		{"CVE", "2021-4197"},
-- 
2.46.0.rc1.232.g9752f9e123-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
