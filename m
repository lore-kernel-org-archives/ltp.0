Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E2EC77B7C
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 06:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751522585; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=76C0jbcMYShloYnAmq7fPxhotNb1vy1a+JQ4eme3lXk=;
 b=HE1xelDN8eA5DiTDac601CLGlHQYTloZQTDsN+sy3Z5Zr396j3cSViRqcRFtuLJlvFx1d
 DKFMeIa/8FrVQhvWDTVHHIK0qqCX2WRQIwuITAluyLWbVjaOPZqwLsxexqaWVroItHkGVc7
 /ADcxBIn40F6DF2f4ChtMeCu0fVZCQE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CB9A3C8D08
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 08:03:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96D003C5F9B
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 08:02:43 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C1180600806
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 08:02:42 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so55372965e9.1
 for <ltp@lists.linux.it>; Wed, 02 Jul 2025 23:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751522562; x=1752127362; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cwR9BxL5ng0P0Yuf6Jrd4iWIHu3B+GqhJex/P+HPTxU=;
 b=SYM4Na7He1nw61PwBVVI1HA0QY3m635XBH3bnWLiFOK+V8+KWRhDN29VHdI8YUEiqT
 GUXQcnmI4kvO279fSOJoHoRr3B7eW+qMPuvitbi4cHwKSR5bjknXFU2tJ4royEmrlXZ0
 iAHnM8NPoHjjr5+bT28O9CngaSc0eOglD47iO5kA/6dOhaqjElE//GBK7tXh9rPZ+agX
 4PT53LC9+QhuQX7WqKIK6PvLRv+Tl4dgtlZkqy1hI+Qi4F2EBvXVwqeh5lNIvKiAsC5T
 fVwbn2Ma67oFRe/+KfVBFWg4H2h2m1A7/2Nk0htddWpUeiJJBf5Bt5vtxvx63S3TcyJV
 SQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751522562; x=1752127362;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cwR9BxL5ng0P0Yuf6Jrd4iWIHu3B+GqhJex/P+HPTxU=;
 b=qnS02a/+7bHH/6fszV1EXoYGU8eLA8xlsBiSeysrkzg4vdwnbTNG7M9XYGebXH5Ue5
 c7YkQdlFmlaACQAPVkxYmCM7wEcWyYvyB7gzrkVXvOdMBCrEZ9VyMO78Ov+1qLgeIlVU
 d/Fn0h8O5NUN5b9g7r8DVV0sIZ48AkUtn8gwQk/cDqbZMUijmC/bUCTOWhncaDbckej7
 LqewpHCSM/scxkw/U2kjJI7mQQO7n3kX3ACwiFUgUrCDitK6gRaAQ8TLEnYgbhFSfk7/
 r0jXgv6fi25Iu18p0hYnKCsfS4jv5ivgFZW5X+FRWohWLpZ+MXt/lrjJZgEkOR0TDy/7
 3Zsg==
X-Gm-Message-State: AOJu0YzYZIf6/Q7ppfGbARZsUUaNgx4J5fwDWi+fGmd0mXZ165wszKBO
 mkhKc4kDijhOnQQ4Hau8kMQ4ETExD62EK+Ui+ldb//O9EqNmzYjTdFr41kHLCPi8T9C5TJB9v8o
 O4SrKNA==
X-Gm-Gg: ASbGnctAicaB1nnG6E6IN1b8DJqq+sz6ZHUHQntU/40d5Afa6URbROOy73UeBy06hDn
 aka9IdlGmlGKTVfICFkVrv9kgbScivjwkktjaIG1Cajs1voldV7clrHdfV8wSRjVw9qO0L4ddig
 e3InlPpPsdt47qfTZABwdXOlI9F9vv0lbpeC6dAZbPs/baS3Xd9JERhOZsOxegb8z23rI/oFCIj
 SNEbPru17hxDavq80D0OT/d1BjXn3UiHQLv/ZE8Yte2r2pNV/4peviDzk1Kic6B4QVJLD/PWU1B
 Ioqi8M5Q061PmVWsB5/WibDeBque9QUtl3AcGFxEnHEzBnnt5bs=
X-Google-Smtp-Source: AGHT+IHhmA7RdtEYFjJCPC8RlcPfDdnrJBmeLwEBdyfYAS0tOhH+yNK7DkhS+sLEx+q4vw/bPyF+JA==
X-Received: by 2002:a05:6000:4104:b0:3a9:de4:851e with SMTP id
 ffacd0b85a97d-3b201203be4mr4101147f8f.45.1751522561905; 
 Wed, 02 Jul 2025 23:02:41 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-31a9cc72255sm1420425a91.21.2025.07.02.23.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 23:02:40 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  3 Jul 2025 14:01:59 -0400
Message-ID: <20250703180201.3384905-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] du01.sh: Read the actual filesystem blocksize
 instead of pagesize
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

On PPC systems, the page size doesn't always equal the size of a symlink.
Therefore, we need to update the test to read the actual filesystem blocksize
instead of assuming it's equal to the page size.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/commands/du/du01.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
index 7977fd461..68099de9e 100755
--- a/testcases/commands/du/du01.sh
+++ b/testcases/commands/du/du01.sh
@@ -60,18 +60,16 @@ du_test()
 }
 
 block_size=512
-page_size=$(tst_getconf PAGESIZE)
-if [ "$page_size" -lt 1024 ]; then
-	tst_brk TBROK "Page size < 1024"
-fi
-page_size=$((page_size / 1024))
+
+FS_BLOCK_SIZE_BYTES=$(stat -f --format="%s" .)
+FS_BLOCK_SIZE_KB=$((FS_BLOCK_SIZE_BYTES / 1024))
 
 # The output could be different in some systems, if we use du to
 # estimate file space usage with the same filesystem and the same size.
 # So we use the approximate value to check.
 check1="^10[2-3][0-9][0-9][[:space:]]\."
 check2="^10[2-3][0-9][0-9][[:space:]]testfile"
-check3="^\(0\|${page_size}\)[[:space:]]\.\/testdir\/testsymlink"
+check3="^\(0\|${FS_BLOCK_SIZE_KB}\)[[:space:]]\.\/testdir\/testsymlink"
 check5="^20[4-6][0-9][0-9][[:space:]]\."
 check7="^10[4-5][0-9][0-9]\{4\}[[:space:]]\."
 check9="^10[2-3][0-9][0-9][[:space:]]total"
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
