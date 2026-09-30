Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9559C9830E
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 03:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790740474; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=czjE5rWFmgMd/BbGOE07AF0q7p9DOEbKR8k5NBlUx0c=;
 b=EESwz5cIo/gaNC1U1Pc4x+DR1TZEztHSAY068aH43MnR9v65J9c1BJ4w13gP7JC/sQD+k
 5T/RnNX3HKbSVFHMovJpLpeAa+W/lKcX8TNdAeXM5TwU6y5By/P97YpFIOKeiYSHAr17LIp
 ZASuPn8YNJa+lwgPq8VXxGAIcqX4dAc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D17DD3EAA8F
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 05:54:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44E4C3EA9D4
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 05:53:39 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 16F7A600723
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 05:53:39 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so45150695e9.0
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 20:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790740418; x=1791345218; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VFMB4ZWJbMhDRoQDbRRujf7rXG6rBxauXvB33m/MSlA=;
 b=NxKNC0dAuho3Yz8D74wqzRlkgpQvckwuYITq5+VKXXbMj2PE1uWJNIYkj5PPW6UZty
 +utMEf+J3ftIdQHW1koe4L3Jk+frwHKbKSTp9yh1ZrcVjfzCs1frcLXco6dlRRNEBEDb
 jLPSEku5TzMQBt2Y8cR7c9gb3Q7X+/3aV3qZoGBh7tvBRsadqisy4nYUxFk7YYvnWlA8
 wq1iolpVV1W5i987ctCZ7AlAHfh2/e/urGEDUvcDSKgvozIBRmv/3TxpPk9u23EbGL0d
 8diIBSMal7hBT6gCar4D+f4zW7SQUvISHryPm5ZdFnC7bFpzJcXd36c3YcwZcc7juM3V
 kXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790740418; x=1791345218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VFMB4ZWJbMhDRoQDbRRujf7rXG6rBxauXvB33m/MSlA=;
 b=KoPuemZiuJJvW9bFEkhLEQkDzK/1KEE+IAKMXVKm2FBUWcf4cyEda8tQPmJFLSG/Je
 2x6x9ym8FgTIJsWeoELqwUrM4cb+jO6BQdwma5yfHR7KTfP0zkYdPX7+usducWrOJyuy
 aL1JJqy9hmfZcvl/ep/LicHJ3AoEejYb7Km1Z4Vv8p1RkqaGoAO22XOMJEKByiTKxhpi
 57mNFQI4GegM8ihhKqpWspgQAVIDBnrpycB4diesy7WRIWpx1R3zkQwrUobZYa9YrNAi
 OKUc/RCiGFdESnIjjiiePmn9RxFjBtf7zTCHelDM8B/jlkYsxiMmcaHE/X/Hn3BDpNTJ
 4wDw==
X-Gm-Message-State: AFuF++lUdkFOpKtaPUt7YxRKegSaXTpfLW9n2bc5xxJh/w256l8XNWIm
 mbuh0Agssv3OGK7+aE0CIQlQqBeRjRiltIBai+3ToexzIHwore8IHIM4+NBJL2Qp5MHn73+ibkD
 a39I=
X-Gm-Gg: AYBFou0ikysEdoO3KhObWJBISTGW87NxHcPSD7YjONUS5332w5e0uBM7x8A+De26U3J
 lp2zcbD8dTGR115LjJ/MMqR5Dj5WFfSkl9FKCGnmE63g0X/iNBqGELQjRwaCQOCc/QwXkks15lr
 GuIrhc7GRMHDUssSeWs18mvcag6YrANXumnWrv4E2PWc1V0cb/f939vxWwk5DKbppnOsiRI6SEP
 Zt9AYD5U24e2dOxJ3ndW4RFk4dkAdlLl5S/JeuaOpXKP1Bc7s8qpeZGEiCrCnmePjrj/H9qC3Zj
 tZIuwP8nImt343OoN8ORf/TwNtGlY2ZkwmvgjO9WngWyrjZiLFFylcUPKc5bCuypNxLwgmVF32e
 yqXeONClrcOR29hco+4vu9SoSyi+3BkZcqTmOGoQeLU5dch1N5vo2aOeH8dkya8H6VYrllL4XzZ
 24MHSaexVGGEUXWJD7ICqvkSChtH475dn7D6088g7jZaL7UaV9LGYpADkCMVWHwHMB9/kaqNwFn
 UQMduk7USTyhSmgH9hE9vbv2vpD0Y6ujgEBbiAEhSY=
X-Received: by 2002:a05:600c:8b4c:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-4a01502fbadmr18046495e9.10.1790740418537; 
 Tue, 29 Sep 2026 20:53:38 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a01751613dsm18039975e9.3.2026.09.29.20.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 20:53:38 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 30 Sep 2026 03:53:15 +0000
Message-ID: <20260930035332.3360-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930035332.3360-1-wegao@suse.com>
References: <20260929022340.524-1-wegao@suse.com>
 <20260930035332.3360-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] memcontrol03,
 memcontrol04: Bind test process to a single CPU
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
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On multi-CPU systems, memcontrol03 and memcontrol04 can intermittently
fail with over-reclaim of protected pagecache under trunk_B:

  memcontrol03.c:104: TINFO: Child 142113 in trunk_G: Allocating anon: 150994944
  memcontrol03.c:121: TPASS: Child 142113 exited
  memcontrol03.c:214: TPASS: Expect: (A/B memory.current=54394880) ~= 52428800
  ...
  memcontrol03.c:104: TINFO: Child 142114 in trunk_G: Allocating anon: 174063616
  memcontrol03.c:116: TPASS: Child 142114 killed by OOM
  memcontrol03.c:230: TFAIL: Expect: (A/B memory.current=43319296) ~= 52428800

In the kernel, per-CPU charge batching (MEMCG_CHARGE_BATCH = 64 pages)
caches charges in per-CPU memcg_stock. On multi-CPU systems (especially
with large page sizes like 64KB on ppc64le where each CPU caches up to
4MB), allocating memory across CPUs allows cached stock charges to
accumulate in ancestor trunk_A. Because trunk_A has memory.max = 200M,
this extra stock pressure forces the reclaimer to evict pagecache in
trunk_B down to ~35-43MB instead of the expected ~50MB.

Set .setup = bind_to_current_cpu in both tests. Since child processes
inherit CPU affinity on fork(), this confines stock batching to a
single CPU across all test children, preventing multi-CPU stock
accumulation and ensuring reproducible reclaim behavior.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/controllers/memcg/memcontrol03.c | 1 +
 testcases/kernel/controllers/memcg/memcontrol04.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index 96224c4ee..d65c03c0d 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -243,6 +243,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.setup = bind_to_current_cpu,
 	.cleanup = cleanup,
 	.test_all = test_memcg_min,
 	.mount_device = 1,
diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
index 22ca1df8c..28ceaf8c1 100644
--- a/testcases/kernel/controllers/memcg/memcontrol04.c
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -242,6 +242,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.setup = bind_to_current_cpu,
 	.cleanup = cleanup,
 	.test_all = test_memcg_low,
 	.mount_device = 1,
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
