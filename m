Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0892FC3A59D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 07:16:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A47A63C922F
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 09:16:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE2203C04D1
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 09:16:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EF1AD1000676
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 09:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666595783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/40Laem9BoF0jlWINqfUeVO09P/GkhooXVR255aNMc=;
 b=bx4oj80vOV31Qv6gGFJ3HJvcg9hma+KGs0MPN2IHuif3HF6v1lK4iaHx6mREXJDqW0/Kj6
 JNqo9Gki+4use4l03DJ9Dukay9DAeUXKrNUGetXuKTPh3NST4Wz2guOUwQzqAqWqS0qvzp
 CylUB3RKbC0sJXmycFDs1Ro4N2BplTw=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-Q9hut7VhMCmykUIki82bjw-1; Mon, 24 Oct 2022 03:16:21 -0400
X-MC-Unique: Q9hut7VhMCmykUIki82bjw-1
Received: by mail-vk1-f198.google.com with SMTP id
 t77-20020a1faa50000000b003b77493b034so60330vke.5
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 00:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0/40Laem9BoF0jlWINqfUeVO09P/GkhooXVR255aNMc=;
 b=BUskt6Bjqbk02uOVGuymFbiyTybGQbd7BxFi9qYBRpcbpTMrzq22DYt9UgPtDqksbd
 lI6FmPzgsHZJB6tqcPjRnUoPSEr4nbUJcLn2u6ndhX9FMdPwkEX/yEiqJcHZquyTnD24
 pyc2RWnCp5tP/QTBNZLR+f43Os11aaYSZeKaAfQM4STrMfLW2d8ftJfzdVSzFOEC9mFg
 BnOgpYrErUjzKT3jzB4m+pXuWKcTFJbRZdikSs6fMSGDlr0cpUkEnrmaW2F9k6MXMde4
 MlrdRaYJhiYH7W7UdJyI/6nhLFTqyrLnMBmiqDwx3FTbmwKnGYSaVN80hiDfd0z0Y/fy
 NAXA==
X-Gm-Message-State: ACrzQf2roqB2JVECbjNJr+Q/HXI2j4KxIE2LHqmOeY+iqJ4pNqPYjnj1
 xjQvLAgZm/VBFH/A0EvjYMkazUIX7UzKw3fRJthu0zu4LrmuwWcIUzfxK7XUwAmmhEyOo2OPTJh
 IXxkttyPGURxO+l+hOdbYuFrZ8r0=
X-Received: by 2002:a1f:9f16:0:b0:3af:1cc7:5096 with SMTP id
 i22-20020a1f9f16000000b003af1cc75096mr17768536vke.8.1666595781240; 
 Mon, 24 Oct 2022 00:16:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4CLxGqpu3obhc2ZObvgjQX1uOaGhGQFR/emKbGIBeCOipBhIFtVvTmxxB/I+CubNtZ6DXtw05UtXmOZCwWiEs=
X-Received: by 2002:a1f:9f16:0:b0:3af:1cc7:5096 with SMTP id
 i22-20020a1f9f16000000b003af1cc75096mr17768527vke.8.1666595780877; Mon, 24
 Oct 2022 00:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221021155740.8339-1-mdoucha@suse.cz> <Y1MCbP1yjLOuoPLb@pevik>
In-Reply-To: <Y1MCbP1yjLOuoPLb@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 24 Oct 2022 09:16:03 +0200
Message-ID: <CAASaF6ySEcVE=b-7nGy+FeLyg_6dNMjL6J_bivjZ6JYzSx5b=w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] save_restore: Check whether path is writable
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

On Fri, Oct 21, 2022 at 10:35 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Martin,
>
> [ Cc Jan, who implemented the original behavior ]
>
> > Tests using the .save_restore functionality currently cannot run
> > without root privileges at all because the test will write
> > into the path at least at the end and trigger error, even when
> > the config paths are flagged as optional.

Problem description makes it sound like this issue affects all 3 types
of config options. Isn't the problem affecting only optional config paths?

Having entry with "(no prefix)" or "!" in save_restore implies that
test wants to write to that path - if we TCONF on root privileges or
read/write access probably doesn't make much difference - we can't
continue.

For "?" prefix, I agree that since its optional, test should be able
to run cleanly without root privileges.

