Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E144DC5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 02:52:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFFFE3E706A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 04:52:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79DE63E2802
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 04:51:53 +0200 (CEST)
Received: from mail-qv2-x01.google.com (mail-qv2-x01.google.com
 [IPv6:2607:f8b0:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F261A1400B8F
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 04:51:52 +0200 (CEST)
Received: by mail-qv2-x01.google.com with SMTP id
 6a1803df08f44-907838c5e2eso11468316d6.0
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 19:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786071112; x=1786675912; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vakz8LA10DLnIqpLuv0bhArG3UmRmTxLtMJ9zBvBOto=;
 b=hGi4T3eNuiofb7hebXcS0JL31JbFUZwOzlMAdu1UnnzLkxPy1KVDeosQhHMOC1Yqx3
 xVMncaQijxVq2QSs+9xTTiBJBtpqe0EC5g9G3KD9vCmnN94FN/+Tas5bfjTameO/zbHj
 zf0mQSdhPQg0brXpGurkBaZ9H8bsmQQ7vQMLeJW221BlC3thdAif2lU+HF87andgP2lz
 fj4oHx6HU2YX/nssRoqfYoNu/1+LyDzZSUyjuV7iECV7DMP8lwa1D9WPcPzaEYH00ZdU
 wVJ0kzGZlnkpbVKQZXP3SnxhGn0ro9AzR0Kwl1fYcTilr7Ysj2Y86kxZPgTg99cSbqlF
 /4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786071112; x=1786675912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vakz8LA10DLnIqpLuv0bhArG3UmRmTxLtMJ9zBvBOto=;
 b=c3eyewArKArvRuNTnthqIq8aaiLGUmYUvfSRFX2Kyya/0w9Rgtk+Kyh2jsHtJ0hT4j
 QcRYgE1oZPvHLXpyY3jLWuQ2nQmOTJEUPP69XBuHiKDaXDYAZ3yW1LeoOU1sik6mhHjl
 4EAEAWV2snGSzc++WG19VczBLo6r8wLehTjXAYURBF3FDU41bt6bi7EF0GKx9Lf5ajqO
 G3sYZZxi0M/RXVfCd8SNPjcZb8JXryT/gmwGqTKZusZ/ujRzI7FvCbHalYCIl2+44Cap
 AVCAj8D94oGidvyB8bD4xZc1Gepy2+28P4TyU4Du53uLUDpEx5sA9+RTsSUuFpn00du7
 OhXQ==
X-Gm-Message-State: AOJu0YwSkfbWYZZQb0xREaAs8I5BlWzhEDk1NqPQA0q2iBTmFI9aEgOw
 VQzu8+LOyNue/XxTfWaEjA8JtkrMNaCEI7vsI4clxb3I1RliIasgKxbWPRevbKBc
X-Gm-Gg: AR+sD11lTBPLDEqI7e05pAZ0jzpe/pYI3H7HQWJn+zYW1eo//u+HMnXOQoKmCqqPVIj
 HJC+tLkzyB3qO7nRhdQNviWf5IskKLD2Jv7mgJvuTuSfbppUxfMOCr80XO01efwognEsWrFqBv7
 31/Zm4Y2An++dpkR/BEYEap0u48i2vco08LRdMRup0shMpXElQPh5tH8Yg8nxbjt15vqDyzy8os
 IQib8FoYqspyFMiO/+7XknA3vrI7bTVZBGWShib+4adK/kzC4mKqSZKkjFBVcTxYu/nwgrFEvCG
 zozKP6bzq4qaozwr5Q5fY5BIfnQLwg5GK0HFOn9GOXHtykcTHN6nLY9NhTAy6mV2AtoZdFjAWch
 igghALuDcOf22qMMEKGVdgneZveDGpITPitck/6zjcD6E0JW0TEoJosjp0IvSRns6UX+diygb9B
 9K0KR9F9UKNRZiS1GnB9/lDDGJuCQfwJe55bUE2BKbWiyRo1tn41zwvQgZKRAKOfOMoJBFErVyd
 paymzDkknNYjcNjAxf8y0+p/ehXhq0RPx6L1Enygt2JBuiHiqa6GToXQTVpJV0Kb7Kln/b94/xm
X-Received: by 2002:a05:6214:2245:b0:8ea:184f:c15b with SMTP id
 6a1803df08f44-908812090ddmr237203976d6.14.1786071111613; 
 Thu, 06 Aug 2026 19:51:51 -0700 (PDT)
Received: from
 runnervmvrwv9.f10dncn03soelb24l4hivhqg2e.bx.internal.cloudapp.net
 ([4.227.169.202]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9088008fddcsm66584266d6.25.2026.08.06.19.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 19:51:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Xuewen Wang <wangxuewen@kylinos.cn>
Date: Fri,  7 Aug 2026 02:51:50 +0000
Message-ID: <20260807025150.4081-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807014416.1453266-1-wangxuewen@kylinos.cn>
References: <20260807014416.1453266-1-wangxuewen@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/functional: fix memcg_failcnt intermittent timeout
 by disabling swap
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

Hi Xuewen,

On Fri, Aug 7, 2026, Xuewen Wang wrote:
> memcg/functional: fix memcg_failcnt intermittent timeout by disabling swap

> +do_setup()
> +{
> +	memcg_setup
> +	swapoff -a
> +}

Could this use ROD so a failed swapoff aborts the test? swapoff can fail
when there is not enough memory to page the swap contents back in.
_tst_run_iterations() ignores the setup function's return status, so the
test proceeds with swap enabled and the original intermittent timeout
remains.

> +do_cleanup()
> +{
> +	swapon -a
> +	memcg_cleanup
> +}

Could cleanup restore only swap areas that were active before setup, and
only if swapoff was attempted? TST_DO_CLEANUP is set before do_setup(), so
a TCONF from memcg_setup() reaches this function before swapoff. swapon -a
can then activate previously inactive fstab entries. Conversely, dynamically
managed swap areas absent from fstab are disabled by swapoff -a but are not
restored by swapon -a.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
