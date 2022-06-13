Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1909EC433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 14:59:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7D0B3C94B0
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 16:59:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CDA53C217F
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:59:07 +0200 (CEST)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E24F31400B88
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:59:06 +0200 (CEST)
Received: by mail-vk1-xa31.google.com with SMTP id bj33so2699272vkb.12
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QM9V6AJEkxJOwz39F5Y/CWncjvVAjJxGFqrOC1GNqmo=;
 b=QfAJCAuLECnsuXmMlcD8Nog3cZMrQvOxIbgwMl3eG/wjkhmoXgF15Qr3N1vmBDRFKF
 PwnkZ2vfK1PtpE10mTi3GNxq33I5tn5lxakpgLZ50JuBKnl0lUK3A+JEmnJ6gi1R7ixc
 t9G+BQaFCD7VkzprfMdEPc981QtOGIMge1MFQmyu/GquvM1u0eSSl5Svwj3+3Tmt/H8u
 oOVB5Y74EgL6jx5AVl46lEhqXhxudiZhB4zkTp8rqLoxIDI4+NOVW4j7gNwEfO37kHhK
 pW1Egmi3gckatZKtZE0wzKJp4voWDoGVlfIS0Jj9PxfrGQonB1Kf5wIT8EdSqwpdn27N
 t5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QM9V6AJEkxJOwz39F5Y/CWncjvVAjJxGFqrOC1GNqmo=;
 b=aJl97camH8Yc/bzpEBjUzdOEuBGyLIw/QjTQU8ITBaVwZODF5+6BX9yiy0XkRlCY0N
 611UhYBgvsejaZlP41Dnwqkjkglc8eKuH5SMkWa9smJ3hkPX2qDteFoj1V4nt2uMabR0
 Kwef0kzCNlyiu2d1QvETFTtfoQuasd8Jqp68Jzvec7umryq4ye52osuAckBwv0zFmUl/
 kCKlnOOSzjfbXMrrxttx827GlZDHdlrpikayabzmIHNqN9YKDCkDC96NPu0E6PW8WJ/g
 Au3aJHDFkl8tfHOrCGULVSZnkbo4yiV1bLCeCd4TRAdjm5SXjuiTnCFPvWvIHJm4V5uK
 NgrQ==
X-Gm-Message-State: AOAM532HhC1EflKFUdB2EGq8j86mJ/+xza+WiIWIeKdPZmmql2iyUov2
 1RYktNHOX8BgFko/qsyPS+JSrBuKXcEvE8QURHY=
X-Google-Smtp-Source: ABdhPJyR/a9RO626kpGaIxWHG0PQaQ1IYOVkqU2llCl82kt8DDh+AreBt0Tvwtz506zQwDjosGbmIxhxvp8MVoVIVAI=
X-Received: by 2002:a1f:2b46:0:b0:35d:74a8:ca14 with SMTP id
 r67-20020a1f2b46000000b0035d74a8ca14mr21411021vkr.36.1655132345621; Mon, 13
 Jun 2022 07:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-2-amir73il@gmail.com>
