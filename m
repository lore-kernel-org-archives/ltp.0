Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E960A2601
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=HotvrfoZ;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eehAsqee
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795437410; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=6mJGB6Jz1WRB7UAC36teipP2m7vcQzTxTW37JWYsUG0=;
 b=HotvrfoZ7l6oJNYmoIYQQjqoo9MG7qkAWoqu2pa1Y78MBeU5DgQNeO8BUGQMtecFk3Aiv
 Z6n75jvsWqCvVvAz2KY1rClvgaZRDXaldqv+9M9M7PAZA1qSYkWdbi6DPE9XAAAVZutyD3l
 RJfihzrlt+maxMT2tnMrhln2rn+6D5Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9041B3E9174
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 13:36:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A7AB3C5493
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 13:36:30 +0100 (CET)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com
 [IPv6:2607:f8b0:4864:20::1048])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3D1031400427
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 13:36:30 +0100 (CET)
Received: by mail-pj1-x1048.google.com with SMTP id
 98e67ed59e1d1-3b421417c3cso2694576a91.0
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 04:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795437388; x=1796042188; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yqfBmV5Dpy70fTb8xY+YI2nvzuOVxPEe6omqryz5qYM=;
 b=eehAsqeeUMPerEgsHE+VqPzUozX/kq/Bwx4ACguciUGau61qv+Nfra8ZkfvcM20DYl
 wI2HXplcTmiI1jsP5WHHxrOWuSaAfFND4ZgJ5D+h/D2FnnIBj31Er5FZyx1p/V4YXjV2
 IWFPo20/OsgmNqBL+jh6UvW+AYJse8uroePjTv4oG/go2m/ptuKA2TJCT5yWkjD1sTGR
 0WjR0JNHHewYI5CSDE/ZIFOHX+oJnmhE2yQ7A6oA/eP4XW5/hsHNbdHKU8gaE7yqKe+T
 LtOVUmN1DilYan4VAl0TAhDyupncb4nbOS5hJMaSIwo/3f5SXmPR8tC+yXtLyOt4SZAm
 5mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795437388; x=1796042188;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yqfBmV5Dpy70fTb8xY+YI2nvzuOVxPEe6omqryz5qYM=;
 b=k+NHW6NB2MBfWxpRHPGJ25jy7iedssGvL/7gnPQ8bDQzj5GiHcT0QrWyIVVNM3esu/
 2Jf3594/l3pQ9mw6/Hk+loisop6Xfzo3kkIZzYJ8iCJ7YYGW8+zSBcOLgZQZ2lL4C9ij
 /ljntA6gaRmYviX3iZZpT5002UTdKH3kndzl6+WhpMr7Uf17qT6kHJ9SHEStXJMjLzlB
 gQ7UqYu2hYOzHl1aarlYCPP3a2t4d1eAKuTq5IzvZ22zUoR6hQNMI9SRyjVv6HOnKuMh
 S8kMndcerOJxrTVCjQ0bwJUWyd4dqss07eMdPM9gBNamdneAUpLxQeI5Uy3dafceLc+1
 YXNA==
X-Gm-Message-State: APuU4Z8JpFCHI2c3KvodSISg3sC3vt+b48Fo+C1MjTrX/78VuEsiJTgW
 M0Cdj9j/er05gtw7rT0aDwTjr+F0KR/UIJvVemjAUMQGR7aQf0qKuj8i0/f3BNWn/bQHvWPmRQF
 urR6cqIRpRKrB7FL1APCIVZBM6N3dxXcU4Ut8L/MNxTFeMWDueLRL3pKtp3smByOzjNNY02hqyh
 osougUpqHPPu5kar6bpQU6MA+1Zw==
X-Received: from pjboy6.prod.google.com ([2002:a17:90b:4486:b0:3b4:297f:c2d0])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f8f:b0:3b3:b0f4:1bf7
 with SMTP id 98e67ed59e1d1-3b41c8d460emr10469959a91.23.1795437388106; Mon, 23
 Nov 2026 04:36:28 -0800 (PST)
Date: Mon, 23 Nov 2026 12:36:24 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123123626.1499705-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] swapoff01: Create 64MB swapfile instead of 65536
 blocks
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
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
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Before commit 6249e87b5fcf ("libswap: customize swapfile size"),
swapoff01 created a 64MB swapfile (65536 * 1024 bytes). Converting that
count directly to filesystem blocks made the swapfile size scale with
f_bsize: 256MB on 4KB filesystems (requiring .dev_min_size = 350), 1GiB
on 16KB block filesystems, 2GiB on exfat (32KB clusters on a 350MB loop
device), and 4GiB on 64KB block filesystems, exceeding the loop backing
device and failing with TCONF.

Use SAFE_MAKE_SWAPFILE_SIZE(SWAP_FILE, 64) to restore a fixed 64MB
swapfile independent of filesystem block size, and drop the now
unnecessary .dev_min_size = 350 override since 64MB fits comfortably in
the default 300MB loop device.

Fixes: 6249e87b5fcf ("libswap: customize swapfile size")
Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/swapoff/swapoff01.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index 065b5edbc..781fe75d6 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -41,13 +41,12 @@ static void verify_swapoff(void)
 static void setup(void)
 {
 	is_swap_supported(TEST_FILE);
-	SAFE_MAKE_SWAPFILE_BLKS(SWAP_FILE, 65536);
+	SAFE_MAKE_SWAPFILE_SIZE(SWAP_FILE, 64);
 }
 
 static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
-	.dev_min_size = 350,
 	.all_filesystems = 1,
 	.needs_root = 1,
 	.test_all = verify_swapoff,
-- 
2.56.1.750.gf70dc682cf-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
