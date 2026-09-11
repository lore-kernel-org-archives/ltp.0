Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43297C88E4D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 20:38:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 006EF3E93AA
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 22:38:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F25D93E546A
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 22:38:09 +0200 (CEST)
Received: from mail-oa2-x09.google.com (mail-oa2-x09.google.com
 [IPv6:2607:f8b0:4864:30::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F2B1E2001B4
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 22:38:07 +0200 (CEST)
Received: by mail-oa2-x09.google.com with SMTP id
 586e51a60fabf-47cf5b09bf1so429686fac.1
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789159086; x=1789763886; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HtFgDfgF2Gq6Omqe5wny8zup8Ra8yuN9unQyB/TLW20=;
 b=ZJmIcLVGcAzhrLugbJB6pddUQQ7mV1eI4IiG4NiFRgjxjEUg57bCX8NE/xrl3adzZh
 fZSkag1c/vjFWsHZyqbkuvNF9GIcaBCZnbAQUREyR+PG/yXf4i/gMoWbvoFBvmYGdxsq
 0Y1TZuchS1w8dAI8FNJV/nNbb+vLUwEHGt6Xu9j9uLlPFz3hObJsrjMxmbUsPLa+6bIa
 Y4uXM6W/0BRUlqw6O6E5U186dz268VxfU5n6fk5MT7NqhBgNImSsbSNwp5tCQ3v2yAB4
 FpRaqj6B+jBNZfhWSKtV2JAE2DoQtiTE4lEQsPlNdoFsWjd7wqBzZEg2Zghiuvj12MaO
 liHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789159086; x=1789763886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HtFgDfgF2Gq6Omqe5wny8zup8Ra8yuN9unQyB/TLW20=;
 b=ls1yd9y+E7p8wL/j6Lv3EZPqtEC4LizQPklOcImM81kob+TkJRHGKfzsGJylKyXSD4
 RNcfyFkzc7QuAh4yL+KBLnGoBkmGgc2NyNSvFad6iz0yjqDT3dnUSsVNhkyNr065X6Ra
 iuIKlzO5Ch5yplpY5KDzxiI2HaOnyg/C1wwESjCmPtJ0qwj5NdFdpStgt+GtaUjgAYRW
 Pjx7aB7P9HNKJlqXyovRkTllvEtFQyv3by+gP+nh6EVQGEIhYQIQhrjJ5hqxuCi9y6fJ
 b3T+wDAMNJAg5OQ50090BA2+RPfeYJP3oEh/G+MS8vNjaj+BEYxv4Kjk12toCcchQ/xE
 LhbA==
X-Gm-Message-State: AFuF++l1EXq9r3gmd8X3eGrZvUIeEsGvDMW55ztuZ7aPfGZqXAiCYJje
 VuOWwqqVE6MG4blDDX9EfVFnegnRo/DJo4HH6U4MZE9VaoQ/gg49hUff
X-Gm-Gg: AYBFou2e65o5vmB0SurWhMOnrvfi3BDgG//fsMdwYls8NFPqi0xc2bjlv4qw1DtdeHt
 TkJJchmoSpRpkCk/U8ZOJqxnTSZHh3f/tJ18mIIGZxAHAWQj2yXwXxtZCbAxCfMHjKGj0hf4ID+
 5GLFDlYEeC/WWJZisxpGNFTOw7rfzy7PirSmrFz/m9lv9Y0tWPUzBWJ251KVjfLzXvhc4TJJ+ne
 YEpjOCdY6ruDqWrOSvxygyE/LdwAd65pvh17BOkcs4ARmDyn2ghYHErgBjBzpvRZKW774fPpINk
 XOhphWeqwFBrQqTOEM9mkySkNIo3GUYdXuJxEkOg8HEXP483g2clr0tzPIPNQxfheVOYJeNdo88
 797owokKZmoEbfHm06x9hXU6tICS6k2nMVc2zsKE8vc4OFhC691NixFanduf6i5Mw0YnX4g6Equ
 HfUulen0MtMfUw1mn643uYxyGVW4xSsHVVkJKZr4+7mkW6i0FWNYkuOWYYIT02RVSlxQ7S3foSb
 /ne88HcHyywmZULbdtZI6rHo2HBXJZLCHdR1vgvFp0STpErK6BzJYGz4JvRrluYy8/eXKWCIWQP
 H2YwIgjo4p4=
X-Received: by 2002:a05:6871:7c09:b0:475:e235:901 with SMTP id
 586e51a60fabf-47dea413696mr4644383fac.31.1789159085714; 
 Fri, 11 Sep 2026 13:38:05 -0700 (PDT)
Received: from
 runnervmlun5p.oyjyvzs5hu5elgto0o55h4yjsc.gx.internal.cloudapp.net
 ([20.40.213.247]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90fb975sm2803429fac.13.2026.09.11.13.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 13:38:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Sep 2026 20:38:03 +0000
Message-ID: <20260911203803.4095-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911195133.278281-1-pvorel@suse.cz>
References: <20260911195133.278281-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] include: Restore kerneldoc for tst_cmd() and TST_CAP()
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

On Fri Sep 11 21:51:33 2026 +0200, Petr Vorel wrote:
> include: Restore kerneldoc for tst_cmd() and TST_CAP()

The subject mentions tst_cmd(), but the patch restores kerneldoc for
struct tst_cmd (the function tst_cmd() was never modified). Use
"struct tst_cmd" instead of "tst_cmd()".

> This partly reverts ef4c5c61f8. We want to have the doc included,
> because both the structure and the function is documented properly
> there. We need to use c:func: and c:type: in references, but that's ok.

ef4c5c61f8 downgraded these comments because kernel-doc and Sphinx emit
name collisions and duplicate target warnings between struct tst_cmd and
tst_cmd(), as well as struct tst_cap and TST_CAP(), when api_c_tests.rst
extracts all comments from these headers. Restoring both blocks without
resolving the target collision reintroduces documentation build warnings.
Also, tst_capability.h defines a struct and a macro, not a function.

> diff --git a/include/tst_capability.h b/include/tst_capability.h
> index c38dcf353..2e9a4dc55 100644
> --- a/include/tst_capability.h
> +++ b/include/tst_capability.h
> @@ -69,7 +69,7 @@ struct tst_cap {
>  	char *name;
>  };
>  
> -/*
> +/**
>   * TST_CAP() - Create a struct tst_cap entry.
>   *
>   * @action: What should we do, i.e. drop or add capability.

For macros, the kernel-doc summary line must use "name" without
parentheses. Change "TST_CAP()" to "TST_CAP".

> diff --git a/include/tst_cmd.h b/include/tst_cmd.h
> index 4829d0aed..36d8751a2 100644
> --- a/include/tst_cmd.h
> +++ b/include/tst_cmd.h
> @@ -19,7 +19,7 @@ enum tst_cmd_flags {
>  	TST_CMD_TCONF_ON_MISSING = 2,
>  };
>  
> -/*
> +/**
>   * struct tst_cmd - Provides details about a command struct needed by LTP test.
>   * @cmd: The name of the command.
>   * @optional: A flag indicating if the command is optional.

Restoring the kernel-doc comment here causes a duplicate target collision
with the existing tst_cmd() function documentation in api_c_tests.rst.

Verdict - Needs revision

Pre-existing issues:
- include/tst_capability.h: tst_capget() and tst_capset() kernel-doc blocks
  use lowercase "return:" instead of "Return:".

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
