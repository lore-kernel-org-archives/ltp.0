Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB6CC61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787915842; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=LFb3sKGhX2I717nga4GUcCPetk6ET+jtkJduubegtC0=;
 b=dBjbjf0tBrW6mFsj1A26T6xdAQxpbxlExx7eB1vJklbpt2yc1YgZ9No4xZRjTBY8jWlsu
 onrAbnb2dJeRRGV/5cQmx/LfYvl0e3DkdggCDjhb6/e2oBO0C/FkMFZ4Axze+AHpPAq7wlC
 l5hZss6qoqnO2EHRb81G4m/vvophajA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C35423E5DC1
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:17:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3168D3E5272
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:17:00 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C70A81A005F4
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:16:59 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-482e2fdf5abso319075f8f.2
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 04:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787915819; x=1788520619; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MllEWMrTo47ZQL+NUVaYB5WS5x1GIfjvmC2mJZEiQcs=;
 b=WhUDVceXlFFon+/mEENfEZfdunlmV/ZQhK0l+3sn3GRaRL9whXFLgD4g+2oKJ9vY/S
 nppwL+HdImQc02Ftqdi0+H74Tw1ln2L15knJzZr51Xx/682WhtXDO6WNcmJL+4XFwAIO
 KwNL8WkUrD5jbBGZQCCbkY3HeokCASwaV3xdZi39KnJAkeZ9lIiLABl6TvmPM7MM7Mq5
 g5A7vHQlHLsS9ospgT3zT7SS/R9FKtdhYWMYWSjVc+/fpI9ROp3jNEjtzOM+livwt0z2
 KVAU0yAMibAO4w2tnXs9aKW9T3G4LWEp/G7T6uORpnRyydTg9EX2EDx7sDBJZ+5HGZh6
 7X5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787915819; x=1788520619;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MllEWMrTo47ZQL+NUVaYB5WS5x1GIfjvmC2mJZEiQcs=;
 b=pE1iMSimCsjcevh+/wEm/av3qVr99LVgCcMfko5rL3e+PCu3/CrI9woNeQ5hwQzH+K
 SyVIYJwi2vhihf4nhETc3xt/gGp0D0NzkuFLXD2Vvokc4cNtgkOC8H67r6mLiPaxo2ZI
 tyKK5SNqex8I0Yjwq87ZIdiDWvsDk8ae/jxMLq2R8C7TdyZuWZN6IiivlsInvm5tnq/+
 R8Af/RFKOkNsgwlgzLiPqrV3D61P3uxcl6hOPHslagPDfry+BzzIocK0h7JXRzuGK0dI
 C5wXCRJswx49Pjz1lX3XDMZfCSZL4wOSo5VtBJ5MG3U8NArQrKIAx70N7bF1NgBS27+e
 Q8KQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOXA6T0PQG3ljTjB4rOq71iYgkxGFoWGV32I6x1KJ9G1na3mNYQ0Pm8bmHZy4I7v+quj4=@lists.linux.it
X-Gm-Message-State: AFuF++kA6yS7qRqDbYa8ZbhIIBqYDNtwVtA6PQWAGQ6LryBQUC1E8Y1I
 bZmvhWTAWgxOqg7WLelD/xWi6KlDlF2rPm545kcnW2uExwSsH5wNQbd33sL75U92pOE=
X-Gm-Gg: AR+sD10dkto/xknKGPyouy6pKQVY6qU2cXsAbMm1md4PqyCEKPcsYqtbwVvy9onWj7s
 ++orLLNqW+oDWQ7tLGA1CLxK2+M6qFKRhWlisgWYtTIxpiFBJj1Dac/mHMLT4uNYIzzS+Njpmn7
 FaxwrwbweYzKwRIpavPxbKQGKa+93RHWnFnnE4tB9VavHgi4L2x5RwpVxhodp6TDlf8wrA8s8Hn
 pTkhnu/gIrSv6rN5TZaDc3PFxqVZAOnloPD0wpulCSGLQ5dlmsOeV6yTAxNRDX8aIxwPhNpRvah
 BdI93ifjbZixboOEhT+oDlrV4E4l0ZpXAkfk9jxbvlI6DtgDC5A2BaGCDY42uWzJe+jW9fcDFiM
 H3bkacfQzlxqvnR/lnZ74fyj8bevDoOvhiTFI+5CUJCawHzFl1PuQQlvb41S01rPbA072pecuNi
 ylOCfQ6KoUahrGB/9PW9HQJtHmueQ4N+5hS5sfa3rFI5AcerW08mFOA8CVWAizm8UXL66b8mUr1
 P4yBfQafTLbI4nDhga2LVZGEQuv4Y022Ggx
X-Received: by 2002:a5d:64c3:0:b0:47f:7759:89df with SMTP id
 ffacd0b85a97d-482f7977513mr8323303f8f.3.1787915819193; 
 Fri, 28 Aug 2026 04:16:59 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbac4f9esm2853354f8f.11.2026.08.28.04.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:16:59 -0700 (PDT)
Message-ID: <6a916e2b.7557dadb.15e29c.14c6@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a916dff.dfcca1bd.1554aa.40c6@mx.google.com>
Date: Fri, 28 Aug 2026 11:16:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setsockopt08: Handle EPERM from disabled compat
 xtables in userns
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Merged, Thanks!

sorry I replied to the wrong email. I only merged the make check thingy.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
