Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2614C624C2
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788164264; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=sl/flV+kGifOmvWev6qAzOeSLgXYEWvieyWl4po7TtE=;
 b=ndA91wdvm7sEJ7Qqg9vEiPxrAeG8urk+GUsuYwosN4PbPxo73pTOU/Q1xgbrPSUnQb4Q+
 /gEw+PnaAakAiRT1cd1f21WTT98HECoKU/1SyMEaxMRc9K5rmj+J6vo/mfyeo5vle/0XURs
 82MPQAt2hJvTVpt5h0Cls8bgw9u7ktc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B9213E5A42
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:17:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EFFF3E59BC
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:16:47 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AF84E1000972
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:16:46 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-482e5733a5aso1868625f8f.0
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788164206; x=1788769006; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z7rDUSP85BnNaSowiv68FjXU6tjIjSurG6eRZ8Fc9/4=;
 b=MxDqDrOBDxuga05Jbsp8+CqRtpH/V9LVLpfRy9LDZLx4pqhX3vN8TnNAqf+Or9pMKF
 2Ev3xSMDNMvKo5KMW11Rxq7kbFAOtica5mged3N+C+vx5q5yUi6f0Zn0jt0gEsD7LDk0
 oGbi6GL8AUPrSs/S8sUjIha8a6mVLukQo4EyxAA8PbL4Xb3ViCsW0VQ1Nu+X3cH659NB
 /JMhyJ1eZOuGKturXp/+RGhLoDbs9pk1EGor+CmTnLhiuNl6/sxHbdwQgBaegTvC7GcY
 J7EVbODGYHc1XpWkwHjRdBHznoUMwOs2CuklFoFB7JF7uALuNGfNBHV8wNb1S0ZquUhp
 2g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164206; x=1788769006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z7rDUSP85BnNaSowiv68FjXU6tjIjSurG6eRZ8Fc9/4=;
 b=PmHBRJGgrA87rfT06Wg0vSFshYP2pLABLYVJdfasISFKZMQdezV53D6516unUEdEwZ
 l8ngqpycUxnJtLqH4mPKuJ3o4vth5xbtDuaq9cffoZ8enO4VskN3VULbZVnHufmcGakL
 8uAagxxNMFj1PStI5wsgITl6BJ5CpZGAD5yj5vK04PKpFkN6x6hMz4Vavr3rfdl/pOvv
 wEgWcrZ9Vy/8aPRqlLCp2RoYbSbcrQAPEZ1eeJpZIvXEYN8zDP0Ed8dbgYfkIWeRFkt1
 mECBWcM4c6CnvWA+pM9YAEWSkr0LS5YbX9U7TK5NqHD+5iPE1fSi4g7RWMplBN+6PhEa
 9i8w==
X-Gm-Message-State: AFuF++nZIRMpVsIFIxShUbISAEN+JdQJdcNwF5gaTQUiD4/iVJg51MqE
 L6xv6aKRKRzE3dF7cM4xomq2qXlQCepfnIgG8qflRRQ/CUGHkK+R47DpUA3/5xkFSLJtqJcb+os
 tw+A=
X-Gm-Gg: AYBFou2MDh4GynOnScNOvUw+ZgNm+KzHID/5NKvOcZR7YMb9HfsKK2pO7R2Z2AQQcUm
 ZlJGsQrA5UkEDieLRn92UoDpW+5i179bFq22ov+1Zlwo5s1f6dy4E+vRJuof5cCdkavefGqXefp
 ljJ/lIHqzURX6DsbAaVba5GgUTEOw1mrbthNEdthzgq+p71kxikTABSbu0ZkKpXmXMtEr7Cr0DY
 VBUXGjobGCy8L5TSyr7EX7lg8DV8m0D/tHAq+cswWRNe3ByPUvVSuWDcRhSyHp3aWcGBBGehE0k
 NDAPG99KRTz7Tzr62dTZrSBm42VCxd1W9A2vqB0EjRVGqNPvwLPkDoCZqABfvFvs8r6UFoDBQux
 x3RHTAoETyx2i3AehrdTgwkUbnFq+t6nLjY6uIZi3hUm2hsFcX5OjdYOKEc6Hwi3vh0+0Pwi+C6
 JvfO7BF8IOWqKf9DhTopZF8mob4zHqKFLj4UEwVLKgX8GjFulY+VMwsNewMussR4/laqPK3OTYM
 5qLcR3lzBU6ERVb70yHCuuuDySyvwDN
X-Received: by 2002:a05:6000:25fa:b0:484:3334:9dc2 with SMTP id
 ffacd0b85a97d-4843efdcbf7mr1379805f8f.15.1788164206092; 
 Mon, 31 Aug 2026 01:16:46 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-482fbb2005esm21156816f8f.24.2026.08.31.01.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:16:45 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 31 Aug 2026 08:16:34 +0000
Message-ID: <20260831081638.19539-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831081638.19539-1-wegao@suse.com>
References: <20260831081638.19539-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 2/2] shmctl03: Fix 32-bit compat mode failure
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>
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
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/shmctl/shmctl03.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
index 9e1c2f099..fcb416a1d 100644
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
+	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax, c ? TST_ASSERT_SATURATED_INT : TST_ASSERT_NONE);
+	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni, c ? TST_ASSERT_TRUNC_32BIT : TST_ASSERT_NONE);
+	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall, c ? TST_ASSERT_TRUNC_32BIT : TST_ASSERT_NONE);
 }
 
 static struct tst_test test = {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
