Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7BDC43334
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 15:15:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACE1F3C9AC8
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 17:15:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B49D93C9202
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:15:07 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 015D02005CA
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:15:07 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id os14so21194618ejb.4
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h0adMZ1Kb/ma53q2a1+wWOI0Ra9PTaFFoIIpzDPRcQg=;
 b=d/tQFmbdr3hY6u+GSKsmeptXciV+JyLXKBskufmWGfNkwi1zbscT8EGAshQW2VJWcS
 9RPCtnEerZFLvM4boPa9uU4yf8cMs5yBBBvs/WAzKTA/kYpmi5KrD5G54EpbyjGmDA0N
 1Uf67UHjoB3Ced6jXQsvco8E92TZ6s6dzfXPy1FyfzrOBay6SzGHQWwP3hDMGGTkf9S+
 Jm5iXFGWtl+KjidEr+BFGc8lY48/wgwFj3n6opd3dGV/VhJrhvMpdcC6YeGT/5aliOh2
 Vrh/LToaJ2khnviYjXUBML1Y16WHJBrLCUD+hJqTwnmxwaK/S85ooy2gEP2yEiZhXbKC
 JtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h0adMZ1Kb/ma53q2a1+wWOI0Ra9PTaFFoIIpzDPRcQg=;
 b=RXj7ibsSl13AP5a3s5EaQ8f+s2Apn2lRCotCkzuXFNt8cxNvzlRyNs4DqzmpwAiDkM
 MSySCXT69eDI+p+xTwLZ9Ce2Y0Xm/v2eHZRXL89A3dTdps4xEEu6CBVQkfRCRrdjJxyv
 SvJ1Rj/Lf3kOy0WX/3e7zp/s83Kh81uGpZHLvkTPgq+XLYOFoONm6mE1MfzAE5ZThegg
 zN10LJW8vYNZ2NUQk1oH4o3C15qycV6saMYkflaK2OVSZUoIzretzCoBi833yWRSDUc/
 AiB90FeFZ1T7WPEuQmF4WL9y6In2gK3DqQvMOvq22H05qHD5u4mjl/amuGIMOFo+cVlq
 AxaA==
X-Gm-Message-State: AJIora9G1a3JUvRVjtOdPp2IpkfJtsG2SsJ7XuoWNKnBBBGUWo2idnqS
 TRUyf8rNYt6Bm14QUuWcK+M=
X-Google-Smtp-Source: AGRyM1sNXyYBubKv+mMG9IMIy1GtxpJZPNZNQhXJ1fwurgj4GViE6zOJQfsyunvqexH0KT3A9peUOg==
X-Received: by 2002:a17:907:168c:b0:72f:2b36:5f03 with SMTP id
 hc12-20020a170907168c00b0072f2b365f03mr10770523ejc.750.1658762106511; 
 Mon, 25 Jul 2022 08:15:06 -0700 (PDT)
Received: from amir-ThinkPad-T480.kpn
 (2a02-a45a-4ae9-1-ded3-af6f-ecdf-f6f4.fixed6.kpn.net.
 [2a02:a45a:4ae9:1:ded3:af6f:ecdf:f6f4])
 by smtp.gmail.com with ESMTPSA id
 g22-20020a17090670d600b006f3ef214e27sm5422966ejk.141.2022.07.25.08.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jul 2022 08:15:05 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jul 2022 17:14:52 +0200
Message-Id: <20220725151453.3846227-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725151453.3846227-1-amir73il@gmail.com>
References: <20220725151453.3846227-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/fanotify14: Encode the expected errno
 in test case
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

So we can add test cases for errors other than EINVAL.
Move comments from generic code to per test case.

Reviewed-by: Matthew Bobrowski <repnop@google.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify14.c     | 46 ++++++++-----------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 5d74b9b91..b9ef2fd91 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -41,38 +41,43 @@ static struct test_case_t {
 	unsigned int init_flags;
 	unsigned int mark_flags;
 	unsigned long long mask;
+	int expected_errno;
 } test_cases[] = {
 	{
-		FAN_CLASS_CONTENT | FAN_REPORT_FID, 0, 0
+		/* FAN_REPORT_FID without class FAN_CLASS_NOTIF is not valid */
+		FAN_CLASS_CONTENT | FAN_REPORT_FID, 0, 0, EINVAL
 	},
 	{
-		FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, 0, 0
+		/* FAN_REPORT_FID without class FAN_CLASS_NOTIF is not valid */
+		FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, 0, 0, EINVAL
 	},
 	{
-		FAN_CLASS_NOTIF, 0, INODE_EVENTS
+		/* INODE_EVENTS in mask without class FAN_REPORT_FID are not valid */
+		FAN_CLASS_NOTIF, 0, INODE_EVENTS, EINVAL
 	},
 	{
-		FAN_CLASS_NOTIF | FAN_REPORT_FID, FAN_MARK_MOUNT, INODE_EVENTS
+		/* INODE_EVENTS in mask with FAN_MARK_MOUNT are not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_FID, FAN_MARK_MOUNT, INODE_EVENTS, EINVAL
 	},
 	{
 		/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_NAME, 0, 0
+		FAN_CLASS_NOTIF | FAN_REPORT_NAME, 0, 0, EINVAL
 	},
 	{
 		/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME, 0, 0
+		FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME, 0, 0, EINVAL
 	},
 	{
 		/* FAN_REPORT_TARGET_FID without FAN_REPORT_FID is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_NAME, 0, 0
+		FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_NAME, 0, 0, EINVAL
 	},
 	{
 		/* FAN_REPORT_TARGET_FID without FAN_REPORT_NAME is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID, 0, 0
+		FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID, 0, 0, EINVAL
 	},
 	{
 		/* FAN_RENAME without FAN_REPORT_NAME is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID, 0, FAN_RENAME
+		FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID, 0, FAN_RENAME, EINVAL
 	},
 };
 
@@ -83,17 +88,12 @@ static void do_test(unsigned int number)
 
 	fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY);
 	if (fanotify_fd < 0) {
-		/*
-		 * EINVAL is to be returned to the calling process when
-		 * an invalid notification class is specified in
-		 * conjunction with FAN_REPORT_FID.
-		 */
-		if (errno == EINVAL) {
+		if (errno == tc->expected_errno) {
 			tst_res(TPASS,
 				"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
-				"failed with error EINVAL as expected",
+				"failed with error %d as expected",
 				fanotify_fd,
-				tc->init_flags);
+				tc->init_flags, tc->expected_errno);
 			return;
 		}
 		tst_brk(TBROK | TERRNO,
@@ -120,22 +120,16 @@ static void do_test(unsigned int number)
 	ret = fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
 				tc->mask, AT_FDCWD, FILE1);
 	if (ret < 0) {
-		/*
-		 * EINVAL is to be returned to the calling process when
-		 * attempting to use INODE_EVENTS without FAN_REPORT_FID
-		 * specified on the notification group, or using
-		 * INODE_EVENTS with mark type FAN_MARK_MOUNT.
-		 */
-		if (errno == EINVAL) {
+		if (errno == tc->expected_errno) {
 			tst_res(TPASS,
 				"ret=%d, fanotify_mark(%d, FAN_MARK_ADD | %x, "
-				"%llx, AT_FDCWD, %s) failed with error EINVAL "
+				"%llx, AT_FDCWD, %s) failed with error %d "
 				"as expected",
 				ret,
 				fanotify_fd,
 				tc->mark_flags,
 				tc->mask,
-				FILE1);
+				FILE1, tc->expected_errno);
 			goto out;
 		}
 		tst_brk(TBROK | TERRNO,
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
