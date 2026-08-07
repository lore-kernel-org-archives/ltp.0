Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368C1C5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 10:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786097103; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SnG7ZFZh8M6d6lBjwQw7F1mLl/gl712/PATOyGTcNEA=;
 b=eYF7ZkmbPpzcxURJqwiMGMUR5PbPULgmsGpTbNJYHlgV38WChRz3zVw2wp/eX3BWzJYYP
 xoY0WCL9dt9wec4iHc+nnXQPxRNg8GY1AhxD1tqGOuhKUU55MWyrvrAh+s4ezm+8VS42gdY
 +SbnoWuBChgwWMmVbcxEbOBsCaVDuf0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA8653E7019
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 12:05:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1C673C0169
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 12:04:43 +0200 (CEST)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com
 [IPv6:2607:f8b0:4864:20::1048])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3685C600BCB
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 12:04:43 +0200 (CEST)
Received: by mail-pj1-x1048.google.com with SMTP id
 98e67ed59e1d1-381250979d5so3347009a91.0
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786097081; x=1786701881; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o1ix/Rr+lEV3aWY/sD0wykKM7RZtTWZUd4OGIKl074c=;
 b=S6Z7pxJHTfO8uN9ei1Ef4kQSSsrYMLkBt9s7FHSKk/AUrAm4wdf7Wz6TfYS2mA+1ai
 KxkDlizCpvzlIi1u3U/C/Nd6iJ/xV5XdqL1dZwTGE1Puv+yE/f+sCRmN9Zf6VcagTvnR
 wso6YaS09SxWq69PkYjcRYIauKbLDEKcUGnIsjwyTFcfJesD/XjJu46DHaiXSzyI1uGB
 cUvbNT6P1Q8YaER0X1UStE50l8GvHDgViBc6RFzjKLKWNz48/nXpWnBm02AI1MjW+E+e
 jJo/xrv8x+WOTv1c4nRPGoGobidSsB3XdA3Ug6c69eiQv8H3+ZkAiY/QlSFhAKzGgd8C
 40tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786097081; x=1786701881;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o1ix/Rr+lEV3aWY/sD0wykKM7RZtTWZUd4OGIKl074c=;
 b=nntqF5zi0V7BBMUu0D5EMcFtcAT7nhFRF9AoiWW0RiTpwaPF6dspjU8Z9pyeGJgqie
 7vZ/wPPiEQjC3mZi9LdV4nsrjk1l8ad6/m68f/jbx3XmtsNSluC5+5799u2TaVtZKcey
 V60juMgYLCmPvk7yoZiHOlocWcJdu/xZ/nrG+inKb53TNtb2vTGB16Mv8Ok1hSlRBQdX
 O+jm5SSjYNHpFjzUYxUZLHksUrTR5igJxgVEhDgw2c3GAyTMPhm8/WbXdbC2XuNE6XFb
 S9IrSNxXC/u/YH7o1UpZTBkpd3MxsJg4zRBjsy9FkBX0VNuxlr4M5idiiB9MHUmWWi98
 oaLg==
X-Gm-Message-State: AOJu0YxrTUv+6POSdcNirDlUviyauUFf2gtJMHtZIMxgXTfDdl0c2yWW
 ZJtOkHfFNI5JvHApIoqNSXxZ/dIml9Q9XOWqUg0m/0RXHV2ffkw4Oys7pEcHhT23ykERwCfifJ9
 QPIgOSbd4VF60gGNkul1qieZ/eBzzDQRfpifA9qkWyza4gCDsYI2DR2E0GKyIvJTHEgc1xyJXoc
 xmF9MZY9T5U9o9a3g/5XEvNf7EXQ==
X-Received: from pjbcv18.prod.google.com ([2002:a17:90a:fd12:b0:38e:7f2c:2c4b])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c6:b0:38f:1a2e:6e56
 with SMTP id 98e67ed59e1d1-3903c59330amr20809157a91.9.1786097081197; Fri, 07
 Aug 2026 03:04:41 -0700 (PDT)
