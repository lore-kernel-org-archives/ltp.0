Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5A2C624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788429237; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=wDNL6l9HsStvrK41Fjmrky72DNmR6U0jsBoya3BIU2U=;
 b=jx66x/Ak+TtUgQLIp3OEKLwbpdDlJBWBq1Or8cLQFJG/znAvQdawKV2odu1doHJJygpSF
 tU49U9OhrAK+61c5YixRs5fWmqMdmogwssIiGaWWOcVyYdVFPSDtyn8/KGwcBugewKsPV79
 N4QRsafuxw3WHp2qguQ9Ssg5w7LWDIs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43BD63E982B
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 11:53:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70FCC3E97F7
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 11:53:01 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F40246007A3
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 11:53:00 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-484362f5c4aso2204305f8f.3
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 02:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788429180; x=1789033980; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qKaxKxTk7QAWyDRxbT31kds7YP2Kb8pBLOYrvX4ZmKU=;
 b=NjNkkbMzjxBmE4TV90tP0V+u6RPgZ9cvQQdHI3cM323kUUpz9ILf/hm/8WHZ1t4keO
 2bSOTd2+8048EdARRg/OUpl6CJQWD2ZIxSWqZPPzKauT4ChUh4WGVAj7vNjkN13XFkch
 gZh4d2e0x5ZQHvhSKsFVPDzS73Ty5pj3EyEyPT/2V4z2fH6MvrrDkgT6Ts3XRJm5i+KD
 6esjy5N6Upczggqt0lPS3G7rt3E/OqIEtg+XUcWfH5Pe9XHApsh3Djys5tFHa8AttTtq
 3cxQuGYoflmc7LdpVogNy6V72DxECBq+vYJQSAoCoaxU4m9qqqplTbahC9epRzIFlZ4y
 EKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788429180; x=1789033980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qKaxKxTk7QAWyDRxbT31kds7YP2Kb8pBLOYrvX4ZmKU=;
 b=SBSsclJ8kZ1ggqNjGxaBf5NHDle0t51OuDspIkPM+0AF/nsgYFweBATZyDy3dggfjx
 5WMBgEkrmSZdKk6q9CobkY9+8jNGwIoQ9/VDlv/C5dxSFgk1+dcqc77LCHOjgdH5FT1c
 fW6SI3t8v+gT8SAL/h9QjbrCoKwJIe+6sbbazsFXiE/nGuXu7i+879Sz/L8uMpgbz9fT
 fG0pFGay2SSqjKFcAXX/FbAOc3UGAKInVIrrpmXGxVm7y1IJkgMV//eqs57RRASfVYgh
 oA4YIMU7UX2zLiyXeskAcu2sORDWkLOl0VtV+ViZaJtboJ7+PtjFNZM3wPSmo6EpHj3l
 wYCQ==
X-Gm-Message-State: AFuF++l9cXGWFLYiX/s7XVKfWh1mMDWT8RdGJMNCKWk0evANag1Cj0ra
 ZJYi1hNofn23g56PwkI3xBsMQdSVxu/ToYY7gEBcjY4gROrzq4cPto8d/0c0EdYZCiJ2XPhok5z
 BblQ=
X-Gm-Gg: AYBFou1IzMd6mzAkkFUCp7/mOZeqfJqHx7jdM9UxGaWgsHns+J7qDCLLYOVQPrPyYU4
 QQUMhiYmvOInY4lGSs2TZkX1H62w3EWlTGrj9XuKV5yAyHLMEAAh5jz6SCTGKn808OCgPD34FHS
 1r7r3Sb8SlQj+49xGKlO4mjUCbHZ7/axTKpT0qUIASxOCA27H5ZmNkDPcgA8+61CLYrmpE3RGK4
 EdCh77U5Ua8IJjh3FUeoUm5U6k0VJ5D80Zh9x9hxy3FPtJbRyNYGmg2mVtXwsnnz3vtEw9flEk+
 iMn2wRuJZKpYHZoeciSSE9HRoYeTF2cgWgAx3m7JGN3AXYWQGWfm5MH4DBmM8AM1XsrdzpwlpvQ
 wflpwuNWJVvarR2/rota0YViSvE3U9dhbu/gzwrZOmbC/GqKlr3LKSVIqQDWINSAJv6ypuFufXs
 KlN6At3on1ijSvcsIVaiS11HHhfz1kBsuu4c0Asn8dog9JIIisTyn+PuGZv4oUNU6UtEswQ2+xq
 iIA/DAa1QX0MVS9R5os78UBCdNJJd2i
X-Received: by 2002:a05:600c:8b05:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-49ce5817bfemr236050725e9.6.1788429180386; 
 Thu, 03 Sep 2026 02:53:00 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49cee5f912esm57600735e9.4.2026.09.03.02.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 02:53:00 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  3 Sep 2026 09:52:53 +0000
Message-ID: <20260903095255.4925-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903095255.4925-1-wegao@suse.com>
References: <20260903095255.4925-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 2/2] shmctl03: Fix 32-bit compat mode failure
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
