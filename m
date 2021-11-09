Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCB4C433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:05:41 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DEF61051
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12DEF61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 310723C07BA
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 12:05:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7669D3C0431
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 12:05:28 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DA89C1A0036B
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 12:05:27 +0100 (CET)
Received: by mail-io1-xd2f.google.com with SMTP id w22so8026507ioa.1
 for <ltp@lists.linux.it>; Tue, 09 Nov 2021 03:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bBnhJGrRYNXyQVAlHlBNPtATuU2w9RwjrNsONS8AXFQ=;
 b=Mlt2zOHcm7nn/yxgM6INxjXZSqabXn1CjXiQGW9Uf8pH9tsHZRbyuc1qel7ObggGqd
 0j245aEMVuah7WRzMwfN5GhPBx+0xlJUmNS9obog6xfCvx5rJj9G61UGmeXP7Kr276Jv
 cCvEUvE5bUhX98hXx72CN8qtmq0nEFvWgKzA9w34XVMexmZGXkyrPdVJWD1xcX8+z+xI
 QROEBahVUOfTBsMAY6pS+F6YAv7zyzT/FRZTmXQIqQHMvYk3eltv/G0tLRUkdzAbknIb
 f6UL4V9cyRtRo5px7VvMFrpwMA+HXyaeKQCLBlM1RRj1LCXX5bccKxAVqmS2xZMpM6Ph
 KidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bBnhJGrRYNXyQVAlHlBNPtATuU2w9RwjrNsONS8AXFQ=;
 b=IjDHCZpeTH7kPKHHgtRV2oEvHz7HU2gjuhu0RWfrpnAOG9WwbgeMEaMNs29SrJFjOx
 MWhXLWFbA2y3Is4eqQB4Tj4G3vzgU/D6xCKQjXjnbkVxkUnZBZS/w/aaDXAXjLnrd0iS
 C0IcHgDARr3oUIoSN8YEsglw4gG2zrn/tQCo4kVBtcBPgY8kxBD4saxdyEeqCC/b2Add
 MlugcX6YWfDiVAfQaTNwR68zqU58SslYqusM867bmD25BbE5it8zMUWIoAsiKIWCK42m
 zmFyFFCL3jGbRwhYL/fOqFT/G/VHi4W2i1iODW5BQXSKOVUj6PbRfjFQZoI93li1hXIS
 k9+Q==
X-Gm-Message-State: AOAM533amGSJ2RYvwmg6h3qVXs2Kq4LitqWxTJMnA1s+Eq82Epky/2i8
 Bzci8eDfTr/GiYqI6XoF+te1M+rT+m6GfkC5mZk=
X-Google-Smtp-Source: ABdhPJwepbfPtxzIC56avzdDcESKM9YGjZELkLxCI2vY0D99o3BRAIuAC9CN8AKKZQLPYaoee0Vq/4LtLkJrzR41wCY=
X-Received: by 2002:a02:a489:: with SMTP id d9mr4725438jam.47.1636455926614;
 Tue, 09 Nov 2021 03:05:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1636451496.git.repnop@google.com>
 <0671d89befb5b24fc3bac510c69811668c39cdf5.1636451496.git.repnop@google.com>
In-Reply-To: <0671d89befb5b24fc3bac510c69811668c39cdf5.1636451496.git.repnop@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 9 Nov 2021 13:05:15 +0200
Message-ID: <CAOQ4uxiFsnvA-8y1mJ7uHccd4bqZUYJkK5Y2R1+KtgDK_OH4Sw@mail.gmail.com>
To: Matthew Bobrowski <repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] syscalls/fanotify: Add a helper macro
 which checks for the presence of specific fanotify initialization flag(s)
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 9, 2021 at 12:05 PM Matthew Bobrowski <repnop@google.com> wrote:
>
> This is a trivial macro that can be used throughout fanotify tests to
> check whether the underlying running kernel supports the supplied
> fanotify initialization flag(s).
>
> Signed-off-by: Matthew Bobrowski <repnop@google.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index a2be18338..e2db3c6f5 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -352,6 +352,11 @@ static inline void fanotify_init_flags_err_msg(const char *flags_str,
>                 fanotify_init_flags_supported_on_fs(flags, fname)); \
>         } while (0)
>
> +#define REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL(flags) do { \
> +       fanotify_init_flags_err_msg(#flags, __FILE__, __LINE__, tst_brk_, \
> +               fanotify_init_flags_supported_by_kernel(flags)); \
> +       } while (0)
> +
>  static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
>  {
>         int fd;
> --
> 2.34.0.rc0.344.g81b53c2807-goog
>
> /M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
