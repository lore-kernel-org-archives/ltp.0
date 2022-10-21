Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4350C4332F
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 11:26:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2D063CB1A9
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 13:26:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 165BA3C93AA
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 13:26:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5CEA420038A
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 13:26:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 539851F8E6;
 Fri, 21 Oct 2022 11:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666351567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZZzRNJwGu3Itgm5U9UJ+GvHS2p9TXOb7vFhidojNAs=;
 b=bE14HwDxavQERl7x+abTq5p0YZIEWhKKEHIT79vt38fb28RGyi8nh6IizHxlQfUR8VjLkP
 sBO2muJ4G+XlmXaI9ZfGB07HMqCtP7pu+W40AkYuOQLY8R+0DCPyuOzqu5TDLTTFmbBNKF
 XZJQlEOdeoi//Q3x9Wv99dgqztBKC18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666351567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZZzRNJwGu3Itgm5U9UJ+GvHS2p9TXOb7vFhidojNAs=;
 b=DHReDFdXtrCyWqF4UzhBdFeDMMzhK98xDePgZL2eVNFFGGe438RPwdiErbmR6Hg6Jq1+WU
 iJsyqUBT1893JbBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23AAB1331A;
 Fri, 21 Oct 2022 11:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Bws1B8+BUmOxPAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Oct 2022 11:26:07 +0000
Date: Fri, 21 Oct 2022 13:26:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y1KBzfdqbibHmAa3@pevik>
References: <20221020133715.256521-1-akihiko.odaki@daynix.com>
 <Y1GFvU/ixieqDSq6@pevik> <Y1JiQSWlxVSkhuoq@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1JiQSWlxVSkhuoq@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > > index 28b7d12ba..5ebbe1d25 100644
> > > --- a/testcases/lib/tst_test.sh
> > > +++ b/testcases/lib/tst_test.sh
> > > @@ -831,3 +831,5 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
> > >  		fi
> > >  	fi
> > >  fi
> > > +
> > > +export LC_ALL=C

> > Thinking about it twice this might have impact on other tests.
> > Li, Cyril, any idea about it?

> Actually I think that we should have put this into the tst_test.sh from
> the start. We do have this as a workaround in du01.sh and telnet01.sh
> already.

> The plus side is that all possible bugreports from users will have all
> messages in english which would make debugging easier.

Thanks for acking this.

I suppose Akihiko is correct that we don't have to put it via setlocale()
in C API, right?

Also I guess you prefer this version (LC_ALL=C). I suggested unset LC_ALL;
export LC_COLLATE=C; export LC_NUMERIC=C as it's used in kernel's Makefile (they
have more there, but IMHO only this is relevant for us).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
