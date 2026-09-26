Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98956C9832F
	for <ltp@archiver.kernel.org>; Sat, 26 Sep 2026 20:45:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF3123E6FDC
	for <ltp@archiver.kernel.org>; Sat, 26 Sep 2026 22:45:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FA4A3E9FE1
 for <ltp@lists.linux.it>; Sat, 26 Sep 2026 22:45:05 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 571226002BE
 for <ltp@lists.linux.it>; Sat, 26 Sep 2026 22:45:04 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so13537785e9.1
 for <ltp@lists.linux.it>; Sat, 26 Sep 2026 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790455504; x=1791060304; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=edM7EGcxe2S74Jevk0YXalqGwSMd4oSXgoCLDzg2Kck=;
 b=hYKzvo0pD2x87tjRPZKBT3DwjZuAEuIO9rSLsaNLHag2tOaY9YSnZ/31l9lOGWHXtw
 fKinWSZ6K4Tt1xyVE0NenCfoA1Vc6lkkhYWfJp3auXYWz7Y+mF7dB+ta7t05Bs+DX/xO
 VbwBkpwrPlzkN0PtP5ubZ7S8FG5YWVPS9CmKpqmC4tQwWQ0tJvZyS+Q0yKkjY9neAd/Y
 Vi6zEyFE5zDxuc0bSyHmLJFdOC4EZmGIeuUcPaCRqkK5mOtTdIKFzi2PSiWEGcZq1lqx
 UNdFp0KUOAfHYUPSWbzPmH7AA0nbahFov+o8wWXjHxJog9Uw1hwrdwyRNXIq7PNG2wJX
 FZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790455504; x=1791060304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=edM7EGcxe2S74Jevk0YXalqGwSMd4oSXgoCLDzg2Kck=;
 b=p0jBWkuhWLpsRLBR/1cpS1ky4QXWSgu6S528axxS8fFIG1c5U28Py9tiBBvD0QxGV2
 Cji7RV0sMUPmDMJQVQAOATSkiETP/3ELHTQPgXXIuGH/SoNJAfXfvaZVik6zVrUAuV5J
 eg0TRNBVSjcpzkJYTuqYgPcYJd/eVIh9K1I+BOaj2z/Rs5Gm5Zto30GLKygEoDAlSvNL
 D53FhhvzRS4zL1aWexjwHWiq4FG2vJ+NFIAU7RRsDsSh7jr1b1tjshCPJenlgdOkHYjB
 S2Q1en3tASZAnRi9VGMYR/mUEOuYf2ht1R/MsOzwPpoJ6TeQnnW2eFaS+LgZFlNdH+zi
 E5Ug==
X-Gm-Message-State: AFuF++m5PQyLFUEIVopsMGIscyyUi0BFBgLL6nVtCU9L/AOsRFepxO7i
 eZaCNoTzrJvhgJsDC0wvFed8wI4YdYop7eeI/PjBEBj3Azli/oBQFL7pRyshqsqE
X-Gm-Gg: AYBFou2ZH3TSozw6gIBfN/7KZQHnSkLuOsZ7fnZc/qNHNaBwWdLlNwhvs/ekrJEStTq
 YZNOYF/yWAiSNxWfK+XSmhyF70xCISOvHJJktjPKh7J3vZwCFmeA04E+xT6SkjEuuh6cevO1dH0
 on30LyVAcCB8MWFC3mGNuJHjRHQ8orN1rZGE17nF/XKAYHcByt3swBPhs6hkh12y1+MxKzM3PyC
 zPUKo59jvpeJorosTj20duKd6RkHwmCGkMnF+2MlLqdoUF87NT+qNwqwlIfb1R9M4AuUI1hP24r
 bPrTly7BqtAtvsvBX9+mvNti+motxgsTrgP7+CrsGY8JnIjqEmfGCMPK+60onZCOFkHFabWbnvR
 vLuJwdOe/cuLJHasSjRod3fGtmToVG/WNNLfE/6ylElcRhTLSpgfXc3i0/bf2/mILgOkbEPZkPy
 EQpHYbS4r/PCJaC+D/bd9/FpD4FjTsdAp9eTMfETsqTHjmVYXkmhYanP47+U3fzOew6f1t8pQ0C
 mvCwQi8Bi4M3XJGTVMAK9yAZ2RChPej7PcZVoALQmG+
X-Received: by 2002:a05:600c:310b:b0:49f:bd3c:bc18 with SMTP id
 5b1f17b1804b1-49fe66f4c72mr170744755e9.19.1790455503539; 
 Sat, 26 Sep 2026 13:45:03 -0700 (PDT)
