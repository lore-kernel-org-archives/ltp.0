Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A07C433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 13:25:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11E833C9B46
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 14:25:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DEF63C0720
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 14:25:45 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 66AFC600691
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 14:25:45 +0100 (CET)
Received: by mail-io1-xd2d.google.com with SMTP id c188so16660534iof.6
 for <ltp@lists.linux.it>; Mon, 07 Feb 2022 05:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QpvezXCRfVTtINZB+cH+XUbDmqlPkxZUFrX5xkq27FI=;
 b=jrPn1nA5DOzAREIghdr4PQLbyxmbE8lK3isCFHtcZFTBfUrsmb5fC4oa0r/qyBDD+0
 7fYlSnkWW0UvWUI6mkyqzgb1j8rgkr1TLXMPW3pX9DTZkZML+ZCXY+NKIYVb1lUf8JJX
 Op7r0/1Ur+gvcaeYyUAUYL0wzwV/l2TNH1YgxWK5R+CYOc4upiHHiporbCxiTbq27+8I
 aJ/CJqZ2uGh7wUw0M+Te29hhC9JtCCOJbBQIHTsF/On9XoJIMTThPN/mGIsch7MuPT7S
 4pL9FklqyV/U1XmxTamoiDiEH7Sc0r00Pka9Ac+cNu9VIU/9HMu3DYh8Y/aRpnzM8U0Z
 GzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QpvezXCRfVTtINZB+cH+XUbDmqlPkxZUFrX5xkq27FI=;
 b=CO5DeP9zAymeE0rDWpQtyDYImiQmzXFB6vaufEaUxPTegpoUuRi1BfaOQga0MJHXDz
 +/loVANRv1vJUw7F4UEs/o0unbLwAyV7jnp6/MRoZPrFpnjp3iKxoYQaCOxNaSBTqdxp
 tZrdM4URVdqTves4ORgRIkz7AR1rbgOgrMdYw8LHEtqqwurEMQl9mYgIhDkqwi7TKa2D
 id+ms/7Ji4XnN/reIxVHA0Iqnywdk9ZDc3BxOrHvws9UbzykOpb/f5++LdGbzuyYXbW1
 /SAAAuVmRTECo77WBs8Xfhw8TDs3XW9TI98ujfbXPia1ZrgetWt/mYgj2j2ifsr7zHAx
 Ah8Q==
X-Gm-Message-State: AOAM533uBzy9UPGerEoh4agmxRPyZmE1WmmC2Pvb1Ngi+ZmH1CIB5PPm
 xzv/u3s3WBXE9mGGHXN9R2vEHh4iJZhKvX5RRh0=
X-Google-Smtp-Source: ABdhPJyQWn4POQG3iDRhRI2vixyv89WH52V7cIve57rdKZhXxyjEWxnjExBkA2EeolfeFVJFTHLzS2XcNhRe+7Ism/c=
X-Received: by 2002:a05:6638:40ab:: with SMTP id
 m43mr5338534jam.53.1644240343952; 
 Mon, 07 Feb 2022 05:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20220203061222.625948-1-amir73il@gmail.com>
 <YgDsIaf5z2rg5tCH@pevik>
In-Reply-To: <YgDsIaf5z2rg5tCH@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Feb 2022 15:25:33 +0200
Message-ID: <CAOQ4uxiba8GE9PtBbX5jWYTia4z_nJNvciBUB_SpTw2YjtjrDA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/inotify: New test for IN_DELETE
 regression
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
Cc: Ivan Delalande <colona@arista.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> On various systems. Interesting enough on it does not reproduce on affected
> system with enabled FIPS (at least FIPS on SLES) when run as ordinary user
> (reproduces when run as root). But that's nothing we should worry about.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>

Your fixes look fine to me.

> Suggest to apply with this changes (unless if worth to compare nevents ==
> CHURN_FILES).

I wouldn't worry about this - it's not related to the regression that
we are testing.

Thanks,
Amir.

>
> Kind regards,
> Petr
>
> diff --git testcases/kernel/syscalls/inotify/inotify11.c testcases/kernel/syscalls/inotify/inotify11.c
> index 88ac4d2d7d..062b92409f 100644
> --- testcases/kernel/syscalls/inotify/inotify11.c
> +++ testcases/kernel/syscalls/inotify/inotify11.c
> @@ -4,8 +4,10 @@
>   *
>   * Started by Amir Goldstein <amir73il@gmail.com>
>   * based on reproducer from Ivan Delalande <colona@arista.com>
> - *
> - * DESCRIPTION
> + */
> +
> +/*\
> + * [Description]
>   * Test opening files after receiving IN_DELETE.
>   *
>   * Kernel v5.13 has a regression allowing files to be open after IN_DELETE.
> @@ -18,16 +20,12 @@
>
>  #include <stdio.h>
>  #include <unistd.h>
> -#include <stdlib.h>
>  #include <fcntl.h>
> -#include <poll.h>
> -#include <time.h>
>  #include <signal.h>
> -#include <sys/time.h>
>  #include <sys/wait.h>
> -#include <sys/syscall.h>
>
>  #include "tst_test.h"
> +#include "tst_safe_macros.h"
>  #include "inotify.h"
>
>  #if defined(HAVE_SYS_INOTIFY_H)
> @@ -43,9 +41,9 @@
>
>  static pid_t pid;
>
> -char event_buf[EVENT_BUF_LEN];
> +static char event_buf[EVENT_BUF_LEN];
>
> -void churn(void)
> +static void churn(void)
>  {
>         char path[10];
>         int i;
> @@ -75,9 +73,7 @@ static void verify_inotify(void)
>         while (!opened && nevents < CHURN_FILES) {
>                 int i, fd, len;
>
> -               len = read(inotify_fd, event_buf, EVENT_BUF_LEN);
> -               if (len == -1)
> -                       tst_brk(TBROK | TERRNO, "read failed");
> +               len = SAFE_READ(0, inotify_fd, event_buf, EVENT_BUF_LEN);
>
>                 for (i = 0; i < len; i += EVENT_SIZE + event->len) {
>                         event = (struct inotify_event *)&event_buf[i];

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
