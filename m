Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABC4C433FE
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 06:51:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4F2D3CAF18
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 08:51:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30C743CAB0D
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 08:50:55 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8CC741A006B9
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 08:50:54 +0200 (CEST)
Received: by mail-ua1-x935.google.com with SMTP id d3so1598183uav.7
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 23:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4g6iXEHfCzH6tpEsuyyXCy39Xugl4WXD+IlKLxRT854=;
 b=byX46et+UH22QI3EVLRuEDmHIg4y4Kz1a5L+YkVVaZ3ebb616GXtkoaUV7VmI6FdRS
 hmt7uofYEx0qfLtD8LdBy6Wby9PaPrWv+zD4OMa8DNma50lCvNGbTlot+BVICsXWhqd7
 9DeUTGFamWDwbH2ufOAAAAqavMqvBITxQNMqr98VKeb5JA07a8L/uuPv5LL/OBksFwqK
 +c1WvJDBhi7OCnXPVbqqrMetH+uFzLX2Q08y35MAk9SoXKaxfEkJEHVYutekEKonrhA9
 6jM99whbAv7p1RxqPsBrsRyzqfmQVUFm3ef5U1Zhajeb/vvgh0bHwiGWTmOnB22aTm/n
 YfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4g6iXEHfCzH6tpEsuyyXCy39Xugl4WXD+IlKLxRT854=;
 b=NUdrugam9D81dM2qcbxF+GyZMcEA3kia9pkSuJr5CUxPrLwMXRtZBvWUtQzo4ZhaqB
 izQ/Oyzi/yqXHzdmtIcr1Laso0pfULlEp3bXkDPpCnpDEJvLQvfOFrfhs6f2UmrD3yPg
 V7ZDksK3MhEAcFq2KSnnGs/pkti8NP98/qbLiS26GEMbGh60RoiOANPG4VrYWPSnkIr2
 M+d1dUw6ECZ1zUOgsmMvv/k3CtdSGEmxDFmOK2943khUCXzN1np0AZdlf3GhF8Gg7/pi
 GjKcUY3/8r+SaEiRw/vBVXqOuw9bbxfaMU8TNy4bQvIdjYTY+jNXUSh93BIWs9vpPTJm
 wBpQ==
X-Gm-Message-State: ACrzQf3Uz+bszPAeJn13Nvg6qEuNdgvTM75fouUOSILImjubv7/x18w9
 6PYYEMGlbXFSv6/99lB7+1s7P90pebRshy1N4uA=
X-Google-Smtp-Source: AMsMyM63YmqVLEk8fkYS05+nRLRkRY7cz2YH+hZm86P/Wzhcmkc0kbILp3hJhUFBFJt9DYNNgqOgVeBgPKvPzgX3De8=
X-Received: by 2002:ab0:4715:0:b0:3ea:d249:de4c with SMTP id
 h21-20020ab04715000000b003ead249de4cmr1854386uac.80.1665730253347; Thu, 13
 Oct 2022 23:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221013154935.20461-1-mdoucha@suse.cz>
 <20221013154935.20461-4-mdoucha@suse.cz>
In-Reply-To: <20221013154935.20461-4-mdoucha@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 14 Oct 2022 09:50:41 +0300
Message-ID: <CAOQ4uxhnyX70QVOgyAa=_zXK=6LT0W+xv7UJ_-WPzgyWuXojEQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] Add fanotify_get_supported_init_flags()
 helper function
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Oct 13, 2022 at 6:49 PM Martin Doucha <mdoucha@suse.cz> wrote:
>

Hi Martin,

Please refrain from empty commit messages.
The text in your cover letter would have been useful in this commit message
and in the commit message of patch 4/4.
If it were me, I would squash those two patches
to emphasise the usability aspect of this helper, but up to you.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 51078103e..43434f6ac 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -213,6 +213,26 @@ static inline int fanotify_init_flags_supported_by_kernel(unsigned int flags)
>         return fanotify_init_flags_supported_on_fs(flags, NULL);
>  }
>
> +/*
> + * Check support of given init flags one by one and return those which are
> + * supported.
> + */
> +static inline unsigned int fanotify_get_supported_init_flags(unsigned int flags,
> +       const char *fname)
> +{
> +       unsigned int flg, ret = 0;
> +
> +       for (flg = 1; flg; flg <<= 1) {
> +               if (!(flags & flg))
> +                       continue;
> +
> +               if (!fanotify_init_flags_supported_on_fs(flg, fname))
> +                       ret |= flg;
> +       }
> +
> +       return ret;
> +}
> +

I am afraid that you have tried to generalize too much.
As a generic helper, this is wrong code, because in many cases
init flags depend on each other, for example,
FAN_REOPRT_NAME is not supported without FAN_REPORT_FID
so the test for support on every single bit independently is plain wrong.

If the code would have checked:

    fanotify_init_flags_supported_on_fs(ret | flg, fname))

It would have least been correct for the private case on fanotify
which tests the support for the flag combination
FAN_REPORT_DFID_NAME_TARGET

But the general helper would still be incorrect.

The reason that the helper would work for fanotify14
is because the chronological order in which kernel support was
added to flags (_FID, _DIR_FID, _NAME, _TARGE_FID)
matches the order of the flag bits.

So my recommendation is not to attempt to guess the
supported flag combinations, but test the relevant flag
combinations explicitly.

1. Change the return value of fanotify_init_flags_supported_on_fs()
    to <the set of supported flags> or 0
2. Change all code if (fan_report_*_unsupported) to if (!fan_report_*_supported)
    or better yet if (tc->init_flags & ~fan_report_*_supported) as in patch 4/4
3. fanotify14 setup() code would then look like this:

-        /* Require FAN_REPORT_FID support for all tests to simplify
per test case requirements */
-        REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, MNTPOINT);
-
-       fan_report_target_fid_unsupported =
-
fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME_TARGET,
MNTPOINT);
+       supported_init_flags =
fanotify_init_flags_supported_on_fs(FAN_REPORT_FID,
+               MNTPOINT);
+       supported_init_flags |=
fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
+               MNTPOINT);
+       supported_init_flags |=
fanotify_init_flags_supported_on_fs(FAN_REPORT_TARGET_FID,
+               MNTPOINT);

Checking these combinations is sufficient and is more readable IMO.
This approach makes extending tests easy.

In the development history of fanotify14, commit 9df7f38c8
  syscalls/fanotify14: Test cases for FAN_REPORT_DFID_NAME
would have added the setup check for supported FAN_REPORT_DFID_NAME

and commit 66d406407
  syscalls/fanotify14: Add tests for FAN_REPORT_TARGET_FID and FAN_RENAME
would have added the setup check for supported FAN_REPORT_TARGET_FID

But the check for supported flags per test case would not need to change
if it was generic like in patch 4/4.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
