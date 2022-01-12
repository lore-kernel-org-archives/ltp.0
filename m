Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04A0C433F5
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 13:23:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 880F63C94D0
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 14:23:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4675C3C04A0
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 14:22:54 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9EB71600786
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 14:22:53 +0100 (CET)
Received: by mail-ed1-x52f.google.com with SMTP id u21so9922438edd.5
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 05:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MfZ/bQyc8Ol4TQ5HaN2khWewBoM9cI1PUzi7/CIfS6I=;
 b=Lsipx6XKx1x6e4uetXaiE2GztJ4AGV6fzRo4TY2NE2SduXUPlNhdbeLCtufRKCwwnC
 0SPpqEeAGedRwJ5A3cFuz+Fx8X+/99cdT8FkqL59AenhPixEDypHH2cxR0hfPpkdJRWL
 3JvI6T/LyCTCLZuaDgcUBHouUXc9It24q4dlN1kjlwLfcM/g4EbP22GfPDk2rbn0ZnTE
 zMXyKDy7LqM19xT86V7+wYsIyDPRZtmoHpEpQZRX4lX8AWYnKPxnZagvhAeBzuBXUUDa
 DtwE0zSmSKkYjMLLWx73/IhVuQzZsYYgMYNR0qZzGhYW+nWTdsCOHzUDX6UNTX3VT46H
 Yt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MfZ/bQyc8Ol4TQ5HaN2khWewBoM9cI1PUzi7/CIfS6I=;
 b=S6TRhNZQCMlt8JVWzwyf0jFHJykgBSTRL18yndbJYJ5DaHkt9Osy049hotjE2iExcY
 k+gAhtJtd8x9vZHufeM6P/W88NGkQYOMN2umGEW239FUsMZ7q5ekdY0+QG3LymDO/xLr
 W3Xees/FGhJco7CM8RpFUgSPbPTlulshNp219XVugEfGLdDXce3ghdS2mCzXmF1waY/c
 kiClaZHr3WyadST5aw2Rricifc+4asvXbeMoPcGB4l4z9ndiqA/6bNdfv1HaTPUBXCXw
 TLWaSHcWWEI94lKuEuDpIrNvAkBqZU9E757KVJBfFSt/sjxLkzhYNYsrWqBn1UZbiOn6
 JlMA==
X-Gm-Message-State: AOAM530wT1JdMR7uxiGFo7B/rR42Qy8QoXK2PR8RAK2STVGyYtwvY3Jy
 O3PRHl/XuaW8eACqf/qrLo2MOiwllemWUtTs8CZtfg==
X-Google-Smtp-Source: ABdhPJz5Wrm0HbctZgKlE4IIfTnFY0GNvyi3qy++ibXIKY6TXHt+qWqe1wMvjNYh3xmQ1f9ikobQGUS2W1drqcKJSp4=
X-Received: by 2002:a17:907:3f92:: with SMTP id
 hr18mr7524933ejc.693.1641993772970; 
 Wed, 12 Jan 2022 05:22:52 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsMHhXJCgO-ykR0oO1kVdusGnthgj6ifxEKaGPHZJ-ZCw@mail.gmail.com>
 <20220112131837.igsjkkttqskw4eix@wittgenstein>
In-Reply-To: <20220112131837.igsjkkttqskw4eix@wittgenstein>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 12 Jan 2022 14:22:42 +0100
Message-ID: <CADYN=9Lvm-1etZS817eZK91NUyxkFBmsu=5-q_8Ei-1eV8DuZQ@mail.gmail.com>
To: Christian Brauner <christian.brauner@ubuntu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
 linux-fsdevel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
 LTP List <ltp@lists.linux.it>, "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 12 Jan 2022 at 14:18, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Jan 12, 2022 at 05:15:37PM +0530, Naresh Kamboju wrote:
> > While testing LTP syscalls with Linux next 20220110 (and till date 20220112)
> > on x86_64, i386, arm and arm64 the following tests failed.
> >
> > tst_test.c:1365: TINFO: Timeout per run is 0h 15m 00s
> > getxattr05.c:87: TPASS: Got same data when acquiring the value of
> > system.posix_acl_access twice
> > getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> > tst_test.c:391: TBROK: Invalid child (13545) exit value 1
> >
> > fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
> > fanotify17.c:155: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> > tst_test.c:391: TBROK: Invalid child (14739) exit value 1
> >
> > sendto03.c:48: TBROK: unshare(268435456) failed: ENOSPC (28)
> >
> > setsockopt05.c:45: TBROK: unshare(268435456) failed: ENOSPC (28)
> >
> > strace output:
> > --------------
> > [pid   481] wait4(-1, 0x7fff52f5ae8c, 0, NULL) = -1 ECHILD (No child processes)
> > [pid   481] clone(child_stack=NULL,
> > flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> > child_tidptr=0x7f3af0fa7a10) = 483
> > strace: Process 483 attached
> > [pid   481] wait4(-1,  <unfinished ...>
> > [pid   483] unshare(CLONE_NEWUSER)      = -1 ENOSPC (No space left on device)
>
> This looks like another regression in the ucount code. Reverting the
> following commit fixes it and makes the getxattr05 test work again:
>
> commit 0315b634f933b0f12cfa82660322f6186c1aa0f4
> Author: Alexey Gladkov <legion@kernel.org>
> Date:   Fri Dec 17 15:48:23 2021 +0100
>
>     ucounts: Split rlimit and ucount values and max values
>
>     Since the semantics of maximum rlimit values are different, it would be
>     better not to mix ucount and rlimit values. This will prevent the error
>     of using inc_count/dec_ucount for rlimit parameters.
>
>     This patch also renames the functions to emphasize the lack of
>     connection between rlimit and ucount.
>
>     v2:
>     - Fix the array-index-out-of-bounds that was found by the lkp project.
>
>     Reported-by: kernel test robot <oliver.sang@intel.com>
>     Signed-off-by: Alexey Gladkov <legion@kernel.org>
>     Link: https://lkml.kernel.org/r/73ea569042babda5cee2092423da85027ceb471f.1639752364.git.legion@kernel.org
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> The issue only surfaces if /proc/sys/user/max_user_namespaces is
> actually written to.

I did a git bisect and that pointed me to this patch too.

Cheers,
Anders

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
