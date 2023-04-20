Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392E1C77B72
	for <ltp@archiver.kernel.org>; Thu, 20 Apr 2023 14:53:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78DD43CBFAB
	for <ltp@archiver.kernel.org>; Thu, 20 Apr 2023 16:53:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAEB23CB33B
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 16:53:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B2F1F1A009B4
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 16:53:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B26B3218B5;
 Thu, 20 Apr 2023 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682002389;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMsvMs0I429atJZpfzIMEbiLBy4PvfyTsqWTfUW+XXk=;
 b=TNMt5FzZD8h9NRtDepqVoQaAkWts168GM4Y5u1lJCa+nGu3KTqB7CsXmMh+Xjojk9xLQEf
 STTXDN+P5Tt1ocixjUdbiP/D2N7PO21TEuYGQ6bFUf43tTASODgEo7/MJvixxIfeyCSlVw
 i4/ZZa3KY9lG0yN2i1d5KglAVQEO1NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682002389;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMsvMs0I429atJZpfzIMEbiLBy4PvfyTsqWTfUW+XXk=;
 b=Q8qQrAlxHL6s1iEm9usi7VECXa7tQZPhT1+lNImNiR/FlZ6W+qkJm2T1umeH36tgLWW7ae
 ssLgE543/MHReFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 900721333C;
 Thu, 20 Apr 2023 14:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KqbfIdVRQWQ8SQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Apr 2023 14:53:09 +0000
Date: Thu, 20 Apr 2023 16:53:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230420145315.GA2694798@pevik>
References: <20230413111434.2103422-1-pvorel@suse.cz>
 <CAEemH2fZU=b60mSD8PoZoQiJ7WQ+rhWiOqPO4XGyhS9aB2QDcA@mail.gmail.com>
 <CAEemH2eu2LCyM3g+2BcD2ZFaGSZ2R+V7-zbYc3Kg4kb=vqtiDA@mail.gmail.com>
 <20230419095939.GA2577418@pevik>
 <CAEemH2fAojMkcK2xEw+aM5oh9Csed-eOtHAs98OCydVRfyCzGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fAojMkcK2xEw+aM5oh9Csed-eOtHAs98OCydVRfyCzGQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_tmpdir: Remove possible double/trailing
 slashes from TMPDIR
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,
...
> > > >> +++ b/lib/tst_tmpdir.c
> > > >> @@ -124,16 +124,28 @@ char *tst_get_tmpdir(void)

> > > >>  const char *tst_get_tmpdir_root(void)
> > > >>  {
> > > >> -       const char *env_tmpdir = getenv("TMPDIR");
> > > >> +       char *env_tmpdir = getenv("TMPDIR");


> > > > It seems that modifying the environment variables is generally
> > > > not a good practice.

> > > > The getenv() function returns a pointer to the value of an
> > > > environment variable, which is stored in the memory managed
> > > > by the system. Any attempt to modify this memory directly can
> > > > cause unexpected behavior or even crash the program.

> > > > Instead of modifying the return value of getenv(), it is recommended
> > > > to create a copy of the value and modify the copy instead.

> > Do you mean to use strdup()?


> Yeah, something like that, or we declare a buffer, and use strcpy()
> to copy the string pointed to by the return value of getenv() into the
> buffer that we can safely modify.

> I prefer it in this way.


Sure, I'll post new version with this. Until then I keep this patch open if
anybody wants to comment it.

> > Also man getenv(3) says:

> >        As typically implemented, getenv() returns a pointer to a string
> >        within the environment list.  The caller must take care not to
> >        modify this string, since that would change the environment of
> >        the process.

> > => I would not mind $TMPDIR got updated in the environment.

> > > Btw, the wise method is to use setenv() function to reset
> > > environment variables if really needed.

> > Well, I don't know any C test which needs it (only NFS tests which are
> > shell
> > tests). But I wanted to have the same behavior in both APIs.

> > > This is a different part of shell API I have to say.

> > Yes, the behavior is slightly different from shell API [1],
> > where it modifies $TST_TMPDIR (keep $TMPDIR untouched).


> > > > Or, the simplest way I guess is just TBROK and tell users why
> > > > this TMPDIR is unusable.

> > If you prefer it's better to TBROK on:
> > * double slashes
> > * trailing slash

> > I can do that. But at least on trailing slash looks to me quite strict.


> -1, trailing and double slash all accepted by shell in command line,
> maybe we shouldn't set a more strict policy than that.

Agree, I just didn't understand before your concern (you mostly objected the C
code, not the fact that the resulted path is modified).

Thanks for your reviewn!

Kind regards,
Petr




> > Whatever path we choose, I'd need also to update docs. BTW the need
> > to absolute path for TMPDIR is only in C - shell happily takes relative
> > path
> > and IMHO it's not documented.

> > Kind regards,
> > Petr

> > [1]
> > https://patchwork.ozlabs.org/project/ltp/patch/20230412073953.1983857-1-pvorel@suse.cz/

> > > >> -       if (!env_tmpdir)
> > > >> +       if (env_tmpdir) {
> > > >> +               /* remove duplicate slashes */
> > > >> +               for (char *p = env_tmpdir, *q = env_tmpdir; *q;) {
> > > >> +                       if (*++q != '/' || *p != '/')
> > > >> +                               *++p = *q;
> > > >> +               }
> > > >> +               /* Remove slash on the last place  */
> > > >> +               size_t last = strlen(env_tmpdir)-1;
> > > >> +               if (env_tmpdir[last] == '/')
> > > >> +                       env_tmpdir[last] = '\0';
> > > >> +       } else {
> > > >>                 env_tmpdir = TEMPDIR;
> > > >> +       }

> > > >>         if (env_tmpdir[0] != '/') {
> > > >>                 tst_brkm(TBROK, NULL, "You must specify an absolute "
> > > >>                                 "pathname for environment variable
> > > >> TMPDIR");
> > > >>                 return NULL;
> > > >>         }
> > > >> +
> > > >>         return env_tmpdir;
> > > >>  }

> > > >> --
> > > >> 2.40.0



> > > > --
> > > > Regards,
> > > > Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
