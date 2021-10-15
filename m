Return-Path: <SRS0=8P1C=PD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461C4C433FE
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 08:02:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C25F61056
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 08:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C25F61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11AEC3C1B31
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 10:02:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B1A23C12F4
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 10:02:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E14FF60218F
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 10:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634284920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cD/EKmOPnArwZmfHdY3IC6ppgJRvCuovLIyaPDkv1BQ=;
 b=eCK+uyP8cgMqGTHi/R/T8jJwA4d4zmb8hc7lvTXia3JvzjqECNtR42DmtBR0hdPtV0acYx
 RMmphpUhtUbl8TsTcsdFRvW0DtU2hMaY7/CF6TXMtm+X8lYpGkTzgxEih4+Ojxzf0uQ9ZP
 DGEB3QLNjTBqsJFiVx4G45vOUdBCxLY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-2YkC9VviPm6ORDNdlM0w5g-1; Fri, 15 Oct 2021 04:01:57 -0400
X-MC-Unique: 2YkC9VviPm6ORDNdlM0w5g-1
Received: by mail-oo1-f72.google.com with SMTP id
 b19-20020a4a3413000000b002b6d6a9dff5so3780662ooa.14
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 01:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cD/EKmOPnArwZmfHdY3IC6ppgJRvCuovLIyaPDkv1BQ=;
 b=8Cq4Id3S79aOa2wcVXTQeClARicq6I06lIad64o7CF3qvPR8l7wm3Ozax/U0WBDVBK
 fv0kYbYM5NhIwxxjPPgwOGfHgWypBmRJt7DVHR+VHZe7UZBC9zkA6hbtqPyPkYFetFUG
 cYP9i6kGXppPLn2sRwDPrXwQTSNXPHXMCx59akI4PHbxhNVNkhxg07ZCooRq6ISdOsOl
 DhlfuEfoOAo1cPR/vgIgce4xe0U+boP8TQF00H8F/t2rzXQvDMpq5eCSGTUu9eMwNmAm
 fujEbsVa2qSlv/zxN+AujUJCr3XgYNeSYHVVEG+K7ZmCwsmbsvvuLr7qoTDRSLC+eSqF
 JEow==
X-Gm-Message-State: AOAM533wBniuw79/8PGVKD0UD/m5LPgoeD5prShS9q4dW3sg5ykZEBjo
 rZCYNp6gBvJpcwgBr30gHYwMiLgnYaTXP5SH0Dm7cOysNU8CfitrAQDSNZjN8lQMBNM26mnJDBs
 D7pU7Mk1sKmT3Yvx2B221X61xjwk=
X-Received: by 2002:aca:b4c4:: with SMTP id d187mr16277928oif.66.1634284916515; 
 Fri, 15 Oct 2021 01:01:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdoLz56URm24QIxVkxkq2lJ6Tj0pYKQxkoiUurVW1rAOJ8ShEBl02stU9dBMFVqgwCLGvQykLr/C6dk4p6IuU=
X-Received: by 2002:aca:b4c4:: with SMTP id d187mr16277898oif.66.1634284915922; 
 Fri, 15 Oct 2021 01:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211015073031.18642-1-pvorel@suse.cz>
 <61692F98.80404@fujitsu.com>
In-Reply-To: <61692F98.80404@fujitsu.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Oct 2021 10:01:40 +0200
Message-ID: <CAASaF6xZaRrm-6D_8aALzQo+qx9=_oWDRvhwcAmYMo7=13SOog@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] creat09: Run on all_filesystems
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Oct 15, 2021 at 9:37 AM xuyang2018.jy@fujitsu.com
<xuyang2018.jy@fujitsu.com> wrote:
>
> Hi Petr
> > To make sure bug on XFS is detected on systems which use it.
> >
> > Due setgid is test problematic on Microsoft filesystems:
> >
> > creat09.c:81: TBROK: ntfs: Setgid bit not set
> > creat09.c:76: TBROK: chown(exfat,65533,4) failed: EPERM (1)
> > creat09.c:76: TBROK: chown(vfat,65533,4) failed: EPERM (1)
> >
> > thus they're disabled.
> >
> > Signed-off-by: Petr Vorel<pvorel@suse.cz>
> > ---
> > Changes v1->v2:
> > * drop useless code creating directory (reported by Martin Doucha)
> >
> >   testcases/kernel/syscalls/creat/creat09.c | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> > index 681b80c7d..1d6c1643c 100644
> > --- a/testcases/kernel/syscalls/creat/creat09.c
> > +++ b/testcases/kernel/syscalls/creat/creat09.c
> > @@ -33,13 +33,15 @@
> >   #include<stdlib.h>
> >   #include<sys/types.h>
> >   #include<pwd.h>
> > +#include<stdio.h>

Is this new include still needed?

> >   #include "tst_test.h"
> >   #include "tst_uid.h"
> >
> >   #define MODE_RWX        0777
> >   #define MODE_SGID       (S_ISGID|0777)
> >
> > -#define WORKDIR              "testdir"
> > +#define MNTPOINT     "mntpoint"
> > +#define WORKDIR              MNTPOINT "testdir"
> You missed "/".
> >   #define CREAT_FILE  WORKDIR "/creat.tmp"
> >   #define OPEN_FILE   WORKDIR "/open.tmp"
> >
> > @@ -51,6 +53,8 @@ static void setup(void)
> >       struct stat buf;
> >       struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
> >
> > +     SAFE_CHDIR(MNTPOINT);
> Why need chdir?

Agreed, either make WORKDIR relative to MNTPOINT and use chdir
or add "/" and then chdir can be dropped.

> > +
> >       tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)ltpuser->pw_uid,
> >               (int)ltpuser->pw_gid);
> >       free_gid = tst_get_free_gid(ltpuser->pw_gid);
> > @@ -119,6 +123,15 @@ static struct tst_test test = {
> >       .cleanup = cleanup,
> >       .needs_root = 1,
> >       .needs_tmpdir = 1,
> This can be removed.

True, since mntpoint implies tmpdir. But for readability I'd keep it,
it makes it
more visible that cwd is tmpdir at start of test.

>
> Best Regards
> Yang Xu
> > +     .all_filesystems = 1,
> > +     .mount_device = 1,
> > +     .mntpoint = MNTPOINT,
> > +     .skip_filesystems = (const char*[]) {
> > +             "exfat",
> > +             "ntfs",
> > +             "vfat",
> > +             NULL
> > +     },
> >       .tags = (const struct tst_tag[]) {
> >               {"linux-git", "0fa3ecd87848"},
> >               {"CVE", "2018-13405"},
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
