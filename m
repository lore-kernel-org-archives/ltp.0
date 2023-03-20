Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F04AC6FD1D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 23:51:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 088DD3CAABC
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 00:51:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99C5F3CA9B0
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 00:51:17 +0100 (CET)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E2F741000603
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 00:51:16 +0100 (CET)
Received: by mail-pf1-x449.google.com with SMTP id
 e14-20020a056a00162e00b0062804a7a79bso1309776pfc.23
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679356275;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=4Fas2rakiukDaDdeltWCU43sJnn/oSNsrkv4SQGpOHY=;
 b=Ap9bREZFzGS0vnjrfL1cOqKN0iJlPTzbzwnDVZlAtJ80cC5LoSZzVS0kyahBWEfOkZ
 dJj527raGtavT93RwqGeI9QnhXUYEYR1GusIaYuE+TgrjGiVSt6Dzn9A9gOcgx9X2J7P
 oz2XmawNpsr4+nprOYf7RbmFNU65i8HbOGa8RK/00hdjdbsubH+PfvxJxEZc3RO+H8+n
 E4nAgujSMvqHtVoI96LRe3zjLh/0FSaf4iVY0e2ECh70jvf9q+opZskUaTRJ+k4t6OcM
 kcWqS5URPuFZlcH4Jnv41urvT4lYEe+lwmJST897Yz9w+daXQvGsROFdlOmBVt20NQDn
 /Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679356275;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Fas2rakiukDaDdeltWCU43sJnn/oSNsrkv4SQGpOHY=;
 b=1dLWoue2NfldvEQyNepfTyoGYMkmqWINb3x/hm1azhMmDELPhTW4kMs8854kYrHsUh
 wFhjm0sxNyFFqTBwCcmaaMR1L6XZyMURCOLegBvsPd0+2kRij2TLwsYoFGsfzEARru9Q
 AMnj4/KF/o54mGUR+dH97fc9uWO70OOvsHHqHPHcPKRXmTGBlKAeFoe36hPJ92cGzjqJ
 5Lsr4O+5bP/Ai8uZ7ryQ9LuKz6MOFKzOoQV309hdd0bsCFB96Fn8YktM6h/K66nWR7yY
 9EOac2oV8TsX57WK4daLR5R++ba1p6JUFJ7pSvD7uL8QD3pRUv1vdMInRHQqFsASO46o
 nMuQ==
X-Gm-Message-State: AO0yUKV9uPCxAsfmVtWG+Y4JRTCj6yvRbhi/F+ky1t0f6KCS4nXDAvmf
 z/S8MZgv7uw7lvKP5KUS4PaB9YJVyVOO/jfb0cQXduSGRxjmel95Hy8VkibsZF5A7nYVqoLBNFQ
 jzgyAAvW05w37794D4dLiOSFOzHQhf2WYyzC1c3nsg9BYmQGQkHCq9cqj
X-Google-Smtp-Source: AK7set8LDyuel1agPlSaDW28NngQWiO4eq7HYAp0lr6Xr65fNnK0+vEXQemvaLyfkoCQLrbEFFL73TsmDxE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:aa7:88c7:0:b0:624:3ff:db10 with SMTP id
 k7-20020aa788c7000000b0062403ffdb10mr338602pff.5.1679356275127; Mon, 20 Mar
 2023 16:51:15 -0700 (PDT)
Date: Mon, 20 Mar 2023 23:51:06 +0000
In-Reply-To: <20230320235108.2058967-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230320235108.2058967-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320235108.2058967-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] tst_device.c: Use PATH_MAX more consistently
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

Replace hardcoded 1024 path sizes with PATH_MAX.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 lib/tst_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 48d7e3ab6..a61c5a748 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -50,7 +50,7 @@
 #define UUID_STR_SZ 37
 #define UUID_FMT "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x"
 
-static char dev_path[1024];
+static char dev_path[PATH_MAX];
 static int device_acquired;
 static unsigned long prev_dev_sec_write;
 
@@ -79,7 +79,7 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 {
 	int ctl_fd, dev_fd, rc, i;
 	struct loop_info loopinfo;
-	char buf[1024];
+	char buf[PATH_MAX];
 
 	/* since Linux 3.1 */
 	ctl_fd = open(LOOP_CONTROL_FILE, O_RDWR);
@@ -489,7 +489,7 @@ int find_stat_file(const char *dev, char *path, size_t path_len)
 unsigned long tst_dev_bytes_written(const char *dev)
 {
 	unsigned long dev_sec_write = 0, dev_bytes_written, io_ticks = 0;
-	char dev_stat_path[1024];
+	char dev_stat_path[PATH_MAX];
 
 	if (!find_stat_file(dev, dev_stat_path, sizeof(dev_stat_path)))
 		tst_brkm(TCONF, NULL, "Test device stat file: %s not found",
@@ -641,7 +641,7 @@ int tst_dev_block_size(const char *path)
 {
 	int fd;
 	int size;
-	char dev_name[1024];
+	char dev_name[PATH_MAX];
 
 	tst_find_backing_dev(path, dev_name);
 
-- 
2.40.0.rc1.284.g88254d51c5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
