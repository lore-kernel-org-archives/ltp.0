Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC864E6B26B
	for <ltp@archiver.kernel.org>; Tue, 23 Dec 2025 02:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766455816; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Gz3PidoOUgnkFE1V5Z4FHuiSzUruOOYzMSVKJVdEtGs=;
 b=lL+pNhEz4rhchC/ZTelTttTY7m1ceFwfGYyHHNa6gZYJGpMY2gexf4uM6kW+atsurAfp9
 MZdXdXJeRrt0zMcBa0rtETmCECOQh3HB+lDbnepNYP6YLXMY8bhUUsbe8rFWLalzhSBNGtc
 q6XGcMsnwWtCgn5HekTdlzMvA/ZUhQg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70EC73D0574
	for <ltp@archiver.kernel.org>; Tue, 23 Dec 2025 03:10:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A9E63D0743
 for <ltp@lists.linux.it>; Tue, 23 Dec 2025 03:08:45 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DC7FC600A4A
 for <ltp@lists.linux.it>; Tue, 23 Dec 2025 03:08:44 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so40685105e9.1
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 18:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766455724; x=1767060524; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaGXSdSToboD4ptrtSXuxvu3sxiDWTUxJ828/8iHLG8=;
 b=CttRnv1PyRkncGECo74E4GZJ0X0GWj26OtOd13JBmmEsfkVgivyyW2cYermnDxyT8D
 R9i3oHBx59zglMUj277av5SYP+oeFdkTrN1e7PQoET3ZxkOWgBPFSOwo8tiwidbssfZa
 KbuQXszf49E2m8SPI2vgM6KWObf6pdxKoRb9hncw8dwcZvoQ+wqV8nSbz0ax73qd4wjc
 uUdAfhKdbHF1zWPUvd06+U3puMGyk/2vIcHZt5qU6fHe+Cu5djCL6+P3qWJpTSU/2p/n
 cHdZ7nPoYoBrM2FRQ3nSEs/3T1sq/noNzXrjCucMiMh5mlfcThJeNyuLZv0CEwEFpJVZ
 gYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766455724; x=1767060524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MaGXSdSToboD4ptrtSXuxvu3sxiDWTUxJ828/8iHLG8=;
 b=Xy/aU1QES3aYnaJI8eJnODfAGp8e/0LspPxL5SA0dDWYPBZKQJxAgekSv+WWmCpWYB
 ysGnx88vJtLlu9gGtkANWHOFhoQDdGr9ygcIgMZ0m3Ogr1UlWLflLZxmASkgZeyD3VT6
 EZRci5Ppusa19epCvc89qFWJSWEpI+I+9bcxQteozUpP311cyOTkC0KB36vl1sNMipfG
 tupQ9mRdX+YDJy5tKSIdWP2h9U+w7ggR9+xASD0oFT1MQZrIJbwkhpAk6hwLxY1mtEef
 teGG1Lh57lzsteE8DNAoVr19xjXslsCiStqy9m+ZFVomGYr0nr8GXQ8NrKiDuCeFIO6q
 S0Bg==
X-Gm-Message-State: AOJu0YzIaCiYM6vg6U/rBJ9uwP/TXbjcDY1jL+ytK4a093SGiJdQ2Iru
 5y7cDxw19hdSLw2/tPoCE879a530ghHXswO/mvCG0O5h4xfSXDeymp6GPcucjggLzNiMAjZPYel
 HVbc=
X-Gm-Gg: AY/fxX5BILkVi9pMboITvu90oW/c6SrXIbE7ZwLVexZ3+gXqyoOgtIUZ8fyT8yNaiuu
 OGqZ/DQN9WAn/2ha5lMLg9ujsYySgUWRq5keE1DkwARh2n697vN8Z47CFJs0pXVmfMEAoFS83KW
 pu3r8xdIfODwqLXFOg/Y1dlZKuJ9gANRlMFXykxmLymAZX0js693MWzW+x83kBVXUkWykCFaxIR
 PRWyPZ25q1G4Ou0fbpzQaplDGQ/rrwJejTDJ1AoCviL5K23LjcwapeflEUJqaTzaN/TMgWDHUEQ
 t54Mr6JNkIJdvNixjNZzptTBnPEDfzjDnPgqv3k0XlDoU4NhOSPwQxqAgXzWCLSgLjJZwm9YcHf
 FH0Pt1HUotFidT8wsxHoyQ+fTY7zxakwDekGgpr1kInqh9J4fGUvm3AiRoQKt6x5ZOvcSu7Mg2z
 Y=
X-Google-Smtp-Source: AGHT+IFTzvgHI8m9hKfVzrF5TYgCnLHr/k29W5ADcHxX0ONI4U8gOrq0pMV5R33uXK+hAexUEsCjmA==
X-Received: by 2002:a05:600c:5250:b0:479:3a86:dc1b with SMTP id
 5b1f17b1804b1-47d36243a0bmr6932625e9.37.1766455724082; 
 Mon, 22 Dec 2025 18:08:44 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-47be3aa99a3sm103856655e9.12.2025.12.22.18.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 18:08:43 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 23 Dec 2025 02:08:17 +0000
Message-ID: <20251223020836.9439-4-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223020836.9439-1-wegao@suse.com>
References: <20251110024805.31070-1-wegao@suse.com>
 <20251223020836.9439-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/4] ioctl_loop01.c: Add new support .needs_cmds
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index 9fbdbb1f2..b8df2d633 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -79,23 +79,6 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)
 
 static void verify_ioctl_loop(void)
 {
-	int ret;
-	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
-					"primary", "ext4", "1M", "10M", NULL};
-
-	tst_fill_file("test.img", 0, 1024 * 1024, 10);
-	tst_attach_device(dev_path, "test.img");
-
-	ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
-	if (!ret)
-		parted_sup = 1;
-	else if (ret == 255)
-		tst_res(TCONF, "parted binary not installed or failed");
-	else
-		tst_res(TCONF, "parted exited with %i", ret);
-
-	attach_flag = 1;
-
 	TST_ASSERT_INT(partscan_path, 0);
 	TST_ASSERT_INT(autoclear_path, 0);
 	TST_ASSERT_STR(backing_path, backing_file_path);
@@ -114,10 +97,23 @@ static void verify_ioctl_loop(void)
 
 static void setup(void)
 {
+	parted_sup = tst_cmd_present("parted");
+
+	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
+	                                  "primary", "ext4", "1M", "10M", NULL};
+
 	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
 	if (dev_num < 0)
 		tst_brk(TBROK, "Failed to find free loop device");
 
+	tst_fill_file("test.img", 0, 1024 * 1024, 10);
+
+	tst_attach_device(dev_path, "test.img");
+	attach_flag = 1;
+
+	if (parted_sup)
+		SAFE_CMD(cmd_parted, NULL, NULL);
+
 	sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
 	sprintf(autoclear_path, "/sys/block/loop%d/loop/autoclear", dev_num);
 	sprintf(backing_path, "/sys/block/loop%d/loop/backing_file", dev_num);
@@ -149,5 +145,9 @@ static struct tst_test test = {
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
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
