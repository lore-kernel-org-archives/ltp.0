Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E4FCA1002
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 03:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756782779; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Xus+ynE05RPgLIyIIpYuh8Cjz/mOt0mvQp1ATFg/+wQ=;
 b=n9j03jSfTDxhOOngpjoP1SqgqJ+lu0f8Mce28o22hMfUSr48ZiDX8EJvXgOxEMkOYI0w0
 XTxrAb9QG46V2zCw1zD6eDGBjjy/5rXstBvPeHGISwL4D77qyzEjk6p1WKhUqBFOO5MKA+P
 btgygGTv3lcw+ZNLGW0z3Yus8UaiMOY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A55B33CD1FD
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 05:12:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F280B3CD1F2
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 05:12:39 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0CC5E1000249
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 05:12:39 +0200 (CEST)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-afebb6d4093so809539866b.1
 for <ltp@lists.linux.it>; Mon, 01 Sep 2025 20:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756782758; x=1757387558; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q25NssvAfdbOzusUS+A6i6UcbUIhUkYYNC5KWqVO+8A=;
 b=GT0n5wDJWPw7kphlZIsmuWB3k4hg3pzDY8+74gASESwuOrZzFSYcca4oIsIvkEsbYs
 +fum4n20gUYrvAjcBn8sWUd2P1QRak8by6DBrNbq1IP4btn6pkGMOpvh/OsP2lGIJwKm
 h2/59lw3tvNIOCHwt05yEySVkOpGzYqgLXVMKbXkgNsDGGISdefosQK9m0VczzMoZZKl
 n13MNiX9SpEx5DRlpFzU6v20FTFQSBDd2R5ERDWkKFfmQndYWfPcaTog/PeaqPtaJmmG
 uJ/dc3Fhic0RPGHu7fobGxX4Lk5UbHvqlxDtzgASIUJbm1HnInZz66Yf6vo/86XxD1RD
 8QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756782758; x=1757387558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q25NssvAfdbOzusUS+A6i6UcbUIhUkYYNC5KWqVO+8A=;
 b=l6GijFNJ8X+QV7zlHXO3h68epZTDWYcOivLVB44IgTu0DcvSN8QejJJmtzJT7XAkp0
 4/3Q3BycKZrtH8rK4BE5DxfwKEcyQOv8a6lddvz14siQi6mYap7JbwgbvM9IwShDV6+u
 hlVps8GbF8hVXIp3XURGgOjH2lToqaj6+HjCKbrR/Vz4W+zQ8sHHfbH+7w3D+zUN0mSy
 UCBZGrG7VrL+73f99dTMFsyy9D0xOboLQnWhvFWN87cbt1KSC8Etb9QHM6kgO9E45J0S
 t0rtmQYrKjCohXa+9TCh+J49BnYmYOJ3fESKCi6h1XTUrKjldC6gIzEPezCj4xRGorIK
 c4bQ==
X-Gm-Message-State: AOJu0YzyqFktt0PfPiLxy6GwxgMkk8HGCNG9itwjVWZb1lBltQR/DwnR
 VowwzGIO2zvFp5uKAMv/mlCXvp5L1eUGSbgRkouE+tEOtLna+3zu3+4Y/eORwAZq6wWWOqW1Sb9
 oLkg=
X-Gm-Gg: ASbGncuhTLfxl7rnYPYNJiTh9METbUEm7ebAhVVZQTpNzOLaSmaUWwOYI7I6Wo3opfo
 6YFoavft0270AiqInLKf0nGdCp4eLe4tNCIBNCx5CG5galhulmtJeLFE27IQUrvLzg3Am4rfKvN
 pv0RVC5pmKchPEboqc65+x/8C1Vib1R/r/oEBZp4lkMupMBsLGbzDcQ7v5cS7dAWC0eEOEi7oqj
 YNpnWldUtC00VmbW/MYEcvXydsduRQ+Q846jykW2f1mVDzVxk3bzACd4mcUzN/X7SycGRACshku
 yDwAWp+RAnI4GWCOigmxNjBPrtzmgO908Wk8YLhIl5hBM+9UYutJda+dTuXqEbWhx8XnaxBY4D3
 SKFbfKJDYKoZPsVM77CnGZIWkoTlvb/Ql2LLmWffpRpfdjfbH2nC84A==
X-Google-Smtp-Source: AGHT+IF1maO1ifpBwJz2m3EjYJBqCw7zxNv4y18fC7P6b1b3E4UYxsENZhcxEtieqjlx0bx7OqLfew==
X-Received: by 2002:a17:906:9f85:b0:afc:cbf4:ca7d with SMTP id
 a640c23a62f3a-b01d979fe6emr1109648166b.54.1756782758256; 
 Mon, 01 Sep 2025 20:12:38 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-61cfc4ea764sm8467074a12.40.2025.09.01.20.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:12:37 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  2 Sep 2025 03:12:21 +0000
Message-ID: <20250902031236.5719-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901074758.5094-1-wegao@suse.com>
References: <20250901074758.5094-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ioctl_loop01.c: Use proper device for partitioning
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

Link: https://lore.kernel.org/ltp/20250829141932.31997-1-jack@suse.cz/
Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 26 +++++--------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index c9137bf1e..695aaeb0b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -78,7 +78,13 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)
 
 static void verify_ioctl_loop(void)
 {
+	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
+					"primary", "ext4", "1M", "10M", NULL};
+
+	tst_fill_file("test.img", 0, 1024 * 1024, 10);
 	tst_attach_device(dev_path, "test.img");
+	SAFE_CMD(cmd_parted, NULL, NULL);
+
 	attach_flag = 1;
 
 	TST_ASSERT_INT(partscan_path, 0);
@@ -92,34 +98,16 @@ static void verify_ioctl_loop(void)
 
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
