Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DF6CA5FA3
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 18:39:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9BC53CC24A
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 20:39:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F27FB3C5E52
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 20:38:46 +0200 (CEST)
Received: from mail-oo2-x08.google.com (mail-oo2-x08.google.com
 [IPv6:2607:f8b0:4864:31::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8D1221000998
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 20:38:46 +0200 (CEST)
Received: by mail-oo2-x08.google.com with SMTP id
 46e09a7af769-81d53a6ca68so741158a34.1
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790620725; x=1791225525; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4R+Yc5+Dy3BDlMpAfvOjN5gJ8b086nUsd3F0AxDgMYs=;
 b=mG3W4yDVGQ9L5Lra13R848wibx2a7fbCuuCypHNFeZI1Re+HHrZRiYQT24oShnVpa8
 WOdQ2qh2vc5FC3IfmhfY5M5a1nsjYegnkSuBtjUSVvzkQ0tULRBMJUQ4JExx9uWo3n5P
 YcEsUcZiWqPxqFU9vIUrwJ3M12LPFUgSEfhwjNZdCW6dUU9jI1msQhGW9FN2qHpR8ZvB
 +/JiUJhQvDGNoHvmVVWmzkdw9GvTtpP0qcFWFwvuVJPb8eG+2RN+vZMJrykEm+EhfePw
 NrkqAG+LtrbwGOGhI6mK3dUN8Hr5UW3C7l+jK6Uir7HospQJi8vpnMLJEFENnu1H5EME
 j5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790620725; x=1791225525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4R+Yc5+Dy3BDlMpAfvOjN5gJ8b086nUsd3F0AxDgMYs=;
 b=lCeXGMrvmNEaGtsfz/yIv+mba2E3Dy7ua1dWzsh7BU58dv0nGe+hb1GiPEQ3Lv97c/
 5MHU09AON+/Cf3DSF9UoTh/e01EA3sVUwrGohOugFdnyszfFAlqNR/UUgmsjHnQWm24D
 yTxNwc6/UnT+mkHYYc2br5tu+F32vCnSuQbaVtVS2muVdEQLVwUi8X3ayQI5nSNVKPlo
 xJY0oEHhX0stZNCm3zM9o74gbGS7vG+5ZJrC9yGAm1a5zIIjek8mEAkKLDOmHDwZp5Gr
 kGUrQM6+38VTSC3dw44wQmScE5d4GCDWy8Ky7p7mkTbNm6GtPMqcNOBcbGMgZcWp2RLl
 P69Q==
X-Gm-Message-State: AFuF++mnZYcjNa0CqAbJ2L5Qe/orK6tflry6layaMvwqheJTXa3wdALP
 Ku7KHOtMOfC/AqGk6nEpnCloBYNkeVcV/HO9nTzVNaksQOq1gqP2Wale
X-Gm-Gg: AYBFou2kVpFA70ukInh9p1i0xYGMRaynrH6nBakgy0N1P7bEJq2qaQeZ27dMzV8hY0M
 6mU3i6zmn/pn6IhdHcyh1tQ3wtY5RKJjq5f/OWlMKitC9W7T8dDvMhClLuGhZarUnF7DmdK5D4t
 uUrj2xkc03aV/gyqdhTMyjao6S3kLc+eOKbiJ6F4JY4yVq5Tl5BI6c5K8SJWQw4w8GXNUSF454J
 RBu6yMRBOEBs4csJBkUBPQ+0Ck3eFK+U23lhRcrx09OBOzvZnAJWYVf+vXmuvXQ1hr0kNX56H9S
 0aqqKNU1lVfFVcL6hIkOEEo/AXKRippN6aKLBBCyaLFAqKtDhO+oC0JCXcEvCsAmQt2mhm42xeu
 Fi4R/k/OJkRWvl5lMwS14LpkTDu/iPShSU9Y5PMTlIbpji6kRjAgNwm6OtBveVWqni4UG5YEbOV
 N2mTxHtRyq/1veto2v5Ly1iclT43XwMonMbH48ygu+dwzKCNtljENWLYvLwalex4b6WqdPd8RIa
 VJ6KwTj6LCMqVKTYf82lgMkpB/sbG67tv8MJPKRbAk9NDtuBMTv3Wje0zpNyMqutA94+BZDkENn
 Cnq2qGj5FBc=
X-Received: by 2002:a9d:6b0d:0:b0:81c:6bc8:48d6 with SMTP id
 46e09a7af769-81c6bc84bc7mr3284337a34.16.1790620725176; 
 Mon, 28 Sep 2026 11:38:45 -0700 (PDT)
Received: from
 runnervmtr4k5.eqja55c0li0upczbesvay52vqg.ex.internal.cloudapp.net
 ([64.236.135.23]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81d57ef33b1sm2315947a34.5.2026.09.28.11.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:38:44 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Florian Schmaus <florian.schmaus@codasip.com>
Date: Mon, 28 Sep 2026 18:38:43 +0000
Message-ID: <20260928183843.10947-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928153059.1624905-1-florian.schmaus@codasip.com>
References: <20260928153059.1624905-1-florian.schmaus@codasip.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] epoll_wait04: Use tst_multiply_timeout()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Florian,

On Mon Sep 28 17:30:58 2026 +0200, Florian Schmaus wrote:
> epoll_wait04: Use tst_multiply_timeout()

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
