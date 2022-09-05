Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622D3ECAAD3
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 15:43:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F9103CA950
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 17:43:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01AAF3CA96D
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:53 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B7E5E6009FD
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:50 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 n23-20020a7bc5d7000000b003a62f19b453so8013734wmk.3
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=msCSPjt+VSSCHFAR3v3bLUJse4NjZPPedOz5Dbyhpi0=;
 b=dQBGQw/jy0N2LkcwdUA8yaT7ahcqeJufh6Bqiu1hrrL9JJDyDmLnZ4FY5Hr6TjiopF
 kvmrmtBBb3k18YBsdGR5lWg3qEa6dg2YfsRiedWv1RtMVTD+GoNgNAkcgANdhoAunN/0
 GTbsJoKtmU2F1xOFyNGPWymjSBGe4X8l6N41aMPveeoMY1hzIs3fi67MVGnFItHHnNBI
 cc21AvDd2ZO/ty/sdGyYOy7jMyzZ3t78gZMIklA4VPjC/TgPkx5CK+z3iq9OmYimpTUE
 9NjjrKKZATRDEYIiCaek1ioZDQ/B2Pv+UhAy8QZvE9aZUNHwLXzG/gOoK+sL0lHiI6LO
 COPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=msCSPjt+VSSCHFAR3v3bLUJse4NjZPPedOz5Dbyhpi0=;
 b=7DS38NTIiYB8jCyPBh+2wevaarsYPfFS0wy/uQBA/tLJgHF5zGOROluAkHKKPLf0Ak
 6sXe35vhWpy9S41qOLh6FZCM9N/yGVoXd+p+xdMVGry99aut37RL684YZIa++RNo4fEv
 6WNnfDL+8zWt9xamlbCaM4DdLbXwUYzSR1oaFLZYp76NUiW3kRAIBlw3JzcZFQwdxw7S
 /5eFluvLaZ8Dz+ENpbsX39dIupBWHaFxjKa0EuDELlgGu3g8+1cld01v+0NaJtltSRyj
 JsbSDG3PbQK28o/sLCMIqE0LcAvfobPdAA1hs2cfwXeGkmiXD65vbSe2MECqVAm/7B9Z
 6vAg==
X-Gm-Message-State: ACgBeo12SFXR+y/c0iK698qn8qaqZNSUutYWVE4Id1x0oBgfsmAM8fjF
 COhHvQSdmyY9YqhbEd3OUhc=
X-Google-Smtp-Source: AA6agR4z4yHuFyDSOye7NtgnBEwhG4dMDMeGUXdh09RvhzETIVYdmG3pVYuEJ4Sb44gOpG2ZVISu/Q==
X-Received: by 2002:a05:600c:3b1f:b0:3a5:e672:a385 with SMTP id
 m31-20020a05600c3b1f00b003a5e672a385mr11000995wms.49.1662392569966; 
 Mon, 05 Sep 2022 08:42:49 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 e5-20020adfe7c5000000b0022862e037e3sm5790023wrn.38.2022.09.05.08.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 08:42:49 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Sep 2022 18:42:33 +0300
Message-Id: <20220905154239.2652169-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905154239.2652169-1-amir73il@gmail.com>
References: <20220905154239.2652169-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/9] syscalls/fanotify14: Add test cases for
 FAN_MARK_IGNORE
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

FAN_MARK_IGNORE is a new API so it also enforces strict rules about
which events and flags are allowed on a non-dir inode mark.

FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY for anything
expect a non-dir inode mark.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify14.c     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 8419cea46..4a1953b33 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -39,6 +39,7 @@
 
 static int fanotify_fd;
 static int fan_report_target_fid_unsupported;
+static int ignore_mark_unsupported;
 
 /*
  * Each test case has been designed in a manner whereby the values defined
@@ -107,6 +108,34 @@ static struct test_case_t {
 		/* With FAN_REPORT_TARGET_FID, FAN_EVENT_ON_CHILD on non-dir is not valid */
 		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET, 0, FAN_OPEN | FAN_EVENT_ON_CHILD, ENOTDIR
 	},
+	{
+		/* FAN_MARK_IGNORE_SURV with FAN_DELETE on non-dir is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME, FAN_MARK_IGNORE_SURV, FAN_DELETE, ENOTDIR
+	},
+	{
+		/* FAN_MARK_IGNORE_SURV with FAN_RENAME on non-dir is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME, FAN_MARK_IGNORE_SURV, FAN_RENAME, ENOTDIR
+	},
+	{
+		/* FAN_MARK_IGNORE_SURV with FAN_ONDIR on non-dir is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME, FAN_MARK_IGNORE_SURV, FAN_OPEN | FAN_ONDIR, ENOTDIR
+	},
+	{
+		/* FAN_MARK_IGNORE_SURV with FAN_EVENT_ON_CHILD on non-dir is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME, FAN_MARK_IGNORE_SURV, FAN_OPEN | FAN_EVENT_ON_CHILD, ENOTDIR
+	},
+	{
+		/* FAN_MARK_IGNORE without FAN_MARK_IGNORED_SURV_MODIFY on directory is not valid */
+		FAN_CLASS_NOTIF, FAN_MARK_IGNORE, FAN_OPEN, EISDIR
+	},
+	{
+		/* FAN_MARK_IGNORE without FAN_MARK_IGNORED_SURV_MODIFY on mount mark is not valid */
+		FAN_CLASS_NOTIF, FAN_MARK_MOUNT | FAN_MARK_IGNORE, FAN_OPEN, EINVAL
+	},
+	{
+		/* FAN_MARK_IGNORE without FAN_MARK_IGNORED_SURV_MODIFY on filesystem mark is not valid */
+		FAN_CLASS_NOTIF, FAN_MARK_FILESYSTEM | FAN_MARK_IGNORE, FAN_OPEN, EINVAL
+	},
 };
 
 static void do_test(unsigned int number)
@@ -120,6 +149,11 @@ static void do_test(unsigned int number)
 		return;
 	}
 
+	if (ignore_mark_unsupported && tc->mark_flags & FAN_MARK_IGNORE) {
+		tst_res(TCONF, "FAN_MARK_IGNORE not supported in kernel?");
+		return;
+	}
+
 	fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY);
 	if (fanotify_fd < 0) {
 		if (errno == tc->expected_errno) {
@@ -224,6 +258,7 @@ static void do_setup(void)
 
 	fan_report_target_fid_unsupported =
 		fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME_TARGET, MNTPOINT);
+	ignore_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_IGNORE_SURV);
 
 	/* Create temporary test file to place marks on */
 	SAFE_FILE_PRINTF(FILE1, "0");
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