Date: Fri,  7 Aug 2026 10:04:38 +0000
In-Reply-To: <anLhvtnHhHay5Y93@linux.dev>
Mime-Version: 1.0
References: <anLhvtnHhHay5Y93@linux.dev>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260807100439.2796808-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] lib: Use backoff polling to wait for loop device
 nodes
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On systems where loop device node creation is asynchronous (such as Android
containers or systems with slow udev startup), calling stat() or open()
immediately after LOOP_CTL_GET_FREE can transiently fail because the
device file (e.g. /dev/loopX) has not been fully populated in time.

Introduce an exponential-backoff retry loop in both
tst_find_free_loopdev() and tst_attach_device() (starting at 1ms delay,
doubling each try, capped at 100ms) to wait for the device node to be
successfully populated.

This improves the robustness of loop device allocations on asynchronous
virtualized environments while minimizing unnecessary delays on responsive
systems.

Signed-off-by: Wake Liu <wakel@google.com>
---
v4 -> v5:
 - Declare tst_multiply_timeout() in tst_common.h to fix old API build failures in CI.

v3 -> v4:
 - Rebase onto the latest LTP HEAD.
 - Remove self-referencing Link in commit message.

v2 -> v3:
 - Reuse LTP native TST_RETRY_FN_EXP_BACKOFF() macro in tst_common.h to simplify code.

v1 -> v2:
 - Strictly clamp backoff delay to 100ms (prevent overflow exceeding cap).
 - Skip usleep on final loop iteration to avoid unnecessary idle delay.
 - Reduce max attempts to 30 (stat) and 15 (open) to bound worst-case timeout.

 include/tst_common.h |  2 ++
 lib/tst_device.c     | 13 +++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/tst_common.h b/include/tst_common.h
index e1f7c7907..d09edbbbe 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -26,6 +26,8 @@
 #define LTP_ALIGN(x, a)    __LTP_ALIGN_MASK(x, (typeof(x))(a) - 1)
 #define __LTP_ALIGN_MASK(x, mask)  (((x) + (mask)) & ~(mask))
 
+unsigned int tst_multiply_timeout(unsigned int timeout);
+
 /**
  * TST_RETRY_FUNC() - Repeatedly retry a function with an increasing delay.
  * @FUNC - The function which will be retried
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 744173ffe..00304711b 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -82,7 +82,7 @@ static int set_dev_path(char *dev, char *path, size_t path_len)
 
 int tst_find_free_loopdev(char *path, size_t path_len)
 {
-	int ctl_fd, dev_fd, rc, i;
+	int ctl_fd, dev_fd, rc, i, path_set;
 	struct loop_info loopinfo;
 	char buf[PATH_MAX];
 
@@ -93,8 +93,13 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 		rc = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
 		close(ctl_fd);
 		if (rc >= 0) {
-			if (path && set_dev_loop_path(rc, path, path_len))
-				tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
+			if (path) {
+				path_set = TST_RETRY_FN_EXP_BACKOFF(
+					set_dev_loop_path(rc, path, path_len),
+					TST_RETVAL_EQ0, 1);
+				if (path_set)
+					tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
+			}
 			tst_resm(TINFO, "Found free device %d '%s'",
 				rc, path ?: "");
 			return rc;
@@ -161,7 +166,7 @@ int tst_attach_device(const char *dev, const char *file)
 			 LO_NAME_SIZE);
 	}
 
-	dev_fd = open(dev, O_RDWR);
+	dev_fd = TST_RETRY_FN_EXP_BACKOFF(open(dev, O_RDWR), TST_RETVAL_GE0, 1);
 	if (dev_fd < 0) {
 		tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", dev);
 		return 1;
-- 
2.55.0.654.g21b8a5bc05-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
