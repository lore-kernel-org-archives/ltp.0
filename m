Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1C0C87FCE
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 09:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753694958; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=/drjunhVrU0AYQntMhzsZvQAOTC60B5hMJ8lQjp1a9s=;
 b=iEHiGLO9o4i61LwQDXE/Vr6bbP0ISJxorQ41yZjT2vDDXMYg4YbxOhWU2507JkZzeWh4Z
 lNH6TRD4J63QwzBp2rEKSCkDwt7yAK5S83y3U6xXYOyOjf1ABXnrQEgJTz4FrYMcCIpObGO
 QXUHi+EZtlp3zcdFkm9diGch4iyDy9I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1F443C91C2
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 11:29:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2331B3C6867
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 11:28:56 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D8050100061F
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 11:28:54 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b7825e2775so1873074f8f.2
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753694934; x=1754299734; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VNbHNIPIyMHaXoSPdrvi6ZFaQ1SpwA1fFyk9/Df/RmM=;
 b=Z2WxPqxxevBtrLKCK9tYKM3+N1/5Hx3o3NChEyTvb8YRCY1v5tif5uP1MqBlWhvIhy
 9SWtUHNVxbjlF9C6LXWl4Z38PuhwphpqewCsIkFZTD5UTYuRNnZbCMPWYTxqisvqBdZC
 AT46wJIJfRkChffC0MPUDzuzlqueLVnFr3MRw4J+8/97Vu5vRly8f8VYofrWLC4fTEsP
 5l2MIuRQVAvDGrjXKElhUAPfUq8DvVBTLmb+Tw0gqA6khq4GjMZRV+2kBY3k79iiFt9w
 O07RUSJcr2qq9Fxp/huhmXCdi4XQNvbwsITW9gKPWxdHlLj7JaRHkFlNzC97etx7CUB3
 yQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753694934; x=1754299734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VNbHNIPIyMHaXoSPdrvi6ZFaQ1SpwA1fFyk9/Df/RmM=;
 b=xBJGURAK173uzBG66F6DlytyGQl/6tAr+6b1tbFE1VSHbwLjtR68xLAW/w/s3FHazN
 MZRZjQKI51lzVQ8tHu1ErXq7qsilUkg/Tojf4DVWapgkxReMj4n0WLF7erSq9lyvYKKf
 J4VbsZ9GP1DjuAtkHEEvd1UdJGLFv7/inetGwKL4GmW3E+2FT4+HVBumqiJ29P62S/2x
 l4XIQdunWZl/JtQZFwUnOLYwsYBWgVTxPRHzF9sDgVS+HlvjIQf4LhY5pdCeAOKC6Uax
 KYGwc+avAv3xzvoEN/V0fuOFOFq7AY2ZZRztIN6IqtaAhLXN3wblcR3GN868g8nHhahV
 bV8w==
X-Gm-Message-State: AOJu0YyyYRQ2FsVQGaOTDrAHUQl+LwVsNgaijyPRMjPVIwodUxwyKT7T
 lFW7bBk0fhKiQZNidYCQu0c+8BPMpDaM58N9G86DB2PTGT7trzJga8UO2u6+BD0/isoDIDVEDrP
 HQCU=
X-Gm-Gg: ASbGncv/hmspNjUz7V/jXnHvd8l/Z6nybXdW+Tggq2bcMqVk36AnAIYJIyO11jnwzfT
 JWB3qo39mv2sIeiAnnRBTKb6/m1hxSaeWlzkNopV0ZJ3zOB7580jS/gx8oGt/Bq01or0NOpDrfB
 07KncWJJfL8eqkT7l3+kTZUV3WfwYStMEnvZZjSa8TEKok8rMo5vdg6wMOVnoux1xzVdKRxuEIR
 frj72W6VukG2nYck/X5ceet0L+J/9ltBe0gpRj2SXS5Z1Lp7d/DOKRng2WhPvd+npVtwIB2Ro5c
 umgCxzMAhN+MtJvqXceRO+0fAZrIjqWt2AAd2YDvEmIPImfaL9L6YkOaJ3BTuYGcSqb0S7FW9HX
 RlGqB5eNrPKI=
X-Google-Smtp-Source: AGHT+IFU/XDzvs0a3qJqWtQNOA8yzZ6IA/E0EV8y6Q+2lY6lz+UJ1UmjBz3wQuD2U243eRNnzIx+Rg==
X-Received: by 2002:a05:6000:2312:b0:3a4:ed62:c7e1 with SMTP id
 ffacd0b85a97d-3b776726f6fmr7342720f8f.12.1753694934043; 
 Mon, 28 Jul 2025 02:28:54 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-31ed29d2c1dsm2667441a91.7.2025.07.28.02.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 02:28:53 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 28 Jul 2025 17:27:48 -0400
Message-ID: <20250728212752.774436-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mount08.c: SKIP test if selinux is running
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/mount/mount08.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/mount/mount08.c b/testcases/kernel/syscalls/mount/mount08.c
index e2824ac55..1f97de182 100644
--- a/testcases/kernel/syscalls/mount/mount08.c
+++ b/testcases/kernel/syscalls/mount/mount08.c
@@ -41,6 +41,9 @@ static void run(void)
 
 static void setup(void)
 {
+	if (tst_selinux_enforcing())
+		tst_brk(TCONF, "SKIP test since selinux is running");
+
 	SAFE_TOUCH(FOO, 0777, NULL);
 	SAFE_TOUCH(BAR, 0777, NULL);
 }
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
