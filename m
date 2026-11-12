Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF7606A331
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=WjNBjwOK;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=G2jKviiG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794512124; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=sgGYMaS0cxfYuHYKtv7cAxzwfGmcX36EA4+h71pnUgs=;
 b=WjNBjwOK7tmV2d8E/4D1cN8e4KRlBloAPJeAmQ6tcsCkpPRRqOhdc0XfE9VQCp0ol/XIv
 IYtXZJg4c408B8iZAXJnZPaE3RoGklW+6wlyDNi3DduEC1eRgVdAMCWOlsVgUcfeLEWqv11
 Et0BtLOjds79YafXS52hW0dYKsr5NNg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C5253EABAE
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 20:35:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DCB93CFEFD
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 20:35:04 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7B6E1600A5B
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 20:35:03 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so206575e9.0
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 11:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794512103; x=1795116903; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YBUcwShaeCr9Dz007ukqBFE8GEy8eR+5qwlQJnGZtRU=;
 b=G2jKviiGAeqHPUKBMI1ZChwU22cRJcAq5QICM9KcfIJTqVeWRuACFb5zBdo2fRRnAu
 N7BN9aBfD4edWdSPycQgKBPCf5KyuXN5BYuT9qMexMOrkJr4HnlNRI08zvi4spnfzTJf
 rnlYrRFcp6hyw8h0h/MzdUvyGIxEwJKvRZgoJT+YFooF4oKBTRtAFeF1ZtDmwnZXjoE3
 NYbMbYK5wr7DF5z/0ttgCjuOpFwSl4Z5toAHH+6veEKaFCiCzLoOCs5Sf1UlNl6jjt09
 oBb5uKAkUWOwzyDML7mBPpy7SoQQqUkurjzehC0aiii6v7cS1xyd7amNApntLgAixWNq
 UOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794512103; x=1795116903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YBUcwShaeCr9Dz007ukqBFE8GEy8eR+5qwlQJnGZtRU=;
 b=TnguVeqoCLwood0Yd4pbvQPP0S9t7UDflyzxBHZKI33wwvFDMOlh1MDF2S1L3tZPAK
 h5bYqf+atBUSXpZ84B0GAF4XAZQqc8zj2vu72XAW4wIV52GoUdwl9bnQBE5Ssp4kCP5N
 WvKbVML4cgk4pG0nzmZ0DoMVrRmTVWxkFn057hXg2Vinf8t5d4YGV+w2MI8JVObxOhgd
 FvMbjy6b6vkZRRpvEd3EiN7JkX/sEruPJeKi6I4NzH5tHtJozpWDXe9xjjlO0X1UjLeo
 bNksY9gYM/60hgxKEabgG+MWU3Ku1XTV/Nu6L2JGC/DJaGvGwgZH4O/vDWisOOMQgEcM
 Hb5g==
X-Gm-Message-State: APuU4Z/qD8TJDpbbfxJU6C9pA4CQ3CFHIS9TmER1Jfodzr0Dl9By+Joa
 BNHA8NchkWxg3pjOJbIGAYgY7uLx3L25UQgGEcepqYX7lr+bPuqNZgpg4SMGzpmU4otJu0C6ry1
 qwJrwcFs=
X-Gm-Gg: AYBFou1BNLYn+OA8FQl1JEw1Xv7oFREJxm2gUi8QmidQzdst5LOqO0+96SEY0lZwSLn
 7f2mhwzmZ6SqcawVmtnUNCFEsKwFonks0PCPsOroaNP5pe54ZuPA12ZATci3VkU5l0LLTG+RaND
 nvO8J1lgjO4mT93vG3EMtapKeQRkRBFCkGIwtVTwPLyrtA57rVwnUaQ+R3OU1MzdYXbWobDwLTm
 YtWiY/7ateMwgvayle774bpXdE7InAUpyHH1szNwLiTcrXSEvgn9aXzpIA3DSNBXFv/EnCn7AQY
 zlTUr2Q32lrYpGmxn81xeje+u9oapP86307J/eeaPj+x8j6cOVaF31pxy+DVOTVQV8lY0aEd8aI
 0LE3PQTkWOzMIJO5ZbpMnZSAygFFTA6CT5SUV0hcTPBID6WpqU7KvBrnARX3s9hd+jrPjzNJkpb
 xoaG1Q2BwQwrOIO215buvV+b8JvOQDZjEI5pcfip50QzFgs0tg+ikBVOKyQYLF6krQBU7/N5Iwc
 P4OdL3IMM8ue9lo8MUfUU6Vu+7FatHLt23WMdOnJqEJXIhuJazmPjhUIJqSkcjmI21G/pNTLMTk
 2x2TNtfWmGNkIouhM2WgsYlZV+U6mZ6ZlLlPLah81UCfgCPjEA==
X-Received: by 2002:a05:600c:a596:b0:4b5:d95c:2380 with SMTP id
 5b1f17b1804b1-4bb55a86fb2mr2819015e9.11.1794512102804; 
 Thu, 12 Nov 2026 11:35:02 -0800 (PST)
Received: from localhost ([176.114.240.8]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2adf53sm90488185e9.15.2026.11.12.11.35.02
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 11:35:02 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 12 Nov 2026 20:34:57 +0100
Message-ID: <20261112193501.420658-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve/ghostlock: Skip the test in 32-bit compat mode
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

struct prctl_mm_map has a pointer member (auxv) and PR_SET_MM_MAP has no
compat handling, so a 64-bit kernel rejects the 32-bit layout with EINVAL:

  ghostlock.c:202: TBROK: PR_SET_MM_MAP failed for all auxv sizes: EINVAL (22)

native 64-bit run covers the generic rtmutex/futex PI code, hence skip on
compat mode.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/cve/ghostlock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/cve/ghostlock.c b/testcases/cve/ghostlock.c
index b37d6e9ca4e1..f0f84c8fbd90 100644
--- a/testcases/cve/ghostlock.c
+++ b/testcases/cve/ghostlock.c
@@ -265,6 +265,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.runtime = 180,
 	.needs_checkpoints = 1,
+	.skip_in_compat = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_CHECKPOINT_RESTORE=y",
 		"CONFIG_FUTEX_PI=y",
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
