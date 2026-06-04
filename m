Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2136DCD6E57
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 09:35:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F95E3E54DB
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 11:35:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 762563E54DC
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 11:34:55 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E48831A003C4
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 11:34:54 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8ced8f44da0so4807576d6.2
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780565693; x=1781170493; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mek922KSBFPmw7gd3tYogksxASm5iEmt4J65YXK9du8=;
 b=TOnMlI6DbE8OTHjTd06Fqb6V106O71pGbXrELHXl/vRV2EMRuwZUHBhAFLa80y3Rtk
 D3zU+Yrz4BLL3OG0xaDefZIFHwTOg6MMbAQo/LTrFajkRN4mDH2Mt5fhkVvLAwjHrhZ2
 1zi5rnP2mU91adyZNBE1oupuYDMVe+8msvdvEQ+QnOm6aD6TdoBGDP4ARq1SNi707ziA
 vhfjEF8gTBg6sr4Ttf3pSTahVX3ytrtj4Okj8JubxJfBPzAZxmaSSqUGJoIgaYDvvKJe
 Leb2teTQqhBk5ozyOp4pIbuXNY68c5aInoOrQOmdLhaafs3Rn2WflhWJ+g/GyuKiMIUW
 BqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565693; x=1781170493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mek922KSBFPmw7gd3tYogksxASm5iEmt4J65YXK9du8=;
 b=bUH7uGy7hrKdGnpFiM3x+tQCckMQ9hQ1lmiUtJBkvEEvw87pqonKZoFTQtC+3XKj1J
 Xim4d2gMgsoXpwVVTG3PQbNYKSzymlZNS91o7uPozk/7jQbNQnXsOJ+TGd3KOGVdTL3j
 rBWSfti+3H+MfrudYTyGDnTd0i1aJXJr2ol1x3fInS+jQ0Dg2oVCH3DitphurUvzNcvY
 N9E1J/jev0WH/MxxMtCx30lLrvesnKbBsF+D2/82TT6QnS8HSaMLh7KoVPjKIATszlCZ
 B2qMLtU1SuH7BItu4tcYe8wQJXBQw+E354Fk6JI3b8SATD5+qq+wB6o2K4c4rrBSAvNI
 YlzA==
X-Gm-Message-State: AOJu0YzZxadd3zpysBGqjFe6Dy4aYbLnv19AJkO9h1s2OyneX3WU+hpb
 5tT1erEPFwZpO3wAPGTLFTigaly79CUsWUMvneROUN53rbTBxjzctAHFWR8gnoC+My0=
X-Gm-Gg: Acq92OGqwJ2Cp+hlAvVpxIlYAadoVF/soqpYqyRILlc74fV/x7jV6kqbKgSJ+8RM357
 ozfbWGetN64px5HUS/M4AxGbJyWFJ18Vy2R5rz118cKqa9REkb+hA8DN/1N1iYQlwbUNWanIc7B
 mj2eB9KR8PC/XvyDBfxU+gkpOlROZC4nZjbPOV0xNl9Bx23cB17XLodefe2pMWmu3Fco3cfJ6p3
 YOllLqvgAsed+zqgXPsd0zbBRXt+MdaA8Gxv+tswIC0J0k56pxDdZ+9jU8qv5CP4/pY6bzlCp3E
 c4z+GZlGNMuR4B7j+y8/Emz9XZ/x7kU2Vi7x1z70LohZMQwY6VYZmwt708lV7XKR0gvsATc05bG
 Jvv4e7Xue6UmLWvxbNltx0dCOxjisKc5YDda+KtZmgzlwgGsyKjExBAcq0VRg2uHvS8HQuAyoX7
 kYDfTdlQh28Ox8e4UP+kQHo+QBMYCBkqgcryqwdZSRZEUL0H85pTBHKPxJsQqbSeLAkLJyNwB/u
 Nj5PRo9AyAol2MejZICZf9+a1UHQJe2d9ttyvLaJV2kA4EK4FI=
X-Received: by 2002:a05:622a:4206:b0:516:e109:b65d with SMTP id
 d75a77b69052e-5177878238dmr107673661cf.58.1780565693342; 
 Thu, 04 Jun 2026 02:34:53 -0700 (PDT)
Received: from
 runnervm3jyl0.nd2n2ml2x1yujloepixabnbq5g.bx.internal.cloudapp.net
 ([52.224.244.102]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775df4dd6sm47158011cf.27.2026.06.04.02.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:34:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu,  4 Jun 2026 09:34:51 +0000
Message-ID: <20260604093451.4058-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604-doc_add_missing_headers-v5-1-2e0adc082d5a@suse.com>
References: <20260604-doc_add_missing_headers-v5-1-2e0adc082d5a@suse.com>
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

On Thu, 04 Jun 2026 10:45:08 +0200, Andrea Cervesato wrote:
> doc: Add missing API references to api_c_tests.rst

--- [PATCH 1/3] ---

> +/**
> + * struct tst_device - Block device used by a test.
>   ...
>  */
>  struct tst_device {
>  ...
>  /*
> - * Automatically initialized if test.needs_device is set.
> + * tst_device - Pointer to the test block device.
> + *
> + * Automatically initialized if tst_test.needs_device is set.
>   */
>  extern struct tst_device *tst_device;

The tst_device variable comment body was updated to kernel-doc format
(starting with "tst_device - ..."), but the opening delimiter was left
as "/*" instead of "/**". kernel-doc ignores "/*" blocks, so this
variable will not appear in the generated documentation. Every other
function in this file was converted with "/**" in the same commit.

> +Filesystems
> +-----------
> +.. kernel-doc:: ../../include/tst_fs.h
>
> ...
>
> +Memory
> +------
> +.. kernel-doc:: ../../include/tst_memutils.h

tst_fs.h and tst_memutils.h were not converted to kernel-doc format in
this commit. tst_fs.h has a single "/**" comment for tst_path_exists(),
and tst_memutils.h has one for tst_mapping_in_range(). The primary APIs
in each header -- tst_fs_type(), tst_fs_has_free(), tst_pollute_memory(),
tst_available_mem(), tst_available_swap() -- all use plain "/*" comments
and will not be extracted.

The resulting "Filesystems" and "Memory" sections under LTP C API will
each document only one function, neither of which is the main API the
section title implies.

Was the intent to convert these headers in a follow-up, or should they
be converted here to avoid publishing sparse documentation sections?

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
