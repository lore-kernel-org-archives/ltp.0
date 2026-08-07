Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5B6C5AD05
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 23:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786144697; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EYNNTP6oXIrxtgRgGqp3445pKx5x1ZT97sMpX1ZcYKE=;
 b=MLq+vHEVcBFapVmPCmY0chRzm7Qm0TMQAUfK7EtCQCkJ2rVwZr5QDb/NsCbSGtYzzNL5p
 xJz7x5NTxmDFxwFMaZ0H/IWQrqVBv5hk3hyxpveAFauG3TL0XduExaqPmlYED7nsF+b/Kh0
 rI9jylM4opFZV06e8990IwWlqgtcMlA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 979FC3E7018
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 01:18:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E1A83C73AF
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 01:17:56 +0200 (CEST)
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com
 [IPv6:2607:f8b0:4864:20::1045])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 87C73600EA8
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 01:17:56 +0200 (CEST)
Received: by mail-pj1-x1045.google.com with SMTP id
 98e67ed59e1d1-38e5a616d07so64442a91.2
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 16:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786144675; x=1786749475; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bd1pdGdCFy9f73nv+gG0P1eepbxX+FqbIrjaMHLDy8U=;
 b=reLIuw/5Mt9qtFvLMwxYc/u2xRpph0zx0B5tyty4KDRO95GzJLNZ5Q+Jow5je+ZmYH
 PQv/oAPqSwiS8mpHaETfiiyOjvRpUfq1g9c0IZEvBeFNsAboukWydKK9v77SXJ4B6XUb
 NJmpTPAlKvjW7UnCy8Vg9bkYlcQHLKWXgvRk+f4Nd+Wp6CJdA8E0TyjhzL2SFZYVFLfl
 cvVPK1f2Sj5BupcqpAnRGaQ48Lk+coKrNPM4plhAkp+a7Eg3dTtbAN6xSrcAPUCiwOu8
 6WQEVZazlU+k5TMvsTY+QlCd7FeSEQ4vXWfudRG2lp3/y33uViq0CJng5wgu9rXBt9md
 kUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786144675; x=1786749475;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bd1pdGdCFy9f73nv+gG0P1eepbxX+FqbIrjaMHLDy8U=;
 b=NA8nSoQybb55lXYE+yPV2VlwACLe4Y7fY5Owwkw9v7Q4CW2AFry1VwH4xMENBjMUx/
 cvWnh/nsq2imnZHtZHAlIytfwgJqrRs482i+hmV3gSe+0soHKMpcYejwsh5HMOUOA48a
 blSgvTAQ+e9KVOhuIkwOLSnsu848MSzmvxLgDKIpQeKIztLWdjpBIoWuwzORh30vxPXO
 WfcdzkKyU+Uun7EzxHhhJgKz8gwqx475GWxB2jJyMIrN+uha+vE0A/vnSajoTYCV8lCm
 QQ83EWOS9DZPmXUXcV2ceULU4zWBABpNTJU9VmeqeyHMdQ7U6aEdcXRO2DNoF2JzmIMt
 LMeA==
X-Gm-Message-State: AOJu0YzDbPINd8s5px7RxXV2fs3R1KzhFcDtAAtmPA/wECMzRKxf5D9i
 JEtzrVMLYW7//eJkNe1j6sQQGZ1+I4BPFRxkQl1B+UVNVn1IfszAvTKy+TxhtNCKIwE1pT8EOie
 77LsoT8FkrCYO5c98hIJfBbYfsDn+Dd2IuTLQP7+mLcNx2sjpHipcsVMy/F+n5zG/m2MBdka/6c
 H97j84ZxBcfgXHuZApPzqhazA4zA==
X-Received: from pjzh4.prod.google.com ([2002:a17:90a:ea84:b0:37d:ce7c:cbd6])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3950:b0:37f:b0a9:1a68
 with SMTP id 98e67ed59e1d1-392822afd23mr3654592a91.7.1786144674592; Fri, 07
 Aug 2026 16:17:54 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:17:52 +0000
In-Reply-To: <20260807105634.2837348-1-wakel@google.com>
Mime-Version: 1.0
References: <20260807105634.2837348-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260807231752.3218267-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] inode01: Use uint64_t to prevent inode truncation
 on 32-bit
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
v1 -> v2:
 - Also change record_inode() parameter type to uint64_t to prevent truncation before assignment.

 testcases/kernel/fs/inode/inode01.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
index 2816ad61a..50b5311a4 100644
--- a/testcases/kernel/fs/inode/inode01.c
+++ b/testcases/kernel/fs/inode/inode01.c
@@ -36,7 +36,7 @@ static struct tcase {
 };
 
 struct inode_info {
-	ino_t ino;
+	uint64_t ino;
 	char path[PATH_MAX];
 };
 
@@ -68,13 +68,13 @@ static void create_tree(const struct tcase *tc, const char *parent,
 }
 
 static void record_inode(struct inode_info *inodes, unsigned int idx,
-			 const char *path, ino_t ino)
+			 const char *path, uint64_t ino)
 {
 	inodes[idx].ino = ino;
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
