Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB8FCD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 10:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780481066; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Od+EbS5HCt6zEQOI4G3pcFG14USF3pRqEK1ChoH7GQU=;
 b=H/KYJVn3xNDFqMnJFf5YwPBxDdMtPLXzi+fJPnUN8IK/5rxgrKCD2vAJkObJ8y4QzDY7h
 hf6SlpkWk8PQnBGdqW3SordV7ZMInzccqCMYxyPaKlCSUGqPyycUlAKNhmpO8zmDOlNKqe+
 3tSHFLhOhrHQuZR0uyU0GqpGPciZXgQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CDF33E308C
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 12:04:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E3803CD6B4
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 12:04:07 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C293A600452
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 12:04:06 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45ef1629ff4so4020987f8f.0
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 03:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780481046; x=1781085846; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cy8oGdJBu4pETDFybBmbFKy+1b7oYhj00DaqkCaruFc=;
 b=bUKKa+60PEUARpnCB3jx2Ww54z85Iase/xm97oDxA+KZsaJzett3zCTCgzWJ5C8V54
 PrI1q2wA4LsbcFW7I6tcBmS6fLBpV/ms8sJ6CyRUStrA/Gm2Ld70aGMpoNf72JLznwEP
 7kMxy7VstFD/l1hWIAwyx57Rq4PTsoY7w3fCphmEiiBIBho/iinMFK8wW8I6wqyCShAe
 4GAbK0X94Kxd7ybQ54x5OnbJhi1h29sIWOkvvFMStFwL+3yYTO8svH1Qvk1Akv8I6JaW
 c+fUUWOauOYwXjOtoP1wD1dIZadR/T4QuEUiTs48cVJoMd5ftRvpVeqa9SLCXcmvdidL
 WVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780481046; x=1781085846;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cy8oGdJBu4pETDFybBmbFKy+1b7oYhj00DaqkCaruFc=;
 b=Hs0TvK7JDZZlzJEM0nQnSBqAanIHW3YQyL5uUc6DCmj7hnyU9kAJrBeRqwagVaBxK4
 iXa2jFwgRQnqRXhiFmvOBllUgx3I2BE2vc09TA1zOH3VRSaJhH+gHfwlfgcs83joIY6d
 65obol4zXb8xiWqR+7ZJxi3Eoe7gm8PdBeaZDt+4brHZhchAxDKnNA99PMUK41nH1L16
 oxWeSTi+B+LpTwTzbGsEnMUnV/yfAv+EjnNcQ9VRh3Y33W/3n8pTJwSDSo+o3M7c5m49
 vt0rblO+4W2yk4dMNM8WkuU+lGKNl+/ztcmbuKIBVcHshc9hBLUMXWrYj3cHqh3aWYJc
 hndw==
X-Gm-Message-State: AOJu0YytpihpF3YnuEc1xJvAWVmrJ8ug/YRPNdg8MEkiYkzCmtixMmtz
 ObCycn1ZNBPqIlspn0t27Z0bUfF59OLiv2s3pSXMpnUMl2yyEAbUb92BeSSNsd1UUWs=
X-Gm-Gg: Acq92OF9iMICR+Px4Fvrh7Qb5k3cVOD/wt5CgAYwicB79OOPYa7zNF9rPf80Lqf7Z9a
 fketJC20TdYTowbyF12Zxider1KCn2wJubYhZ3lI1DVobX9v0I31DVTgxBjyFv8yNWIZAacoqjx
 /oLxPA+MPPOb1zRoWd4G+G+bg4kHybAU70dI57R24dTs+1NeJak+87Z3potF1oS51M1wdg8Cajt
 J1wEItP2HfkJFoqzdkF++pRplWW5QLZ84x/XgLnZmAz+VwiCAvoE8W7q+/6GLfunIAqTquDVqEO
 t0yde+u8Hh69zeQLgLYVCln9PhvNRFz3DrG/6GySzvNfeXr9xNTaesta5YU7/s0EmDpSWQxzyyN
 hdMolBdrfmtGJJYUy8rlKJvF+mb8O4NnFGEDcF4ZBBQIY4gGiRDR+c2nSN+MlFs9l4mUffgOaot
 +ZwXaxEyvYN2osV99YLpTZKrfJt/3s/fOnoiJWH/Ds/QodzTiogNs+4c2tMQECU4eWGKXRjrnhm
 mRr7Ypcgys=
X-Received: by 2002:adf:e542:0:b0:45e:8866:e58d with SMTP id
 ffacd0b85a97d-46021794663mr2992324f8f.11.1780481046056; 
 Wed, 03 Jun 2026 03:04:06 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f67c6sm6348973f8f.16.2026.06.03.03.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 03:04:05 -0700 (PDT)
Message-ID: <6a1ffc15.1d29a1e2.387b81.4885@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260603-doc_add_missing_headers-v4-1-1fe3a372c155@suse.com>
Date: Wed, 03 Jun 2026 10:04:04 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] doc: Add missing API references to
 api_c_tests.rst
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Fixes: eef750db28 ("libs: adopt tse_ prefix for extended (non-core) library")
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>

This 'Verdict:' was copy-pasted by accident. the rest should be ok.
I will fix it at merge.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
