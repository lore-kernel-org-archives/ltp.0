Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C106CCA476
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 06:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760078942; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=MJsUL+BPb/QXTmAbxNZt9KtS85eCMtEnEKQWcA3QIhI=;
 b=Zwxz62WkAevtO9bZMRQ9xqhl5ageYz4pWjWrsNVPMysg1DT9IjnZetg664kG32ldvpQU4
 x3dcdPA6GIdC9TvalaECW/uYXd8a6NQPk8ufTPrDOgCQDBC5lYlWHFo2ybgoir2B+fmbSGq
 egVMxn7PIRrI4bMs+tPRiJO4EzHsYE8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 974093CE23E
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 08:49:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 621503CE95E
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 08:48:01 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C37001000A6C
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 08:48:00 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so17549155e9.0
 for <ltp@lists.linux.it>; Thu, 09 Oct 2025 23:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760078880; x=1760683680; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOxrrfX6Stb2Y9a3Dl9kFdOmxlPTc89f/WX5v3ze7DQ=;
 b=IX6iNVA+JfvQHIOVL/NjXaO2MA70rhxOfdDjHuzfyKGt4/x1boraKV39WXsCRzi5D1
 YFOyfZpGF1RJGRAgaTc5cgtIhaK8XpN7B5Zjo3t7PKl9Dp6ZBsychyTYjj3hjRkLoL6z
 j22J2k3tVs8G+zxbnssX+DIyV01t1pHffm6P1eiM5x1DMq+GRbn1MJ6JC6xrC+pf3sS7
 gGynD8vOArfg6KZYWJNJwnl1fNHnPIFxGizXD5aM7wkV0zaXQrODMcA3N7QB01OQvR9i
 JZi2WXQw3Mm1ZUJWCR/8kZHrlLY8alakCDuVsi3F8oorhs7J1SCT1bF4xQhRWMnL1mu7
 VmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760078880; x=1760683680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOxrrfX6Stb2Y9a3Dl9kFdOmxlPTc89f/WX5v3ze7DQ=;
 b=Yzu2oT5FSZdGeQdU8CotT215phjkPKotkiiNYGH35qC6uUBc5Fp2DUUYUnRQGx5tzR
 tZmyTxJpqGELLXzNw3OH/vNd/r14n9ISlMBtO5i43zzjp95hlbJm7Jrm5xSkaJTFBQ7c
 qOlXMIY0NUHBW9HH0H5mzDRqXS6OgQoohGy9hiMHs4QuEuzWGfmR5FZ3XxZ3i7cQYjg5
 5u9BRTkn/H4kEBVN6yon6+xsEQspmqTKV5r+SU7Rl/kWq7dbceQZ7NnGRtMMANYmP1+q
 rPlj5ms/XjuniBIFT990jNYHeooCLYTJrnT+hy+0uddX/bBGL5ecU1OCKC9ILCavy95w
 emHg==
X-Gm-Message-State: AOJu0Yw/p94wmHZGEkog3DKGP7rlXfd3WQ8fY/4jpO5vvs2USH5aXfS4
 ViLyi2R9dhKAETqiKDH7Vr1lyDUCxhpyaOA3xrlM9MKX3TTbAaj9SV42rSr1M1ASkpFif3uB/2U
 xn6A=
X-Gm-Gg: ASbGncvHwTipH4VDbluvx8kpKOLRkoRBV19j+IbjLByh0Vz+bFXjfeJ4NGSqGmx+71W
 bLqLvBKqo0k5qQl1XKc/e46Y+Iy5jW1HgsC5S8P+4yRI+F++BDT+PcVyfwbezT2dCeCqB218miX
 EK1bZdu4dZX84FTMogVOWW34gd6DgS+OhWBthjrP0bnk3ZWuGnHrJVJ4LeBJmQ8WDZZMjJEk4Gk
 Te63q7d7VwVKZDDULwTIFMOnjq/xY0Fb4eSEYRwCeNGXesGC6O5Ha15FG6/EKBPkU4XNuGVXrML
 uiEoCtQcJg7gEhYZ+ywX1b6ApJVdOiGgPwQSNEBS/LWflDsawEtBsXwiOnOZFL5eN8VSDEvFGhu
 EuzrOvfuh/p1oMonnKjOYUBJK89c/pDfO/XucoL9w
X-Google-Smtp-Source: AGHT+IEn/n5cQHIxvGoS8Ihfohq4uzTWgBKTvoXZn+Ph+YclhlnAfdHgc0e2nPEqoPioYvVoYus3vw==
X-Received: by 2002:a05:600c:19cf:b0:450:cabd:b4a9 with SMTP id
 5b1f17b1804b1-46fa9b08f21mr72303995e9.29.1760078879886; 
 Thu, 09 Oct 2025 23:47:59 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-46fb497aea6sm31103765e9.4.2025.10.09.23.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 23:47:59 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 10 Oct 2025 06:45:48 +0000
Message-ID: <20251010064745.31361-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010064745.31361-1-wegao@suse.com>
References: <20250928232708.24007-2-wegao@suse.com>
 <20251010064745.31361-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] ioctl_loop01.c: Update to new .needs_cmds
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index cb1b506d2..fe62e7e5a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -78,21 +78,7 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)
 
 static void verify_ioctl_loop(void)
 {
-	int ret;
-	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
-					"primary", "ext4", "1M", "10M", NULL};
-
-	tst_fill_file("test.img", 0, 1024 * 1024, 10);
 	tst_attach_device(dev_path, "test.img");
-
-	ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
-	if (!ret)
-		parted_sup = 1;
-	else if (ret == 255)
-		tst_res(TCONF, "parted binary not installed or failed");
-	else
-		tst_res(TCONF, "parted exited with %i", ret);
-
 	attach_flag = 1;
 
 	TST_ASSERT_INT(partscan_path, 0);
@@ -112,10 +98,20 @@ static void verify_ioctl_loop(void)
 
 static void setup(void)
 {
+	parted_sup = tst_cmd_present("parted");
+
+	const char *const cmd_parted[] = {"parted", "-s", "test.img", "mklabel", "msdos", "mkpart",
+	                                  "primary", "ext4", "1M", "10M", NULL};
+
 	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
 	if (dev_num < 0)
 		tst_brk(TBROK, "Failed to find free loop device");
 
+	tst_fill_file("test.img", 0, 1024 * 1024, 10);
+
+	if (parted_sup)
+		SAFE_CMD(cmd_parted, NULL, NULL);
+
 	sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
 	sprintf(autoclear_path, "/sys/block/loop%d/loop/autoclear", dev_num);
 	sprintf(backing_path, "/sys/block/loop%d/loop/backing_file", dev_num);
@@ -148,5 +144,9 @@ static struct tst_test test = {
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
