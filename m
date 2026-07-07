Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB76C43602
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 14:28:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7A193E5CF9
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 16:28:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E30FB3E27A2
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 16:28:13 +0200 (CEST)
Received: from mail-qv2-x01.google.com (mail-qv2-x01.google.com
 [IPv6:2607:f8b0:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5787E6002C7
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 16:28:13 +0200 (CEST)
Received: by mail-qv2-x01.google.com with SMTP id
 6a1803df08f44-8fb613b6726so6437476d6.1
 for <ltp@lists.linux.it>; Tue, 07 Jul 2026 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783434492; x=1784039292; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=376FDKxY5WGPFUkzyvgECBwYaDB0jhwTbzud19iOMuU=;
 b=hZ4/GnelpBmjOajOZsQm2oAwV+ry/uflB/3wWcUAkz/cPylMk3fyDJO83bpKwQVcNs
 EnJMnsjVha0rEIk5XTZeHx9G12O+9zq/yghE+rgdaFZ4XnlJ1CdowNxXPMFXsnNARk3l
 bV1nMG4gB7ybwDMXZ73HIsTG/YaD08fICCeT15nmoSB3yGz8ejy8/xYdFgFjzfKdlvYW
 pHaNSKHwgugOdvSi0Q+WGBbe+WPgdgaEnYkymkTj7E1JMpWOmkQnIvxTap7xzAwLx8JO
 4VEA1Jj3dtxlF1S7RKLBtIIOH7Ab3H2YkSj2BZLgIwKa7CEZONlx4jkEP9dyFBsC0vAo
 kOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783434492; x=1784039292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=376FDKxY5WGPFUkzyvgECBwYaDB0jhwTbzud19iOMuU=;
 b=j1VBj31+tYtzSMEml91tn6mSjPsGR4MConf+cenDFcDJIBD5cMPjpVdbSGFH+5pDF4
 InQc5pShLLWblN/A2WgiRGu5vbmpwWKXozC6WHvWJFpkIPfV7rjGOGujMD0KeruFkQCD
 wOJHDwZWUG8UfzZALDdilmv/C7IH4o5349XWyDoTXT/0ve9fPvqKvK2NB+zd/DRwuHG6
 Hvju98XJACT3+OJky3Be1PXHXN6kJahmGU0frMdNUaMRUfdH511R2RcjIGPu7BtuJfzd
 dINjZjR0HQm939wD0FI1fo0p+EILYt20guJa9Dw22pAU+kdaPrCoJyJLnQqjeFnRkMBZ
 TYbw==
X-Gm-Message-State: AOJu0YwLYSGYZEBirvYwIEvK+xuRCHg3FPbkdOj1gcUs/X4Ybj5Jb1cX
 0D6BC0e9mmysrz8AKvP53Jh0FUH6WCrAHZmLyMaSNsBTMJcp7Qg6UeoW
X-Gm-Gg: AfdE7cmxqJ2ArbQnHtS6jAlp4dYBC3HzsZm+pl0rACbDLhG/VTRsFOGwlwGOX44OCSw
 NSx0F38QduapDIQCNiR7rXgBol9D7CSfjQSLpRdnCfSp23G9FNA192KbwB9oZsH5VvwM5zHH2TO
 KaVCFToeyv6qH+V9z12M73Jlvl2FF+AcTq1W4aE4JN/NYPLscD2XRQ5pd2nZemiN6ju82tBF2k9
 ozo9pXJYqHnzAKfel7Y55Ln4U4O375IxOTwsxGhzTUXBMuwuGzYIoj5RwwZtJl2dpL/LvElw05z
 BZSHw++IitgEAGqIhqsb78x/Id2zsRjcxU5RG3ME9Koi3xkAV5sLXQEqXWmKjHWYAKBIPNOjcTk
 8k1UGekWCxmnbq7T0Uq+z8/ABWrw50I8yg79RvsLgTqZTETpofzZb8RxHOzC4IHIAhIXEbLtDcG
 sKWjneKS8gtNAmXNV60633zD3ExrL9QhzNX10nrb7ovoQS2gKUMdrYc/fZCfVkhRJyHLIDQZllM
 sGgEeKtNJqHHd9jhQ5utZG3eVW1Kw==
X-Received: by 2002:a05:6214:2e4a:b0:8f4:821d:95f7 with SMTP id
 6a1803df08f44-8fcb25a90bemr69764566d6.18.1783434492058; 
 Tue, 07 Jul 2026 07:28:12 -0700 (PDT)
Received: from
 runnervmkkn4f.claegtiifgau1bm0f4pfh1su5e.bx.internal.cloudapp.net
 ([172.208.62.170]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f472a9d8c0sm157909746d6.49.2026.07.07.07.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 07:28:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue,  7 Jul 2026 14:28:10 +0000
Message-ID: <20260707142810.4143-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707-cve-2026-46331-v3-1-3f6f1d697eec@suse.com>
References: <20260707-cve-2026-46331-v3-1-3f6f1d697eec@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: Add pkt_cls.h fallback
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

On Tue, 7 Jul 2026 15:42:27 +0200, Andrea Cervesato wrote:
> lapi: Add pkt_cls.h fallback

--- [PATCH 3/4] ---

> +#ifndef TCA_PEDIT_KEY_EX
> +# define TCA_PEDIT_KEY_EX		3
> +#endif

The value is wrong. Counting from TCA_PEDIT_UNSPEC = 0 in the kernel
anonymous enum:

  TCA_PEDIT_UNSPEC  = 0
  TCA_PEDIT_TM      = 1
  TCA_PEDIT_PARMS   = 2
  TCA_PEDIT_PAD     = 3   <-- 3 is PAD, not KEY_EX
  TCA_PEDIT_PARMS_EX = 4
  TCA_PEDIT_KEYS_EX  = 5
  TCA_PEDIT_KEY_EX   = 6  <-- should be 6

With value 3 the kernel would receive a TCA_PEDIT_PAD attribute where
TCA_PEDIT_KEY_EX is expected and reject the filter with "Unknown
attribute, expected extended key".

This also breaks the test in patch 4/4 which uses TCA_PEDIT_KEY_EX
as a netlink attribute type.

> +#ifndef TCA_PEDIT_PARMS_EX
> +# define TCA_PEDIT_PARMS_EX		4
> +#endif
> +
> +#ifndef TCA_PEDIT_KEYS_EX
> +# define TCA_PEDIT_KEYS_EX		5
> +#endif
> +
> +#ifndef TCA_PEDIT_KEY_EX
> +# define TCA_PEDIT_KEY_EX		3
> +#endif
> +
> +#ifndef TCA_PEDIT_KEY_EX_HTYPE
> +# define TCA_PEDIT_KEY_EX_HTYPE		1
> +#endif
> +
> +#ifndef TCA_PEDIT_KEY_EX_CMD
> +# define TCA_PEDIT_KEY_EX_CMD		2
> +#endif

All five of these are anonymous enum values in the kernel header, not
preprocessor macros. A #ifndef guard tests the preprocessor symbol
table, which does not include enum constants. So every one of these
#define lines executes unconditionally even on systems that already
have the full kernel header -- the enum values are silently shadowed
by the macros.

For the four correctly-valued ones this has no observable impact
today, but the guard gives a false sense of safety. For
TCA_PEDIT_KEY_EX the wrong value makes the situation permanent on
every system.

The correct approach for enum-valued constants is to use
AC_CHECK_DECLS in configure.ac, the same way this patch already uses
AC_CHECK_TYPES for the two enum types:

  AC_CHECK_DECLS([TCA_PEDIT_PARMS_EX, TCA_PEDIT_KEYS_EX,
                  TCA_PEDIT_KEY_EX, TCA_PEDIT_KEY_EX_HTYPE,
                  TCA_PEDIT_KEY_EX_CMD],,,[
  #include <linux/tc_act/tc_pedit.h>])

That generates HAVE_DECL_* macros which can be used as guards around
the fallback defines.

--- [PATCH 4/4] ---

> +cve: Add act_pedit page-cache corruption test

The fix commit 899ee91156e5 does not exist in torvalds/linux, and the
field `tcfp_off_max_hint` mentioned in the commit body is absent from
the kernel source. The fix has not been merged to mainline and is
therefore not in any released kernel, including 7.2.

Per the staging rule, a test for an unreleased fix must:
  - carry a [STAGING] subject prefix, and
  - be listed in runtest/staging, not runtest/cve.

> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "899ee91156e5"},

The SHA 899ee91156e5 cannot be resolved in torvalds/linux. Update
this to the correct SHA once the fix is merged.

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
