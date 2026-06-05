Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF016CD6E5D
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:31:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 560AC3E5474
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 11:31:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D293C3CDA3F
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:31:20 +0200 (CEST)
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DAADC10006B7
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:31:19 +0200 (CEST)
Received: by mail-oo1-xc43.google.com with SMTP id
 006d021491bc7-69e4d51b15dso1178625eaf.2
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780651878; x=1781256678; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y14H7Bh9ZiBnywzU6nw9wlxdqa3Siail/57Alxbu3Mo=;
 b=OLOHTzoJhdS+0fDZeOGQAezSTqbyu7CmoUPPWQzp70bK0/H1CPFwhQB/GQrUo+SPDK
 2xN2xPQSEH0sn5K5CX59hBb/cKKOfYWxlgZeGaWdxfMb69OhxMGtEksm4mxPEHE1p9Rd
 /FUCFAZBd2ufwaYPxsElgp3K1YoD0cD15J6934A/MYlwnppYw+3EeLDYa32jRRyoO3iU
 /wMJDA+k2BhwTdlze4WUk8Ojv43GRp1HSuCPY6utVSx9oDGxPhRlSmjyO7fWJfseYEN0
 gS0aPRXwFTjUm8A4GQzehaM8/C0JP7BuCgEOmyNElsisP/eo1sShdsFdwXBG1m6oDQ4m
 HCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780651878; x=1781256678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y14H7Bh9ZiBnywzU6nw9wlxdqa3Siail/57Alxbu3Mo=;
 b=Jo03rUcH/CHUASCuu2JSXRcMWgFkEFm6UNpkiDI7LYUYb8lfxgifGPCV42rBYZJ7K9
 +Glv2EdSFcF4HLx9aLrZ+WMLU6SNjImwZDNuV5SXX2WbNcPBwhvAYhODBe/qYXyoNLch
 T5r0bT70+efCxIrpViEn95W7yIyuimoBTqhv6LjXPflAdlDqnAJk6xSLxdRcrrqMUCW8
 JjwkqtckHojYkxqxrqitR8awSR4QpPgMJZ1gcenGPOG5pf3kBNx1v3Qob+5gnZ4yTVrg
 V9EGiBt7LFIwvKQJ0rW9EpFOMDhU7bDVow28unBHent71q+5QKv0axFfxSUTdXLybug0
 ynSg==
X-Gm-Message-State: AOJu0YxUX5yUbPYHmk5gswuHrYLzotdPpGfzciVmGr8p2QoEp3urgM88
 MeNFmrVhCoTby/0xPrTE5xgwAIXuwqYgUYCFg1AUHryLUKND9LUeIhsq
X-Gm-Gg: Acq92OHQSKNKPXAgbf/0RHk/OTvcDhvJIyzpsfhOmXPrPozKCRbYFLfudmIdmw1iEq3
 VlmBRsoKGUoy9oZ1jr2QBU2fRGKcAxtFIhpt4TLfzcUjfIakN4MVbAOJpXo0K3ayoFyhbhuhFDN
 qqgS9YNT3+XZ+iJQRhzLM6mtNTwKlt6tCi9Xr7OsXbCcVcxg9lrbM4+b3T+g4KC4IxehdXZzrUs
 DEdPpJcoAxWLwlndVbfLNDya8YqSDe9NUf59wO5IwSfGDtcwmXzEzUhbnTkC7TWxzfO1HiSRYRQ
 vEXZtU+UzmBrb5SvtTOIiZ29X0Git+bwPD7Kiegc8ZrXV3pd/EyA1dRJjAPrDmuA+Xtp76rRpr9
 W1TQ1alRhoMmDJmNMatRVELPzXEYpV/QVl/+UIcY8w6NuoghQlM9qqfXh7tDaHHTkryiogx/E6m
 PzNGSxndhEhX0OUDmIYFVEI9679ds13VcBDNN1ZCUgNdMT2MPX44ILg10SNy7qmjMs6uxcChVJQ
 nk1ZWKgcKuvU4QEtC3lMQGKaM2VWk5jLEnDycz4z+dnLX+HKes=
X-Received: by 2002:a05:6820:813:b0:69e:31c6:2e9c with SMTP id
 006d021491bc7-69e68cafd88mr1419600eaf.56.1780651878361; 
 Fri, 05 Jun 2026 02:31:18 -0700 (PDT)
Received: from
 runnervm3jyl0.liu2e0sny4beva0y4fvxt5jcyf.gx.internal.cloudapp.net
 ([52.154.132.165]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e4620c6a3sm5090353eaf.1.2026.06.05.02.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:31:17 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Fri,  5 Jun 2026 09:31:16 +0000
Message-ID: <20260605093116.4156-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604065417.25924-2-sachinp@linux.ibm.com>
References: <20260604065417.25924-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permissions test
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

Hi Sachin,

On Thu, 4 Jun 2026 12:24:10 +0530, Sachin Sant
<sachinp@linux.ibm.com> wrote:
> fs/acl: Add ACL_USER_OBJ permissions test

--- [PATCH 1/8] ---

> The patch also adds acl_lib.h containing shared helper functions
> and definitions for ACL and extended attribute tests.

The commit adds two distinct things: the shared helper library
acl_lib.h, and the first test acl_user_obj01.c. Per Ground Rule 7,
each patch must contain exactly one logical change. acl_lib.h should
be introduced in a preparatory commit before the tests that use it.

> then sets ACL_USER_OBJ with write permissions and confirms that
> file creation succeeds.

> +	add_acl_entry(acl, ACL_USER_OBJ,
> +		      ACL_READ | ACL_WRITE | ACL_EXECUTE);

The body says "sets ACL_USER_OBJ with write permissions" but the
code grants read, write, and execute (rwx). The description should
say "full permissions (rwx)" or "rwx".

> +uid_t user1_uid, user2_uid, user3_uid;
> +gid_t user1_gid, user2_gid, user3_gid;
> +int users_created = 0;
> +
> +#ifdef HAVE_LIBACL

These variable definitions are outside the #ifdef HAVE_LIBACL guard
but are only used inside it. Per c-tests.md Rule 16, all test code
must be wrapped by the feature guard. Move these three lines inside
the #ifdef block.

The same pattern appears in acl_mask01.c (patch 2/8), acl_other01.c
(patch 3/8), acl_inherit01.c (patch 4/8), and acl_file_ops01.c
(patch 5/8).

> +LDLIBS			+= $(ACL_LIBS)

This applies the ACL library link flag to every binary in the
directory, including xattr_test01, which uses only xattr syscalls and
does not call any libacl functions. Per the build-system rules,
per-target flags are preferred when not every test truly needs them.

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
