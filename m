Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E9AC55182
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 07:40:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30D8B3E2804
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 09:40:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01CD73E1501
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 09:40:08 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A66892009F6
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 09:40:07 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-380f4166f80so573851a91.1
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785915606; x=1786520406; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u2oCd1qwUIukX4pQ62wJ6nfMWa8ijMnaEIPDtRoKniU=;
 b=UK84hDBwIlEJwPi82ACFJes6pxHr/UCL6LpTdkiAcN0O6dnCggAgaUaa6ZHzeQ9Bd9
 5LRdpB69rUl88qwgRvN5f0kf+7haxVtcvaPfndBZzj2vehr4rA7x+nyRGCz0lJj7m1qI
 NmwlNzFMKc94W6y+v3JB50+3DkcH/YHPPy+TBFR/tqJ1p+Di+aPNQk/3PJRs2ITsdPui
 CnatnxUHjR9fs+soy0lY/I9A0hXyJy2HS+mfIHb4HFTTaUtL2QpFTA1jqpTAw6z8K6iJ
 8w9Js59D1UrL4N89olJKDJodepMnSItGLUwpu33CC3E+VhdHXHPCulSml76iDKoJqWSM
 zadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785915606; x=1786520406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u2oCd1qwUIukX4pQ62wJ6nfMWa8ijMnaEIPDtRoKniU=;
 b=bqA67w9m82MeEi81C/AhcDK++w2n4fDjPzZZtfSW/qNYYFHdCh9m9rpvVlGeI5KFME
 ANETvdUoFFEHi14H9sfXUlrCfS59Quo/mxOzOzKykctuqJJyYIWI8HcTGbLk4lv6zaA+
 HLNl2eOBpaUxuBrg9EXjB6ATFu/0fWCbvUpnFQ4wNmRYMs7F3c9GlZWdeibSdDn/lO5L
 RzmGGw6Nt4WRpzVth/MNuMB1XWpJW2s0BmBsfxgsfg9lOW0kxP+wDmiLR6JoX1C7y7Rj
 Wn2c4yoaOyEDMFEw7t5BhXYDEKUGzzH+emMU26NiVnSm7Hs7yRMKXfQHthfYqPeTaYC0
 RSQA==
X-Gm-Message-State: AOJu0Yy6M3llVAUJTVxYizLyxNcdZC9fY3EMUe45Bh8vfhRL0ZNnE1rU
 5md0HpYzz2g+BANME1Obr+5fDzsRc6dClAn8u5dqEdd22HLFqmPJiQ+kp/ML7Hz6
X-Gm-Gg: AR+sD12Hxar0buP6WuKIvnqE0FL8xaAgjxxpe/zLmLe7vv6fsvd6hY2yG0gXh2rKLqg
 Xb0pYKalkbqvtE9lWVFmVO1cwujX3dusMJq0k36r5rU5izbVcluzpVEtEFfe/HXwXbRELdzSlCn
 C1CoIXjqdVf96OMgonruIPyNCgT+gyO0QzjqXMefApDOYQ9DBmmKoKI4+f8MHHFCtwKkEUeAgFM
 h2T2YnRrz9sVwywmMaJfE3AWHs6azd1fQCum+FADzkGu8bYQsrmim5K8wNbtOeuWwBXy7BnwHCt
 hDd7ekAxHopeURt3YAMCVVms0Yy3jauay9fZz1nx+w/DFSdaebwhGmX6mK1UM9emeqCz6OqkFfj
 vaa7mKVQLg/6RPDtlwS9nIpqLoI/3zS4xQadvq2l6NpoiN+/3dsQ/BL3EcU5MI2qO/1Heb6zYw+
 RN9on7La3dMCuFsgHWlCYRkNcqN7GgT3gZaeDPM6Af1Ig5HAGacVBRC1lXQS9laYxcpIoMLwCwt
 /8464PWbZGV+Zw4CXuyb/D2a6mzLGqgdt2Q8k762qpIvVNf2Z4MnDIqXOaaf3E5UtlmmNOIL9LI
 SA==
X-Received: by 2002:a17:90b:1dc4:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-3903c537808mr4803391a91.8.1785915605957; 
 Wed, 05 Aug 2026 00:40:05 -0700 (PDT)
Received: from
 runnervmvrwv9.nk4tndqwwfke1ntf4syi1chdsc.xx.internal.cloudapp.net
 ([172.171.107.82]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38febffb2ecsm3714887a91.8.2026.08.05.00.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 00:40:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Xuewen Wang <wangxuewen@kylinos.cn>
Date: Wed,  5 Aug 2026 07:40:04 +0000
Message-ID: <20260805074004.4086-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805064053.916492-1-wangxuewen@kylinos.cn>
References: <20260805064053.916492-1-wangxuewen@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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

On Aug 5, 2026, Xuewen Wang wrote:
> memcg/functional: fix memcg_failcnt intermittent timeout by disabling swap

> +TST_CLEANUP=do_cleanup
> +
> +do_cleanup()
> +{
> +	memcg_cleanup
> +	swapon -a
> +}

Could the test save and restore the initially active swap areas instead?
`swapon -a` does not restore the original state: an active area absent from
fstab, such as zram, remains disabled, while an fstab area that was initially
disabled may be enabled. The cleanup also runs if setup exits before
`swapoff -a`, so that path can enable swap without the test disabling it.

> +	swapoff -a

Could `swapon` and `swapoff` be declared in `TST_NEEDS_CMDS`, and could this
invocation abort on failure? A bare command failure is ignored by the shell
library, so a missing command or a failure to move swapped pages back to RAM
allows the allocation to proceed with swap still active and preserves the
timeout this patch is intended to fix. Failures while restoring swap should
also be reported.

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
