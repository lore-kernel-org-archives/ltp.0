Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E545CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778146291; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=t+tPDrkda4uUQlbqtfFN0F8xSI5bPkZcInK1UohHcIQ=;
 b=HrbO/YILiOitZIaxRUlyCL+2hyx8ltdYKO/Jxtr28zJr6uyfTsl2KoDdEZ0RBvyMS4ZIi
 JdhdRkn+AZcCt9DoOUVZkFWspyV6dNxnd22mViJf59Z8iuALiC/QBgZkcnwDbjAGud/unWn
 tnSPmL+Q+F3TTVBilk4CnhSFIiUgLzo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF37A3E5F6F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:31:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CB953CE0D0
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:31:09 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 008C01A0064C
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:31:08 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso7426285e9.1
 for <ltp@lists.linux.it>; Thu, 07 May 2026 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778146268; x=1778751068; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=XRwhKsT0RWYSLG4Vu0J2v7P/h8oPaR/sT58Lft1yqtPer0KURx6qQV5aO+nRUiMNFH
 1CkzXqce9x4cCV7jzgTfk0ImS/hKQ992dP4Q52k6gc9TdHXXTuUPTHTBL2mFLNT8MW8P
 Hn5CKz91dr1w1IYEG1raf67VqeUV5f9q027zJi+POqgyzXvnBp/VKM8E1qhN0x2AxIt7
 cNZ9ZVTydLq4Ngq0wdki3PaXPrFIoTnjcLm2Ogx7iZev/jEbwPD6JKDRdQa253aBhb2U
 liouZnolpqjzWXFqHt16vjVOIQvEwHG9HhOwrh1ydU0fqRgbMUTfAaROB/Z5bWXIjEdu
 XQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146268; x=1778751068;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=JqU05vuUnJ7M+vsqa2NnIskG1FVwyWsLy9LYmUmbPcWtA4GnZAQcCqxyLeF8WJXbmF
 e73PusituDGkhl/wFyE/uBUn1uU0lNTzm6b+aGSXFuQf8oxoexbVheHltCn6FaIOIM5b
 zngQHrUGR4eh8QlMia/RkoingIn3lfoaGNC+RztOiUdnSqAkzsrsfuNgi5wjcFZl/rur
 li/OtGltc3cyt3U9NmMP1IrM9Stl9wgFN+4nSds82hyeKoPeo+ZKjK2ipQKT4Doli4cq
 P/N1dbx6zQJYp8tO18jGgDNIKc+pGUQ4Eq+jeU/dGX2RuFFhIAC2BlxClZSJAQXKC/a8
 3p0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ95Wz3F/vwyeQj51j0Nb0tNu0hMwKuw6xoz+/XW3eGpicROvLmjjbYBYDpZa2DF21fBgw8=@lists.linux.it
X-Gm-Message-State: AOJu0YwQ5inV/vsU8nGaFF5YaJzTF+Yc3NnD0sqbjoF5CMdmh3rS+9SA
 Z/aZGU9MxjPNRlT1idJ+8t0drMgQosM4jM46rhZjWdbiXDkYYlc03fHACrmKxLccMwQ=
X-Gm-Gg: AeBDietMukhPfiBhklPEUGb+DUK8fPFerGAFPPHPnmjaWMxWgYeUu8TZCiQB79FKk31
 WsmVA8/sEU5zGbuBp5bRhN0DpJXY+3VUgDu4aStRNKppWs8qtCf42KYvlnfLzfGSY1x0XtNV/Ve
 aztGhGS3AJIcIZsJozbd+loA+z7APAbe0RJASQ63ay72/keC+2k4dxj4IA/RndNoT+a8wXBIgag
 VjbpKXvHin2pGycsqMJenqVs1R08EmThh3q4MohOlCuLJq8xtNlihgwcHEvlSFT5/MPm+efDOX7
 mOXpQh5Zf51qnWycxprhIAI+VtmVtaxz16I9K0OFCAKeBT9ndCMLXZXdWwm6EGDzStXf0YzCAKY
 lVRw89NzznXiGCpt/kZ9mmMSdnTvXtFXOEQr8rdzXlpuyZhDOyWnxrCXwbX4tfsYphMqC//7hRK
 fZDb9sCebAQxQL4UTB7uBUJrqan63GAPbHx7ZUJQ0WvunwaV2dz4WBAUtOIqsB8zrJ3C1onq5OF
 GCr/azx/gu9PVWq2d5G3R2yLnEYOM41B1lTA9gQc5J4Awths0XBRuUA
X-Received: by 2002:a05:600c:a118:b0:48a:58e1:6d02 with SMTP id
 5b1f17b1804b1-48e51f35b3emr83184675e9.19.1778146268203; 
 Thu, 07 May 2026 02:31:08 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53142ce6sm35748985e9.28.2026.05.07.02.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:31:07 -0700 (PDT)
Message-ID: <69fc5bdb.050a0220.3d6020.ffed@mx.google.com>
To: "Fushuai Wang" <fushuai.wang@linux.dev>
In-Reply-To: <20260430094142.37777-1-fushuai.wang@linux.dev>
Date: Thu, 07 May 2026 09:31:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] read_all: Add /dev/fuse to default blacklist
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: yangx.jy@fujitsu.com, wangfushuai@baidu.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
