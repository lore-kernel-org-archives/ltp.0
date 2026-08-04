Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12363C55184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785857115; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WPhx8c3+LX7jRVboF5bj5Rpv4xnLQD+xtygUaaIunNM=;
 b=bU0fXuQfs8skWKK1jS6Irpw7DLJbiH1nKxcxjmRD1UNd9x7vxY4u8wiInKEMK6U+dqqQJ
 Duq4NLVIw2S1VYauJ3my2SpXcavJkwq4psD1pURIKuOj0bRrmAVKjNdY3aa+lr0rWsbhqDu
 lzu3paYvJE/zw8TYjH4FCyLhh75Qfss=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 519563E90C6
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 17:25:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F5CD3E7169
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 17:24:55 +0200 (CEST)
Received: from mail-pj1-x1047.google.com (mail-pj1-x1047.google.com
 [IPv6:2607:f8b0:4864:20::1047])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B2C4B200906
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 17:24:54 +0200 (CEST)
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-38fcaa5f82cso3171908a91.3
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785857093; x=1786461893; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d4lT6m3tQ3SUahwLeIlEnhgAiemgbv2dDScSisdU5XU=;
 b=OJnkiMmlTYniVVAqLITA21fC8eG6X36/+ZpKFlkVPdbviGADBmiUzvsfHpjy40fNtr
 2aYFC+Te8Zm/hkpW3qwE4UJzS4k3A7J13MQdSHj54H4O+lFgJn5BGXzwhqmm4tpPTA+I
 UkxVQ0e9+Sq9nmQAUwg5AwKQY5xMhAu03t/qUuz+SRCthqERvQk6qKXK2pUhoS9y9JyX
 H5fzJI4s+Z+lCi66iIfpHMiMd+/qjg1SzD0eXHj1NYQ5sDOXx5gJPaCBYnjptn6Oe3oK
 zhCSorLYPQQbGBwpSJrZjPrLmSgKq94yVvTOe5rl5MSOSxG51xcmBhlDztkvzNUdj/WX
 GTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785857093; x=1786461893;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d4lT6m3tQ3SUahwLeIlEnhgAiemgbv2dDScSisdU5XU=;
 b=Au1YW2ZvtfIvRC0NnUd++N0WTTadnZ9aOEHQ158Gy+JLhDQx761xmyg7SoGEnkmtEw
 ryAYEEZpgRMYGNzGdOa9/FmMjrkwXlNg9g1dfrLFRzxJCEM2kgaLX0JYinowYAa6RZZE
 RKxrTFsM4rvBHtofU4XDB3cSbMHoisrZVTPItFhYX69XZmpwDeciIVlEPFJWCUUPC8+J
 bZ1Y5DqFXHVOWAF7kj9N4XqgZb8SoTrzkb5FBJhkcoHbRuhKg7Im2CUHKzPn2RAZBjsG
 Ld8NnRz65da9uVE0UK+malGqtVJGVHqj0CAM1WJIm3fY5D4Ry4VrrNk9abTvIvqKSRai
 PFWQ==
X-Gm-Message-State: AOJu0YwGy/mDmMm3ANdPyEcaT0mz4xMMUXlGRbfz+HPP9SWKyZ5YcJo3
 AtS2P0utX9o8tyiJSrYetMbAF0Mnrf/u45ZzC4M67u/e2FA+UX7R/OwaXmHW2LdhZJ+wt916cfZ
 0KwrnK+Ax2fGEsm0+4RXgd7T5RveyPSNllUVjwIuXQ2c4FkKbQi2yxQeR9qC3tt47M94Xvq+m4N
 XumceyDfOaiSYeOhKPC5z6A9ctJg==
X-Received: from pjbmp4.prod.google.com ([2002:a17:90b:1904:b0:384:f6e1:ff81])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2ccf:b0:38f:57f0:1f4b
 with SMTP id 98e67ed59e1d1-38fbc576496mr11890231a91.35.1785857092561; Tue, 04
 Aug 2026 08:24:52 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:24:50 +0000
In-Reply-To: <anFjaQ--3q38-psW@linux.dev>
Mime-Version: 1.0
References: <anFjaQ--3q38-psW@linux.dev>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804152450.921218-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] lib: Use backoff polling to wait for loop device
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

Link: https://lore.kernel.org/ltp/20260803152754.3991113-1-wakel@google.com/
Signed-off-by: Wake Liu <wakel@google.com>
---
v2 -> v3:
 - Reuse LTP native TST_RETRY_FN_EXP_BACKOFF() macro in tst_common.h to simplify code.

v1 -> v2:
 - Strictly clamp backoff delay to 100ms (prevent overflow exceeding cap).
 - Skip usleep on final loop iteration to avoid unnecessary idle delay.
 - Reduce max attempts to 30 (stat) and 15 (open) to bound worst-case timeout.

 lib/tst_device.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index d3c53a1a1..a3c0992e0 100644
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
@@ -156,7 +161,7 @@ int tst_attach_device(const char *dev, const char *file)
 	int dev_fd, file_fd;
 	struct loop_info loopinfo;
 
-	dev_fd = open(dev, O_RDWR);
+	dev_fd = TST_RETRY_FN_EXP_BACKOFF(open(dev, O_RDWR), TST_RETVAL_GE0, 1);
 	if (dev_fd < 0) {
 		tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", dev);
 		return 1;
-- 
2.55.0.571.g244d577d93-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
