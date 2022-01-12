Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A23CC433EF
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 15:56:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F4693C950C
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 16:56:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECCEB3C0F6A
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 16:56:39 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 291A160090A
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 16:56:39 +0100 (CET)
Received: by mail-ed1-x535.google.com with SMTP id z22so11691947edd.12
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZUIE2TtYEPu3+VteNSorh9BvWhArgrA6kX1TNQslOW0=;
 b=AE/8XXAT+GWlyXsKx8iA8oMQffflNVnXzes3tLi6pUcdB26QnlwM5w2N5hjYTKUrYM
 jAaju3PO7uKcuVu63C2ADgjyfSGnOaRkjGo3n83BUjtc8NuRMMZRf9Sd2bZsj3FpNDmh
 9wfHxXxetHOur2oYPvYr94mxr4fHWk2Tr8IrVcngbeTV0p1I+7MuZZDHB1mTOiS+VuDP
 JaPDWtmZBeu48jDcOIspNjRGaAatl80ncdPUoESUq4eaxxfNuRmEpEDyHhsicpmuYgY3
 LH53J9eVBWGj/3QTgylfiHYpmY7USbh49S09PlvaA/AYzEuDSkgAXTmy/gWYT0p0vxFs
 Jyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZUIE2TtYEPu3+VteNSorh9BvWhArgrA6kX1TNQslOW0=;
 b=XhhAww3y7JXWpCOL4owWmWoBswthm1JUyHqgrHBb11Azu834DhUiFh6bJryzkkRWuQ
 2rXAyIhFAIHo1ibss7kySSGQfFeu/qpDSI1IrZkMRMOxC8E3kG3cQYNOPOX6LYOxeeiQ
 Br+J7XuKC8rLalnxVmtFV+3/4Zs3It+qjzc2SADd9k68wrucKI2PU7qrFF7sscFeQ4ZD
 j62vSd28mf0beelkVTHYj61bWblGhjbgZVc5pKeSZn6FG6me0etPf6iVqT/yZHgGsWG7
 J15clN8D7pO+db74im6s0YK7iD06axUiHY2kUxkzwfjg0utw8gh/Pc5r67/ZJfyKGo/G
 E97Q==
X-Gm-Message-State: AOAM5322DqESWtUGSFxcI3RsN9T3JushPQ0Z+djyvStbhMWh9PHEjjFw
 eafT6RG03bvolVGBlKzq+hxxnNw8hFwJTMCIoMC2kA==
X-Google-Smtp-Source: ABdhPJyeWuZt41D3Y95p0NJDealf3e/VotiCxmEZUzV2AnJgFO8G1BJ8ATEhYpQN39OJfSr22ufSLjOu8AmH8BWXpUc=
X-Received: by 2002:a17:907:3f92:: with SMTP id
 hr18mr255113ejc.693.1642002998420; 
 Wed, 12 Jan 2022 07:56:38 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsMHhXJCgO-ykR0oO1kVdusGnthgj6ifxEKaGPHZJ-ZCw@mail.gmail.com>
 <20220112131837.igsjkkttqskw4eix@wittgenstein>
 <CADYN=9Lvm-1etZS817eZK91NUyxkFBmsu=5-q_8Ei-1eV8DuZQ@mail.gmail.com>
 <20220112140254.cvngcwggeevwaazw@wittgenstein>
 <20220112141445.txgrdlycvfkiwsv5@example.org>
 <20220112142846.3b3m2dyhdtppgwrw@example.org>
In-Reply-To: <20220112142846.3b3m2dyhdtppgwrw@example.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 12 Jan 2022 16:56:27 +0100
Message-ID: <CADYN=9LBjp0=mqyPkTGmdeMx52cg4pM39fnXe-ODTZ=_1OP+zw@mail.gmail.com>
To: Alexey Gladkov <legion@kernel.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [next]: LTP: getxattr05.c:97: TFAIL:
 unshare(CLONE_NEWUSER) failed: ENOSPC (28)
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
Cc: regressions@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>, containers@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 Christian Brauner <christian.brauner@ubuntu.com>,
 LTP List <ltp@lists.linux.it>, "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 12 Jan 2022 at 15:28, Alexey Gladkov <legion@kernel.org> wrote:
