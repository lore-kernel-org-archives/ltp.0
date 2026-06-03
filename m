Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94DACD6E57
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 14:45:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70EA83E7214
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 16:45:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B05E93CE107
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 16:44:47 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 024C360067D
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 16:44:46 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-517583cb07aso32852431cf.2
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780497886; x=1781102686; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=040MzuwTPVyTLhKFDzmg46HRtMxJyYfLEHunddqMj08=;
 b=q3g/3dONyb4o0ZEToKX1Z27+TBiXwGmHT0domfuOhrvvJMq3L5d19adS2WTS3Rmw/4
 2m0VAV+9mxaeEotq1cXN32jj1GB3kMV0A7qX7KvrashrGAhQN2CbMrqpAWLRIlJVVARE
 TDt2wQIbqJwodUQzbmaynjO+tUBsIwvpBDcZzJwiinRLG0vO3KOuMjlC9nWvAkuwMQGf
 0FrvsZGZHIlVFklkg3INkNMw38IsG8c9SnvY/yw67J3OiSbBHDviv9fy15nUKZ5W77ae
 LafjZDvhuFe9JCa8TjtKkG8EXt+y834lYOyFKel++KPW0oCnAVcDHlIzUYbtW5JsF9rz
 F3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780497886; x=1781102686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=040MzuwTPVyTLhKFDzmg46HRtMxJyYfLEHunddqMj08=;
 b=pgIpbAcQYUr9xo0CLAeQQJSQXZ3lu64t8O3a278M0D0cpBG3saWgjmL5l0pte9wVVb
 yFEC5k53BSiuXh6zqbypme80w05PvKaUl6mGVIZB+OB3XoFfGeMGB37Fxcx+cBGi7eCj
 STu26XCFv+iw1KUAIXxPSzJ6biZUonTyoy+Pc/xtvCChb1US7wVM4FRDzNZrWywkG3DA
 R5qm4cpRarVHz0nmiEMijXFOQtywVrcp+6LYmnj9aKE+zhPQh7v4weAzu5LD63uH5zrV
 77jlcOsD2oPwwPPMs6RIQj5lgclm0AICsibzEISqQ8XW69ZfroCL6JcPBhXH0Ux6JUqp
 7E1A==
X-Gm-Message-State: AOJu0YyAx/4Dn7Bk7KRn+iXYEUsif/vXHUuiwv1Hh3m8Pf6oix1Rf/1d
 zcratX1e7nulKssj4Hui9ksC2YyYDXE7pKxgKD7XCoZyqTZCdGxRKt5l
X-Gm-Gg: Acq92OFvNsZmkbX7L+wEtOyyWkm9jwB5qTU53Z5NUSZyWbLmaSyq6ZGoR22ShvCD4T8
 QQh03Ut6fKhW4FL9Cro/V/jlstqcNxlsM1aiqIH8nJeBXobQ8Am3as8sytocBxuEuuhTOp2lB2N
 kuyFf9K0IZctv863qhV2DoYhWNKhCD783/pbBEPGCWTDYt4MbWg+jgZfa/nPXY1r804SEqg1vSP
 K61NpZpAugK9Lby19PPrYUygqDJkJAXpv1tgjXuNO+KNHvhuIGp5lr78XIoeKK+pFmjtsFCczmF
 mJlxtsUxxpLwchRWT36/hUc3Qp656g1BSVfveNbhoM/6Ybl3XXKA9OPYEWzJadklK53TWh4BXb4
 /Qiy2aoHYCr9M2GHBsGsEVZiV9TY4tEuLYzqSxDAoJ7ffkfHL52GuXYhiSQiglGS5sGk0RKyAQR
 BFJhYhEgIhZpUljGot824igsid7wEAK4RwYWM103PtS+n32H5VjQhC/Tb236iUWS6N8v78XdmAE
 pWMfvTRfa5q+mc7T1i8gOc5IHusMq7A1U0aWyWghedfP8FI
X-Received: by 2002:a05:622a:581a:b0:517:736b:e0c2 with SMTP id
 d75a77b69052e-517786aa792mr51491361cf.27.1780497885489; 
 Wed, 03 Jun 2026 07:44:45 -0700 (PDT)
Received: from
 runnervm3jyl0.ifytnyyjtqiufk1iw4ikp3oyca.bx.internal.cloudapp.net
 ([52.150.28.36]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775dcf367sm25523471cf.25.2026.06.03.07.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 07:44:45 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed,  3 Jun 2026 14:44:44 +0000
Message-ID: <20260603144444.4237-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603115828.587769-2-pvorel@suse.cz>
References: <20260603115828.587769-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] renameat201.c: Rewrite into new API,
 split into renameat203.c
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

thanks for working on the renameat2 conversion/cleanup. The direction looks good, but I don't think this series is ready yet. There are a few must-fix issues here:

- patch 1 adds renameat203.c but does not register it in runtest/syscalls, so the new test never runs;
- patch 1 also drops the old btrfs-specific RENAME_EXCHANGE handling for the ENOENT case, which will regress on the kernels mentioned in the commit message;
- patch 3 moves the fallback into a misleading lapi/stdio.h name and puts a non-static function definition into a public header.

