Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F2DCD6E5D
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:30:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1990F3E547B
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 11:30:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF56B3CDA3F
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:30:24 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 932F31A00653
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:30:23 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8ccf887de87so19571486d6.0
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 02:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780651822; x=1781256622; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ol+K4dl9dlW4R4sKIuY92NRXOgs/bvDP9hEc9GXVb6U=;
 b=ZdplxI98E23Bth5An2Cd7mX9a8k7dzuAu3HreOE62AKPA70MdcglCpJ3Wd3ZUTPSP8
 Gb58UWx3QtmCLTLBlmeplFB3+NoUQZcFm0s4TZL+JGjrc8Voco3P7ye3/alEmyKO41iF
 zDGKqKRB6E3z+yQ8SyD0yLp0s/yblGQGDzKK3Ru1BIULyeSvOBeqh3NuZw/uoBpzxfpq
 rCu9NMyAxgO8cCbB0o+kYO6Gd6+oVoyEC8jOpiuB0na3gxm4cr8vILwWrjJf6A5b1byz
 URZyNCNdjJt3HUzV5525PUwQQYnWnwviTl0OTAAnO9wEZkdg/EbDGNt+iIkYxihV5tNH
 NxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780651822; x=1781256622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ol+K4dl9dlW4R4sKIuY92NRXOgs/bvDP9hEc9GXVb6U=;
 b=VuoyEH0QNg/bXK5DFY15tjhxEiPDrX/zsKG0nMzxCZBPpf3BLrbK/WoMW6OYsvfDnp
 C5oEyeLFhFTZ2Z6g4uH1rNmIh36CF84rgijSZSZ6W70Z0ig5SuKHWieYNQhF+3DFHWnW
 3fG4xd1BmbpsZxgax8/T6D7qkSHxIAYVG0hsBnUBdqLH1iLlr4sDSiQRz8llyIx8wf7V
 sIqUn0RrVRGM1t+xCJgxBVJ0nHfOqG5M9cBdwxOi8Btdqn9Xj3o6X5e0/CiZDjtyIE9d
 7r4kmllLypSdrKn+OUamSlbbKubru9dhkDH3zesSbSLyXZGEERCVdtJdIdx/eskA8iwf
 Vkvw==
X-Gm-Message-State: AOJu0YxnIs9k8whP42z+mRowdLYrykeV0UVohF2fEgosC9H3j+KNZuUR
 0SInBuR/LRx/r0+vuxPzihtDiUgD8MGI4jrqHMKo2UD121j/VkK88jFj
X-Gm-Gg: Acq92OHnfA0873wFf3XECOTNipx0OT+QZRf8wHAlVYh4aVeky/jxUVbW2u7ODmSyobx
 4AB0IJ4yIiLZv/F4zlkq/X7j3uGcR88upmq/aPdjf/9CHT7YMfu1Eyi7Z8qfyBAsTgvkC6jzR8R
 OemU836S0DkQbN07q7sYyI1v8e2ZHFUQ9WThTUpxpom8CsxhOJzqY9VJ+34UA+by5+nQu1r/EWd
 tSEgCV+df9HSjiYCyJuArG2FqZwAqHNRzabjwpT5+ZjX0Pj1fr9Dlg68x2vcMSKeSGFjI1IWWp4
 0KNvBOuAj6Fz6YVHL9W2/qz4tv2ZYu0dT10FmNKxk40dEVwhZMDxZtcdPB/Oe1CjfA+2/dXD6fP
 tCP6V6fz3tS7yI/eJ2qM/rGBvN6ZlP4l918qqZf1ieWP1reTlmCFrDLO3j1D0JK3qangwHr74Vl
 uvo058MCepD+abeFMqRrVAli7kg+BIxoTXw6KT9O++kcXcbUN18pRiguYx+D90nV3DqJCCdFfLc
 UQto1QXYMHauzCsnPUAukjY5Y4pzcymwSkZPsqjf0NASnpKoQ==
X-Received: by 2002:a05:6214:4904:b0:8ca:268b:13b2 with SMTP id
 6a1803df08f44-8cee61597a5mr49132866d6.32.1780651822181; 
 Fri, 05 Jun 2026 02:30:22 -0700 (PDT)
Received: from
 runnervm3jyl0.floazsvxcilefmrd5phyrjbtph.ex.internal.cloudapp.net
 ([64.236.201.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccdb8dadsm77572746d6.12.2026.06.05.02.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:30:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri,  5 Jun 2026 09:30:20 +0000
Message-ID: <20260605093020.4127-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605-doc_add_missing_headers-v6-1-678aac302a60@suse.com>
References: <20260605-doc_add_missing_headers-v6-1-678aac302a60@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: Add missing API references to api_c_tests.rst
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

Hi Andrea,

On Fri, Jun 05 2026 11:17:13 +0200, Andrea Cervesato wrote:
> doc: Add missing API references to api_c_tests.rst

--- [PATCH 1/3] ---

>     Fixes: eef750db28 ("libs: adopt tse_ prefix for extended (non-core) library")

The Fixes tag references a commit that does not exist in the git
history. `git cat-file -t eef750db28` returns "Not a valid object
name". Either the hash is wrong or the tag should be dropped.

--- [PATCH 2/3] ---

>     * - .needs_device
>       - TST_NEEDS_DEVICE
>
> +    * - .needs_hugetlbfs
> +      - \-
> +
>      * - removed
>        - TST_NEEDS_DRIVERS

The `removed` row corresponds to the formerly-named `.needs_drivers`
field. Alphabetically `needs_drivers` (d) sorts before
`needs_hugetlbfs` (h), so the `removed` row should appear before
`.needs_hugetlbfs`, not after it.

>     Add 8 missing struct tst_test fields to the C/Shell API comparison
>     table in writing_tests.rst: ...
>
>     Add a shell API variables reference section to api_shell_tests.rst

Two independent changes are bundled here: updating the comparison
table in writing_tests.rst and adding the "Shell API variables"
section to api_shell_tests.rst. These touch different files and serve
different purposes. Each should be a separate commit per ground rule 7
(one logical change per patch).

--- [PATCH 3/3] ---

> - ``SAFE_FILE_READ_STR(path, buf)``

The macro is declared in include/tst_safe_file_ops.h as:

  #define SAFE_FILE_READ_STR(path, buf, buf_size)

It takes three arguments, not two. The `buf_size` parameter is
missing from the listed signature.

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
