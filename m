Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8938DC43334
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 11:11:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 231FC3C9481
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 13:11:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEB513C1925
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 13:11:02 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6770F1A00641
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 13:11:02 +0200 (CEST)
Received: by mail-ua1-x929.google.com with SMTP id p3so3143351uam.12
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 04:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u3fgzsaPypQrEUPbD6Fzf7TnZGQ4cZHXJDvg6b129ZY=;
 b=ei1IeBViTuh07L/5M9RK9jsRgaSk+pZ7wiemxcceAkq2Vj6yW7t/ahckYSCMTi1pv+
 5+hIU6LPrR5HpdGvEWI/yl8VOUCxcNMTxAS+kvzSuzR0V0EDaQsQ+GYZMTuCMSNtGlOf
 QK0PykFAnPGDudot8H2N9VdspvtWnASsI+tRz3ExqhHUHAfW3ofM4UmR8Vx9g277Kz3E
 FaFBmc0SocNZVP/b+I1eL/cmw9wuzPWAkbS0k9Hj1DYBjqonSPaxfgoSFPlwCs7Xs8UY
 d+bFqbqkhcEiV+/pF/A2cFiMf4K3hZJY9gc8pAbb/IkfaMIZU+WaOYH9SiuxUwizAqTJ
 OkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u3fgzsaPypQrEUPbD6Fzf7TnZGQ4cZHXJDvg6b129ZY=;
 b=AeO9jYpsEpSUEe86wImDcShKzPGAExrqdT2+PiUmngNOiWjw4aJtii5JcK3KfdK3KB
 6k/ACJPmh1qFUfvyg4Klv5CmFEqdRY+yaQVWc5nREA3SW3IEiwfJRdlosXxwnW5VYUWt
 Xtml3JMkNdnEIAkafaAgUOX9QJAcpWRSbs/7E/oE3S+X78EiLeNoL6glg4UQMMJD5enk
 iJ7Wg+8fKuaGqWvL4Jt+0NN+Ftt889AJ06vsPO/CHzJeqPVzYvbGmO/j8HCSUG7NofXk
 /E9+rYjKlrm1Zm0eWde9vvtKVYREJbg28fMq5QAjsXaHQ1/b91xtxTJHvR5VekSOQLwo
 bYlg==
X-Gm-Message-State: AJIora8eKrkMTY1PycO4usOmrXo1IbIDkdClQvexFkC3IM9A81waBdWD
 KiUSESpJh3UnOpHKJx55c/KPiqdyaEgJRw3fdnA=
X-Google-Smtp-Source: AGRyM1t4UWMDMl0Z1iWJLm6TnE3vzK0zFyUoh8ke+C1q4imafJlT6sjhQ0rpHMblV8LNxFhaMeCImzOw2wg86tMmCrU=
X-Received: by 2002:ab0:3da8:0:b0:35d:1e90:ee26 with SMTP id
 l40-20020ab03da8000000b0035d1e90ee26mr1865287uac.80.1655205061066; Tue, 14
 Jun 2022 04:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-4-amir73il@gmail.com>
 <20220614102609.matiab5wmhc43nm4@quack3.lan>
In-Reply-To: <20220614102609.matiab5wmhc43nm4@quack3.lan>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 14 Jun 2022 14:10:49 +0300
Message-ID: <CAOQ4uxitmPwwGHiAonZjyqJKG=+SvzraGG9ot1=a2iNrcscAAQ@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>, Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 14, 2022 at 1:26 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 13-06-22 17:38:24, Amir Goldstein wrote:
> > Move the test file into a test directory, so we won't set a mark
> > on the mount path when watching the children of a directory.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> One question below...
>
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > index 067dd65ae..efef25135 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > @@ -74,16 +74,19 @@ static int filesystem_mark_unsupported;
> >
> >  #define MOUNT_PATH "fs_mnt"
> >  #define MNT2_PATH "mntpoint"
> > +#define DIR_NAME "testdir"
> >  #define FILE_NAME "testfile"
> >  #define FILE2_NAME "testfile2"
> >  #define TEST_APP "fanotify_child"
> >  #define TEST_APP2 "fanotify_child2"
> > -#define FILE_PATH MOUNT_PATH"/"FILE_NAME
> > -#define FILE2_PATH MOUNT_PATH"/"FILE2_NAME
> > +#define DIR_PATH MOUNT_PATH"/"DIR_NAME
> > +#define FILE_PATH DIR_PATH"/"FILE_NAME
> > +#define FILE2_PATH DIR_PATH"/"FILE2_NAME
> >  #define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP
> >  #define FILE2_EXEC_PATH MOUNT_PATH"/"TEST_APP2
> > -#define FILE_MNT2 MNT2_PATH"/"FILE_NAME
> > -#define FILE2_MNT2 MNT2_PATH"/"FILE2_NAME
> > +#define DIR_MNT2 MNT2_PATH"/"DIR_NAME
> > +#define FILE_MNT2 DIR_MNT2"/"FILE_NAME
> > +#define FILE2_MNT2 DIR_MNT2"/"FILE2_NAME
> >  #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
> >  #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
> >
> > @@ -239,50 +242,50 @@ static struct tcase {
> >       },
> >       {
> >               "ignore events on children of directory created on a specific file",
> > -             MNT2_PATH, FANOTIFY_INODE,
> > -             FILE_PATH, FANOTIFY_INODE,
> > +             DIR_MNT2, FANOTIFY_INODE,
> > +             DIR_PATH, FANOTIFY_INODE,
> >               FAN_EVENT_ON_CHILD,
> >               FILE_PATH, 0, FAN_OPEN
> >       },
>
> I'm somewhat confused here why you remove the FILE_PATH test here... In all
> the other tests you just replace MNT2_PATH with DIR_PATH which makes sense.
>

Good question.
I guess while doing the conversion, I realized that the test case definition
was wrong, so I fixed it and forgot to mention it in the commit message.

The test case (#17) should be placing an ignored mask on a directory
(DIR_PATH) with FAN_EVENT_ON_CHILD and see that the event on
a child (FILE_PATH) is ignored.

But what the test case was doing is setting an ignored mask
with FAN_EVENT_ON_CHILD on the child (FILE_PATH).

Petr,

Do you want to add this to the commit message?
Or split to a separate patch?

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
