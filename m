Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D0FC433FE
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 05:50:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AA583CC5A8
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 06:50:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93D913CC595
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 06:50:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6BD626005E0
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 06:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669701039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHJu+3hUggQbj3RHdNHGsndK1eoolNQFT6ECgNU7W+U=;
 b=VaeUrBFaTVMSC1nLdA1nF+pZ9Iwms0QUx7V0+fDqVGnwjW+cdbDfjQSB81Vv5ugY+c5qk4
 bPaXKGBB8VWO0+DRZK1MDrKsSQG/fcUBItxr96NJgEmLyzSBbhZr5eF/h+fJHvd/oeqQxh
 kAPqTpBxdrHBfA9L6hBVCsk46vGNPEI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-253-jKajsY7cMseeec1yLPClAA-1; Tue, 29 Nov 2022 00:50:37 -0500
X-MC-Unique: jKajsY7cMseeec1yLPClAA-1
Received: by mail-wm1-f69.google.com with SMTP id
 b47-20020a05600c4aaf00b003d031aeb1b6so9628281wmp.9
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 21:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QHJu+3hUggQbj3RHdNHGsndK1eoolNQFT6ECgNU7W+U=;
 b=tXt2t1mJ5XvKU78LXGozF2Ln05FhDwMRRmGqmrTvS+2gB+QVU5nA8upxX0myuwCpkx
 2knyLWkm77BMOiAxICPByna7q5RfwDSLAQv3PGBWkY8x7jDmuYMDNfsuNKjm32xwRcQ5
 UnAeDDDzPm72qUsCJlgVIffxkVwilu0qXTW6z/yJsbl+yLkxn53z9WRkDS5aidfmZl82
 knJd+nv2Hp2gbWdj457tTz9in3okU7KGgfARxI0hd//WHa1h3gPcwrTFlKwS1aLDzoyk
 WUELlUAKdd3yXi6J4+92xnOmeZ2r2lvRBUTLIpvxb8Z8PNuVBy5zn0RnnsQlyK3XvNjh
 thog==
X-Gm-Message-State: ANoB5plFhEU9va9jUa5YN/C7/FPDB5ud/zmu/niC+GeWWAjFnFYVvq0g
 +HQ9sFxCh5z7mWxW0bTPLmGjJmq0vzY+9rHHNhiRPb5x/NDiYpJIFhH9yKs6FFjNsmbJ0QlHO/V
 /kP/+FGQh0MGxznWNJ3axROe91ks=
X-Received: by 2002:adf:f011:0:b0:241:c78c:3671 with SMTP id
 j17-20020adff011000000b00241c78c3671mr27907670wro.129.1669701036114; 
 Mon, 28 Nov 2022 21:50:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5eFvQWQd/7gCSvOnYMZzF6YwqdvJdLVCKkAwixf/T9U8tiEv1/2zig+AeD+Gl50I2nnNzuhwJbeEK7DVV0TX8=
X-Received: by 2002:adf:f011:0:b0:241:c78c:3671 with SMTP id
 j17-20020adff011000000b00241c78c3671mr27907661wro.129.1669701035842; Mon, 28
 Nov 2022 21:50:35 -0800 (PST)
MIME-Version: 1.0
References: <1669704060-5635-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1669704060-5635-2-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1669704060-5635-2-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 29 Nov 2022 13:50:24 +0800
Message-ID: <CAEemH2cURWwmhDTL2CeAsDZnoRp=HtA-Ww8T43+5Cy29VmxCcA@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] include/lapi/sched.h: Move lapi/clone.h
 into here
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
Content-Type: multipart/mixed; boundary="===============1688160538=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1688160538==
Content-Type: multipart/alternative; boundary="0000000000001f718c05ee959139"

--0000000000001f718c05ee959139
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 29, 2022 at 1:40 PM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:

> Like namespaces_constants.h, kernel doesn't have
> clone.h header. We can also move it into here.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>