In-Reply-To: <20220613143826.1328830-2-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 13 Jun 2022 17:58:54 +0300
Message-ID: <CAOQ4uxjfuQ5oj8V8weD+-ChvXZ9nXy=MB285dAn1zQKV6dn2cA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] syscalls/inotify12: Introduce test for
 inotify mask flags
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jun 13, 2022 at 5:38 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Test behavior of IN_ONESHOT and IN_EXCL_UNLINK.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/inotify/.gitignore  |   1 +
>  testcases/kernel/syscalls/inotify/inotify12.c | 168 ++++++++++++++++++
>  3 files changed, 170 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/inotify/inotify12.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3b26d19e6..1259e41f1 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -588,6 +588,7 @@ inotify08 inotify08
>  inotify09 inotify09
>  inotify10 inotify10
>  inotify11 inotify11
> +inotify12 inotify12
>
>  fanotify01 fanotify01
>  fanotify02 fanotify02
> diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/kernel/syscalls/inotify/.gitignore
> index 593cf6c04..f6e5c546a 100644
> --- a/testcases/kernel/syscalls/inotify/.gitignore
> +++ b/testcases/kernel/syscalls/inotify/.gitignore
> @@ -9,3 +9,4 @@
>  /inotify09
>  /inotify10
>  /inotify11
> +/inotify12
> diff --git a/testcases/kernel/syscalls/inotify/inotify12.c b/testcases/kernel/syscalls/inotify/inotify12.c
> new file mode 100644
> index 000000000..fe72771c5
> --- /dev/null
> +++ b/testcases/kernel/syscalls/inotify/inotify12.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 CTERA Networks. All Rights Reserved.
> + *
> + * Author: Amir Goldstein <amir73il@gmail.com>
> + */
> +
> +/*\
> + * [Description]
> + * Test special inotify mask flags.
> + *
> + * Regression test for kernel commit a32e697cda27:
> + *
> + *     inotify: show inotify mask flags in proc fdinfo
> + */
> +
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <sys/wait.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "inotify.h"
> +
> +#if defined(HAVE_SYS_INOTIFY_H)
> +#include <sys/inotify.h>
> +
> +#define EVENT_MAX 32
> +/* Size of the event structure, not including the name */
> +#define EVENT_SIZE     (sizeof(struct inotify_event))
> +#define EVENT_BUF_LEN  (EVENT_MAX * (EVENT_SIZE + 16))
> +
> +#define        TEST_FILE       "test_file"
> +
> +static char event_buf[EVENT_BUF_LEN];
> +
> +static struct tcase {
> +       const char *tname;
> +       unsigned int mask;
> +       int expect_events;
> +} tcases[] = {
> +       {
> +               "Watch for multi events",
> +               IN_MODIFY,
> +               2,
> +       },
> +       {
> +               "Watch for single event",
> +               IN_MODIFY | IN_ONESHOT,
> +               1,
> +       },
> +       {
> +               "Watch for events on linked file",
> +               IN_MODIFY | IN_EXCL_UNLINK,
> +               1,
> +       },
> +};
> +
> +int fd_notify;
> +
> +static void verify_inotify(unsigned int n)
> +{
> +       struct tcase *tc = &tcases[n];
> +       int fd, len;
> +       unsigned int tmpmask;
> +       char procfdinfo[100];
> +       struct inotify_event *event = (struct inotify_event *)event_buf;
> +
> +       tst_res(TINFO, "Test #%d: %s", n, tc->tname);
> +
> +       fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
> +
> +       SAFE_FILE_PRINTF(TEST_FILE, "1");
> +
> +       SAFE_MYINOTIFY_ADD_WATCH(fd_notify, ".", tc->mask);
> +
> +       sprintf(procfdinfo, "/proc/%d/fdinfo/%d", (int)getpid(), fd_notify);
> +       if (FILE_LINES_SCANF(procfdinfo, "inotify wd:%*d ino:%*x sdev:%*x mask:%x",
> +                            &tmpmask)) {
> +               tst_res(TFAIL, "Could not parse inotify fdinfo");
> +       } else if (tmpmask != tc->mask) {
> +               tst_res(TFAIL, "Incorrect mask %x in inotify fdinfo (expected %x)",
> +                       tmpmask, tc->mask);
> +       } else {
> +               tst_res(TPASS, "Correct mask in inotify fdinfo");
> +       }
> +
> +       fd = SAFE_OPEN(TEST_FILE, O_RDWR);
> +       SAFE_WRITE(1, fd, "2", 1);
> +
> +       /*
> +        * Read the 1st IN_MODIFY event
> +        */
> +       len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
> +
> +       if (len < (int)sizeof(*event)) {
> +               tst_res(TFAIL, "Got no events");
> +       } else if (event->mask == IN_MODIFY) {
> +               tst_res(TPASS, "Got 1st event as expected");
> +       } else {
> +               tst_res(TFAIL, "Got event 0x%x (expected 0x%x)",
> +                               event->mask, IN_MODIFY);
> +       }
> +
> +       /*
> +        * Unlink file so IN_EXCL_UNLINK won't get IN_ACCESS event.
> +        * IN_ONESHOT won't get IN_ACCESS event because IN_MODIFY
> +        * was already generated.
> +        */
> +       SAFE_UNLINK(TEST_FILE);
> +       SAFE_WRITE(1, fd, "3", 1);
> +       SAFE_CLOSE(fd);
> +
> +       /*
> +        * Possibly read the 2nd IN_MODIFY event
> +        */
> +       errno = 0;
> +       len = read(fd_notify, event_buf, EVENT_BUF_LEN);
> +       SAFE_CLOSE(fd_notify);
> +       if (len < 0 && errno == EAGAIN) {
> +               /* Treat no event same as we treat IN_IGNORED */
> +               event->mask = IN_IGNORED;
> +       } else if (len < (int)sizeof(*event)) {
> +               tst_res(TFAIL | TERRNO, "Failed to read events");
> +               return;
> +       }
> +
> +       if (event->mask == IN_MODIFY) {
> +               if (tc->expect_events > 1)
> +                       tst_res(TPASS, "Got 2nd event as expected");
> +               else
> +                       tst_res(TFAIL, "Got unexpected 2nd event");
> +       } else if (event->mask == IN_IGNORED) {
> +               if (tc->expect_events == 1)
> +                       tst_res(TPASS, "Got no more events as expected");
> +               else
> +                       tst_res(TFAIL, "Got only one event (expected %d)",
> +                                       tc->expect_events);
> +       } else {
> +               tst_res(TFAIL, "Got unexpected event 0x%x",
> +                               event->mask);
> +       }
> +}
> +
> +static void cleanup(void)
> +{
> +       if (fd_notify > 0)
> +               SAFE_CLOSE(fd_notify);
> +}
> +
> +static struct tst_test test = {
> +       .timeout = 10,

OOPS should be changed to .max_runtime = 10

> +       .needs_tmpdir = 1,
> +       .cleanup = cleanup,
> +       .test = verify_inotify,
> +       .tcnt = ARRAY_SIZE(tcases),
> +       .tags = (const struct tst_tag[]) {
> +               {"linux-git", "a32e697cda27"},
> +               {}

Missing }

Sorry, I hadn't notice this build failure before posting.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
