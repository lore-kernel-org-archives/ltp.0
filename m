Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF07CCD13D2
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 11:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777548256; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=TygnfJazD1SdxWdFlQhL0hgiAS+W2s3cj3SXBGF/B/k=;
 b=bsYdyp99reiUeoxMCFb7z+PuWv8QZc9iqKvZ0M/8X+Bf67ATdYzzW8bYV/VtW+NYQl/6b
 wEbcQL1TaqK4EByMDzL8Wkaazapfx6FeD64Sqgf5ZPKZ66SDSt8akwPz8rQjCvgI7Anjtfd
 m+9RQG4H9oUa5SjUMV312pOvxAeEOMk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DE4D3E594A
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 13:24:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA06E3E2ACC
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:23:52 +0200 (CEST)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4DA321000DB9
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:23:52 +0200 (CEST)
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-362d9dd9a49so906938a91.0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777548231; x=1778153031; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wlAwfiI6N+SqRJnmPJyuySIBrQKB6L/zpKoIFGcQh+o=;
 b=JevaRbGT6lC/GiA4gq39V3bcfWWCy6o8OtjH6mAOivZMAEtKrowmzqQTi9uZaLMdN6
 tIxxGibcKiJnEmar2tuAgnfcFllKpo7FIfw9TKg/uS2piqDmB9iSk6l7ECm49lxL9cjm
 sRc67/8EecR21Oc+BLlEpC6Kj9dKqrnQS6HFVgfTwDqshLQYHhNE/JHQsHaCYrsBc/cd
 3tbHTuzcPoIO144rLsDXgXQd0HEXoxdtjMNjNvqxX+l9CQSPDVLdxnCA/Jq7a6Q1tCcv
 hEw0IfbEZAyZpicnMFwHNcfDUcx3btEAkkloOddOtpV4kGy/aP7TiehVurUkxnl7bkif
 iIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777548231; x=1778153031;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wlAwfiI6N+SqRJnmPJyuySIBrQKB6L/zpKoIFGcQh+o=;
 b=aPwWsPBUbHMedlOixetH3TPyHxBCLluQDwgzCWS8Cd1/RKW7D+NZMndj2BpbuBOmdw
 9ev50rbKReRNytzXY68UQp3lshtXXiMFUSheHXZUsr8/F676nuyu+3MNQjvwV9YnMB7x
 ZsKGChcdckF+6r1ec2sHTuDmGBMLZegirhyb+UL/RJxmdOZhHy8p999wJ8DNoMlJnHms
 yQpi2/i90p4UhjwdCq2Ky4EN4bx9hGyIVC6lhaHju2OHqQZ+BEwEslwjxdwGviaQ9Ox9
 Mkvu6yhWbJVJvnLJ6rVaOZ9AHGklPEHmblJ6o/W3SxLxzzf+zXeU2cp8Sk+ntvQTK355
 gI5Q==
X-Gm-Message-State: AOJu0YyIBYf1WzJSmqiwZ0SPQYpiWsLmNXDNPjIqSqga2hzrfeKJ5YkU
 MqD1o4hkL8LoICnP2wa6HwJ9E1rnsxEK9uVWZTzDhhnvVRqXgpp93owOX6wi5ANN38zBHOO3mRb
 qYe9CpzJ4P0AXdq7A/onx2dbddINSCEjtYInrX4f1LHlAaBaEvpBQMoaD7dnYrMeVzP7diM2+dn
 Ywcc34XS2zg2naP/jZpkBJK9n+RQ==
X-Received: from pfbik4.prod.google.com ([2002:a05:6a00:8d04:b0:82f:a6d1:a709])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7f9d:b0:39b:ba95:b14c
 with SMTP id adf61e73a8af0-3a3cf632a70mr2932970637.24.1777548230321; Thu, 30
 Apr 2026 04:23:50 -0700 (PDT)
Date: Thu, 30 Apr 2026 19:23:46 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430112346.4054436-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] listmount04: Allow both EINVAL and EBADF for
 BEFORE_6_17_9 case
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

On some LTS kernels (like 6.12.y or 6.6.y), the bug fix
commit 78f0e33cd6c9 ("fs/namespace: correctly handle errors returned
by grab_requested_mnt_ns") was backported.

The backport changes the behavior of listmount() for kernels
before 6.17.9, returning EBADF instead of EINVAL when invalid
mnt_id_req.spare is provided.

Update the run() function to accept both EINVAL and EBADF when the
expected errno is EINVAL on a kernel version before 6.17.9.

Change-Id: If5b138e64b7c3d8434eea180dd6adc845db44f42
Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/listmount/listmount04.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index 919f4c854..ee15ff99c 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -152,9 +152,16 @@ static void run(unsigned int n)
 		req->mnt_ns_fd = tc->spare;
 	}
 
-	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
-		tc->nr_mnt_ids, tc->flags), tc->exp_errno,
-		"%s", tc->msg);
+	if (tc->exp_errno == EINVAL && tc->kver == BEFORE_6_17_9) {
+		int exp_errs[] = {EINVAL, EBADF};
+		TST_EXP_FAIL_ARR(tst_syscall(__NR_listmount, req, tc->mnt_ids,
+			tc->nr_mnt_ids, tc->flags), exp_errs, 2,
+			"%s", tc->msg);
+	} else {
+		TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
+			tc->nr_mnt_ids, tc->flags), tc->exp_errno,
+			"%s", tc->msg);
+	}
 }
 
 static void setup(void)
-- 
2.54.0.545.g6539524ca2-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
