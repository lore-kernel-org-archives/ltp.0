Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F89AC4332F
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 12:41:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 050F63CB1D3
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 14:41:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40BA33CAFAC
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 14:41:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6B3F81A01149
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 14:41:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA1481F8E9;
 Fri, 21 Oct 2022 12:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666356068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5kpfm1hnRUEyxuLmpaCdrMRHewzcXlwQeFuGdP8smyI=;
 b=wSkL2Tq8M0fC8cO/BfvmYK5E87h80qMpqEXyIPBLxOFI6sqZNqdM2yVX6+c16Py84hw8Ck
 7XTS7q9AeN017bCwdalx13qrLvBCXmenIXVjpCTIa3ba1w+wiGYgUvg36XdgM6jI0wCFXa
 5thLrqJwX4GJiOq5CAmhwyBvv0VAexk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666356068;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5kpfm1hnRUEyxuLmpaCdrMRHewzcXlwQeFuGdP8smyI=;
 b=fkzp+jd2f3TBhsmgeWAokMcE23QVWobbsFO/oQwFlnSyGLVbTQXw5QeKMQy+lPy/wcphrO
 xNqpiZHcGoGbfdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C760313A0E;
 Fri, 21 Oct 2022 12:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c3qqMGSTUmMVZwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Oct 2022 12:41:08 +0000
Date: Fri, 21 Oct 2022 14:42:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y1KTyn/9pv5lvbhj@yuki>
References: <20221020133715.256521-1-akihiko.odaki@daynix.com>
 <Y1GFvU/ixieqDSq6@pevik> <Y1JiQSWlxVSkhuoq@yuki>
 <Y1KBzfdqbibHmAa3@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1KBzfdqbibHmAa3@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] tst_test.sh: Normalize the locale
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > > > index 28b7d12ba..5ebbe1d25 100644
> > > > --- a/testcases/lib/tst_test.sh
> > > > +++ b/testcases/lib/tst_test.sh
> > > > @@ -831,3 +831,5 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
> > > >  		fi
> > > >  	fi
> > > >  fi
> > > > +
> > > > +export LC_ALL=C
> 
> > > Thinking about it twice this might have impact on other tests.
> > > Li, Cyril, any idea about it?
> 
> > Actually I think that we should have put this into the tst_test.sh from
> > the start. We do have this as a workaround in du01.sh and telnet01.sh
> > already.
> 
> > The plus side is that all possible bugreports from users will have all
> > messages in english which would make debugging easier.
> 
> Thanks for acking this.
> 
> I suppose Akihiko is correct that we don't have to put it via setlocale()
> in C API, right?

I do not think so. It's not entirely clear from documentation how this
is supposed to work. However it seems that in bash the effect is
immediate, if you export new locale and then type nonexisting command
name to bash prompt to get a message from bash it's in the new locale.
So either setlocale() is not needed or bash calls it if it detects that
one of the LC_ variables has been changed and calls it.

For dash it does not seem that it has been translated at all, it
produces messages in english either way, so we do not have to care.

And all localized programs that we start from the shell after the export
do call setlocale() at the start of the main(). That is actually
required to enable locale support to begin with.

> Also I guess you prefer this version (LC_ALL=C). I suggested unset LC_ALL;
> export LC_COLLATE=C; export LC_NUMERIC=C as it's used in kernel's Makefile (they
> have more there, but IMHO only this is relevant for us).

I do not think that LC_COLLATE and LC_NUMERIC is enough, we want actuall
messages in english. If we do not want to use LC_ALL, which is probably
the easiest we should use at least LC_MESSAGES and LC_NUMERIC but
possibly LC_TIME too since date and time can be part of the messages we
do parse as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
