Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC29CD1288
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712115016; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=XpwRD+vEY+6CZ5usHYae23qBjIrtiEDRLReYcZonULE=;
 b=l0pBB9ssJ31har9Ds64iGBdBZo8EaUDdzTbrW5uPRBnZiTVB5LcyjaIujyZpqyT4MPc8w
 9mu3BNck+uJQWxh6iziKX/3FVnjqYjouqMaKvU134apLkuPGFMrLkWDvb98webXHeu8X8Tv
 z1Fy+I0kGpGi/v0GGW2wj5Mown3BoEg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 676783CD0EB
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 05:30:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 706183CD12B
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 05:29:21 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2560B1A0118F
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 05:29:21 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-416200b3caaso4429865e9.1
 for <ltp@lists.linux.it>; Tue, 02 Apr 2024 20:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1712114960; x=1712719760; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0/mcabtedNA38OO5RRa83KGWg7O6hfFSk3n0wWGypE=;
 b=Dzj7isUYINSJConheZ8mCrHtLJZanUpyxYWCvOD2qocvV50LOGA2WZMoElZPECXtfK
 dfGUp8g5h5Tbw5RejnPBVmdxj3mjr+w6vreFpc2jYnChH0HsiU2uNV7w2yE+4q72+8y3
 xYipgl4CnZ6VwhWnzTj5T7IsksxJqf8HoXnaap+i+YGRjHRP2LMDu1yZtUZ5sXJ1G2Fb
 R1OcybxFAR+W76nWglIUk0FDRIUoqFX8SS6UNk2jHqCRmNK5qv8WTF6QgRUYjcjAiibx
 5X9qAUCEaO2CvFE65my8x6euSJt7bUpEXcbqkVivNVL6NZFI0yz7vgc+TlwgLa1F/pBL
 ffNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712114960; x=1712719760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0/mcabtedNA38OO5RRa83KGWg7O6hfFSk3n0wWGypE=;
 b=ejY/WMROeKHU0dtnof5vmcznE+RnBi81vbNrPPM59PFHk5KVIUc2FRqUdeYOHBMkmh
 ODQi1sixDsxxkBFqrFEY1dmfnMuX5AFClsolERgSwQuUPf1UH0LhE4Te9hO7pxls83Jq
 K3qmhyVMGN/wHgNkn6Yx5UKLxrTrsoLTx/0s5z+1J8u+/pAqw894EFpsX5If5j87Ea8L
 ERV2VMeZ1gPIiJAr44oDqy1ZceD0f7KHbbFg72ddTOTSWjMnw8H5yO+IkSX57I566Lhi
 0zQmfiR51qR2fC2MNeH1ReHVKPUoZhfQlagwXmFWeFeDx5yRy9SH2iw327opdcQat9do
 7eWQ==
X-Gm-Message-State: AOJu0Yx86ucULf78Y2VSQRL+wQfaYnDg4sY+Iq9Ppq+0/8343XTWrjUv
 tHgJ/TduqZ65p8byx/7pCds9+3b+izHqdqj8VNW+79BC8Q69s3bUMOOubjbitbTflm4g70UADlk
 =
X-Google-Smtp-Source: AGHT+IFTCQnTYnHpbLl3fZTl6GuNb9LTrzIfGUG+8Tnxs2J5OwdfxeECvZLVVpMuOks4lqqRe/xzgA==
X-Received: by 2002:a7b:c843:0:b0:413:e81a:55c0 with SMTP id
 c3-20020a7bc843000000b00413e81a55c0mr12085580wml.41.1712114960403; 
 Tue, 02 Apr 2024 20:29:20 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 j29-20020a05600c1c1d00b0041493a93cc5sm20197496wms.2.2024.04.02.20.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 20:29:20 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  2 Apr 2024 23:28:58 -0400
Message-Id: <20240403032859.3826-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240403032859.3826-1-wegao@suse.com>
References: <20240327034923.30987-1-wegao@suse.com>
 <20240403032859.3826-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/3] shmat02.c: Use TST_EXP_FAIL_PTR_VOID
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
 testcases/kernel/syscalls/ipc/shmat/shmat02.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat02.c b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
index 53cb6f542..3ad1fd08e 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat02.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
@@ -44,20 +44,7 @@ static struct test_case_t {
 
 static void verify_shmat(struct test_case_t *tc)
 {
-	void *addr;
-
-	addr = shmat(*tc->shmid, *tc->shmaddr, 0);
-	if (addr != (void *)-1) {
-		tst_res(TFAIL, "shmat() succeeded unexpectedly");
-		return;
-	}
-
-	if (errno == tc->exp_err) {
-		tst_res(TPASS | TERRNO, "shmat() failed as expected");
-	} else {
-		tst_res(TFAIL | TERRNO, "shmat() failed unexpectedly, expected: %s",
-			tst_strerrno(tc->exp_err));
-	}
+	TST_EXP_FAIL_PTR_VOID(shmat(*tc->shmid, *tc->shmaddr, 0), tc->exp_err);
 }
 
 static void do_shmat(unsigned int n)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
