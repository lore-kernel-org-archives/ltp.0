Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A06ACD4F3D
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 02:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779330252; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=WTaEoLoNzMbhByobhnyiu+LCDPaTrGI/oDcV8lkCrjg=;
 b=pMaTp3WFzqA0IVINFH0tpPeoEp3zazgNTitk5kGeMmxCyyFyPNlQ7QHPLis2H3onlbYoJ
 Mv+fDK9y49ElhZdGi4zju/ZrKd7PaC6XoFO/rJ+L1nDgf2RNwIb5LEORA9PEeXqJiSZk72U
 ZJ7fYx8jeA0WLJ59+pDjSOAD5MVPC+4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 281243C737E
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 04:24:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDE553C737E
 for <ltp@lists.linux.it>; Thu, 21 May 2026 04:23:48 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8902610005F7
 for <ltp@lists.linux.it>; Thu, 21 May 2026 04:23:47 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso5156602f8f.2
 for <ltp@lists.linux.it>; Wed, 20 May 2026 19:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779330227; x=1779935027; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X2WxKMKRIPXn/LMTRMQaz+6zYn5Ule4H/Dy8AO4z+9g=;
 b=fJ3bU5zRMLLTBTIKliUhM3H79imTakUcKaoCgZLuUwNGj6DjIgUUrshyhoHWO5lo0c
 mXuGh7YZ7DvwdsigwEgh4FkuAuyIaXu3/eXsV31XtXq10VQ5C/0ofpkd+PVkrJxER+0n
 IoComnSEQAyVrufCw+6NM9G/BlFE2pTGwF3cIHyTyb2eM9fJTPQP364SuQspLlVX+DRb
 6q8dSlqMkWfNeM9EVuQsrPkHvATAQrMdw1ZO5kU/K0fn8+8yqXIId89AuvoVndgla5Yw
 ouqwHSQQ9/+Vmu8fxVHcRdDfDtfquH3Ex3hh5BzxrEadXjzd+geAOEXSQcrC171lLlWP
 QiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779330227; x=1779935027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2WxKMKRIPXn/LMTRMQaz+6zYn5Ule4H/Dy8AO4z+9g=;
 b=QXpyy8BcKJLI8A2oidFWrkRienxd8HawRGIXz2lhNKknTZIX6zAko6dmnAPsEXL3F3
 +GJyRYePiPAgfDK+BE6WxXoz5kwcTThYB+NYKbRsoQ6Dr9cZzc5F13zDamJYi3O4PgA6
 xnRTfGVDz8NVL+3znpfVI1yItwjAKyIM9hL5+snaUePUjyoYAHOjLu9lmtha+o6cmIQ7
 xWwz0xZN7ogZCOP7JfJr6zDNcTVxTk//mklNyDzs3oZMlooAucVCF6LWpe+/xpL1WLu1
 xzLwqtotxUXUemcFbHukp9UnUdvh6LDAxZx09nLlV/0aEnXxNVHmY2gMAxqYX6fPB0ig
 wixw==
X-Gm-Message-State: AOJu0YwpDtZIs4xpoEubrbZN02Asxt3Q/I+8HSgStGRkwjll+OXEBgOd
 aRy8GvdNSDtjb6BWGHTN6LyjtZ0a+FZU0GL1HoevPPN6kYVaG2yc7MnHt5UgA79FXEx4/KrNpvu
 Hmt8=
