Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AC7C25B76
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 14:16:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A35E23D08E7
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 16:16:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EAE23C2B89
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 16:16:03 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD0641A00922
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 16:16:02 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42135a45e2aso15301335e9.3
 for <ltp@lists.linux.it>; Mon, 03 Jun 2024 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717424162; x=1718028962; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YBDKzJzfL/kisf7mX2QsAYw1VZ+9j8Trx6m3G0+ZVko=;
 b=GNV4Su5mQs+u/ZD5l6Yb8f2tXgViZL0F+2R9psVzhCyXc9xKDE8I3Gu0uBxum0ZnGL
 RWntkr5Pr/ePfCNBkIc8hYAruHqDI0j82eKEeBJneb29V3Pi1s42IWGpk27wjFToWa0k
 gPJRQ16ZjzZkUbOtcA4zQJ3kfw6bxMvpCBjcg3jCTZoeYIzr2CTvFBic4lEIPx41aMND
 WbgUmB8g+8kYTpGp0Aie7hyxW2G3/PgdE2l2oUMcbTgr0YNdtVoKQiHDufgPduHqTZTn
 Ro+PsfMODJwzGH/c0PJmnNPfCrrkOyzEa0+bqcnqZBOkNGpkd0Yla40Lf0aUzUYK2U8U
 LgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717424162; x=1718028962;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YBDKzJzfL/kisf7mX2QsAYw1VZ+9j8Trx6m3G0+ZVko=;
 b=l0G6s7anbWby0/vueDBDWNPv9iDnkgkVFS0syH6takKw7ALrlNCV35hIzyFjb0yQcI
 +Ges4Y+EaXCl35M9+IEqNXBA2F+gxR4CW27I2SgQ0sTQnjgQjo+mxK5AjIUMUfs4oLri
 3TbpnNhd+Tzk2tmW+f+8Lf3gcqqK2VNCq9fA7EsfV5U/LnY1agY2j2MXiA5BELoUBm8o
 d59e6GKZzbBT7O74IgUlbe06YwSHg0lSolVubeMiNHAsLRR1G+J8d48sa6b+WN607rBl
 7DCccdPjvQD4JM6n/9FqUad5fxuOQlPES7Eylwp7LspdOmpL4LCHmit9de6B/c2Gqp5v
 7QBg==
X-Gm-Message-State: AOJu0YyJw1/KmNJiKTVI3coSB66i0dDmBX7y7SPLUXLoO22stFtw68xG
 dnG/bmtkhuLCKYOmiCT+F95dcj3k7w+1eg272UZI3+lX4c3VfkOdoZxP2XQf7udPgPJ58Ayxw50
 nvAzHmzKtm8bna9XEb0bdPy1gfSU=
X-Google-Smtp-Source: AGHT+IGY+EvQcy49e709K3vzE3ETL4Wdv3maZIEQn0Y4A8NoxHNp0I351LzeE52h/tDeTC1PX8kuQ6bQu8rROcaYF/k=
X-Received: by 2002:a05:600c:45d3:b0:41b:cb18:e24b with SMTP id
 5b1f17b1804b1-4212e04fe7amr62423425e9.9.1717424162101; Mon, 03 Jun 2024
 07:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCsO8fTwOsVwhCdBksStaPVjXHBi8m3g+_b-ZAnKByUR3cqyA@mail.gmail.com>
 <20240603124653.31967-1-akumar@suse.de>
 <1c82db37-4c4b-4679-9c18-618c57ec6a0a@suse.com>
In-Reply-To: <1c82db37-4c4b-4679-9c18-618c57ec6a0a@suse.com>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Mon, 3 Jun 2024 16:15:49 +0200
Message-ID: <CAJCsO8e9CCMhXhRk5Kf1LiUO1_HwQ0E2E6-p0pjyz1EZu8Y7eA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] unlink09: Fix open syscall flags
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

+1

Reviewed-by: Sebastian Chlad <sebastianchlad@gmail.com>

On Mon, 3 Jun 2024 at 15:49, Andrea Cervesato via ltp <ltp@lists.linux.it>
wrote:

> Hi!
>
> thanks for fixing the commit message and the test. According with the
> open() documentation an access flag
> is a must and that's one thing that makes this test wrong.
>
> LGTM
>
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
>
> On 6/3/24 14:46, Avinesh Kumar wrote:
> > In the SAFE_OPEN() calls, we missed to include any of the mandatory
> > flags for open syscall:  O_RDONLY,  O_WRONLY,  or  O_RDWR
> >
> > Fixes: 2cf78f47a6 (unlink: Add error tests for EPERM and EROFS)
> > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > ---
> >   testcases/kernel/syscalls/unlink/unlink09.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/unlink/unlink09.c
> b/testcases/kernel/syscalls/unlink/unlink09.c
> > index cc4b4a07e..405deb05f 100644
> > --- a/testcases/kernel/syscalls/unlink/unlink09.c
> > +++ b/testcases/kernel/syscalls/unlink/unlink09.c
> > @@ -43,12 +43,12 @@ static void setup(void)
> >   {
> >       int attr;
> >
> > -     fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_CREAT, 0600);
> > +     fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_RDWR | O_CREAT,
> 0600);
> >       SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
> >       attr |= FS_IMMUTABLE_FL;
> >       SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
> >
> > -     fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_CREAT, 0600);
> > +     fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_RDWR |
> O_CREAT, 0600);
> >       SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
> >       attr |= FS_APPEND_FL;
> >       SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
> > @@ -79,7 +79,7 @@ static void verify_unlink(unsigned int i)
> >       /* If unlink() succeeded unexpectedly, test file should be
> restored. */
> >       if (!TST_RET) {
> >               if (tc->fd) {
> > -                     *(tc->fd) = SAFE_OPEN(tc->filename, O_CREAT, 0600);
> > +                     *(tc->fd) = SAFE_OPEN(tc->filename, O_RDWR |
> O_CREAT, 0600);
> >                       if (tc->flag) {
> >                               SAFE_IOCTL(*(tc->fd), FS_IOC_GETFLAGS,
> &attr);
> >                               attr |= tc->flag;
>
> Andrea
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