Received: from localhost.suse.org ([37.109.167.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff13b3c59sm18554405e9.0.2026.09.26.13.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 13:45:03 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: ltp@lists.linux.it
Date: Sat, 26 Sep 2026 22:44:53 +0200
Message-ID: <20260926204459.20699-2-sebastianchlad@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260926204459.20699-1-sebastianchlad@gmail.com>
References: <20260926204459.20699-1-sebastianchlad@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] memcg/memcontrol0[34]: Use expected values from
 the protection model
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Sebastian Chlad <sebastian.chlad@suse.com>

memcontrol03 (memory.min) and memcontrol04 (memory.low) still expect
A/B/C ~= 33M and A/B/D ~= 17M after reclaim, which are the values from
the original kselftest. These were never derived from how the kernel
distributes protection among siblings, and the kselftest replaced them
with simulated values for both tests in kernel commit f10b6e9a8e66
("selftests: memcg: adjust expected reclaim values of protected
cgroups"):

  A/B/C  memory.current ~= 29M
  A/B/D  memory.current ~= 21M

(see tools/testing/selftests/cgroup/memcg_protection.m for the model).

Real kernels match the model, so the old D target leaves very little
room below the upper bound of the 20% tolerance. On 6.12 x86_64, 105
iterations of memcontrol03 across ext2, ext3, ext4, xfs and btrfs gave:

  A/B/C  27.5M - 27.9M  (old range 22.0M - 49.5M)
  A/B/D  22.7M - 23.0M  (old range 11.3M - 25.5M)

so A/B/D is already at ~90% of the old limit and small variations in
reclaim push it over. Passing runs on 6.4 ppc64le show the same
picture for both tests (C 22.6M - 32.0M, D 17.6M - 24.2M).

Switch to the model values. Keep the 20% tolerance, which is already
at least as wide as the kselftest's; kernel commit d2def68ae06a
("selftests: memcg: increase error tolerance of child memory.current
check in test_memcg_protection()") raised the kselftest tolerances to
15% (C) and 20% (D) for the same kind of sporadic failures.

This doesn't change the outcome where C is reclaimed far below D while
the unprotected A/B/F keeps its pagecache (seen e.g. on ppc64le with
C ~= 6M and F ~= 13M). That is a protection failure the tests should
keep reporting.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 testcases/kernel/controllers/memcg/memcontrol03.c | 13 +++++++------
 testcases/kernel/controllers/memcg/memcontrol04.c | 13 +++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index 96224c4ee..aa94f4999 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -18,9 +18,10 @@
  * memory pressure in it.
  *
  * A/B    memory.current ~= 50M
- * A/B/C  memory.current ~= 33M
- * A/B/D  memory.current ~= 17M
+ * A/B/C  memory.current ~= 29M
+ * A/B/D  memory.current ~= 21M
  * A/B/E  memory.current ~= 0
+ * (for origin of the numbers, see model in memcg_protection.m.)
  *
  * After that it tries to allocate more than there is unprotected
  * memory in A available, and checks that memory.min protects
@@ -217,10 +218,10 @@ static void test_memcg_min(void)
 	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++)
 		SAFE_CG_SCANF(leaf_cg[i], "memory.current", "%ld", c + i);
 
-	TST_EXP_EXPR(values_close(c[0], MB(33), 20),
-		     "(A/B/C memory.current=%ld) ~= %d", c[0], MB(33));
-	TST_EXP_EXPR(values_close(c[1], MB(17), 20),
-		     "(A/B/D memory.current=%ld) ~= %d", c[1], MB(17));
+	TST_EXP_EXPR(values_close(c[0], MB(29), 20),
+		     "(A/B/C memory.current=%ld) ~= %d", c[0], MB(29));
+	TST_EXP_EXPR(values_close(c[1], MB(21), 20),
+		     "(A/B/D memory.current=%ld) ~= %d", c[1], MB(21));
 	TST_EXP_EXPR(values_close(c[2], 0, 1),
 		     "(A/B/E memory.current=%ld) ~= 0", c[2]);
 
diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
index 22ca1df8c..92ab53a51 100644
--- a/testcases/kernel/controllers/memcg/memcontrol04.c
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -17,9 +17,10 @@
  * memory pressure in it.
  *
  * A/B    memory.current ~= 50M
- * A/B/C  memory.current ~= 33M
- * A/B/D  memory.current ~= 17M
+ * A/B/C  memory.current ~= 29M
+ * A/B/D  memory.current ~= 21M
  * A/B/E  memory.current ~= 0
+ * (for origin of the numbers, see model in memcg_protection.m.)
  *
  * After that it tries to allocate more than there is unprotected
  * memory in A available, and checks that memory.low protects
@@ -182,10 +183,10 @@ static void test_memcg_low(void)
 	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++)
 		SAFE_CG_SCANF(leaf_cg[i], "memory.current", "%ld", c + i);
 
-	TST_EXP_EXPR(values_close(c[0], MB(33), 20),
-		     "(A/B/C memory.current=%ld) ~= %d", c[C], MB(33));
-	TST_EXP_EXPR(values_close(c[1], MB(17), 20),
-		     "(A/B/D memory.current=%ld) ~= %d", c[D], MB(17));
+	TST_EXP_EXPR(values_close(c[0], MB(29), 20),
+		     "(A/B/C memory.current=%ld) ~= %d", c[C], MB(29));
+	TST_EXP_EXPR(values_close(c[1], MB(21), 20),
+		     "(A/B/D memory.current=%ld) ~= %d", c[D], MB(21));
 	TST_EXP_EXPR(values_close(c[2], 0, 1),
 		     "(A/B/E memory.current=%ld) ~= 0", c[E]);
 	tst_res(TINFO, "A/B/F memory.current=%ld", c[F]);
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
