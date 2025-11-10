Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4155DCCFA1A
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 02:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762742934; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=04qzmUtT3c8AYX/ze0O3Sa6mCgI8o/Yj9CtsjfU4AT8=;
 b=g9sg2Cojbk4aL99xX5qzI3LKbu6WF4jHJh64lKo6WK1zpaN5UvbHtdxTeKN0W08I3NPJb
 lhB2uBZmRsHYI0XQD2LOSvA8KcUamaWGDtBjJR3B0gLJTCOgWPYuorRf4tBIiICkD6OheSV
 PqvXHUYCLW1BTaao8XA83DWCwMHFxPo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94C463CF552
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 03:48:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF51A3CF533
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 03:48:13 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6346D2002D2
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 03:48:13 +0100 (CET)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b725ead5800so325940766b.1
 for <ltp@lists.linux.it>; Sun, 09 Nov 2025 18:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762742892; x=1763347692; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LD3b7LD7U/NPinQf99NpVEDFiYzU7aKLEaJ3xF9R2p4=;
 b=LIX1PyLfsAKuq+sP7ngakBDQQqLDYhAV9dbGhd7Z2TR7jgiyT4eDxyuJt5PPJpiPTw
 Zjpob3HhF2t5Psy8YDS503cWbnkhWwtHKpANYwGEYnUDXl1BmBuf4mfCU0LrM1fhFbFo
 mkT+1524pKtnkNe7F49ywj7J0YH4lXJJ6vk7eo+s6pIHcXjG+idkcibTrMt0T3OMIawn
 nHtTwk2WU1LYZQYE+Ngg+e4c7Dkq/o8S+L+P2GsUdx8UiPp8Ni4m/fSCIE1SigAFpDra
 1rdHnsVOl5DRCNhWMlxiAoINTXGwMPIcyc/Cm5xRWH9AX/qhLdSEJSfa2Nx+3SduOEuf
 8EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762742892; x=1763347692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LD3b7LD7U/NPinQf99NpVEDFiYzU7aKLEaJ3xF9R2p4=;
 b=WtM/iGkQ5bxYEZtrD0vbQgPOfzU9uMNsvl1yuyRqiFemhKebrMnfw8xN87YGg8RmtA
 qTg4PwcHgQ6ttM+QKInAX/Lj4hcKYSKPatGF2rZcmKOJvq/0m70wmz4wllMEEk5sA0fR
 gb32F0bNTN2dexYox7qlHtz7yRFohsVZRBkgWfHi6lTO+BadDeyzXa2RzPHBCsL6MKqv
 034CTjJRo8lmsDFR9nG0Ko7LMQ/Lql7a9f19nbtnwIJ9LPlifDSh/1sjvYnae86slInx
 aFyMpGL8SMqA4PIxRYot9sU5I4Zky97Vd6PKTIi3gFO8l95olGgy2e1iDX/Fq1cHJHLt
 C8Yg==
X-Gm-Message-State: AOJu0YzW71W9EfdgPp2/ryGkH8NgrgiQ0pNpAMhldd3GuTjHII+WoK3c
 JmsetC0osRsSIYE4HiNS/ZPmOB5FPvLbTcsU8zEPiWAf/S01ICDpyX5MiZihscKS9y9wcwBoJ32
 oEMM=
X-Gm-Gg: ASbGnct10KrUAuJ1Tcih1aIM10wNDrgLjsNJSUJi0juiDH9jXfJkKence/71Aqbw1ZQ
 E7YRApaXWKSUQS1Wd2f6xpTDqmF2SlYFwy17xEadd19VrMcyqMh/osxdJ+hoLsj+eZSvC6HigAq
 2zJRqlCR4AlH6LuNvdoYKLAaZiJfjXOiv2HB8985TxDAR3CPH8GKGVuiq/6oTzj5bvcNdKVEG8N
 ng5Ea7xUXcfTSL2QrYj839OYw7lSGRmz9pkuZ33n+gQXWpExFsFTduRrx/WU9fuETyWDIUFE/Bf
 KFrforRpBdb41Dgp5aKOxBRzpUV8C6HuFFqSkabu201/Bu55IIyx0OIqH8Q9Y3WaXIbzkGTnlZk
 mqawdKRzV+Fh63GIsINPPyNuNVpNLeugzOVEMzl8ENaXFLeH5aWym6tiZW3UYyuxR3MbVcTRIkH
 w=
X-Google-Smtp-Source: AGHT+IFI9sZKnQxQNTF8zeFnX/3LO7SuhGvVmLH0fVp1tWPad8UlJLz9eCGdHcEX3qxVXsEN1+JU+A==
X-Received: by 2002:a17:906:6a07:b0:b6d:608c:838b with SMTP id
 a640c23a62f3a-b72e049121bmr635479766b.45.1762742892590; 
 Sun, 09 Nov 2025 18:48:12 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf4fbda2sm956236466b.28.2025.11.09.18.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 18:48:12 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 10 Nov 2025 02:47:54 +0000
Message-ID: <20251110024805.31070-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110024805.31070-1-wegao@suse.com>
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/3] ioctl_loop01.c: Add new support .needs_cmds
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
index 4ecc93b1e..a8a9305c8 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -78,23 +78,6 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)
 
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
@@ -113,10 +96,23 @@ static void verify_ioctl_loop(void)
 
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
