Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0537C77B61
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 08:19:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B1043CBA67
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 10:19:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46FE53CB1F5
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 19:55:36 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8ADE11400267
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 19:55:36 +0200 (CEST)
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64115eef620so6805663b3a.1
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682618135; x=1685210135;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1tdm4FiIsP2t7Yt65fgM7Acxe6s8lWe0a0JiJhX5Vys=;
 b=T+hL2yisp9Xjh47W7SCXnfMdjWJCIkaJCve4FxZR7UYsB73WSbwAGjKFJb7/rRWcEp
 nk9yQn/vGYi3Oa5mRUcu5SnDZND0EUIcwAW7Otctz7TpucJra4HBePt4mrtifPqCFWvX
 ZFecWWKH2yQ5/ecgzW5ij4HalAnKoWbUUEPz1ZiOziIsDo1o/811TWBDdUMhb4ZAHqwu
 z+G77HcQ1kwHo4rWDmbXaFV7y7XAAwXgp7hx7ryxr5LqFRGYS2XspitBHr/wZmpRNsb/
 40hB+N7F8NiUmyS+DHdjExQZ3Ax5m7YmmP6XTTiuSpqizW8iajX1kDb8hqEFq8P3Lw7e
 FJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682618135; x=1685210135;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1tdm4FiIsP2t7Yt65fgM7Acxe6s8lWe0a0JiJhX5Vys=;
 b=j4UrwFjSnIXb6qwKRyNc/33DCNv15RCm0tCR8Po31CCntHvJGO4ywTGGgMAA/pxn4l
 pY1G57Cc2P/x/C16gaaJWX1V61BdBP2kjbPAsbqiBU4gLl5P8lA1URBqI3mEnhUHDpoI
 nLqbr4R68UvE4GteZFKStdUgUYMY2ih/DTTmw1gCBqeySXy3VcO5MjmUxWId5KgzN7bc
 2ClQM3qWuK9nl8tT3I9DRuPw9UPzlPIMJvcnqxf30cl54k85umPg7RTA2awFAzbNWBbS
 j+yoL78T7mKKGu7BKEDuCB3d0BcvEdTnJJYOQ7XXXher18UAPe7vz5BY/eHzIUpTAS6x
 wNXw==
X-Gm-Message-State: AC+VfDz0qFnvMtN2ySqX5jSZJyCOobeWrPKAgOdjDRPi637ZGIlhDqQn
 X/oOXR+QneIWL0tlkaCXWTZjUiYHBJ53Dw==
X-Google-Smtp-Source: ACHHUZ7sZ2bQdHvK1lr3RlofW8l3AvASYk5oMfCZK5y1RPYBfaLvCIIlDp0DRhHD8J6uxXpnyx5VHg==
X-Received: by 2002:a05:6a00:2d20:b0:63d:39a5:5bb9 with SMTP id
 fa32-20020a056a002d2000b0063d39a55bb9mr3240252pfb.7.1682618134705; 
 Thu, 27 Apr 2023 10:55:34 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:51:8f24::104])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a056a00178c00b0062e12f945adsm13507659pfg.135.2023.04.27.10.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Apr 2023 10:55:34 -0700 (PDT)
From: Sowmya TI <reachmesowmyati@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 27 Apr 2023 23:25:15 +0530
Message-Id: <20230427175515.1514-1-reachmesowmyati@gmail.com>
X-Mailer: git-send-email 2.40.1.windows.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 28 Apr 2023 10:19:14 +0200
Subject: [LTP] [PATCH] cpuset_regression_test.sh: Renamed the test function
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
Cc: Sowmya TI <reachmesowmyati@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Sowmya TI <reachmesowmyati@gmail.com>
---
 testcases/kernel/controllers/cpuset/cpuset_regression_test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index 8e87d20e4..1ae8933bc 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -12,7 +12,7 @@
 
 TST_SETUP=setup
 TST_CLEANUP=cleanup
-TST_TESTFUNC=test
+TST_TESTFUNC=do_test
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_MIN_KVER="3.18"
@@ -178,7 +178,7 @@ cleanup()
 	cgroup_cleanup
 }
 
-test()
+do_test()
 {
 	local cpu_exclusive_tmp cpus_value
 
-- 
2.40.1.windows.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
