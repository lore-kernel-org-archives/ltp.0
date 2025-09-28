Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2162CAC5BB
	for <ltp@archiver.kernel.org>; Sun, 28 Sep 2025 23:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759102099; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=bEcoRFiVBgB+vEYuAN8kHZgj02oOAPoVwsJLNbrhFTI=;
 b=WAIFWZ5N7yt4BvHQcu0fc5nCaQyu5zJLOtEGIpGNLt9NJsOm/RXMCiEzBYZu72a+frpEf
 Ed5yNbf0uCgQIHH3rH6fmp/Nl9iwRA7xsBpCRMfW6Je6JAUpOqoqUk5QLkYVxQqWTCQNFG1
 rH9TQrFZkUfQ8By0fwOUgudAMun7FBw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 150BE3CE1AB
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 01:28:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C54703CE1A2
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 01:27:17 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1162D100045D
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 01:27:17 +0200 (CEST)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-62fc686dc41so3904973a12.1
 for <ltp@lists.linux.it>; Sun, 28 Sep 2025 16:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1759102036; x=1759706836; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSGCTw7emV00vu570aoB6WeifBoeoHtLfkXUX1uZ2tA=;
 b=d1sSWYruKZW6ylUPwbYWmDHMm4CiiEZGlyND6misbpR45BkBxKqeF4rhU1x2BvrY5w
 tCviQpCtiB6FEx2drIiaixMc25rtqcwozp3jjzm5XzrdNgAXJSSY92GXHzCJnG2ht8JN
 xH+E+GMHnEbN/1n0xTdxX5gqQvRkHAGOFbpD/su1Xue2nZkFEpZ6UcSlLl0AC+VOtBJz
 J87Ty8tjeMQQeC/t9ok9ybQUzNEPNi3JDDrdEb0jgiUFsmYdTyZS6YybsOEJ5pARVpjT
 uSyr+yvHXjXd8kqHxMHIg2tMOA7g+mN8kAcBuQ2XGlA/tDFX59z3VelCsVoAM7H0Shz+
 3nGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759102036; x=1759706836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tSGCTw7emV00vu570aoB6WeifBoeoHtLfkXUX1uZ2tA=;
 b=E0UBruHKAKVfmExgJ9wgWOIqlMZAIVleUF9/Gm5eytaX1n4/rkYm+z8iUvDQqrXBUp
 /uW9OBeQJDM8jSkw4y/9KSNwU4KoMY0wlx2yswAmi79xUEDxQ6rsM1o2ffJOa/+H0siJ
 wNu+HuxAINJTK8TKnMfPs+WPAzXoCDkAB4a7lOrmpCN8PqNJH0Y2RgC8zUxZOgR2W2Dv
 7eyhgAt9lXbMNhHEwXTYSN08jTcPo9Zj/6yOGkJwKpKCBqD4V7Yd9Emsiw4JDygYPnnh
 XgV3ubGhsn1jG9omQLiSMjv3O3BL2gA1aRqbjxHlIAbI5ltEHqJ5l32knSkw3ydrjWEh
 jE7w==
X-Gm-Message-State: AOJu0YzDOcSWZX2TUTfyjl5cXLqDDiJBgWFNnwpElXJ2Rxw0HjBu0rqP
 3M+hYgaCPxbE6h3w092usIHXQGAyjrolDcFWoyktO3g8HtE3UfJqY5h4q5CgNvWH+ZhRLhCFcJT
 Y3u7Uxw==
X-Gm-Gg: ASbGncuXyOV7NvHYBjCDhLeB1Z2y3sVfyVSs5T+cJ6wHAMIltsTWxn3YfEKMezh8KoG
 mlw9Ko2tr/PLpBQPedPk6GqcexixfTm9D9HrQRT7en01OoKV0nOWDMt0NGmUEfFLSrbbh9nz+KS
 youh+2kIwqW78j6F6FtuyZ3bzJBvpPaKI6dsgYIaZDrGrAXc9wOsrEqG75FtGJEyZk7uhTtspFq
 hRnhbBdgnW/pw6KC04XDbF0MB+Oe8KBGt6XkeDrDCe7Dqc+WaylxsCVtfn/4/hIA/vAbr6FoQVi
 eGoPPQRQpIOe69TPVRo2Foz6I78UqeXOxIEcOfa/LZaoCB5dfqLJsC62qa3x1zUWpxk5w6jMbvp
 SssVtYi2zYsHlYE6O10Q9SKrfAvk7KVN+k5dogNu4i3c=
X-Google-Smtp-Source: AGHT+IHmAW+aaxkXAACTZztjlOGURk9KoTFtAr4xaGwf7LW0OgtPezj7UmiOKU1t5umnG/OaEycxdg==
X-Received: by 2002:a05:6402:210a:b0:634:bdb3:e656 with SMTP id
 4fb4d7f45d1cf-634bdb3e8ccmr9171500a12.17.1759102036174; 
 Sun, 28 Sep 2025 16:27:16 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-634a3af5483sm6740358a12.42.2025.09.28.16.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Sep 2025 16:27:15 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 28 Sep 2025 23:26:58 +0000
Message-ID: <20250928232708.24007-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250928232708.24007-1-wegao@suse.com>
References: <20250926085021.22141-1-wegao@suse.com>
 <20250928232708.24007-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] ioctl_loop01.c: Update to new .needs_cmds
 struct
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

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index c9137bf1e..70036d6ef 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -97,9 +97,10 @@ static void verify_ioctl_loop(void)
 
 static void setup(void)
 {
-	int ret;
+	parted_sup = tst_cmd_present("parted");
+
 	const char *const cmd_parted[] = {"parted", "-s", "test.img", "mklabel", "msdos", "mkpart",
-	                                  "primary", "ext4", "1M", "10M", NULL};
+					"primary", "ext4", "1M", "10M", NULL};
 
 	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
 	if (dev_num < 0)
@@ -107,18 +108,8 @@ static void setup(void)
 
 	tst_fill_file("test.img", 0, 1024 * 1024, 10);
 
-	ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
-	switch (ret) {
-	case 0:
-		parted_sup = 1;
-	break;
-	case 255:
-		tst_res(TCONF, "parted binary not installed or failed");
-	break;
-	default:
-		tst_res(TCONF, "parted exited with %i", ret);
-	break;
-	}
+	if (parted_sup)
+		SAFE_CMD(cmd_parted, NULL, NULL);
 
 	sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
 	sprintf(autoclear_path, "/sys/block/loop%d/loop/autoclear", dev_num);
@@ -152,5 +143,9 @@ static struct tst_test test = {
 		{"linux-git", "6ac92fb5cdff"},
 		{}
 	},
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "parted", .optional = 1},
+		{}
+	},
 	.needs_tmpdir = 1,
 };
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
