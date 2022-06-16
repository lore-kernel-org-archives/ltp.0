Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C03C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 13:31:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 608963C81E1
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 15:31:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D838A3C0675
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 15:31:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7D3606002FD
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 15:31:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2DEE21B13;
 Thu, 16 Jun 2022 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655386262;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iokjdbQksSaYXcKtZ1m3d90gybD2YWLqKSTqmefsGN4=;
 b=JZvNX/VOlwZgBd9KM8RCQbvQ9X0g3IGz8p1o5HB6cC3LgVezWn/7yATLWAbi16JAcORYqR
 EszJWZ0jm0LZJddZmsGXXjJpJngS/A1fwbMQLoll0PgSP1D/XzVrkhF5FQjutyhzenPPK+
 t/I6wkzgykqfAlPSE9+eqfiWHjRNGCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655386262;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iokjdbQksSaYXcKtZ1m3d90gybD2YWLqKSTqmefsGN4=;
 b=kedO81BMhP103NtpHYgoo8h9IO23oeJfpL6sDiMfl4DSLRLL7sH/+Ft9q1S2jP+Xt/XWBR
 5W73aUgcpJeSTfCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A9AD13A70;
 Thu, 16 Jun 2022 13:31:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F7VVIZYwq2KrGgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jun 2022 13:31:02 +0000
Date: Thu, 16 Jun 2022 15:31:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YqswlUo82GnEzEnE@pevik>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-4-amir73il@gmail.com>
 <20220614102609.matiab5wmhc43nm4@quack3.lan>
 <CAOQ4uxitmPwwGHiAonZjyqJKG=+SvzraGG9ot1=a2iNrcscAAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxitmPwwGHiAonZjyqJKG=+SvzraGG9ot1=a2iNrcscAAQ@mail.gmail.com>
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, Jun 14, 2022 at 1:26 PM Jan Kara <jack@suse.cz> wrote:

> > On Mon 13-06-22 17:38:24, Amir Goldstein wrote:
> > > Move the test file into a test directory, so we won't set a mark
> > > on the mount path when watching the children of a directory.

> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>

> > One question below...

> > > diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > index 067dd65ae..efef25135 100644
> > > --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > @@ -74,16 +74,19 @@ static int filesystem_mark_unsupported;

> > >  #define MOUNT_PATH "fs_mnt"
> > >  #define MNT2_PATH "mntpoint"
> > > +#define DIR_NAME "testdir"
> > >  #define FILE_NAME "testfile"
> > >  #define FILE2_NAME "testfile2"
> > >  #define TEST_APP "fanotify_child"
> > >  #define TEST_APP2 "fanotify_child2"
> > > -#define FILE_PATH MOUNT_PATH"/"FILE_NAME
> > > -#define FILE2_PATH MOUNT_PATH"/"FILE2_NAME
> > > +#define DIR_PATH MOUNT_PATH"/"DIR_NAME
> > > +#define FILE_PATH DIR_PATH"/"FILE_NAME
> > > +#define FILE2_PATH DIR_PATH"/"FILE2_NAME
> > >  #define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP
> > >  #define FILE2_EXEC_PATH MOUNT_PATH"/"TEST_APP2
> > > -#define FILE_MNT2 MNT2_PATH"/"FILE_NAME
> > > -#define FILE2_MNT2 MNT2_PATH"/"FILE2_NAME
> > > +#define DIR_MNT2 MNT2_PATH"/"DIR_NAME
> > > +#define FILE_MNT2 DIR_MNT2"/"FILE_NAME
> > > +#define FILE2_MNT2 DIR_MNT2"/"FILE2_NAME
> > >  #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
> > >  #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2

> > > @@ -239,50 +242,50 @@ static struct tcase {
> > >       },
> > >       {
> > >               "ignore events on children of directory created on a specific file",
> > > -             MNT2_PATH, FANOTIFY_INODE,
> > > -             FILE_PATH, FANOTIFY_INODE,
> > > +             DIR_MNT2, FANOTIFY_INODE,
> > > +             DIR_PATH, FANOTIFY_INODE,
> > >               FAN_EVENT_ON_CHILD,
> > >               FILE_PATH, 0, FAN_OPEN
> > >       },

> > I'm somewhat confused here why you remove the FILE_PATH test here... In all
> > the other tests you just replace MNT2_PATH with DIR_PATH which makes sense.


> Good question.
> I guess while doing the conversion, I realized that the test case definition
> was wrong, so I fixed it and forgot to mention it in the commit message.

> The test case (#17) should be placing an ignored mask on a directory
> (DIR_PATH) with FAN_EVENT_ON_CHILD and see that the event on
> a child (FILE_PATH) is ignored.

> But what the test case was doing is setting an ignored mask
> with FAN_EVENT_ON_CHILD on the child (FILE_PATH).

> Petr,

> Do you want to add this to the commit message?
> Or split to a separate patch?

Both ways work for me. Could you please rebase your LTP fork, do either of these
changes and ping me to pull?

Thx!

Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
