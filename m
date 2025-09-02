Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F196CA1005
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 11:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756811913; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/ytzOdp0mxbg3p+6kAjFac3AJhTIuV1aMd9U9iEtKm8=;
 b=e12TZqtb8nu/zUCsjajWLMQ8jk5lERr9DwKP1ApHwbEHNNL2u4smpKFGLj8EktpE0S17s
 VLqcs8TOCGBlKMsM6fZKAg+un7yplFU0/wVm1fcC0AKCsr8s1rBiCxZBW8Fo69fMiGgd0i/
 2HX8TygHMYAb3uC8wgKTsJUxkf4jf5E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 832473CD3AB
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 13:18:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A9D63CCCD5
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 13:18:13 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4C6ED600236
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 13:18:13 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b0225483ca0so480925366b.2
 for <ltp@lists.linux.it>; Tue, 02 Sep 2025 04:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756811892; x=1757416692; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXDFCe/FtLmPKUOBUaUlzNchgGVR3KH0h7vmN9qPgGg=;
 b=CFuacoqTmfn7OmMpL/vEWrARDAULx8NueSCCHE/ELvSTURtkxYoI8EI6MZRxdemvBL
 4+OEL9lhSpSQ5cNge2KD009Elt/93Koq2Rexu/YCY/yFrFwPPZguAA5BayLz/Mk5Wgqh
 w+CaKHVfMtGprsZcnSYV0FCF6+T4fAyxJvAEWGqZz2yhtYvp6hzGYHo337peVrNCJRQv
 5LGWUE+GyYmApKAcoko0SXZ75ZBwaa9/wf3FoFNnNYI9bfYqm3EhkbGCHhGrbwGTwjjR
 EhunEXcs5yvaTm6jbkc4YE4/Pikt4YWZMzxP5uCPR68HZGzC5DoZ0XSQFiKEAbODxXWI
 Hcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756811892; x=1757416692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXDFCe/FtLmPKUOBUaUlzNchgGVR3KH0h7vmN9qPgGg=;
 b=LnYBYwF10oXVAG6a/G1CuOWh68Gsz73658E7XgzUDY8DhdL5om9j3C128Rl2PRriyj
 d0fbHjS5rcV/qL86l5ZxI5g5jem3AFJPdCAlW+RSPo8stH+3SvxacJsgMwxMcOZh7gY4
 g3yey8RF6HE+koXMJ5L0GFvpp9nUXabQ3wirZuHRKWg1+P2xdxO9rlMtUkcCZkdmmgdo
 kgfRzTFn09EKDE4Pvhrv8xhT9aNOQRSYlB3zDSBglUvy0gQchocRzJvitDtjYafMPngZ
 sOuiEspl72trQxV5Z8wQN8QMdIdkhFXjxBEK14XM9KKIe3iSs01aRrhod/Wmbgi9dYTo
 pcfg==
X-Gm-Message-State: AOJu0YxYhpaWDU9GXT+msDwS5DGBT/16A/amtbH7qv7ANDajxHls0nIo
 5m4wCCF5lDk9f/YvYu5EZZvtFYZlnVv3hAXpP+3yGvuJToxnct7OyeO7dFjsJmSWMW3N0/J3JEN
 jEJE=
X-Gm-Gg: ASbGncvY0WVW0p3dnQ8z4vk6awFiUF289vm0uKZ7zeYL4Sl+806E9FHFE+imlO4SggV
 ICmg2Rc0UaSN7EqpXQAvQ8raBE6xZbzx7p+p9CFjV2c9mIv2PIQpszkJtwnq0diwvq60BCjHAMU
 XXTjVBXfjijjtTF4ue/Y+z5BwzmOE9oILH9R+vvxvc2+BtlkcwjEcaBuT9uAeG2kz/Crc0WjH4k
 r+U9mCGeIZV3oqPNLgevILzyDKXW8fJhIOSvjjI8DvSl+NCE6ynquGkiIOEUwJNF+kY1pBl8MPy
 hLoRM32ed+TEEfLJsYFJSraBFxBzlCa6Dt6VeFFIHyUCgNZ2i0WoazIQavqx+P2NGIQNtZTVNbD
 4351TCq8m5kKoiGiUCDIho0mcWcH+HEpWrBS6g0aPlId0wHFmrwC2bF3b27cD/Qzt
X-Google-Smtp-Source: AGHT+IGdJ/H8fJQwTMDL46YCV5/ZZL85m+YD+1ymxpygEBMpuREhQQPdXli5iXjERaRQ5SsF8Rg2Mw==
X-Received: by 2002:a17:907:6d1e:b0:af9:add3:6bbb with SMTP id
 a640c23a62f3a-b01d8c92c41mr970193366b.29.1756811892333; 
 Tue, 02 Sep 2025 04:18:12 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b042fcae867sm430721866b.58.2025.09.02.04.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 04:18:12 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  2 Sep 2025 11:18:00 +0000
Message-ID: <20250902111809.6071-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902031236.5719-1-wegao@suse.com>
References: <20250902031236.5719-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] ioctl_loop01.c: Use proper device for partitioning
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is same patch used on ioctl09,the page cache of loop0 can cache old
version of the partition table which is then used by the partitioning
code. Fix the problem by calling parted against the loop device directly.
More detail see patch [1].

[1] https://lore.kernel.org/ltp/20250829141932.31997-1-jack@suse.cz/

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 34 ++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index c9137bf1e..b70e9fc22 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -78,7 +78,21 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)
 
 static void verify_ioctl_loop(void)
 {
+	int ret;
+	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
+					"primary", "ext4", "1M", "10M", NULL};
+
+	tst_fill_file("test.img", 0, 1024 * 1024, 10);
 	tst_attach_device(dev_path, "test.img");
+
+	ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
+	if (!ret)
+		parted_sup = 1;
+	else if (ret == 255)
+		tst_res(TCONF, "parted binary not installed or failed");
+	else
+		tst_res(TCONF, "parted exited with %i", ret);
+
 	attach_flag = 1;
 
 	TST_ASSERT_INT(partscan_path, 0);
@@ -92,34 +106,16 @@ static void verify_ioctl_loop(void)
 
 	tst_detach_device_by_fd(dev_path, dev_fd);
 	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+
 	attach_flag = 0;
 }
 
 static void setup(void)
 {
-	int ret;
-	const char *const cmd_parted[] = {"parted", "-s", "test.img", "mklabel", "msdos", "mkpart",
-	                                  "primary", "ext4", "1M", "10M", NULL};
-
 	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
 	if (dev_num < 0)
 		tst_brk(TBROK, "Failed to find free loop device");
 
-	tst_fill_file("test.img", 0, 1024 * 1024, 10);
-
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
-
 	sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
 	sprintf(autoclear_path, "/sys/block/loop%d/loop/autoclear", dev_num);
 	sprintf(backing_path, "/sys/block/loop%d/loop/backing_file", dev_num);
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
