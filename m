Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5FDC55ABA
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:34:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AE1E3E7161
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 19:34:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC53C3E90BE
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 19:33:56 +0200 (CEST)
Received: from mail-pj2-x03.google.com (mail-pj2-x03.google.com
 [IPv6:2607:f8b0:4864:39::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E211D140006D
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 19:33:55 +0200 (CEST)
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-3810f0aba07so641048a91.1
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785951234; x=1786556034; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=51Zff+8ED340nm8e8PbgPB4b2UzmfHRFoyofW5CC5YI=;
 b=CBowkqYrPLBQbYGmg48n5xBJu4yqAXY1nRzSsmoAQIMfVR294p6jTbc7aUzmw9jAbu
 ZZfMOmz4YNcDeQY0koKns8mYB2Cj3IWrq/cxVOj7i4DMDLSNOE2qLuaUb+s4OnD9oyeI
 JqmaJ6uJVLsGP+73xp8a6cP9b0mzJzlMNrydeUz0V6JzabBOsDTegFhWsnObbIwTjfW4
 UaQiFdmfW1A8ZCUgqUR3xogw8frkq2nFWFjtS4qrWj3UC8VvPPTVlLvJiXVCU+NCvKIx
 ys0o/y4ywwAg7w3XYhoF1+vUHCqIPpWzYfFxR2K3CY3/t7Irs2kWUB7Wb8oaTvOcxFzz
 QvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785951234; x=1786556034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=51Zff+8ED340nm8e8PbgPB4b2UzmfHRFoyofW5CC5YI=;
 b=O8ZS2Vdokk64AnzgaMcxdyqjN9lqC7SvvJz751Af9FoYlBMcxjJihhf3Tgawbas6OZ
 JHgui+yJHIrKHQOK214mfWuhu6eF2NZQ5ULOV/YOLduo573Z+TKA127fE4nF5dyHzztp
 cXT6QO3JgiS7YxRXVPGxYhxgxhNEnNhZ96Gly4SRyQG+43RAiAzpMOTrneg7ZtPF8L3R
 eXmlkg1K8m3dhOUPLzx4ZsVJF8G98ZKBznUjSpz6dL0uNpTsjhxBk+4UzROCIxvTVSGv
 1JrCc2V8dig8otpyooz3MAMQG+xOG5tXgX6zIIeRO5rDGHbM2srsYp+LwrG2yCgE95BB
 nBJg==
X-Gm-Message-State: AOJu0YwmwzNItffStfhYJHuLI5/+YLQGxVvryAzC3p2GxgIO53G+0LCD
 AIXmiyE4w9trXSTQ41hRkXomgoua4isPGrhORB6Yd8Axyl/b6h4tN/My
X-Gm-Gg: AR+sD13/ggRDbbLR6G/K8I3J5x0bXjItc2deRRdvQ1D+NtVHfE0SQUTWrU42PVUh2Xs
 GVMRVZbBzEjJgLKGjRfRJg0cPzjleg080k/ch4ux+RR2d4NgFt5XvrHVVQOnlRHsYwbhARBe4+z
 uJO74gljpyMIHmTZOjRyS9FpEGH8gWPU3qr4fqXSzDGenKZ7TfuOBMzcXl8uoBeLRlZvjGYwawz
 8wg1016hgh7sC7h9o7l66NDQ6GyiNbq2lv89xFQD/ea7r14P4U1cGVYU1Pgf4MnkWGCXBNZSNwq
 EdxQvTXmcqLEkeOyBjJJtpQv4+cB39GbI+BCXLyQlG3LTdOMg6rnNl660I0fDz4jIBc9vG/aGAy
 V5/XDluex1rDijNdv9jG9/V1xhAtaxZkz3ebGsuh9MeV+zDhWycxPscMagWrg2HbonpDpGqZp85
 47isPxV+fiBIazj8sodIZ5ggnYgmftV1jxW7fbwFmBAHwdJ9umuApFnGb9IdF+anlrPi0pmanUI
 GA/nLDrhTFW9WjG6Tbi+R1o2dAclynZZ00Ws+gcfPiMlnwjBZMlaOT5ni3XLv5Oqv037vr0
X-Received: by 2002:a17:90b:4b81:b0:38e:7f1b:efa with SMTP id
 98e67ed59e1d1-3903c582798mr7548016a91.11.1785951233837; 
 Wed, 05 Aug 2026 10:33:53 -0700 (PDT)
Received: from
 runnervmvrwv9.lm5voez41cuu5k0eg3hjwl50ja.xx.internal.cloudapp.net
 ([4.154.22.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3903927db6esm3568316a91.10.2026.08.05.10.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:33:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed,  5 Aug 2026 17:33:52 +0000
Message-ID: <20260805173352.8682-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805151451.648990-2-pvorel@suse.cz>
References: <20260805151451.648990-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kvercmp: Factor out error handling
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

Hi Petr,

On Wed, Aug 5, 2026, Petr Vorel wrote:
> tst_kvercmp: Factor out error handling

--- [PATCH 1/9] ---

> +static int _tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)

Could this helper use an unreserved name such as parse_kver or
tst_parse_kver_internal? Identifiers beginning with an underscore are
reserved at file scope by C, and LTP's C rules explicitly prohibit them.

--- [PATCH 6/9] ---

> +static struct tst_test test = {
> +	.min_kver = "4.4",
> +	.max_kver = "5.0",
> +	.test_all = do_test,
> +};

How can this self-test verify that a valid range is run? On kernel 7.2,
the framework exits with TCONF before do_test() is called, and runtest.sh
accepts TCONF as success. The test therefore remains green even if running
a test inside a valid min/max range is broken. Could the test use a range
containing the running kernel, or assert the gating result another way?

--- [PATCH 7/9] ---

> +/**
> + * tst_kver_cmp() - Compare two kernel versions, versions passed by 3 integers.
> + *
> + * @a1: First kernel major version.
> + * @a2: First kernel minor version.
> + * @a3: First kernel patch level.
> + * @b1: Second kernel major version.
> + * @b2: Second kernel minor  version.
> + * @b3: Second kernel patch level.
> + */

Could this public API document its return value with the required kernel-doc
Return: section? It should describe the negative, zero, and positive cases.

--- [PATCH 9/9] ---

> +metaparse: HOST_CFLAGS		+= -I$(abs_srcdir)/../include -L$(abs_builddir)/../lib
> +metaparse: HOST_LDLIBS		+= -lltp

How does this work for cross builds? metaparse is linked with HOSTCC, while
lib/libltp.a is built with the target CC. HOSTCC cannot link
target-architecture objects, so metadata generation fails with an
incompatible object format. Could the needed parsing and comparison code be
built with HOSTCC and kept free of target-library dependencies instead?

> +	if (min_kver && max_kver) {
> +		if (tst_kver_cmp(a1, a2, a3, b1, b2, b3) < 0) {
> +			fprintf(stderr, "%s: min_kver (%s) > max_kver (%s)\n",

Could this comparison apply the documented two-component max_kver semantics?
For example, min_kver "7.1.5" and max_kver "7.1" is a valid nonempty range
because max_kver "7.1" includes every 7.1.x stable release. This literal
comparison treats the maximum as 7.1.0 and rejects that range.

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
