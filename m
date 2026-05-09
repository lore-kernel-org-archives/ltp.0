Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3065CCD3447
	for <ltp@archiver.kernel.org>; Sat,  9 May 2026 08:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778315241; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=7cTpJv7Esk6mTtD61Itkhbu1DgtJ8LyDmNnpiNNe2VY=;
 b=fvm086zGX6gOnWaHT+tK+7pda+GJEuH9C2LLpQhnCCF3E2ZoXuEWWxzAmRRjIMBHnQLZm
 ZyexDqrhV9M/qWVR+0dh+vC11vaFLMbwKhN+vUMZrXryywEx8zaGxYHRaynlvDz31B0Bv09
 Th0doGKEC31pNH5e7clkLGQqAk/0inw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2EA43E21E9
	for <ltp@archiver.kernel.org>; Sat,  9 May 2026 10:27:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 127943C79AE
 for <ltp@lists.linux.it>; Sat,  9 May 2026 10:26:56 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 78C831000D41
 for <ltp@lists.linux.it>; Sat,  9 May 2026 10:26:56 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso2371632f8f.0
 for <ltp@lists.linux.it>; Sat, 09 May 2026 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778315216; x=1778920016; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WwF6U8U62bJT12vjn8r0aaYker9s0HHfjLE1aG9DZNY=;
 b=FXZJ/7/jAIR5ISWCxe/gS6Td6bHwKq0Cv5FuXUbx6bJjdtjvDA5WLAUbsketJmXjbi
 r0xmkorhKqHBSl/Gyi6QklGKArOTXZOc/EWdgBe2QeDjDAkJe2+V1LnySiZbYpy0qBFr
 nLtwFquPLlJbIWRNvk2B4EEIwxCYkPNUPlKOQ2sMRCMfqQKZ6ZlXSYS78t8bdRteMsNH
 EgNkwNfHY1rZB3FlvHyZjZX/aVRuBf+OweFuIhGj92WE9d1jD/67dABnfe5xfqzCAKdc
 8EiWsJxIPj+WwNKSRsfKU9iAH1rUHydaVwl4h3HLOmh/2dFExYCQufGn/gxHPpmmNZdm
 ocWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778315216; x=1778920016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwF6U8U62bJT12vjn8r0aaYker9s0HHfjLE1aG9DZNY=;
 b=XqIlDYDVMrySu4vjujNIfFU94buAk7iNX8w2U7b32DkHpLiDdzsUL1OHLW1E0JOWfm
 bLVQ7DcsJdOwydg+EiM9ndQNJV3MDTKizreLy4iacv1ygBzx4ZMnBLb7mRkDtgMK1lMr
 rAySfeS1vmgeoHsxw3HKGJtGWwaqViA2ExWt8Vcd4fgpqMxNfvl43c25/gy4acWNJg6V
 hS77gaxBFidDqABozlLHRmh1/yhxUlHZuZMWBNNOP7MpFVZW342mncLoDGVkPBNCu8Vr
 m+VZ1umW7XrYV/dIXeAuMQwpH8dbYx/hUvh/YfFb/hGzIhSgk7tlvQqi7oHgx0AU7SYg
 cq4A==
X-Gm-Message-State: AOJu0YwfkhOinOufbEOCVhZqDwMwReRxtOHJdWz21JxQ7btYIeXGzYou
 4Idsq/q7TC/5CNz7djJ2GldUKnNPe4WKVvQsybxpAOsSTXIpKbQT/JTcp4+mFGMEjkC6iQzq+co
 qMoI=
X-Gm-Gg: Acq92OFD5kXnFmENk0EvcBgPyHaSMMJrSTPoUNGYB6aX2I2+RUxSH6gDtnFKb5/aHjb
 vtAullNWi7xOZL4ywoKIL2B+k66mhV7Mgbec62rbaJqddVUxssbkqFmBSr5/jms2KeWq4sXbT0z
 Aee1opW2Xgo74gnWN1o1bmydu72xmiYxqPW9K+jtuKuc8i89d1hb0uQ/jm7FqMBqFx5G/Kl2ExB
 +hAC3t4Q/04Ip66QEaa3Ski1ONsBesXymU+kgzOWIJU7KoVEjsUB1qQbR5XYJI/R8qAy4wGBcso
 pbp3zqHSNxWCrRitZOY8gyZwAxZ4KSCy0koA/rC6e5Ne4djp1XyWw7ToZijE5Iokw/8ozUH/ZfA
 jxo3wGUrO12xEldOCzScHmktSYPMjzaWSBTtSVGiBSBkqXJC7laljWPfdL6Nj7kCNz/QXXG9Rmv
 gx0BfXnUVsLio=
X-Received: by 2002:a05:6000:144f:b0:441:1df5:480c with SMTP id
 ffacd0b85a97d-4515df67132mr24400355f8f.42.1778315215596; 
 Sat, 09 May 2026 01:26:55 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4549120eab7sm10235564f8f.23.2026.05.09.01.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 01:26:55 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat,  9 May 2026 08:26:47 +0000
Message-ID: <20260509082649.8533-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] OpenPOSIX: Allow 0 return value when detaching or
 joining joined thread
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

Latest test in our openqa setup (Linux 7.1-rc2, Glibc 2.43) show following errors:
- pthread_detach_4-2: Test FAILED: Incorrect return code: 0 instead of ESRCH
- pthread_join_6-2: Test FAILED: Return code should be ESRCH, but is: 0 instead.

These are caused by glibc commit 5da15b15adab661c80e373b6af89be0b5fa5b3ad
("nptl: Do not use pthread set_tid_address as state synchronization (BZ #19951)").

The new glibc logic removed the explicit validation of thread handles that
previously returned ESRCH:

--- a/nptl/pthread_detach.c
-  if (INVALID_NOT_TERMINATED_TD_P (pd))
-    return ESRCH;

--- a/nptl/pthread_join_common.c
-  if (INVALID_NOT_TERMINATED_TD_P (pd))
-    return ESRCH;
-

Update the tests to allow both return codes.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../conformance/interfaces/pthread_detach/4-2.c             | 6 +++---
 .../conformance/interfaces/pthread_join/6-2.c               | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c
index a6dc83efd..1e7b84117 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-2.c
@@ -18,7 +18,7 @@
  * 1. Create a thread.
  * 2.Wait 'till the thread exits.
  * 3.Try and detach this thread.
- * 4.Check the return value and make sure it is ESRCH
+ * 4.Check the return value and make sure it is ESRCH or 0
  *
  */
 
@@ -59,9 +59,9 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	ret = pthread_detach(new_th);
 
 	/* Check return value of pthread_detach() */
-	if (ret != ESRCH) {
+	if (ret != ESRCH && ret != 0) {
 		printf
-		    ("Test FAILED: Incorrect return code: %d instead of ESRCH\n",
+		    ("Test FAILED: Incorrect return code: %d instead of ESRCH or 0\n",
 		     ret);
 		return PTS_FAIL;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/6-2.c
index bd7e295d6..4052a55e2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/6-2.c
@@ -61,11 +61,11 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 
 	/*
 	 * Now that the thread has returned, try to join it again.
-	 * It should give the error code of ESRCH.
+	 * It should give the error code of ESRCH or 0.
 	 */
 	ret = pthread_join(new_th, NULL);
-	if (ret != ESRCH) {
-		printf("Test FAILED: Return code should be ESRCH, but is: "
+	if (ret != ESRCH && ret != 0) {
+		printf("Test FAILED: Return code should be ESRCH or 0, but is: "
 		       "%d instead.\n", ret);
 		return PTS_FAIL;
 	}
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
