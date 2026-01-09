Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A27D232E2
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 06:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767939535; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=SAu6Syx3tt5iWtDH9qq7jxYcKyuPmVFlHJzf/l/NTUs=;
 b=VnhnOHItk4lPwr+CCmIvl+63y+i1RFJ5wseodyxNLh6A+cizX2gFGN0l90QTI1Rs7waIK
 ZDpHc/ezxpVOHetWLxO03/ZAV1r47M/gXLkeSFNMyB0zodz7BYsbGllk8N49+0arK12/Y8a
 dhNCYPUCrjxxBGKAcWjv7hkx1TEmUz4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CC983C6FE2
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 07:18:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B8933C54E7
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 07:17:24 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CF9191000954
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 07:17:23 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso24029135e9.0
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 22:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767939443; x=1768544243; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7itwjnHfOlwlr1/Ui8NFCPi3MimReLCfAD+BZibXvXw=;
 b=T/dqodab3uC8dugGskXTcvcAUEsj3xk0TYiIQFI2A2e1m4hhyRu3YT+5ClLvDHrwDO
 YYKRLLMj2olaDCjo7mag48hPR1j4EYzIQUXu71RQx1hjxAZuNV8l90+tgcABEsbYhNLw
 F7Fsfwxy4wMDf4PigwcOyCWrUuVwfPcp7GBSQhWm/bX4hTwQefg2SNlF6eGypV+ca4vw
 PfekcRElOFlzg2viuS1/zNuHj6Wl4o19i+cN2XoYZYdhapFFlThl+6ol1nGvExHf6bjb
 /xpqzi9rQBceWWhub9xFzNG3YxrruytH/zdY+WX+KsV8U0LOLUHBXs+3IsO57vhNrhln
 Pw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767939443; x=1768544243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7itwjnHfOlwlr1/Ui8NFCPi3MimReLCfAD+BZibXvXw=;
 b=PfaJC/xxL7J5Jb3WQPEu8LYesCtyItGbA8dU9r0tr1YYIJV2g8OsejB6lbKiTyfSEh
 8ZHFg+v+AhCY4YhQdWOxOAbrSeydFOFD6bf0HnjwnP5UqWaEnSkzU1Nz+Wai4UntorTy
 dA+nJMOqfo+u+/RoBooQtl+8X/HUHZacIeQ9pBOry7nGmkeaksVLJsDc1VOVNKfUjnOF
 3KNHlB0RNsl/WmCEaGeAyMdmUxZ59OMuwmQsnIzW41JGztyimgs9/58BE5GLz8PUr1Bp
 o+BdKU2IUfPQLqv7JX2UCmH/KNVyjqD+8dd+V2Y6BL8SA170jQSd7Bw+M6PBGxLID3LH
 nqGA==
X-Gm-Message-State: AOJu0YwNdJwCn35q+3ZUu2g9B3lhZozeEs06oYHCJyOjp6mvfBD8l8SM
 Oxw3TVfPVZQoy8IGJpmFjcYk7QKvvq1+SBFpk3eP4oSxVNCl/dNgg9AsfWcajtw6zoU9VMYvPQR
 u95I=
X-Gm-Gg: AY/fxX6lhk/zgmZGymnVIaX9L7nDBFkG014ClQwDpZmuE4AB1fcIPZdddkppgos6+0F
 n/v52LvAoOFZJdC6JwQMX65oAJstJ4jmAOMknTcgd43EibbI3Wqd7MZp8Iu4Ky7I5cSxdvXBbEc
 SFfi84LedICA/xLmtPY2XYnBNFB9BPKpvOIauwhj0KrYcMF76Mw4ymYlL/pNnq7qRbL0pOV69Pj
 I/nlwhVEWi/69pGxOOjQJCfmOjiETM3U24OFK2ssw3xxZD16uUinvHT3jXjEO701dk+h6abUUsy
 4PQH11y8ASjS6V19ADxoaoskBEvA4Wd5YW88pJphOGmV1lzf/hjK6XV96uiOvf1YJw3SoqshcFn
 QnZFLROEnUyqefn/+wCua/+clkLYU3AnQrErJkgW/ShHqjDqym8nqeonK/1HXqb1xLCDUQWA8e7
 U=
X-Google-Smtp-Source: AGHT+IFO5Jp8C+CSLSZL70I3ybSQ5N+X64h2JtRyREtho4gAvneYXdIN4qgVyGklxRxxc8ZjVdORvw==
X-Received: by 2002:a05:600c:5304:b0:471:5c0:94fc with SMTP id
 5b1f17b1804b1-47d9143a981mr11647845e9.6.1767939443048; 
 Thu, 08 Jan 2026 22:17:23 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-47d7f695956sm195599225e9.6.2026.01.08.22.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:17:22 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri,  9 Jan 2026 06:16:32 +0000
Message-ID: <20260109061716.20258-4-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109061716.20258-1-wegao@suse.com>
References: <20251223020836.9439-1-wegao@suse.com>
 <20260109061716.20258-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 3/4] ioctl_loop01.c: Add new support .needs_cmds
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
