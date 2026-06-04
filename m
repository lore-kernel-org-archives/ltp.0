Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E989CD6E6B
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 11:02:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45B793E52CB
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 13:02:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CF0E3D07B4
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 13:01:58 +0200 (CEST)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com
 [IPv6:2607:f8b0:4864:20::122c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CF250200969
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 13:01:57 +0200 (CEST)
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-137ec563a95so571121c88.0
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 04:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780570916; x=1781175716; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1Q1qAZu2qYkUexNMjWmo9Wc+1S6+IiEYuQ08fsq+og=;
 b=VzrOLYHtR+7eTk9N6UXyP/cC71SDl7It9LQT+DEK7RTpKyvmYXJTzgFdBS8lPx3jFa
 SWE+2Ztp+oMVx+4/zer+WKcSZ90BbFX6IpLXK/Q4DTCsvo5saU51OJ9GUDil+WAUU7Vg
 ewPrQrXYTWpmbIrKYSFTVV3hoQ1RCXTXKV6kcT10cIM9UlRN3t49Jqc+FI2fFYB8VwOm
 EFDh91L8Yi0+/wCgZl7dsfNz7yrYp+/MWC4V8Vo8ez/o/5grS4U6SUPo23ABwvKZhhoB
 3vvSg7aHHOl9eQYlQJt9X/MkE3A97abM/BYnF9RYtHa1kLGPvu6kjIs5CJAuQpXwxLde
 Ffkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780570916; x=1781175716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r1Q1qAZu2qYkUexNMjWmo9Wc+1S6+IiEYuQ08fsq+og=;
 b=A04yrO3K5cV2FTvJ6e+dT6gPbqpYtkcC98xOo84Zn73L539EonzTJg8DPomWN0NNTA
 TLGI+eGUgMCzdqzNKLY834mVYxP030dQSqsZTiKknIhyoXEnojp6JS0BH2XNLpcq/t3s
 I2tqkh6jIGcfAflaHW+FJUC4FUQSTLM8jUUAwChPR0pKqxpTZfzzXXm3e+7PhywlHrBE
 ETta65EIoTdjxwepxw7O7FwcdM9v5lhENk83rFxO41E6zEeLVhVd/UIBAyWdE+aQR+kL
 HPTY+EB1nFxWajiYFyURAqnDJ6FHZXu09gMm2geZ63wRtxmHz48kJfVDZEe7IVx6Ukos
 50Ag==
X-Gm-Message-State: AOJu0Yx70rLCkz21eDc30gAUUXlsMI5xQ+RgZgygdoZH8qWzPnmKsX2f
 N4tvmThigLL8jAemGJXskkj0v9JWis7P9mhU64/H+J7ZF0p8RKpOqj2AYzPJ0idc
X-Gm-Gg: Acq92OEMq4HXGwebCWAI7Y00Ep3FtXu6DVkVcqXqNMlLvQ4FAJoIJmzUf5giTeOa4ce
 qXuPz29/0ApchR0r+vV3wc8GsIVfY49FBTOVlkUucIAv7jQf9IyAyTjlGNPOLDBnwVhZofiu65V
 tRJqitflJPITcvaK+Ir/SWEtZhQcVHr5JhikmrIQh0EeR7SYoxVcJbUSO+qe7YQoj94pAk3BYgr
 KR6jMnx4a4DjUm/Jamv4k1Kk+wX1Ihz5ZONdZjj6HbjiAUQcdR8wLJvCGR9vmTZOkvMzegRajsT
 eKVTsls25AwYMBXHrIIeyqfDyCvjVLfqBvEvh6VnZkFPPdkfQKpRhLhPr7W4k1w6MiPQj/VqjzH
 cW8jbFXu7H0IgcDpJL9O2uGMFpdzXwOo2oS7ERzMBqfYT7y17aAp9wrezjNCO7qY/B1KjBk+vyt
 9ywUCYaTxP/HvumbTCZM0bF1LwXmMhmSSCdfP+mHzSSJIS6RbXaFExVvsc3GvjHA==
X-Received: by 2002:a05:693c:2c97:b0:2ce:25be:c8e8 with SMTP id
 5a478bee46e88-3074fb56f74mr4046668eec.17.1780570915698; 
 Thu, 04 Jun 2026 04:01:55 -0700 (PDT)
Received: from localhost.localdomain ([45.146.54.109])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db525a1sm4796077eec.1.2026.06.04.04.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 04:01:55 -0700 (PDT)
From: XiaoLei Wu <wxl18715129466@gmail.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jun 2026 19:01:38 +0800
Message-ID: <20260604110138.774341-1-wxl18715129466@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ah_4n5km_qrz4nmk@yuki.lan>
References: <ah_4n5km_qrz4nmk@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib: treat ntfs3 as ntfs in filesystem skiplists
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
Cc: XiaoLei Wu <wxl18715129466@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ntfs3 is handled as a separate filesystem, but tests that skip ntfs
generally want to skip ntfs3 as well. Handle this in the common
skiplist check instead of adding ntfs3 to individual tests.

Signed-off-by: XiaoLei Wu <wxl18715129466@gmail.com>
---
Changes in v2:
- Move ntfs3 handling to tst_fs_in_skiplist() instead of adding ntfs3 to
  individual test skip lists.

 lib/tst_supported_fs_types.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index d3020fc..d20c655 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -72,6 +72,9 @@ int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist)
 {
 	unsigned int i;
 
+	if (!strcmp(fs_type, "ntfs3"))
+		fs_type = "ntfs";
+
 	if (!skiplist)
 		return 0;
 
-- 
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