> ---
> This patch has been verified on my ltp fork[1].
> [1]
> https://github.com/xuyang0410/ltp/actions/runs/3571298308/jobs/6003048080
>  include/lapi/clone.h                          | 56 -------------------
>  include/lapi/sched.h                          | 31 ++++++++++
>  lib/tst_clone.c                               |  2 +-
>  testcases/kernel/containers/pidns/pidns13.c   |  2 +-
>  testcases/kernel/containers/userns/userns08.c |  2 +-
>  testcases/kernel/syscalls/clone3/clone301.c   |  2 +-
>  testcases/kernel/syscalls/clone3/clone302.c   |  2 +-
>  .../syscalls/close_range/close_range01.c      |  2 +-
>  .../syscalls/close_range/close_range02.c      |  2 +-
>  9 files changed, 38 insertions(+), 63 deletions(-)
>  delete mode 100644 include/lapi/clone.h
>
> diff --git a/include/lapi/clone.h b/include/lapi/clone.h
> deleted file mode 100644
> index 437d1376f..000000000
> --- a/include/lapi/clone.h
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright (c) 2020 Linaro Limited. All rights reserved.
> - * Author: Viresh Kumar <viresh.kumar@linaro.org>
> - */
> -
> -#ifndef LAPI_CLONE_H__
> -#define LAPI_CLONE_H__
> -
> -#include <sys/syscall.h>
> -#include <linux/types.h>
> -#include <sched.h>
> -#include <stdint.h>
> -
> -#include "config.h"
> -#include "lapi/syscalls.h"
> -
> -#ifndef HAVE_CLONE3
> -struct clone_args {
> -       uint64_t __attribute__((aligned(8))) flags;
> -       uint64_t __attribute__((aligned(8))) pidfd;
> -       uint64_t __attribute__((aligned(8))) child_tid;
> -       uint64_t __attribute__((aligned(8))) parent_tid;
> -       uint64_t __attribute__((aligned(8))) exit_signal;
> -       uint64_t __attribute__((aligned(8))) stack;
> -       uint64_t __attribute__((aligned(8))) stack_size;
> -       uint64_t __attribute__((aligned(8))) tls;
> -};
> -
> -static inline int clone3(struct clone_args *args, size_t size)
> -{
> -       return tst_syscall(__NR_clone3, args, size);
> -}
> -#endif
> -
> -#ifndef CLONE_PIDFD
> -#define CLONE_PIDFD    0x00001000      /* set if a pidfd should be placed
> in parent */
> -#endif
> -
> -#ifndef CLONE_NEWUSER
> -# define CLONE_NEWUSER 0x10000000
> -#endif
> -
> -static inline void clone3_supported_by_kernel(void)
> -{
> -       long ret;
> -
> -       if ((tst_kvercmp(5, 3, 0)) < 0) {
> -               /* Check if the syscall is backported on an older kernel */
> -               ret = syscall(__NR_clone3, NULL, 0);
> -               if (ret == -1 && errno == ENOSYS)
> -                       tst_brk(TCONF, "Test not supported on kernel
> version < v5.3");
> -       }
> -}
> -
> -#endif /* LAPI_CLONE_H__ */
> diff --git a/include/lapi/sched.h b/include/lapi/sched.h
> index 3b0b4be31..1d22a9d7e 100644
> --- a/include/lapi/sched.h
> +++ b/include/lapi/sched.h
> @@ -11,6 +11,7 @@
>  #include <unistd.h>
>  #include <stdint.h>
>  #include <inttypes.h>
> +#include "config.h"
>  #include "lapi/syscalls.h"
>
>  struct sched_attr {
> @@ -43,6 +44,32 @@ static inline int sched_getattr(pid_t pid, struct
> sched_attr *attr,
>         return syscall(__NR_sched_getattr, pid, attr, size, flags);
>  }
>
> +#ifndef HAVE_CLONE3
> +struct clone_args {
> +       uint64_t __attribute__((aligned(8))) flags;
> +       uint64_t __attribute__((aligned(8))) pidfd;
> +       uint64_t __attribute__((aligned(8))) child_tid;
> +       uint64_t __attribute__((aligned(8))) parent_tid;
> +       uint64_t __attribute__((aligned(8))) exit_signal;
> +       uint64_t __attribute__((aligned(8))) stack;
> +       uint64_t __attribute__((aligned(8))) stack_size;
> +       uint64_t __attribute__((aligned(8))) tls;
> +};
> +
> +static inline int clone3(struct clone_args *args, size_t size)
> +{
> +       return tst_syscall(__NR_clone3, args, size);
> +}
> +#endif
> +
> +static inline void clone3_supported_by_kernel(void)
> +{
> +       if ((tst_kvercmp(5, 3, 0)) < 0) {
> +               /* Check if the syscall is backported on an older kernel */
> +               tst_syscall(__NR_clone3, NULL, 0);
> +       }
> +}
> +
>  #ifndef SCHED_DEADLINE
>  # define SCHED_DEADLINE        6
>  #endif
> @@ -55,6 +82,10 @@ static inline int sched_getattr(pid_t pid, struct
> sched_attr *attr,
>  # define CLONE_FS      0x00000200
>  #endif
>
> +#ifndef CLONE_PIDFD
> +# define CLONE_PIDFD   0x00001000
> +#endif
> +
>  #ifndef CLONE_NEWNS
>  # define CLONE_NEWNS   0x00020000
>  #endif
> diff --git a/lib/tst_clone.c b/lib/tst_clone.c
> index 07e7f0767..ecc84408c 100644
> --- a/lib/tst_clone.c
> +++ b/lib/tst_clone.c
> @@ -8,7 +8,7 @@
>  #include <stddef.h>
>
>  #include "tst_test.h"
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>
>  pid_t tst_clone(const struct tst_clone_args *tst_args)
>  {
> diff --git a/testcases/kernel/containers/pidns/pidns13.c
> b/testcases/kernel/containers/pidns/pidns13.c
> index 39fd6df7f..6a155027c 100644
> --- a/testcases/kernel/containers/pidns/pidns13.c
> +++ b/testcases/kernel/containers/pidns/pidns13.c
> @@ -31,7 +31,7 @@
>
>  #include "tst_test.h"
>  #include "tst_clone.h"
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>
>  static int pipe_fd[2];
>
> diff --git a/testcases/kernel/containers/userns/userns08.c
> b/testcases/kernel/containers/userns/userns08.c
> index afdad6cad..2697d874b 100644
> --- a/testcases/kernel/containers/userns/userns08.c
> +++ b/testcases/kernel/containers/userns/userns08.c
> @@ -25,7 +25,7 @@
>
>  #include "tst_test.h"
>  #include "tst_clone.h"
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>  #include "tst_safe_file_at.h"
>
>  static pid_t clone_newuser(void)
> diff --git a/testcases/kernel/syscalls/clone3/clone301.c
> b/testcases/kernel/syscalls/clone3/clone301.c
> index f7ef0b2d7..d0fadbc5d 100644
> --- a/testcases/kernel/syscalls/clone3/clone301.c
> +++ b/testcases/kernel/syscalls/clone3/clone301.c
> @@ -15,7 +15,7 @@
>  #include <sys/wait.h>
>
>  #include "tst_test.h"
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>  #include "lapi/pidfd.h"
>
>  #define CHILD_SIGNAL   SIGUSR1
> diff --git a/testcases/kernel/syscalls/clone3/clone302.c
> b/testcases/kernel/syscalls/clone3/clone302.c
> index 08d6417ce..b1b4ccebb 100644
> --- a/testcases/kernel/syscalls/clone3/clone302.c
> +++ b/testcases/kernel/syscalls/clone3/clone302.c
> @@ -14,7 +14,7 @@
>  #include <stdlib.h>
>
>  #include "tst_test.h"
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>
>  static struct clone_args *valid_args, *invalid_args;
>  unsigned long stack;
> diff --git a/testcases/kernel/syscalls/close_range/close_range01.c
> b/testcases/kernel/syscalls/close_range/close_range01.c
> index 5e2de4d1e..30bb600b6 100644
> --- a/testcases/kernel/syscalls/close_range/close_range01.c
> +++ b/testcases/kernel/syscalls/close_range/close_range01.c
> @@ -28,7 +28,7 @@
>  #include "tst_test.h"
>  #include "tst_clone.h"
>
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>  #include "lapi/close_range.h"
>
>  static int fd[3];
> diff --git a/testcases/kernel/syscalls/close_range/close_range02.c
> b/testcases/kernel/syscalls/close_range/close_range02.c
> index bd46936bb..aec899261 100644
> --- a/testcases/kernel/syscalls/close_range/close_range02.c
> +++ b/testcases/kernel/syscalls/close_range/close_range02.c
> @@ -18,7 +18,7 @@
>  #include "tst_clone.h"
>  #include "lapi/fcntl.h"
>  #include "lapi/close_range.h"
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>
>  static int try_close_range(int fd, int flags)
>  {
> --
> 2.23.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--0000000000001f718c05ee959139
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Nov 29, 2022 at 1:40 PM Yang Xu &lt;<a href=
=3D"mailto:xuyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Like namespa=
ces_constants.h, kernel doesn&#39;t have<br>
clone.h header. We can also move it into here.<br>
<br>
Signed-off-by: Yang Xu &lt;<a href=3D"mailto:xuyang2018.jy@fujitsu.com" tar=
get=3D"_blank">xuyang2018.jy@fujitsu.com</a>&gt;<br></blockquote><div><br><=
/div><div><div class=3D"gmail_default" style=3D"font-size:small">Reviewed-b=
y: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&g=
t;</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
---<br>
This patch has been verified on my ltp fork[1].<br>
[1]<a href=3D"https://github.com/xuyang0410/ltp/actions/runs/3571298308/job=
s/6003048080" rel=3D"noreferrer" target=3D"_blank">https://github.com/xuyan=
g0410/ltp/actions/runs/3571298308/jobs/6003048080</a><br>
=C2=A0include/lapi/clone.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 56 -------------------<br>
=C2=A0include/lapi/sched.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 31 ++++++++++<br>
=C2=A0lib/tst_clone.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0testcases/kernel/containers/pidns/pidns13.c=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0testcases/kernel/containers/userns/userns08.c |=C2=A0 2 +-<br>
=C2=A0testcases/kernel/syscalls/clone3/clone301.c=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0testcases/kernel/syscalls/clone3/clone302.c=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0.../syscalls/close_range/close_range01.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
2 +-<br>
=C2=A0.../syscalls/close_range/close_range02.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
2 +-<br>
=C2=A09 files changed, 38 insertions(+), 63 deletions(-)<br>
=C2=A0delete mode 100644 include/lapi/clone.h<br>
<br>
diff --git a/include/lapi/clone.h b/include/lapi/clone.h<br>
deleted file mode 100644<br>
index 437d1376f..000000000<br>
--- a/include/lapi/clone.h<br>
+++ /dev/null<br>
@@ -1,56 +0,0 @@<br>
-// SPDX-License-Identifier: GPL-2.0-or-later<br>
-/*<br>
- * Copyright (c) 2020 Linaro Limited. All rights reserved.<br>
- * Author: Viresh Kumar &lt;<a href=3D"mailto:viresh.kumar@linaro.org" tar=
get=3D"_blank">viresh.kumar@linaro.org</a>&gt;<br>
- */<br>
-<br>
-#ifndef LAPI_CLONE_H__<br>
-#define LAPI_CLONE_H__<br>
-<br>
-#include &lt;sys/syscall.h&gt;<br>
-#include &lt;linux/types.h&gt;<br>
-#include &lt;sched.h&gt;<br>
-#include &lt;stdint.h&gt;<br>
-<br>
-#include &quot;config.h&quot;<br>
-#include &quot;lapi/syscalls.h&quot;<br>
-<br>
-#ifndef HAVE_CLONE3<br>
-struct clone_args {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) flags;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) pidfd;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) child_tid;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) parent_tid=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) exit_signa=
l;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) stack;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) stack_size=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) tls;<br>
-};<br>
-<br>
-static inline int clone3(struct clone_args *args, size_t size)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return tst_syscall(__NR_clone3, args, size);<br=
>
-}<br>
-#endif<br>
-<br>
-#ifndef CLONE_PIDFD<br>
-#define CLONE_PIDFD=C2=A0 =C2=A0 0x00001000=C2=A0 =C2=A0 =C2=A0 /* set if =
a pidfd should be placed in parent */<br>
-#endif<br>
-<br>
-#ifndef CLONE_NEWUSER<br>
-# define CLONE_NEWUSER 0x10000000<br>
-#endif<br>
-<br>
-static inline void clone3_supported_by_kernel(void)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0long ret;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((tst_kvercmp(5, 3, 0)) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check if the sys=
call is backported on an older kernel */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D syscall(__N=
R_clone3, NULL, 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -1 &=
amp;&amp; errno =3D=3D ENOSYS)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_brk(TCONF, &quot;Test not supported on kernel version &lt; v5=
.3&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
-<br>
-#endif /* LAPI_CLONE_H__ */<br>
diff --git a/include/lapi/sched.h b/include/lapi/sched.h<br>
index 3b0b4be31..1d22a9d7e 100644<br>
--- a/include/lapi/sched.h<br>
+++ b/include/lapi/sched.h<br>
@@ -11,6 +11,7 @@<br>
=C2=A0#include &lt;unistd.h&gt;<br>
=C2=A0#include &lt;stdint.h&gt;<br>
=C2=A0#include &lt;inttypes.h&gt;<br>
+#include &quot;config.h&quot;<br>
=C2=A0#include &quot;lapi/syscalls.h&quot;<br>
<br>
=C2=A0struct sched_attr {<br>
@@ -43,6 +44,32 @@ static inline int sched_getattr(pid_t pid, struct sched_=
attr *attr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return syscall(__NR_sched_getattr, pid, attr, s=
ize, flags);<br>
=C2=A0}<br>
<br>
+#ifndef HAVE_CLONE3<br>
+struct clone_args {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) pidfd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) child_tid;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) parent_tid=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) exit_signa=
l;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) stack;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) stack_size=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t __attribute__((aligned(8))) tls;<br>
+};<br>
+<br>
+static inline int clone3(struct clone_args *args, size_t size)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return tst_syscall(__NR_clone3, args, size);<br=
>
+}<br>
+#endif<br>
+<br>
+static inline void clone3_supported_by_kernel(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((tst_kvercmp(5, 3, 0)) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check if the sys=
call is backported on an older kernel */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_syscall(__NR_cl=
one3, NULL, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
=C2=A0#ifndef SCHED_DEADLINE<br>
=C2=A0# define SCHED_DEADLINE=C2=A0 =C2=A0 =C2=A0 =C2=A0 6<br>
=C2=A0#endif<br>
@@ -55,6 +82,10 @@ static inline int sched_getattr(pid_t pid, struct sched_=
attr *attr,<br>
=C2=A0# define CLONE_FS=C2=A0 =C2=A0 =C2=A0 0x00000200<br>
=C2=A0#endif<br>
<br>
+#ifndef CLONE_PIDFD<br>
+# define CLONE_PIDFD=C2=A0 =C2=A00x00001000<br>
+#endif<br>
+<br>
=C2=A0#ifndef CLONE_NEWNS<br>
=C2=A0# define CLONE_NEWNS=C2=A0 =C2=A00x00020000<br>
=C2=A0#endif<br>
diff --git a/lib/tst_clone.c b/lib/tst_clone.c<br>
index 07e7f0767..ecc84408c 100644<br>
--- a/lib/tst_clone.c<br>
+++ b/lib/tst_clone.c<br>
@@ -8,7 +8,7 @@<br>
=C2=A0#include &lt;stddef.h&gt;<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/clone.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0pid_t tst_clone(const struct tst_clone_args *tst_args)<br>
=C2=A0{<br>
diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel=
/containers/pidns/pidns13.c<br>
index 39fd6df7f..6a155027c 100644<br>
--- a/testcases/kernel/containers/pidns/pidns13.c<br>
+++ b/testcases/kernel/containers/pidns/pidns13.c<br>
@@ -31,7 +31,7 @@<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;tst_clone.h&quot;<br>
-#include &quot;lapi/clone.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0static int pipe_fd[2];<br>
<br>
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kern=
el/containers/userns/userns08.c<br>
index afdad6cad..2697d874b 100644<br>
--- a/testcases/kernel/containers/userns/userns08.c<br>
+++ b/testcases/kernel/containers/userns/userns08.c<br>
@@ -25,7 +25,7 @@<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;tst_clone.h&quot;<br>
-#include &quot;lapi/clone.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
=C2=A0#include &quot;tst_safe_file_at.h&quot;<br>
<br>
=C2=A0static pid_t clone_newuser(void)<br>
diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel=
/syscalls/clone3/clone301.c<br>
index f7ef0b2d7..d0fadbc5d 100644<br>
--- a/testcases/kernel/syscalls/clone3/clone301.c<br>
+++ b/testcases/kernel/syscalls/clone3/clone301.c<br>
@@ -15,7 +15,7 @@<br>
=C2=A0#include &lt;sys/wait.h&gt;<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/clone.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
=C2=A0#include &quot;lapi/pidfd.h&quot;<br>
<br>
=C2=A0#define CHILD_SIGNAL=C2=A0 =C2=A0SIGUSR1<br>
diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel=
/syscalls/clone3/clone302.c<br>
index 08d6417ce..b1b4ccebb 100644<br>
--- a/testcases/kernel/syscalls/clone3/clone302.c<br>
+++ b/testcases/kernel/syscalls/clone3/clone302.c<br>
@@ -14,7 +14,7 @@<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/clone.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0static struct clone_args *valid_args, *invalid_args;<br>
=C2=A0unsigned long stack;<br>
diff --git a/testcases/kernel/syscalls/close_range/close_range01.c b/testca=
ses/kernel/syscalls/close_range/close_range01.c<br>
index 5e2de4d1e..30bb600b6 100644<br>
--- a/testcases/kernel/syscalls/close_range/close_range01.c<br>
+++ b/testcases/kernel/syscalls/close_range/close_range01.c<br>
@@ -28,7 +28,7 @@<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;tst_clone.h&quot;<br>
<br>
-#include &quot;lapi/clone.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
=C2=A0#include &quot;lapi/close_range.h&quot;<br>
<br>
=C2=A0static int fd[3];<br>
diff --git a/testcases/kernel/syscalls/close_range/close_range02.c b/testca=
ses/kernel/syscalls/close_range/close_range02.c<br>
index bd46936bb..aec899261 100644<br>
--- a/testcases/kernel/syscalls/close_range/close_range02.c<br>
+++ b/testcases/kernel/syscalls/close_range/close_range02.c<br>
@@ -18,7 +18,7 @@<br>
=C2=A0#include &quot;tst_clone.h&quot;<br>
=C2=A0#include &quot;lapi/fcntl.h&quot;<br>
=C2=A0#include &quot;lapi/close_range.h&quot;<br>
-#include &quot;lapi/clone.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0static int try_close_range(int fd, int flags)<br>
=C2=A0{<br>
-- <br>
2.23.0<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000001f718c05ee959139--


--===============1688160538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1688160538==--