> Check whether .save_restore
> > paths are writable and handle negative result the same way as if
> > the path does not exist.

Do you mean for "?" prefix only?

>
> > Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> > ---
>
> > This is the first part of sysfile handling fixes to allow running some
> > tests without root privileges again. I think this is a good enough solution
> > for the save_restore part but we should discuss a few open questions first:
>
> > 1) Is it OK to fail early during sysfile save when the test would otherwise
> >    run fine but throw TWARN at the end because the sysfile is read-only?
> I don't think that would be a good change.

For optional path, if test can't read/write it (b/o of no root privileges),
I think library shouldn't try to save it - then that would also skip
attempt to restore it.

>
> > 2) Should the '?' flag skip read-only files as if they don't exist?
I think yes. If we can't restore those files, that means test shouldn't
be able to change those and we don't need to worry about saving them.

> >    Alternatively, we could still let the '?' flag fail trying to write
> >    into read-only sysfiles and instead introduce a new flag for cases where
> >    read-only file should be skipped.
> Looking at files which use '?', some of them (mostly network related, I guess
> written/rewritten by Martin) use SAFE_TRY_FILE_PRINTF() on
> /proc/sys/user/max_user_namespaces. It looks to me these need to to skip
> read-only files, i.e. define new flag with this behavior.
>
>
> Kind regards,
> Petr
>
> >  doc/c-test-api.txt | 11 +++++------
> >  lib/tst_sys_conf.c | 32 ++++++++++++++++++++++----------
> >  2 files changed, 27 insertions(+), 16 deletions(-)
>
> > diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> > index 64ee3397f..0f36b5a67 100644
> > --- a/doc/c-test-api.txt
> > +++ b/doc/c-test-api.txt
> > @@ -1601,13 +1601,12 @@ If non-NULL value is passed it is written to the respective file at
> >  the beginning of the test. Only the first line of a specified file
> >  is saved and restored.
>
> > -Pathnames can be optionally prefixed to specify how strictly (during
> > -'store') are handled errors:
> > +Pathnames can be optionally prefixed to specify how to handle missing or
> > +read-only files:
>
> > -* (no prefix) - test ends with 'TCONF', if file doesn't exist
> > -* '?'         - test prints info message and continues,
> > -                if file doesn't exist or open/read fails
> > -* '!'         - test ends with 'TBROK', if file doesn't exist
> > +* (no prefix) - test ends with 'TCONF'
> > +* '?'         - test prints info message and continues, even on read error
> > +* '!'         - test ends with 'TBROK'
>
> >  'restore' is always strict and will TWARN if it encounters any error.
>
> > diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
> > index 003698825..1e381a249 100644
> > --- a/lib/tst_sys_conf.c
> > +++ b/lib/tst_sys_conf.c
> > @@ -20,6 +20,22 @@ struct tst_sys_conf {
>
> >  static struct tst_sys_conf *save_restore_data;
>
> > +static void print_access_error(char flag, const char *err, const char *path)
> > +{
> > +     switch (flag) {
> > +     case '?':
> > +             tst_res(TINFO, "%s: '%s'", err, path);
> > +             break;
> > +
> > +     case '!':
> > +             tst_brk(TBROK|TERRNO, "%s: '%s'", err, path);
> > +             break;
> > +
> > +     default:
> > +             tst_brk(TCONF|TERRNO, "%s: '%s'", err, path);
> > +     }
> > +}
> > +
> >  void tst_sys_conf_dump(void)
> >  {
> >       struct tst_sys_conf *i;
> > @@ -59,16 +75,12 @@ int tst_sys_conf_save(const char *path)
> >               path++;
>
> >       if (access(path, F_OK) != 0) {
> > -             switch (flag) {
> > -             case '?':
> > -                     tst_res(TINFO, "Path not found: '%s'", path);
> > -                     break;
> > -             case '!':
> > -                     tst_brk(TBROK|TERRNO, "Path not found: '%s'", path);
> > -                     break;
> > -             default:
> > -                     tst_brk(TCONF|TERRNO, "Path not found: '%s'", path);
> > -             }
> > +             print_access_error(flag, "Path not found", path);
> > +             return 1;
> > +     }
> > +
> > +     if (access(path, W_OK) != 0) {
> > +             print_access_error(flag, "Path is not writable", path);
> >               return 1;
> >       }
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
