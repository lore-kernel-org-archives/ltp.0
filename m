Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F8CC4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 15:37:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDE7D3CB1AE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 17:37:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CD193CB05B
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 17:37:05 +0200 (CEST)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A8084601477
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 17:37:04 +0200 (CEST)
Received: by mail-ua1-x931.google.com with SMTP id t26so9735697uaj.9
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6YCq+59zHSmhbtQiRat8ITFxx2KYaG5XnXUutVYXGOs=;
 b=qhjiN5r1oVSnX2vOsRb3QRcEr7u3WzrkBEuaflOlDad/ndzC3hhY2U/SuqGr1kKUFk
 CP5rarG8VQAsuXulBQpN9WhFqXbV7vGIv5JcQd19B/FUcgNXPbYOVAoRFix352ZINxm3
 2c1XgY6xz5MGHc6ULklJRRUNd4T3oU4bYnMXOY7Wh8GcYEbFBfoNixWBFPzcaGfUHpIU
 8Jjs7aGeU44s1qTEqPXoA1LnjqGbTaUtoc7gz1C9aXxfND4UqK0hB3YegCBc2jGlDEKC
 RtqCkI4WMej01+IlJkNj3EyKWxbbty2yDoUSw5S7AGQtDTu8d727HN+JUR0yY/QiC4hS
 ur5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6YCq+59zHSmhbtQiRat8ITFxx2KYaG5XnXUutVYXGOs=;
 b=0rr5286//W4IRSeAsu3JfnT675vGJHi1rHl96WAOezJMQ7TI9s7NLYb4GCBEvEHHA2
 MXfLJoAZLj+emjpoXkLHQ5BD5GEPq1Dpp6OGcRyf8oDhHQDCl+Lle9lopt7A/vGyo2YF
 9HnbC+Qx+HyTrP8zWMB/BrB2tGCauxXIs5Wd+NolKyp9JZHhUEeHPdosJS/2vYi0f7wi
 aTid+xcyX81ZSBS2sBi8ysOgJmgmmAsWri7bv2+W+YwpROjE6N8W4IoefDcS8bdINOLl
 R0dLFOFpIqxA48Mtp/a+NT0ctMLaME0VRS8XyiSpmq299S5PgRnbrcvUJ8VEUvymDYNs
 42rA==
X-Gm-Message-State: ACrzQf29lAwum6hD8uy5om6iUGEmzwRQf/xFd0q+oFBOajJ5aQTJCye+
 2IWIMFiExz/aUzD3db3J9TYy7LTkF2KTJGkmJo/26nSy
X-Google-Smtp-Source: AMsMyM4VGaLefwpRCxKODDHAxXAVGqaGp2GJDaNjQJz3i4xIg9wIwhhlz47u7FF/3EF+XHTlTjxSDIZxVKu6Ib/6iLs=
X-Received: by 2002:ab0:6413:0:b0:3e1:b113:2dfa with SMTP id
 x19-20020ab06413000000b003e1b1132dfamr8350461uao.102.1666280223411; Thu, 20
 Oct 2022 08:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221020130843.15147-1-mdoucha@suse.cz>
 <20221020130843.15147-3-mdoucha@suse.cz>
In-Reply-To: <20221020130843.15147-3-mdoucha@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Oct 2022 18:36:51 +0300
Message-ID: <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add fanotify_get_supported_init_flags()
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

On Thu, Oct 20, 2022 at 4:08 PM Martin Doucha <mdoucha@suse.cz> wrote:
>
> Since FAN_ALL_INIT_FLAGS constant is deprecated, the kernel has added
> new fanotify feature flags and there is no other way to check
> for their support, we need to manually check which init flags needed
> by our tests are available.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>
> Changes since v1:
> - Fixed check for FAN_REPORT_NAME
> - Added longer patch description
>
> Thanks for pointing out the flag dependency between FAN_REPORT_NAME and
> FAN_REPORT_DIR_FID. I must have misread the documentation on that one.
> Since this appears to be the only flag with a dependency for now, let's
> keep the special handling simple. If the kernel adds more flags that are
> invalid on their own, we should handle that using a table.
>
> These flag support checks will be needed in multiple tests so it's better
> to have one common function that'll do them in one call than to copy-paste
> multiple setup steps from one test to another.
>
> Though it'd be great if kernel itself would provide a syscall that returns
> all supported fanotify init, mark or mask flags in one call.
>
>  testcases/kernel/syscalls/fanotify/fanotify.h | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 51078103e..f3ac1630f 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -213,6 +213,32 @@ static inline int fanotify_init_flags_supported_by_kernel(unsigned int flags)
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
> +       unsigned int flg, arg, ret = 0;
> +
> +       for (flg = 1; flg; flg <<= 1) {
> +               if (!(flags & flg))
> +                       continue;
> +
> +               arg = flg;
> +
> +               // FAN_REPORT_NAME is invalid without FAN_REPORT_DIR_FID
> +               if (flg == FAN_REPORT_NAME)
> +                       arg |= FAN_REPORT_DIR_FID;
> +

NACK
this is not the only dependency
this is not a valid generic function.

I only gave a recipe in v1 review how I think the checks should be done.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
