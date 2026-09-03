Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C57C61DD6
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 03:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788406409; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=wDNL6l9HsStvrK41Fjmrky72DNmR6U0jsBoya3BIU2U=;
 b=Mjra3cQi5791wY/z7VasQHegRlDVEmN6QRdtErsB6AF2tj8apCkNga147uUkzShR4zGlS
 zeBzHMq7/zUFyrKx8ssFUnp57eghwoSMBHu8o2qdRnwnPrDha5a5/UlMV4LkuDqEzKBzMWo
 iW6z0sZsA/231/4PLq+isHjPxipXGTc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EE603E2254
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 05:33:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC3DD3E9857
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 05:32:34 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7DD921A0035F
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 05:32:33 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4843e397f74so701306f8f.1
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 20:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788406353; x=1789011153; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qKaxKxTk7QAWyDRxbT31kds7YP2Kb8pBLOYrvX4ZmKU=;
 b=HGFGKbaCoPV/HYsJzsLh+iObBW9q60eyok5sNDj82hZu6JwMLUJVtqsKhMglhn5QLE
 HLfNQORX79Nb4OylPpZ19pCN8qN3Vhz0QphjF8JhepVTuOooPPy9OuAsy1LZClunSx8X
 uldxVDk8pzlNfudJqczWFHnZey3zoE1knywAqVxJCFKTBTWhvvquV0UyIFSr1dvt8LXN
 8yWp1MTf6bRMaPre/rXkxT2f2JMmJitlhsWNutvR5eAInjMcMdofgSyyOcJFD5fhi9jr
 m5lgkx9hj1wyrqUd8yqZW6pu9ruzfjC1gdTjXlSc4z5vLdy/zoXncFKWlrUgMHr4PhVr
 zVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788406353; x=1789011153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qKaxKxTk7QAWyDRxbT31kds7YP2Kb8pBLOYrvX4ZmKU=;
 b=pk3Qgkxy+BWwKmDNKQ/loqw0pk1eGl+bpVOdWaSHOCPf60kOX4caVsO5WcZ2LPCmW0
 m2W9StBWCC6hlHnB24tfrSa6N/gltA6yqR3NfNPNccENRHcF2r7IvN5qQoSyzLMmBBn6
 bPpce0kp2S7vc/hfqwE2UFDuQ+euvhbjDvG003ju2nz6B8PJek3AZMlhcDcC1/g/j1T8
 6GZZMOmt/w1jrsPDVM8On/9EWfeC73EEBXA//uWFFoMYbUsD96wNh4NpWe8itSJ8/A9d
 9Pymy1vbFHoQvnaeMr6WvFlGyU5okdiPDBlaBILOzgL5sQq868ojk/3QCz366xQR+VkX
 0b3w==
X-Gm-Message-State: AFuF++myeHdSrLBSqU2XWIljwlJf9yIigkTT70nNm1DERO+FAe2OrRnb
 WHRvl9XejCsy6t5NWaW1nETGJvd1yHSJKvIqZE0V9hQ45pzJ0BqmKEvltXatvx8PHoJiSHbhVBS
 sjqE=
X-Gm-Gg: AYBFou1eIe4zs+xk+HhO4HcdVTdyJ8G+ldknsbORJFl3uUPCfPLVU0n+S9+zWIjcCd6
 77pI1Ofb1hZoAcjmx04ij2XJ3CNis9qVLYhIONncbDIMKrEX5A1Mi3K+jIUnMItySeSigcgZihX
 vz4quzhb6L6UhJgnJayCaWmp7Wsp9N59BPK53maWNbJgJ/hHVCFXIYGF6IDp2WzcdxdjqaWm4wS
 6qh89hoj+lXO8HRPIAAD1VhL/rGOHe7pH2fkKyMLx/+SSbP3XDbon7ShxBfykhKEE1ACtTl1+U4
 IoWK16MzH4QlJnFKoWlMLtulqcbL3sygySzBp335ffjVhYn4sqZkuDobdkzkJSpb6tk4vcjNHi8
 dT/3/yTY1dTW+T1XGRHsdih4MzCZIybEiZhNjU1oidPunIsjwn/v2Oi5CM1UHKSWMtnlKrcYQ9/
 Z3ub4TWwVd5mxqWsvNkY+T+BHOq5mePSVumvzOv1qgSil60VX8N9v5i2o8H04eI3W4hzVlU0lwC
 09tBogEx0nJk9bwYjtRtud1nd9mnwUZ
X-Received: by 2002:adf:e006:0:20b0:485:8224:1a3f with SMTP id
 ffacd0b85a97d-48582442d9bmr562831f8f.16.1788406352951; 
 Wed, 02 Sep 2026 20:32:32 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-48448e736a6sm10135471f8f.5.2026.09.02.20.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 20:32:32 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  3 Sep 2026 03:32:14 +0000
Message-ID: <20260903033219.4747-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903033219.4747-1-wegao@suse.com>
References: <20260903033219.4747-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 2/2] shmctl03: Fix 32-bit compat mode failure
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
Cc: Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 64-bit kernels, the default shmmax and shmall values often exceed
the range of a 32-bit unsigned long or are clipped differently by
the kernel's compat syscall layer than they appear in /proc.

Fix this by utilizing the new TST_ASSERT_ULONG() flags to properly
clamp and truncate the expected values under compat mode.

Link: https://lore.kernel.org/ltp/aJm5SBOaRoe1e0PB@yuki.lan/
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/shmctl/shmctl03.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
index 9e1c2f099..cf021be4c 100644
--- a/testcases/kernel/syscalls/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/shmctl/shmctl03.c
@@ -30,9 +30,16 @@ static void verify_ipcinfo(void)
 	else
 		tst_res(TPASS, "shmmin = 1");
 
-	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
-	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
-	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
+	int c = tst_is_compat_mode();
+
+	/*
+	 * On 64-bit kernel, shmmax is clamped to INT_MAX for 32-bit
+	 * compat syscall, while shmmni and shmall are truncated
+	 * to 32-bit.
+	 */
+	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax, c ? TST_ASSERT_SATURATED_INT : 0);
+	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni, c ? TST_ASSERT_TRUNC_32BIT : 0);
+	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall, c ? TST_ASSERT_TRUNC_32BIT : 0);
 }
 
 static struct tst_test test = {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
