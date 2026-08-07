Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F26C5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786100218; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=zkRHwp8ju3NUsUsYpky6qgZbh1SPvJszNYHG9E+NbZk=;
 b=QAx7vcEnl5D9TtwanS0ygnPqw6YXMKPtAVX6BAR7Q9hV4oCWKx6D22oHO4+bE+rDjWWFR
 gYw4Em6raNpre1tq317uV0+HaEN9B/8Y6IAImGLkk8LbLR+UQHqORTk4h8n9iTdN7xHIk6k
 lt8lsRqR+3jeNXTAfNP8OINrNNKamCg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82F4E3E7017
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 12:56:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B1013C281A
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 12:56:39 +0200 (CEST)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com
 [IPv6:2607:f8b0:4864:20::445])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 852A1600D2B
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 12:56:38 +0200 (CEST)
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-8486ffba174so7633097b3a.1
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 03:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786100197; x=1786704997; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B4zV5n7Sk/xxWVy/8C6gl8QxktJSw2RcuvU7dfZx7Gc=;
 b=g7kTNNAWfxDf3ZsxL8TnCd4w6t+jtSAFKgIDDuLSAewwV8kCwcccYV0VAaP2OOgC78
 ay3syr8Gp0f+c+MRQVQqBZQvDQ+HmDmfdsgK2xQ81z92gYTlAXj8dCT69bzdyx/UH6Z5
 X2CeoQxkuWmSqBJ5+D5KQG0PFM4Cw2OWF9V2DZG6pwEF0Z48fsqVTfnb/20XMsJ9dSLn
 J61Sp61Mgu1L+MkD9wTNygreEwLhFYZxFa2G/yUxdb5pXI4bLS7qeNcFrB94fmvZQbem
 ewFRCdmLt6ESBPGnLY/15cgDT1P3R5hOIFbh7u/Ifd3ZvX4XJ9sDx/LVkurDXGCchrLt
 aEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786100197; x=1786704997;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B4zV5n7Sk/xxWVy/8C6gl8QxktJSw2RcuvU7dfZx7Gc=;
 b=s4GUdWsk9CuXIlzln7W4WsnJm8tKxoHTAL5K95xzIflgP1NwCHTafG18R1vA3oQL1f
 mRSexls7bgsmLHXKHjwC7wDXgXAFgvX7kK3/zAnSXo6lH5z9NJWnEyIr2on41ijOBGAc
 Cje0dc4qW8bIo+S9m1qnC/P8RoXYKw3gZ7VVPmZWzLobEYSi7d2B8qKLGugLz0a0Ciwt
 RHgDTSRHbeBRiztKxlS0MFf8MHbTaL1QujLkCMGBqr6YfW4a+HoJD2vvWqpOjXlBfiVH
 bQ8ibDdZE7HZo+SyiohL53C515g5+AHPsPSsxORexCPfHopESpOOkIb5b4eKG99qxrKB
 +VPg==
X-Gm-Message-State: AOJu0YxyCQPe4Axhmp8YHuhr2i/OJ+oA47neCEnlnj4QZ/uL7jR6mlQB
 yKj3/jk+3ujONeOYVgfe5/GtlTIS0++bVf9Ta41qO/RBsEwSQMDBZd7l/MuF6hDd6oprPW4WaZ3
 YTFlQyt8lQL6hjJbfr9NRe7xjjn2pSRG4UL/L7rrOThB2dEMNwhbxcttXCutLTbHwVXnPo3HYsW
 jEJujI/MtSSwa1Bjn0XO4t7FAoDQ==
X-Received: from pfbfr12.prod.google.com
 ([2002:a05:6a00:810c:b0:848:40f5:a538])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d8f:b0:848:48c6:480c
 with SMTP id d2e1a72fcca58-84f2e00e9ddmr23370031b3a.24.1786100196368; Fri, 07
 Aug 2026 03:56:36 -0700 (PDT)
Date: Fri,  7 Aug 2026 10:56:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260807105634.2837348-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] inode01: Use uint64_t to prevent inode truncation on
 32-bit
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 32-bit architectures, ino_t is typically 32-bit, whereas the kernel
and struct stat may support 64-bit inode numbers (e.g. st_ino is
unsigned long long).

The conversion of inode01 to the new API introduced tracking of inodes
in an array of struct inode_info, which used ino_t. This causes 64-bit
inode numbers to be truncated to 32-bit when running as a 32-bit binary
on a filesystem that uses 64-bit inodes.

This truncation can lead to false duplicate inode reports and test
failures.

Fix this by using uint64_t for tracking inode numbers throughout the
test.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/fs/inode/inode01.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
index 2816ad61a..d41ff2c62 100644
--- a/testcases/kernel/fs/inode/inode01.c
+++ b/testcases/kernel/fs/inode/inode01.c
@@ -36,7 +36,7 @@ static struct tcase {
 };
 
 struct inode_info {
-	ino_t ino;
+	uint64_t ino;
 	char path[PATH_MAX];
 };
 
@@ -74,7 +74,7 @@ static void record_inode(struct inode_info *inodes, unsigned int idx,
 	snprintf(inodes[idx].path, sizeof(inodes[idx].path), "%s", path);
 }
 
-static ino_t verify_file(const struct tcase *tc, const char *path)
+static uint64_t verify_file(const struct tcase *tc, const char *path)
 {
 	char buf[PATH_MAX];
 	char extra;
@@ -128,7 +128,7 @@ static void verify_tree(const struct tcase *tc, const char *parent,
 	for (i = 0; i < tc->fanout; i++, create_file = !create_file) {
 		char path[PATH_MAX];
 		unsigned int my_id;
-		ino_t ino;
+		uint64_t ino;
 
 		snprintf(path, sizeof(path), "%s/%08u", parent, ++*id);
 
-- 
2.55.0.654.g21b8a5bc05-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
