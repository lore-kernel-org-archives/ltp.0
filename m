Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9C7C433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 09:59:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA2703C95D1
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 11:59:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5313D3C9175
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 11:59:00 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8E297601C66
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 11:58:59 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id ss3so26127337ejc.11
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DAcMZAOscOTNrnxcFax5dn78M2CSp+Ft8nvDSTJGtns=;
 b=KEgAIEWqxTI7VKvLWPeqhU1WqDkDh/SZK8U/vdeV+gGdFF4BIWbMLjCsYI4iS3eA5j
 Tt5LicqSmPv1bGYDGIp6XSpiNhJvZg1k20Lf4NKAawXqanucABgwIJEJlRCmgbtuSUs0
 60nEVKF1CHxHtj6mKk/UQLGSTSCq85T1PF4KGfmaTvKG+2gZS5JVdFdAHuHr3Xh6BjhL
 Nd3y10sL9DgvVGWYbruQXX8PAI8MbjmSsxdJYgA6fBskpv+1tS5RL6FZEN6rpXDA+2cD
 kYat+vM9b1CHBDPjZ6bmZgrBMUTR1V9t/RhLqYiNMrA0mE7d6/VLAi7RrhNgWsltBNxr
 WcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DAcMZAOscOTNrnxcFax5dn78M2CSp+Ft8nvDSTJGtns=;
 b=UX3tgLAcpxJaPX/9I7qQ1XCFoxJpHf3IdDG5vPdP+XTQbxKSodj0iOsgxGy8wEd7fS
 wcHcOYnbuDrXEWVCk/wZkw7DsAuDgJM9orXkCLqgmg2dSyfoZ5hvJhxQp98SZIQyIwYS
 uCY3AImLAnzA6SY8L7Kfu8bmnGQRwTA3Tvv6nODCN3OH5iMh+mLec8whWfba0YEhL1/Z
 5IZqnMeh0BJE9FR9iVQ/LiqhnENJsRjJAY1EYBDvU+Slv8KOQUS+f2Jl5JwN5rlN+Mus
 N6UszQ+fItVmlLugSM4CFD/84n55Vw90vcZtwNEfOGHJBay3ZZCK8wk07UUnS8kw+13f
 gfKg==
X-Gm-Message-State: AJIora8VJy+bDiFK9AxjU55y1uDTP0jml+6J2PUQeqlLUoE00zvja9qx
 m+Ws1lEchj1f+L8YaB7cDhg=
X-Google-Smtp-Source: AGRyM1v092k7nHaytGFp/l5qId1JVRjoqbFRzYvgjweFBuAoUtpC4WFw6LwzSE7P8WydfYOYsUyrIA==
X-Received: by 2002:a17:907:75f5:b0:72b:40da:a7cd with SMTP id
 jz21-20020a17090775f500b0072b40daa7cdmr29640276ejc.662.1658224739074; 
 Tue, 19 Jul 2022 02:58:59 -0700 (PDT)
Received: from amir-ThinkPad-T480.kpn
 (2a02-a45a-4ae9-1-844c-43f4-b96e-8109.fixed6.kpn.net.
 [2a02:a45a:4ae9:1:844c:43f4:b96e:8109])
 by smtp.gmail.com with ESMTPSA id
 r23-20020a170906a21700b0072b616ade26sm6477512ejy.216.2022.07.19.02.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jul 2022 02:58:58 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Jul 2022 11:58:52 +0200
Message-Id: <20220719095853.3373732-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719095853.3373732-1-amir73il@gmail.com>
References: <20220719095853.3373732-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/fanotify14: Encode the expected errno in
 test case
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

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify14.c     | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 5d74b9b91..c99e19706 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -41,38 +41,39 @@ static struct test_case_t {
 	unsigned int init_flags;
 	unsigned int mark_flags;
 	unsigned long long mask;
+	int expected_errno;
 } test_cases[] = {
 	{
-		FAN_CLASS_CONTENT | FAN_REPORT_FID, 0, 0
+		FAN_CLASS_CONTENT | FAN_REPORT_FID, 0, 0, EINVAL
 	},
 	{
-		FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, 0, 0
+		FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, 0, 0, EINVAL
 	},
 	{
-		FAN_CLASS_NOTIF, 0, INODE_EVENTS
+		FAN_CLASS_NOTIF, 0, INODE_EVENTS, EINVAL
 	},
 	{
-		FAN_CLASS_NOTIF | FAN_REPORT_FID, FAN_MARK_MOUNT, INODE_EVENTS
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
 
@@ -88,12 +89,12 @@ static void do_test(unsigned int number)
 		 * an invalid notification class is specified in
 		 * conjunction with FAN_REPORT_FID.
 		 */
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
@@ -126,16 +127,16 @@ static void do_test(unsigned int number)
 		 * specified on the notification group, or using
 		 * INODE_EVENTS with mark type FAN_MARK_MOUNT.
 		 */
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