>
> On Wed, Jan 12, 2022 at 03:14:45PM +0100, Alexey Gladkov wrote:
> > On Wed, Jan 12, 2022 at 03:02:54PM +0100, Christian Brauner wrote:
> > > On Wed, Jan 12, 2022 at 02:22:42PM +0100, Anders Roxell wrote:
> > > > On Wed, 12 Jan 2022 at 14:18, Christian Brauner
> > > > <christian.brauner@ubuntu.com> wrote:
> > > > >
> > > > > On Wed, Jan 12, 2022 at 05:15:37PM +0530, Naresh Kamboju wrote:
> > > > > > While testing LTP syscalls with Linux next 20220110 (and till date 20220112)
> > > > > > on x86_64, i386, arm and arm64 the following tests failed.
> > > > > >
> > > > > > tst_test.c:1365: TINFO: Timeout per run is 0h 15m 00s
> > > > > > getxattr05.c:87: TPASS: Got same data when acquiring the value of
> > > > > > system.posix_acl_access twice
> > > > > > getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> > > > > > tst_test.c:391: TBROK: Invalid child (13545) exit value 1
> > > > > >
> > > > > > fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
> > > > > > fanotify17.c:155: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> > > > > > tst_test.c:391: TBROK: Invalid child (14739) exit value 1
> > > > > >
> > > > > > sendto03.c:48: TBROK: unshare(268435456) failed: ENOSPC (28)
> > > > > >
> > > > > > setsockopt05.c:45: TBROK: unshare(268435456) failed: ENOSPC (28)
> > > > > >
> > > > > > strace output:
> > > > > > --------------
> > > > > > [pid   481] wait4(-1, 0x7fff52f5ae8c, 0, NULL) = -1 ECHILD (No child processes)
> > > > > > [pid   481] clone(child_stack=NULL,
> > > > > > flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> > > > > > child_tidptr=0x7f3af0fa7a10) = 483
> > > > > > strace: Process 483 attached
> > > > > > [pid   481] wait4(-1,  <unfinished ...>
> > > > > > [pid   483] unshare(CLONE_NEWUSER)      = -1 ENOSPC (No space left on device)
> > > > >
> > > > > This looks like another regression in the ucount code. Reverting the
> > > > > following commit fixes it and makes the getxattr05 test work again:
> > > > >
> > > > > commit 0315b634f933b0f12cfa82660322f6186c1aa0f4
> > > > > Author: Alexey Gladkov <legion@kernel.org>
> > > > > Date:   Fri Dec 17 15:48:23 2021 +0100
> > > > >
> > > > >     ucounts: Split rlimit and ucount values and max values
> > > > >
> > > > >     Since the semantics of maximum rlimit values are different, it would be
> > > > >     better not to mix ucount and rlimit values. This will prevent the error
> > > > >     of using inc_count/dec_ucount for rlimit parameters.
> > > > >
> > > > >     This patch also renames the functions to emphasize the lack of
> > > > >     connection between rlimit and ucount.
> > > > >
> > > > >     v2:
> > > > >     - Fix the array-index-out-of-bounds that was found by the lkp project.
> > > > >
> > > > >     Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > >     Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > > > >     Link: https://lkml.kernel.org/r/73ea569042babda5cee2092423da85027ceb471f.1639752364.git.legion@kernel.org
> > > > >     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> > > > >
> > > > > The issue only surfaces if /proc/sys/user/max_user_namespaces is
> > > > > actually written to.
> > > >
> > > > I did a git bisect and that pointed me to this patch too.
> > >
> > > Uhm, doesn't this want to be:
> >
> > Yes. I miss it. I tried not to mix the logic, but I myself stepped on this
> > problem.
>
> It should be fixed in the four places:
>
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 22070f004e97..5c373a453f43 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -264,7 +264,7 @@ long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
>         long ret = 0;
>
>         for (iter = ucounts; iter; iter = iter->ns->ucounts) {
> -               long new = atomic_long_add_return(v, &iter->ucount[type]);
> +               long new = atomic_long_add_return(v, &iter->rlimit[type]);
>                 if (new < 0 || new > max)
>                         ret = LONG_MAX;
>                 else if (iter == ucounts)
> @@ -279,7 +279,7 @@ bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
>         struct ucounts *iter;
>         long new = -1; /* Silence compiler warning */
>         for (iter = ucounts; iter; iter = iter->ns->ucounts) {
> -               long dec = atomic_long_sub_return(v, &iter->ucount[type]);
> +               long dec = atomic_long_sub_return(v, &iter->rlimit[type]);
>                 WARN_ON_ONCE(dec < 0);
>                 if (iter == ucounts)
>                         new = dec;
> @@ -292,7 +292,7 @@ static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
>  {
>         struct ucounts *iter, *next;
>         for (iter = ucounts; iter != last; iter = next) {
> -               long dec = atomic_long_sub_return(1, &iter->ucount[type]);
> +               long dec = atomic_long_sub_return(1, &iter->rlimit[type]);
>                 WARN_ON_ONCE(dec < 0);
>                 next = iter->ns->ucounts;
>                 if (dec == 0)
> @@ -313,7 +313,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>         long dec, ret = 0;
>
>         for (iter = ucounts; iter; iter = iter->ns->ucounts) {
> -               long new = atomic_long_add_return(1, &iter->ucount[type]);
> +               long new = atomic_long_add_return(1, &iter->rlimit[type]);
>                 if (new < 0 || new > max)
>                         goto unwind;
>                 if (iter == ucounts)
> @@ -330,7 +330,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>         }
>         return ret;
>  dec_unwind:
> -       dec = atomic_long_sub_return(1, &iter->ucount[type]);
> +       dec = atomic_long_sub_return(1, &iter->rlimit[type]);
>         WARN_ON_ONCE(dec < 0);
>  unwind:
>         do_dec_rlimit_put_ucounts(ucounts, iter, type);
>

Thank you for the fix.
I applied this patch and built and ran it in qemu for arm64 and x86.
'./runltp -s getxattr05' passed on both architectures.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


Cheers,
Anders

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
