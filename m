Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F07C43334
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 13:47:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC6683C62DF
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 15:46:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B4403C0277
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 15:46:48 +0200 (CEST)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E8E3C6018CB
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 15:46:47 +0200 (CEST)
Received: by mail-ua1-x934.google.com with SMTP id l9so494096uac.4
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MtJmxtjJPlpegJJKN0mRFELEJZbCKd3jrV1JS6QczXU=;
 b=bVIBjw6S7pViqOdg0soanNUfw/VeAmtu0x3btAl4hFWFV+OHA1SDQC4iZ+DgVamODb
 xEJSih4xkQA+Dkqx3hbT5dsR8uEqC4wel/HriE4XIBMe9HBG7leyMKhiEycW6KN9eIzT
 3NMTaZz9/GP3oHSeDLwJg+FgN04hcpI36t64HRASRN+Tw0TzXbeO4s5x5QsHHP4FJmnT
 6oSaC/YsT1Kup2JLty4Rw6e58pTyo50Ii8Y1aej0nyPXl5YRKm7hjD5c5nXd9pJHUGhS
 uiHXIUnEhTqqtIFG2SyWD/s01aAoMUM+h9oY916be/T9nuR8PS17QVdb2T3KBuoF3mAR
 /+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MtJmxtjJPlpegJJKN0mRFELEJZbCKd3jrV1JS6QczXU=;
 b=3ON8q67VElqJUy2F37iG8U78R/Q19TK3e4KZA1Hqp1RB4nc5uK3BiGKLZ9XI+fvdel
 kp89CWsLbeiGqPV6+EpELgR8WjycS+6RZTDjqyqSiOauCktA8DVD/ALE3dkjbBiQNEOs
 eawTrVFffiufwrl/PsPqrZI+gHJeWllf4k6kzACkeiPBv7KAe2FZ/rxFrYycTz5fu8qt
 +DEBD4vomCdNVkTXCl9YMAUKDs7sjiR56jx0E0BghxizDw0iQkBHn7uyVfyxyXmpYaDb
 +PDYNYhQ3mbrVEEczkBLyC8eZHhk/aICf7YU1Nt89XMWULFj4m1NjgJLwniMbeF9S1Ek
 07Fg==
X-Gm-Message-State: AJIora/IS0zpffEOU+utUWIACcCqqCxLA9xjrI8ovOaRi48U87pCLcWm
 TwiiQ7ZBW7+hIXKXWvlqMMuWJSY70aCy2dkhoa/HwD9oRYaZTg==
X-Google-Smtp-Source: AGRyM1uE+cMm+Luh5h6J5Df2XYy4IKdpdQ4XZMvNqeD//f3W5Fy0WE+Y3Acnw7xxXX9NCetNhGHYsHLRgBYB1J1YSnw=
X-Received: by 2002:a9f:23c2:0:b0:365:958:e807 with SMTP id
 60-20020a9f23c2000000b003650958e807mr2016170uao.114.1655387206851; Thu, 16
 Jun 2022 06:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-4-amir73il@gmail.com>
 <20220614102609.matiab5wmhc43nm4@quack3.lan>
 <CAOQ4uxitmPwwGHiAonZjyqJKG=+SvzraGG9ot1=a2iNrcscAAQ@mail.gmail.com>
 <YqswlUo82GnEzEnE@pevik>
In-Reply-To: <YqswlUo82GnEzEnE@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 16 Jun 2022 16:46:35 +0300
Message-ID: <CAOQ4uxhOitNbnQVCx0RdEh2ne6wMnFD-UEc=+QHpGn_7Xez81w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] syscalls/fanotify10: Watch directory that is
 not the mount path
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

On Thu, Jun 16, 2022 at 4:31 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Tue, Jun 14, 2022 at 1:26 PM Jan Kara <jack@suse.cz> wrote:
>
> > > On Mon 13-06-22 17:38:24, Amir Goldstein wrote:
> > > > Move the test file into a test directory, so we won't set a mark
> > > > on the mount path when watching the children of a directory.
>
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> > > One question below...
>
> > > > diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > > index 067dd65ae..efef25135 100644
> > > > --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > > +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > > @@ -74,16 +74,19 @@ static int filesystem_mark_unsupported;
>
> > > >  #define MOUNT_PATH "fs_mnt"
> > > >  #define MNT2_PATH "mntpoint"
> > > > +#define DIR_NAME "testdir"
> > > >  #define FILE_NAME "testfile"
> > > >  #define FILE2_NAME "testfile2"
> > > >  #define TEST_APP "fanotify_child"
> > > >  #define TEST_APP2 "fanotify_child2"
> > > > -#define FILE_PATH MOUNT_PATH"/"FILE_NAME
> > > > -#define FILE2_PATH MOUNT_PATH"/"FILE2_NAME
> > > > +#define DIR_PATH MOUNT_PATH"/"DIR_NAME
> > > > +#define FILE_PATH DIR_PATH"/"FILE_NAME
> > > > +#define FILE2_PATH DIR_PATH"/"FILE2_NAME
> > > >  #define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP
> > > >  #define FILE2_EXEC_PATH MOUNT_PATH"/"TEST_APP2
> > > > -#define FILE_MNT2 MNT2_PATH"/"FILE_NAME
> > > > -#define FILE2_MNT2 MNT2_PATH"/"FILE2_NAME
> > > > +#define DIR_MNT2 MNT2_PATH"/"DIR_NAME
> > > > +#define FILE_MNT2 DIR_MNT2"/"FILE_NAME
> > > > +#define FILE2_MNT2 DIR_MNT2"/"FILE2_NAME
> > > >  #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
> > > >  #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
>
> > > > @@ -239,50 +242,50 @@ static struct tcase {
> > > >       },
> > > >       {
> > > >               "ignore events on children of directory created on a specific file",
> > > > -             MNT2_PATH, FANOTIFY_INODE,
> > > > -             FILE_PATH, FANOTIFY_INODE,
> > > > +             DIR_MNT2, FANOTIFY_INODE,
> > > > +             DIR_PATH, FANOTIFY_INODE,
> > > >               FAN_EVENT_ON_CHILD,
> > > >               FILE_PATH, 0, FAN_OPEN
> > > >       },
>
> > > I'm somewhat confused here why you remove the FILE_PATH test here... In all
> > > the other tests you just replace MNT2_PATH with DIR_PATH which makes sense.
>
>
> > Good question.
> > I guess while doing the conversion, I realized that the test case definition
> > was wrong, so I fixed it and forgot to mention it in the commit message.
>
> > The test case (#17) should be placing an ignored mask on a directory
> > (DIR_PATH) with FAN_EVENT_ON_CHILD and see that the event on
> > a child (FILE_PATH) is ignored.
>
> > But what the test case was doing is setting an ignored mask
> > with FAN_EVENT_ON_CHILD on the child (FILE_PATH).
>
> > Petr,
>
> > Do you want to add this to the commit message?
> > Or split to a separate patch?
>
> Both ways work for me. Could you please rebase your LTP fork, do either of these
> changes and ping me to pull?

Done:
https://github.com/amir73il/ltp/commits/fan_evictable

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