X-Gm-Gg: Acq92OGODMi7MD+i0kY8FPebtZZDhtY8h0vROK5n5S08zlhNPijxqpsg8rsUNh6Nk5l
 nIjcq9OxIgA9D/QVDZQDtfOQy7GSRdJYYMGgX/NAwnsd8D/gzzX+pm317Y/TXOLiiQAtEM/bM1S
 1j3vtGFT6M+ZPJAa6ea9elYWK1EyTKCMbFqk8RMDlx0dygao8jaxBcO9PDR/ccuQAYEqH/SyVBi
 NCNbCDExqO1mtkxvdP7hLcPTSgrI7PhV770BBv5BAAlfcA4FXEVkSCyUlYJwEmMDP9G/pB4EG9t
 jO2Wm2EC80uSGSO0cgLWVkMJfBYJepf4iYwg73adDCSfr7iyYpd4F0Dif6bwyCetBTy7kN3M5jU
 +zmGupVhUs1cEP4FEahZMmv+vhbOn9ZYuSRU6AoNdQhXiwocbTYgZSolCQqAkW/paCkJ0/j0Myp
 yE4sbSFbvReQw=
X-Received: by 2002:a05:6000:4205:b0:454:af3:33a0 with SMTP id
 ffacd0b85a97d-45ea38b4eb3mr1257902f8f.17.1779330226939; 
 Wed, 20 May 2026 19:23:46 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45d9adc2209sm55262304f8f.0.2026.05.20.19.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 19:23:43 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 21 May 2026 02:23:14 +0000
Message-ID: <20260521022315.8924-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] OpenPOSIX: Return PTS_UNTESTED when detaching or
 joining joined thread returns 0
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

The previous commit allowed a 0 return value, but as suggested by Cyril,
returning PTS_UNTESTED is more appropriate for Open POSIX testsuite when
the implementation does not trigger the optional ESRCH error.

Latest test in our openqa setup (Linux 7.1-rc2, Glibc 2.43) show following errors:
- pthread_detach_4-2: Test FAILED: Incorrect return code: 0 instead of ESRCH
- pthread_join_6-2: Test FAILED: Return code should be ESRCH, but is: 0 instead.

These are caused by glibc commit 5da15b15adab661c80e373b6af89be0b5fa5b3ad
("nptl: Do not use pthread set_tid_address as state synchronization (BZ #19951)").

Fixes: 630827d58634 ("OpenPOSIX: Allow 0 return value when detaching or joining joined thread")
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../conformance/interfaces/pthread_detach/4-2.c       | 11 ++++++++---
 .../conformance/interfaces/pthread_join/6-2.c         | 10 +++++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c
index 1e7b84117..4e5d80c96 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c
@@ -18,7 +18,7 @@
  * 1. Create a thread.
  * 2.Wait 'till the thread exits.
  * 3.Try and detach this thread.
- * 4.Check the return value and make sure it is ESRCH or 0
+ * 4.Check the return value and make sure it is ESRCH
  *
  */
 
@@ -58,10 +58,15 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	/* Detach the non-existant thread. */
 	ret = pthread_detach(new_th);
 
+	if (ret == 0) {
+		printf("Test UNTESTED: Implementation does not return ESRCH\n");
+		return PTS_UNTESTED;
+	}
+
 	/* Check return value of pthread_detach() */
-	if (ret != ESRCH && ret != 0) {
+	if (ret != ESRCH) {
 		printf
-		    ("Test FAILED: Incorrect return code: %d instead of ESRCH or 0\n",
+		    ("Test FAILED: Incorrect return code: %d instead of ESRCH\n",
 		     ret);
 		return PTS_FAIL;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/6-2.c
index 4052a55e2..c924578a2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/6-2.c
@@ -61,11 +61,15 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 
 	/*
 	 * Now that the thread has returned, try to join it again.
-	 * It should give the error code of ESRCH or 0.
+	 * It should give the error code of ESRCH.
 	 */
 	ret = pthread_join(new_th, NULL);
-	if (ret != ESRCH && ret != 0) {
-		printf("Test FAILED: Return code should be ESRCH or 0, but is: "
+	if (ret == 0) {
+		printf("Test UNTESTED: Implementation does not return ESRCH\n");
+		return PTS_UNTESTED;
+	}
+	if (ret != ESRCH) {
+		printf("Test FAILED: Return code should be ESRCH, but is: "
 		       "%d instead.\n", ret);
 		return PTS_FAIL;
 	}
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
