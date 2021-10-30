Return-Path: <SRS0=DQX/=PS=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E741EC433EF
	for <ltp@archiver.kernel.org>; Sat, 30 Oct 2021 06:12:26 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C892460F55
	for <ltp@archiver.kernel.org>; Sat, 30 Oct 2021 06:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C892460F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADFE63C6F20
	for <ltp@archiver.kernel.org>; Sat, 30 Oct 2021 08:12:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73FF63C6F15
 for <ltp@lists.linux.it>; Sat, 30 Oct 2021 08:12:11 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 365051401111
 for <ltp@lists.linux.it>; Sat, 30 Oct 2021 08:12:11 +0200 (CEST)
Received: by mail-io1-xd32.google.com with SMTP id q127so14179306iod.12
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 23:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+tx3J4YDiJv8Ml2rc9Jz+9Mg6Bpu/TyE6I+xJK3BdtU=;
 b=HtC2qijfX1870Do6RX5NHIhet49VFKUo/7SMmfmqnNU1M1zvcFFJ+iWpsAiVDVK4Nm
 LRgYLYAUq0C82NlOuWm8ZFmy4mUvQFJgOeyhFs+TdXHNA0IfzDQ2wZSG5eAbphBSFaqm
 0nGaVrYan8CPo9JM6PyVFxcO6J8p/gvdMpnUqh6VX6DjBy+vSpj5iBI/jGQpfQIqdmhm
 nvOMazfBeyYHywAgPwDr81+20TLlyRfQaxVywGvnR7F8lI9rjO6Tb5MhwU4iMrNFsDH7
 opBG4hOqxvMtE9evjATJSjXU7i2ASItzmq89b30wl5FdCLXu1IIYFsW7GOP3wMXRcyea
 c2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+tx3J4YDiJv8Ml2rc9Jz+9Mg6Bpu/TyE6I+xJK3BdtU=;
 b=e5TTbX3qwPDraf3BoqPj0lEt29iWkmUHZvzfNRbCHhUKdv7XuTi+dI81i3xRidXq8P
 Qv6e11DoVfup5Nw02gSjOjFMI9sFstJBE2LEXi0U7Lu5dvhiGpgX/A75WPPGkZiFO3Be
 L9Cokdm0bHFBmayIkncNSA2B9AI+vr4A1u8cSznLRhiXmyOwR+9IzBeW682pfOgbtDvZ
 PKdFnQH1G3ih2+ZTry+ZAKPuGTM9Fm4zf8t76MjTDn9J+bAfpRRJqug4bwEd/r3PcEeI
 EQWuG1zNGBKB2VyOexNVZHlp97llN10MLhbj9ky0VQ3bU4la9426oe5nINbkDsjYOuNa
 2/Ow==
X-Gm-Message-State: AOAM532kHfqia8H/9vGMtrCzQ42yZGnkC0iyadd9aN3ofNbAQJe2j92U
 AqhShz16iWK4XnjhgfHMvmuWX2PUmH21D6m/NzQ=
X-Google-Smtp-Source: ABdhPJyE5ab3UYfhtLCjFO6gog1byxOBOWebnHU18wcwrEQPCPzOmWNCgPLvZKGDksL06fdByjy726M9t1I65dGAahg=
X-Received: by 2002:a05:6638:2607:: with SMTP id
 m7mr11374582jat.136.1635574329846; 
 Fri, 29 Oct 2021 23:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-3-krisman@collabora.com>
In-Reply-To: <20211029211732.386127-3-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 30 Oct 2021 09:11:59 +0300
Message-ID: <CAOQ4uxhnNzfraGyMMNtipDgF2MuW2QCqsHR6jhPAgkFyP4h_ww@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/9] syscalls: fanotify: Add macro to require
 specific events
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sat, Oct 30, 2021 at 12:18 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Add a helper for tests to fail if an event is not available in the
> kernel.  Since some events only work with REPORT_FID or a specific
> class, update the verifier to allow those to be specified.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v1:
>   - Use SAFE_FANOTIFY_INIT instead of open coding. (Amir)
>   - Use FAN_CLASS_NOTIF for fanotify12 testcase. (Amir)
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h   | 17 ++++++++++++++---
>  testcases/kernel/syscalls/fanotify/fanotify03.c |  4 ++--
>  testcases/kernel/syscalls/fanotify/fanotify10.c |  3 ++-
>  testcases/kernel/syscalls/fanotify/fanotify12.c |  3 ++-
>  4 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index c67db3117e29..820073709571 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -266,14 +266,16 @@ static inline void require_fanotify_access_permissions_supported_by_kernel(void)
>         SAFE_CLOSE(fd);
>  }
>
> -static inline int fanotify_events_supported_by_kernel(uint64_t mask)
> +static inline int fanotify_events_supported_by_kernel(uint64_t mask,
> +                                                     unsigned int init_flags,
> +                                                     unsigned int mark_flags)
>  {
>         int fd;
>         int rval = 0;
>
> -       fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> +       fd = SAFE_FANOTIFY_INIT(init_flags, O_RDONLY);
>
> -       if (fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, ".") < 0) {
> +       if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, ".") < 0) {
>                 if (errno == EINVAL) {
>                         rval = -1;
>                 } else {
> @@ -378,4 +380,13 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
>                                     fanotify_mark_supported_by_kernel(mark_type)); \
>  } while (0)
>
> +#define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
> +       if (mark_type)                                                  \
> +               REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type);       \
> +       if (init_flags)                                                 \
> +               REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(init_flags, fname); \
> +       fanotify_init_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
> +               fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
> +} while (0)
> +
>  #endif /* __FANOTIFY_H__ */
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> index 26d17e64d1f5..2081f0bd1b57 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> @@ -323,8 +323,8 @@ static void setup(void)
>         require_fanotify_access_permissions_supported_by_kernel();
>
>         filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
> -       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM);
> -
> +       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM,
> +                                                                     FAN_CLASS_CONTENT, 0);
>         sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
>         SAFE_FILE_PRINTF(fname, "1");
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index 92e4d3ff3054..0fa9d1f4f7e4 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -509,7 +509,8 @@ cleanup:
>
>  static void setup(void)
>  {
> -       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> +       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> +                                                                     FAN_CLASS_CONTENT, 0);
>         filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
>         fan_report_dfid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
>                                                                           MOUNT_PATH);
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
> index 76f1aca77615..c77dbfd8c23d 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify12.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
> @@ -222,7 +222,8 @@ cleanup:
>
>  static void do_setup(void)
>  {
> -       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> +       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> +                                                                     FAN_CLASS_NOTIF, 0);
>
>         sprintf(fname, "fname_%d", getpid());
>         SAFE_FILE_PRINTF(fname, "1");
> --
> 2.33.0
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
