Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E58606A319
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aHUc3y7H
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF08B3D25F9
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 13:54:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FBBA3C52F3
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 13:54:19 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E934360008A
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 13:54:18 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a1d75f2f11so13323405e9.3
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 04:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792670058; x=1793274858; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U9dilShG9yxZ73/T13sz0SWvQL1Qy0D5GZaP+pAT0Vw=;
 b=aHUc3y7HgTQZWh+ZrJvXCe43Z0uRUQwxBxtv3LgqgStxLz8vvsZAB/et5QPUdLVC9p
 ygzDiPPZ8LdFJrnZdR9Z3wJEtzr4jJW2TSUT8hmrM1bsddxzI/rXCDb7rtVkqiu+vTaV
 yu/a8En/0OWGD8KgLABBeIRUjkb265GRR7gwhOHyqipUNx7Gi6NnCm3bD/Ewx/aYHI6x
 NPntnRK3Skz0TkHkq1bvNvGbzUaqkddNZcr9gw5tGtmD5hC18QL89838XU3mz9yes7FP
 W6cZvAi+UlMwMhb4c85RHGlROM+Pbv7RnZbVAZLU/SA9neAPhYB6jJXHH98XuPX5MwK7
 YEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792670058; x=1793274858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U9dilShG9yxZ73/T13sz0SWvQL1Qy0D5GZaP+pAT0Vw=;
 b=QapzbyaAeKpCr1O+wc47zyvqIZ+9kJG4WZFSQuqmULAnFL3OrXUZRhWJpIQEvA2eDF
 j5KzXjiskfqCV33ceUFvkcBMnMtmbxJIgO0vrWrX6GnNP6UgZzoaK7Tf4nMyDeercX5W
 NSET+mivSeq+E8Fv1XR/dsGbveCrKMD2mbAWCBnBUxt4GFoL7ER+GuOpVJkbzMIXMDYH
 lDj3Q5bPU321PEnOKUqxjPx3ULeiYDjFbwxHdobiS7mIOvRe1ccpgwJFt5bVRK1MIsMh
 qcmiuO6eN7cK5UhvHXY9Atn5BPJBLcgIcbll2XbWMA2or+NNIICmNgGuiBlUIh/5Awam
 wrGA==
X-Gm-Message-State: AFq9FYKP4BZmdETKZd6JV/6bsw84Gvv87sIOaQqBGcK2U+vodp6cU3RZ
 uGEuspMv2UPrcy7x/wh3NJpz75BvCmS72y7BSONa613NKqXU07AY16wzbYf+hw==
X-Gm-Gg: AYBFou3mIy0Db+7oiOJIkSQjCtt/YjeWMexoAwyAxhuLHoeJCOBFWaOIc+Fui77djx3
 rgDkPVvS12m4WDVUpk+R76ITjH1l2oLkLvDuwqsjYEef6Lou3XgtDk80MebZjKbY8cv/toRQ5Zm
 lzG2B/UXg/Hu0p7fmw/7ZVth92tc0ZPxIcR99Gw5T5E2HXKLa+9oUaoqgnquvV/kIg021RY5k3c
 jkYAlG/YBg9vwxS/oEBDKgzwkcY/H/79rydQZyfTDz5ANMROLm7Yq4VZNcGTYv+BctSsT9QyswX
 Haf3ovoROJ7X31sOin/rPHhRQV9/vyx4TBnxa/A1czfLVVhsvXHRia6rzbm/LwyI5LB4zDiZ46Y
 bMeAdeE5qltAOIzTCZgSoQuk2fR3d/tKrLuUHLraOmMs39VJHVbqWwoKpJlZaTbpbCddPzN5lDX
 9kQd1odrYShys6kh4Q8W8ed02zSV6WyFQQnW0eL13YQ3lTd7L9IJaC6u6pNp6Tna9yofMbBlbfI
 1Kse5jt9yXe5kZX2amFYySfjumPH+PED0m0k+8apSUFTk5LL0+v5LdVHBB4vg2DxiXMQxOihUXF
 Wj+g71mt8c7cJc9GbPkhhTD/hA==
X-Received: by 2002:a05:600c:a48:b0:4a1:e0db:8cf8 with SMTP id
 5b1f17b1804b1-4a1fd8a7f8dmr104625645e9.3.1792670057375; 
 Thu, 22 Oct 2026 04:54:17 -0700 (PDT)
Received: from localhost.suse.org ([37.109.163.221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2038ddb20sm60707055e9.0.2026.10.22.04.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 04:54:16 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Thu, 22 Oct 2026 13:54:10 +0200
Message-ID: <20261022115410.23845-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: tst_device: Scale loop device detach timeout
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Sebastian Chlad <sebastianchlad@gmail.com>

detach_loop_fd() retries LOOP_CLR_FD 40 times in 50ms steps, a fixed
2s timeout that ignores LTP_TIMEOUT_MUL. When another process still
holds the loop device at cleanup for longer than that, e.g. on a
loaded machine, the test ends with a spurious
"ioctl(/dev/loopN, LOOP_CLR_FD, 0) no ENXIO for too long" TWARN.

Scale the number of retries with tst_multiply_timeout(), which attach
already uses since d90d20046 ("lib: Use backoff polling to wait for
loop device nodes"). The default stays 2s, multiplied by 4 on kernels
with slow kconfig options and by LTP_TIMEOUT_MUL. The 50ms polling
step is kept, so the detach still finishes shortly after the device
is released.

Signed-off-by: Sebastian Chlad <sebastianchlad@gmail.com>
---
 lib/tst_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 00304711b..79e1fe0fb 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -251,7 +251,8 @@ uint64_t tst_get_device_size(const char *dev_path)
 
 static int detach_loop_fd(const char *dev, int *dev_fd)
 {
-	int ret, i, retval = 1;
+	int ret, retval = 1;
+	unsigned int i, retries = tst_multiply_timeout(40);
 
 	/* keep trying to clear LOOPDEV until we get ENXIO, a quick succession
 	 * of attach/detach might not give udev enough time to complete
@@ -259,7 +260,7 @@ static int detach_loop_fd(const char *dev, int *dev_fd)
 	 * Since 18048c1af783 ("loop: Fix a race between loop detach and loop open")
 	 * device is detached only after last close.
 	 */
-	for (i = 0; i < 40; i++) {
+	for (i = 0; i < retries; i++) {
 		ret = ioctl(*dev_fd, LOOP_CLR_FD, 0);
 
 		if (ret && (errno == ENXIO)) {
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