Please see inline comments below.

---
[PATCH 1/3] renameat201.c: Rewrite into new API, split into renameat203.c

BUG: renameat203 is built but never added to runtest/syscalls, so the new test will not be executed by the harness.

> runtest/syscalls
> renameat201 renameat201
> renameat202 renameat202 -i 10

Please add:

> renameat203 renameat203

Without that, the split is incomplete.

BUG: this patch removes the old btrfs-specific handling for RENAME_EXCHANGE, but one of the remaining cases still depends on it.

> +	{NON_EXIST, FLAGS_ERRNO_DESC(RENAME_EXCHANGE, ENOENT)},
> ...
> +	TST_EXP_FAIL(renameat2(olddirfd, TEST_FILE, newdirfd, tc->newpath,
> +			   tc->flags), tc->exp_errno);

On older btrfs kernels, RENAME_EXCHANGE returns EINVAL because the flag is not supported, regardless of whether newpath exists. The old code handled this with a TCONF path:

> if ((test->flags & RENAME_EXCHANGE) && EINVAL == TEST_ERRNO
>     && fs_type == TST_BTRFS_MAGIC)

That exception needs to be restored for the RENAME_EXCHANGE case, otherwise this will fail on the backported kernels mentioned in the commit message.

BUG: fs_type became dead code in renameat201.c.

> +static long fs_type;
> ...
> +	fs_type = tst_fs_type(".");

After removing the btrfs check from renameat2_verify(), fs_type is no longer used. Either restore the compatibility check above or drop fs_type entirely.

BUG: renameat203.c is left with an unfinished TODO in submitted code.

> +static void setup(void)
> +{
> +	// TODO
> +	fs_type = tst_fs_type(".");

Please do not leave a bare TODO in the final patch. Either finish whatever is missing or remove the comment.

minor: desc points to string literals, so this should be const char *.

> +struct tcase {
> +	const char *newpath;
> +	int flags;
> +	int exp_errno;
> +	char *desc;

minor: the macro ordering is a bit confusing here:

> +#define TEST_PATH TEST_DIR TEST_FILE
> +#define TEST_PATH2 TEST_DIR2 TEST_FILE2
> +
> +#define TEST_FILE "test_file"
> +#define TEST_FILE2 "test_file2"

This works because macro expansion is lazy, but it reads backwards. Please define TEST_FILE/TEST_FILE2 before the TEST_PATH helpers.

nit: LTP subjects usually omit the .c suffix, so I would expect:

> renameat201: Rewrite into new API, split into renameat203

Commit message nits:
- "lets keep" -> "let's keep"
- "Due cdd1fedf8261c" -> "Due to cdd1fedf8261c"
- "defacto" -> "de facto"
- "somehow covered" is vague; "also covered" would read better

---
[PATCH 2/3] renameat202.c: Rewrite into new API

nit: typo in the test description.

>  * Verify that :manpage:`renameat2(2)` with RENAME_EXCHANGE swapps the content.

"swapps" -> "swaps"

nit: same subject style comment as patch 1; I'd drop the .c suffix:

> renameat202: Rewrite into new API

Commit message nits:
- "Due cdd1fedf8261c" -> "Due to cdd1fedf8261c"
- "defacto" -> "de facto"
- "Again, as in previous commit," is weak context; I'd restate the actual constraint directly instead of referring back to the previous patch

---
[PATCH 3/3] lapi: Move renameat2.h into lapi/stdio.h

NACK: lapi/stdio.h is the wrong name for this fallback.

> +++ b/include/lapi/stdio.h

stdio.h means standard I/O. renameat2() is a rename syscall, not a stdio interface. Other lapi headers are named after the API they provide (execveat.h, close_range.h, fallocate.h, ...), so this really should be something like lapi/renameat2.h (or, less preferably, lapi/rename.h).

BUG: the fallback definition in a public header must be static inline.

> +#ifndef HAVE_RENAMEAT2
> +int renameat2(int olddirfd, const char *oldpath, int newdirfd,
> +				const char *newpath, unsigned int flags)
> +{
> +	return tst_syscall(__NR_renameat2, olddirfd, oldpath, newdirfd,
> +						newpath, flags);
> +}
> +#endif

All other lapi fallback wrappers use static inline. Without that, including this header in multiple translation units can produce multiple-definition linker failures. For a shared lapi header, that is a real bug and must be fixed before merge.

minor: these includes are not needed for the renameat2() fallback:

> +#include <stdio.h>
> +#include <stdint.h>

The old test-local header only needed config.h, lapi/syscalls.h and sys/types.h, and that is enough here too.

minor: once the header is renamed, the subject should probably be adjusted as well, since the patch does more than just "move renameat2.h"; it also updates the tests to include the new header.

---
So overall this is a NACK for now.

The must-fix items are:
1. add renameat203 to runtest/syscalls;
2. restore the btrfs/RENAME_EXCHANGE compatibility handling in renameat201;
3. rename lapi/stdio.h to something API-appropriate;
4. make the fallback wrapper static inline.

The rest are minor cleanups, but I would also fix them in the respin.

Thanks.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
