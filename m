Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BD8C624D3
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788356454; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=yjJTYc900IzGf87yVDvxvrqO9kHiy0WR1DM0btmhsuI=;
 b=jwHabZKUGeTmCBY8o2c4VpU4J+CoburVCPPDSGs9Yg5wd9wmkQeL0vlV6MqOyPPzaeKt1
 CjHqvH/WwZfk2m96W4LY+74QuBlesp3R3QeRCRK0R5Aw0wwWoMIMmbd1GuJvDhk1O0U0Qqv
 lGlO0SB/3Rjv/FXRUwXhbWcOQcXQBh0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87EA93E5862
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 15:40:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4241F3C9A10
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 15:40:35 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5FAEE6009CD
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 15:40:34 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso7831625e9.0
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788356434; x=1788961234; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FDG6m4lF88AZzsfgzSIoNDm46uczWUoT6zfyrGKWGq8=;
 b=Asoo7KpYyvXtGlN67n9d36ulSbThK7/Z2iBsFZZR5c7WeHOUVeNaa61hgp49KIfG6z
 LeyqZvw80/Gh0V2uBNHBSd6eJ6LPjOsPLx6y0yav/eNxCoREElxL4mwCixDiKRX5MmPw
 ugkJiLqZBbN3Q584oLz4IHdmT7if1LbvnS3MCLNucQuA1fi3ysegswn8nNDDoD4r/cMS
 ROZKmrZyd7oY3FLq0bmnwpj5J1+KtE1T6A11MJVmow1iJlegVFg0FtSvfnP5SYd+pdpE
 Y/P5ZmjzWjERHrWN6qczWzoCv/f4vQi2MgJ1LN2OOzQ8h4lheR4JLxuy2oKfO6ngsasX
 j8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788356434; x=1788961234;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FDG6m4lF88AZzsfgzSIoNDm46uczWUoT6zfyrGKWGq8=;
 b=f+KRgMQqQJ7B7c6YREiMFoYbjgEjKOeSqHdiI2B/9HOPAuSadp4riBR2ajNS7AJRb2
 LNVKp339MGJc359055SfO7BqzClM6w1zPeqh0FYp3NtBsPd6tyuK/m+jFevzPFkJz3aN
 9sl54UIeM3Ti60YdXuUGOQJMGw/PGBHEOPOuEjBLCfdJjpeBN2md7vwVoum+IZ23PO6h
 VZiH4j8ojzpMiIRsdsYId8ehEqLQhCU80IMdaDbQX1OxH0hy6KuZSEPfdB5h8MFkkN7p
 kMtjPV2md8Yc5wvfBEIpHz4RbTbijaidZdB3TmwbSnk4bjubXdTzZgpXQ0kB+DVcxUs/
 kG4Q==
X-Gm-Message-State: AFuF++kpuqwBY0NI28iQ9nbyL88V63GejP4ZbvIphA+Voc/maF6Zh3+j
 WxQanoeUC2Z7e4YmwH/tbv4KjyACRHGm6SI9dBdYO1v9smcZBrAajTF1CPunmhq4rYn966UVORz
 uAer//40=
X-Gm-Gg: AR+sD112C16Vc4L2Qdz5VItC/m7seuSlGGCS0Pmo/4Vr9Lefs7HtPfNp8ZQigZQZtsK
 A8B71WOo3Q1cgg5XeZmeoAjmb1ERBqQIx6dRJw31n1QOCU1PrTuDzV/q3Won3ydn6Lfnm481MIF
 vkn7mI+qpmCAX/fx/Xug5pq4MvuZq4VhnIiuJbR++rL5MolpfCfknUml1WRwjQCuGpJtGg3m8ww
 0iBthZFJ6qnrC4vTeboKOgHbX/JG/ps6qjNL8jC0xNRhmjc29D+8PNDOcgKZrGAKd6vd84Egelq
 huEIFqxfczgom+4b5nqbjjlljopSfC/L2CpBEfg8VLrZN6MPCDilBo2iP3u8HpfSLy2e5+1q5Jm
 HV6Alyi3A+J2XF3X7bq+tA+vB+539F8ZisKUWr5CPXEyo7yuRDQ1Gzk/tcXo4HMc4G9xexjDb5Y
 ucmYmursdVFqS1V0/QiW9KUxDffhfmmlNYz+IXyCCHf3IWlA==
X-Received: by 2002:a05:600c:354b:b0:49b:d03:8d3a with SMTP id
 5b1f17b1804b1-49ce58180bbmr75784705e9.11.1788356420467; 
 Wed, 02 Sep 2026 06:40:20 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4642382sm76386395e9.3.2026.09.02.06.40.19
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:40:20 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  2 Sep 2026 15:40:18 +0200
Message-ID: <20260902134019.163296-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/ioctl03: add IFF_BACKPRESSURE flag
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

Kernel commit 485e38995cc3 ("tun/tap: add IFF_BACKPRESSURE flag")
introduced a new TUNSETIFF flag, and d00c7369ef24 ("tun/tap &
vhost-net: stop tail-drop when IFF_BACKPRESSURE is set") added it
to TUN_FEATURES. TUNGETFEATURES now reports bit 0x80 on kernels
that support it, which ioctl03 does not recognize and reports as:

  ioctl03.c:90: TFAIL: (UNKNOWN 0x80)

Add IFF_BACKPRESSURE to the known flags table.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/ioctl/ioctl03.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl03.c b/testcases/kernel/syscalls/ioctl/ioctl03.c
index 8a868a98e605..1f538016344c 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl03.c
@@ -44,6 +44,10 @@
 #define IFF_NO_CARRIER	0x0040
 #endif
 
+#ifndef IFF_BACKPRESSURE
+#define IFF_BACKPRESSURE	0x0080
+#endif
+
 static struct {
 	unsigned int flag;
 	const char *name;
@@ -56,7 +60,8 @@ static struct {
 	{IFF_MULTI_QUEUE, "MULTI_QUEUE"},
 	{IFF_NAPI, "IFF_NAPI"},
 	{IFF_NAPI_FRAGS, "IFF_NAPI_FRAGS"},
-	{IFF_NO_CARRIER, "IFF_NO_CARRIER"}
+	{IFF_NO_CARRIER, "IFF_NO_CARRIER"},
+	{IFF_BACKPRESSURE, "IFF_BACKPRESSURE"}
 };
 
 static void verify_features(void)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
