Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917F4C48BF6
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 01:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709257869; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=wYsElXltk1dsLfw1zPHYvGvhn72US7SNBhaEj6TaAWY=;
 b=Nxdia9/+D3clw4vHPiQSBPtaJiAqvyMIaWuVRfE2rBaNgR6jgm3iY5/ojnDlmXuA71SxL
 I5IuHFhjAKQgRHrxni4YlF2YLdYxc73mkdr8E1N/dK7NxUs6MgjBtRNQWh16+ATAxTOCK9C
 RfhtWnr6GqAsFTkF8DNJH+e0r+0FYOI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6098E3D1954
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 02:51:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78A3D3C99B6
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 02:50:47 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 86D43201DC6
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 02:50:46 +0100 (CET)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d311081954so13018761fa.2
 for <ltp@lists.linux.it>; Thu, 29 Feb 2024 17:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709257845; x=1709862645; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c8Qqa7EyubNcDAQZuQHuQdjxY3Sap1gvpc7syrfqEx8=;
 b=cu+jgkWJW9VO51Io/iNeagucBuPxCN/f5TmFkxARcMtNp3JEZzvExvLzbc07reXKsg
 VyTbp3qWGjdgZL571TOOPOk6zhekX2RRqWsu/yJF3GaG6k6Yo6XXPpdTZniGg5JnqriO
 /rgeB+cOAZ0g6FeaIOQwkTAqtMLpSfT4zLamVdyd/xLIT64XyIdQnG6+H2i4Ov5hf2o2
 yoVz26XAoYc+XK0F6j6XTmEANXiu0h8GQSeNIGvu6IbKZdAjULn7P/FVyuKupir0lshD
 GPZ6SPV4iJUfkPU/NNm5vAQ5SlCxHpMBASPMbgbwahtvTx3vcex1Ajf+R7k2lRAm/dCw
 39Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709257845; x=1709862645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c8Qqa7EyubNcDAQZuQHuQdjxY3Sap1gvpc7syrfqEx8=;
 b=XD9UBiniOgtJOVNYyJT0CuVG7Vl48HaAWB7ryKnXyOCxoM240zuEWh2nLSfg5PipfJ
 oDYvfttU4sVFjS9pBjwUbVHRAH1imgcOZ7rzAUGwnOmn2boddo6sNK/O/RSya97YDAsY
 yAFdHR0xQRYXloMlLOAo1Fes4IYN/Zn8+Vy3to0fz3i+bPQ/WMrIC9lS5070VWjIIVVS
 cNKwfNjINRUlRKbFiFrzvtppsLnnBQjKCOObDRFUqCUxGDwFKxJaia5sojTD2MCPKHML
 D7hp9m1ufaml64qN+HLCtvRVSYandoaOA/fRmLqc+0NiMEk/6QpIi1XB+T+L4fu6WR6m
 c8sA==
X-Gm-Message-State: AOJu0YzbYOMQviYa2KXedZB9PPjkafpPZ6wxtaN77XdDWKuO/x2UkR+Q
 x4W4uCcfUx2LqxNr3mFEiGOinxknWk6FcUW1xeGDqV2iZspC6Pmi9Aeq3VMvXwysJUQVcS7CRl0
 =
X-Google-Smtp-Source: AGHT+IGXrBGXwsP0qqAT5Ucy12NMfkO9hdCAinj4nbm08Ds24KYN1+HkIVfx036znQ+UapeqE63LxQ==
X-Received: by 2002:a2e:9b87:0:b0:2d2:1a1f:ad77 with SMTP id
 z7-20020a2e9b87000000b002d21a1fad77mr94231lji.13.1709257845052; 
 Thu, 29 Feb 2024 17:50:45 -0800 (PST)
Received: from localhost ([81.95.8.245]) by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c468f00b00412b0e51ef9sm3747986wmo.31.2024.02.29.17.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 17:50:44 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 29 Feb 2024 20:50:37 -0500
Message-Id: <20240301015037.22061-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] libswap.c: Check free space with correct mnt path
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

The tst_fs_has_free should check fs size of mnt point.
But current code check ".", that means check /tmp/LTP_xxx
instead of /tmp/LTP_xxx/mntpoint.

Also tst_fs_has_free's "size" parameter's type is unsigned int,
it will overflow if encounter big filesystem block size(such as Btrfs
can use 64k).

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_fs.h          | 6 +++---
 lib/tst_fs_has_free.c     | 2 +-
 libs/libltpswap/libswap.c | 4 +++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 1dd7d32fc..99dbba4d1 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -60,7 +60,7 @@ enum {
  * @mult: mult should be TST_KB, TST_MB or TST_GB
  * the required free space is calculated by @size * @mult
  */
-int tst_fs_has_free_(void (*cleanup)(void), const char *path, unsigned int size,
+int tst_fs_has_free_(void (*cleanup)(void), const char *path, uint64_t size,
 		     unsigned int mult);
 
 /*
@@ -225,7 +225,7 @@ static inline long tst_fs_type(const char *path)
 	return tst_fs_type_(NULL, path);
 }
 
-static inline int tst_fs_has_free(const char *path, unsigned int size,
+static inline int tst_fs_has_free(const char *path, uint64_t size,
 				  unsigned int mult)
 {
 	return tst_fs_has_free_(NULL, path, size, mult);
@@ -252,7 +252,7 @@ static inline long tst_fs_type(void (*cleanup)(void), const char *path)
 }
 
 static inline int tst_fs_has_free(void (*cleanup)(void), const char *path,
-				  unsigned int size, unsigned int mult)
+				  uint64_t size, unsigned int mult)
 {
 	return tst_fs_has_free_(cleanup, path, size, mult);
 }
diff --git a/lib/tst_fs_has_free.c b/lib/tst_fs_has_free.c
index e82dfa837..080d693ab 100644
--- a/lib/tst_fs_has_free.c
+++ b/lib/tst_fs_has_free.c
@@ -27,7 +27,7 @@
 #include "tst_fs.h"
 
 int tst_fs_has_free_(void (*cleanup)(void), const char *path,
-		     unsigned int size, unsigned int mult)
+		     uint64_t size, unsigned int mult)
 {
 	struct statfs sf;
 
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index c8cbb8ea1..6c75d20fa 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -137,6 +137,7 @@ int make_swapfile(const char *swapfile, int blocks, int safe)
 	struct statvfs fs_info;
 	unsigned long blk_size, bs;
 	size_t pg_size = sysconf(_SC_PAGESIZE);
+	char mnt_path[100];
 
 	if (statvfs(".", &fs_info) == -1)
 		return -1;
@@ -149,7 +150,8 @@ int make_swapfile(const char *swapfile, int blocks, int safe)
 	else
 		bs = blk_size;
 
-	if (!tst_fs_has_free(".", bs * blocks, TST_BYTES))
+	sscanf(swapfile, "%[^/]", mnt_path);
+	if (!tst_fs_has_free(mnt_path, bs * blocks, TST_BYTES))
 		tst_brk(TCONF, "Insufficient disk space to create swap file");
 
 	/* create file */
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
