Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC53C61DA4
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 08:31:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71CF13CC36D
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 09:31:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 460883CB246
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 09:31:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 93AE020013D
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 09:31:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675413059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FFkZZ8jsLFnXJDbu7FrwbMferagV1ii4TNBPN8LeaXg=;
 b=hhfRSwYsnLSvmC4sSMhdVWY3HwiSGF/5vWapVbYPnlG6s+qDnvq3vKOl52PRfxChXYUhm5
 elHRlv0lJ2E3/MiJvs8klOct35OASlczrazKv0Hy1m6ylAaNa9HzOgh0Qu2t5YhWupzXZA
 SZxwyOOmOBmD00NuLR/kNuO2iOi081A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-193-_bwZ1gUvNrqoS1hRle0-pA-1; Fri, 03 Feb 2023 03:30:55 -0500
X-MC-Unique: _bwZ1gUvNrqoS1hRle0-pA-1
Received: by mail-wm1-f71.google.com with SMTP id
 j20-20020a05600c1c1400b003dc5dd44c0cso2277061wms.8
 for <ltp@lists.linux.it>; Fri, 03 Feb 2023 00:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FFkZZ8jsLFnXJDbu7FrwbMferagV1ii4TNBPN8LeaXg=;
 b=Sbuvog0E1ycNPv6ROEvgKU52VRsOeUov1dyZlBDsqUDFyzKwVpgYdfW0eYnxHE0mUf
 GxLHqbZOl3/5Q1pbqLwiqF9RjzMIH6R9l0w7OY6XE3bMVkKhWCB+b7PxC0iQASepPRHV
 /um9W2TQuYUFax9h5nnZrAcgyePtc6/V2nPGGgpsDwh+IjQ8pXoXgt139mNjMnDCAz4Z
 b1hV+8QSLdpzZYkx/gk8WsVv/NWzUYKnzMAdDmygXKDYcs7NWz4Bx446+6p0en4WqQRO
 hXYNtIHFM7CrAwPFioF7fTOMGmEwQfGVpWmANjV6XpAbqSPlbYgjcEhE05r5KOadFD26
 tYyw==
X-Gm-Message-State: AO0yUKWBghyMa3kqnM0D1xjT3kSDcKv7egAWfeQF/YY/1/mKtag4uoq/
 k48ZXsXNA1iCJMrSErROoIHtAVwRbPhd1xlkP/EXv5htYzxlgtvSVNbvaWzFgKXoOgM2M9R1osB
 Zc09FEFSQO16W2TpcQMugqfqgQ+4=
X-Received: by 2002:a5d:4e42:0:b0:2bf:b1a5:ffd8 with SMTP id
 r2-20020a5d4e42000000b002bfb1a5ffd8mr241529wrt.129.1675413054455; 
 Fri, 03 Feb 2023 00:30:54 -0800 (PST)
X-Google-Smtp-Source: AK7set8VPRWL+RUsI/9/tGr1aIKG7tco6qTgy68DYnkGV/vT7+VgYLP9+cxqVgQNJ6YQIGQFYT5x6sxaKUCP5gp9acs=
X-Received: by 2002:a5d:4e42:0:b0:2bf:b1a5:ffd8 with SMTP id
 r2-20020a5d4e42000000b002bfb1a5ffd8mr241526wrt.129.1675413054245; Fri, 03 Feb
 2023 00:30:54 -0800 (PST)
MIME-Version: 1.0
References: <20230131002532.459456-1-edliaw@google.com>
In-Reply-To: <20230131002532.459456-1-edliaw@google.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 3 Feb 2023 16:30:42 +0800
Message-ID: <CAEemH2eqaSi2Zb0nuKi_0ao90V10BYPnOKO6As2kq+76++Z0EQ@mail.gmail.com>
To: Edward Liaw <edliaw@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] close_range: check for kernel support below 5.9
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward, Petr,

Sorry for the late append reply.

On Tue, Jan 31, 2023 at 8:25 AM Edward Liaw via ltp <ltp@lists.linux.it>
wrote:

> Check for close_range syscall support in the kernel before running
> close_range01 and close_range02 tests.
>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  include/lapi/close_range.h                          | 13 +++++++++++++
>  .../kernel/syscalls/close_range/close_range01.c     |  2 ++
>  .../kernel/syscalls/close_range/close_range02.c     |  1 +
>  3 files changed, 16 insertions(+)
>
> diff --git a/include/lapi/close_range.h b/include/lapi/close_range.h
> index 19db52d3d..0e464bb30 100644
> --- a/include/lapi/close_range.h
> +++ b/include/lapi/close_range.h
> @@ -25,4 +25,17 @@ static inline int close_range(unsigned int fd, unsigned
> int max_fd,
>         return tst_syscall(__NR_close_range, fd, max_fd, flags);
>  }
>  # endif
> +
> +static inline void close_range_supported_by_kernel(void)
> +{
> +       long ret;
> +
> +       if ((tst_kvercmp(5, 9, 0)) < 0) {
>

Using tst_kvercmp together with ENOSYS check is a repetitive practice,
I think verifying the returned value and errno is quite enough to determine
an un-support syscall.

And there is possible a lite kernel version newer than 5.9 removes this
syscall support. Then this test will fail again because this tst_kvercmp
skips the ENOSYS check.

Otherwise:
Reviewed-by: Li Wang <liwang@redhat.com>



> +               /* Check if the syscall is backported on an older kernel */
> +               ret = syscall(__NR_close_range, 1, 0, 0);
> +               if (ret == -1 && errno == ENOSYS)
> +                       tst_brk(TCONF, "Test not supported on kernel
> version < v5.9");
> +       }
> +}
> +
>  #endif /* LAPI_CLOSE_RANGE_H__ */
> diff --git a/testcases/kernel/syscalls/close_range/close_range01.c
> b/testcases/kernel/syscalls/close_range/close_range01.c
> index 30bb600b6..072bbab66 100644
> --- a/testcases/kernel/syscalls/close_range/close_range01.c
> +++ b/testcases/kernel/syscalls/close_range/close_range01.c
> @@ -53,6 +53,8 @@ static inline void do_close_range(unsigned int fd,
> unsigned int max_fd,
>
>  static void setup(void)
>  {
> +       close_range_supported_by_kernel();
> +
>         struct rlimit nfd;
>
>         SAFE_GETRLIMIT(RLIMIT_NOFILE, &nfd);
> diff --git a/testcases/kernel/syscalls/close_range/close_range02.c
> b/testcases/kernel/syscalls/close_range/close_range02.c
> index aec899261..2aa6d2c9f 100644
> --- a/testcases/kernel/syscalls/close_range/close_range02.c
> +++ b/testcases/kernel/syscalls/close_range/close_range02.c
> @@ -111,4 +111,5 @@ static struct tst_test test = {
>         .tcnt = 6,
>         .forks_child = 1,
>         .test = run,
> +       .setup = close_range_supported_by_kernel,
>  };
> --
> 2.39.1.456.gfc5497dd1b-goog
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
