Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76673CAC5AC
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758876709; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=2U/gtLfxqxGOZpyze8gmW+5Z88Ws6TLzRiXnao5/J4Y=;
 b=p0ln4lQeIs1I0auSgzWok+yO5NgT+rbPY8hXdSm44r52eR2DWAR/bhKhFX7v7WKCbrNtN
 bPaSskeqQGeMsSNeOJ5tv3NMy7lhCt7Te4HV+IARSfp0/3QYq5DBOgIrnxSw/BcENu+qGqw
 HCGOGVh0YZ7ULLoEHKiHs5ESwUS2F6I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7AC03CE09B
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 10:51:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C3633CE091
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:50:49 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1FC5714001F6
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:50:49 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b07d4d24d09so363869366b.2
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758876648; x=1759481448; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Ktze2Q6DPKj1ake7vz7tILFXbR/T+ZJ4V4SRCkk5IY=;
 b=Gs6Rrd/icz+5AaPuZDRJu5b2pWH42biNkaBIyWHT9aO9yVw3f6P5bS8IJwKh530a9p
 WyZGDhS5SwK3tRbjsZLQ+1OiwTg+uDz4Ewn/qUFp9JMCEtXyGgFRW94vZtHMSrdVkx3a
 ZYDOGEX/ywHckwTnpusmD83Gux8lG+IRz11TjwukM35Nj3JuGwX8uDxwYnKhCZjhvZc0
 VXex3/lmW6mvP4gC8wTBqcWJurIYt4vYGSrB0a3Z9R0klOVXnPCai3fu5MDwsJ0FnyL9
 1lZH7CZNv0Q4GIa3qXx0I0onEvnA6HaXxWfwEjgrxz3MJXnRya7QA+iKHHXhsvtoz++t
 NZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758876648; x=1759481448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Ktze2Q6DPKj1ake7vz7tILFXbR/T+ZJ4V4SRCkk5IY=;
 b=WFlM6zrq15UotzafVIisTVkzqqeOqZl6O6kYd0J7csH8kCLKLk6MffOc4a5YgJz12k
 T1E/rWGpuQMaqy+zIAIfYeikFIqT5LmXMUpwfCGrVc4AJvN/zxyYUbi8GAwyA3wcheya
 NpDrKXphWy0ZVAUAq55sii2QOlKX0TeK1IPUoFURvoPufl4zKCdUB9sk6C0JzdrYH0uH
 KueEw21KVjs6b1VqA9WpfBX6Tg7ZIKt4F9KZHmbVtdrWHkRcHa3UNq6w6+rS+V21d3rs
 TukYSYucJ1vb3Xf2petIGJhlj2F+bMGQQNbdFVdys6ss2AuOeNiZjzmQyn4tZSRBNepM
 Mqww==
X-Gm-Message-State: AOJu0YxWku1xEFFBJ2/XRY/Io3tNOu+evzTsUtNu4XMN3KyBzniKvOOd
 KNuTtVhjPkAHlLMpo4TCPvzSWbRgxJ6xc0Zoa6M+bjB4JoTJVzQsrASEhV1M5T5ZxcHAVTTVFSS
 /Isc=
X-Gm-Gg: ASbGncvtA5we9RMrsDX7yGLTZFJp/zr3NWayRDiCcuYsWzmrWb3HlAzUX1NwNL6I0CA
 XqHlPap7KXdO6gLFZCp7rgLYW6Gc/R/2YNG6oc8ndmNDiCP0zZc0MYaV3g+Gg71a1li7jj+VJ1h
 upXHrsYHQvzmJ7PYySqgTm01tzjonBl2cQDF12JfcFGfP9AknSqhB8rqt+d7zjNSa81LWxt/0E7
 p7A1mnOJnm+BUN/kVc9kLHMaQ7jonuOeSvFLsZHxqTzSfqF+wEXsHAOfZXyUlAzCqNWNpRoFWwC
 SiHRrryhZcIzB5KlbQa07AAwo4pQv7CDc/eQQNrg3husG01bOSomm8QYNEDE3DSyBFb5Doyx/fO
 tRmahWgZgJhJA3IQ80vFXPPiub6fxGjVzVqEgoUnR2C1ZhxHun9h1xHZhKU+9yfOp
X-Google-Smtp-Source: AGHT+IHXOCyLuylpZDudB65w//gp6Yptu3j5UeWPMBtwCrmlyvZbIUGnVTRqy5MYr6k3Xfah2mFEbQ==
X-Received: by 2002:a17:907:3d56:b0:b2b:c145:ab8d with SMTP id
 a640c23a62f3a-b34ba639af9mr682474166b.24.1758876648316; 
 Fri, 26 Sep 2025 01:50:48 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b3545a97f4esm320474666b.103.2025.09.26.01.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 01:50:48 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 26 Sep 2025 08:50:12 +0000
Message-ID: <20250926085021.22141-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926085021.22141-1-wegao@suse.com>
References: <20250926085021.22141-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] ioctl_loop01.c: Update to new .needs_cmds
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

NOTE:This patchset is draft for review not final one.
Since not include update .needs_cmds for all related testcases.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index c9137bf1e..a3f0857e3 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -97,9 +97,10 @@ static void verify_ioctl_loop(void)
 
 static void setup(void)
 {
-	int ret;
+	parted_sup = tst_cmd_present(test.needs_cmds, "parted");
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
+		{"parted", 0, 0},
+		{}
+	},
 	.needs_tmpdir = 1,
 };
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
