Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62280C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 10:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786099507; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=jIzyqPO7lR8IhElVFkmRC5FiBKcu4YYPD7g2yFQUN34=;
 b=ffnPfZ5hajAbZoWDOFWgQbkNUGF7ogrEzU47UuwHLWQFYwJOl7e7y5MizJnt1alp6cj+F
 CNqfzOFDK9wG1N/LcwXFDcMA7YwteH2ppWLubaOnZcJTtrxwPTReo7MvPz1bTbzIcSr/hle
 6sA+VJ1iitiaXP8tE3ZFeCGYsztoqEY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A69513E7009
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 12:45:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF0523E2647
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 12:44:47 +0200 (CEST)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com
 [IPv6:2607:f8b0:4864:20::1048])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A7D2D2001C8
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 12:44:46 +0200 (CEST)
Received: by mail-pj1-x1048.google.com with SMTP id
 98e67ed59e1d1-38dbe39ce62so1870353a91.0
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786099485; x=1786704285; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RgtI/qxEGFD6bPahqVRVqi5OU//MZdw1N6aeyQ9cocU=;
 b=ODMxchF7RfApClhQO6aOp4Sb1439HJQ0R1mqxvmpZ8ulKyOM23uzLWulA5pZ3ZdaVH
 3IFGt0L8hhEc6qy35MEziUC+mAv75vQbWGipJtGp5sfzlP6GbBG9ak/D+qiTQHpbvNuy
 +7QCWxYUkJ2ncMKE1tc2q5+T6fRjxO4FkWlaPCwXRwh69vgpk3/sRF7QvMD2VSJ7/LiJ
 IpEGLjcn7bWTp8pkYFbMLNfko2q61Vt/Q5I50B2L1Vu8fuC/chszRol361cuKG0L11n2
 Zf/deX2HjwpOozKioJW5GQ+wbxfzIe1JvhPX9F+oKDRifuFe/J/DK+9uBorre2EOYyYq
 0xDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786099485; x=1786704285;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RgtI/qxEGFD6bPahqVRVqi5OU//MZdw1N6aeyQ9cocU=;
 b=SuPf13ySi0O465LIIf33ALv7I7JtntnrhMwfu/cMh0/E3VEfqpqNaFW1q3EBWTOKD9
 5tH3bNT+2cX/yqEEzqvqgOPDmDuSgHb0lfCexpq73JTvVFY4ZF9Lap6znGdnm66wUEQD
 qN0GhmGacug0uNpGztFYDkjkLlL68I9Svt62dZIoDj5XZKvL6oMEDibG9+K/dNjqMDdi
 SQwXLeBrmbdws5IEcg05E24TjR9hOa4YmYwMzh/8dkQ/aCgZ2ybGPBybagWa9XjdTk68
 PH5sMudRguR7FwQMWWXk/cpbKOjT3/HTThwAynMiPNG+KHeSxYo7/PdDTqpTJAZELz2u
 9Qmg==
X-Gm-Message-State: AOJu0YzRPFjiFsvSPyi6g/nXv9pDMn01k+TsGtJBWEElNa65QaF2Sq4k
 x7I5dxn9kKRhFKHu8ejxT5tEKOqcCoNjKM77CJhx6yyce/lZigDpiKEBB/3ANiNjN/8gNsP6UuJ
 9NOjVHULdMwBaDNVNJjwX0SANbc+fAQxL2AMm0BqLkZSL5Mpy20Sopgj+QrJn4PmDjABp4PUf28
 eV/+2eVe9cBHNcLKlFyFcmLqD0jg==
X-Received: from pjuo6.prod.google.com ([2002:a17:90a:d206:b0:381:2921:e696])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3ec3:b0:38e:7f22:f674
 with SMTP id 98e67ed59e1d1-390897b18cbmr1482833a91.11.1786099484383; Fri, 07
 Aug 2026 03:44:44 -0700 (PDT)
Date: Fri,  7 Aug 2026 10:44:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260807104442.2831991-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/file_attr01: Fix EOPNOTSUPP expectation on
 tmpfs
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

The test was expecting EOPNOTSUPP when ufattr is NULL on tmpfs without
xattr support. However, file_setattr() always copy structure from
userspace early (via copy_struct_from_user) and returns EFAULT if the
pointer is invalid, before checking filesystem xattr support.

Therefore, the EOPNOTSUPP exception is only valid for file_getattr()
which does not read from ufattr early.

Restrict the EOPNOTSUPP expectation to file_getattr() (tst_variant != 0)
to avoid false failures on file_setattr().

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/file_attr/file_attr01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/file_attr/file_attr01.c b/testcases/kernel/syscalls/file_attr/file_attr01.c
index 419d54c36..2e6c07d07 100644
--- a/testcases/kernel/syscalls/file_attr/file_attr01.c
+++ b/testcases/kernel/syscalls/file_attr/file_attr01.c
@@ -119,7 +119,7 @@ static void run(unsigned int i)
 	struct tcase *tc = &tcases[i];
 	int exp_errno = tc->exp_errno;
 
-	if (tc->ufattr == (struct file_attr **)(&null_ptr) && missing_tmpfs_xattr)
+	if (tc->ufattr == (struct file_attr **)(&null_ptr) && missing_tmpfs_xattr && tst_variant)
 		exp_errno = EOPNOTSUPP;
 
 	if (tst_variant) {
-- 
2.55.0.654.g21b8a5bc05-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
