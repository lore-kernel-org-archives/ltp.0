Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A8FC433F5
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 16:04:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E95523C9DED
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 18:04:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81A9B3C0FED
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 18:04:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9F9DD1A01146
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 18:04:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7447210DF;
 Tue, 29 Mar 2022 16:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648569839;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aycQia48k446wUbZhLoKad7OdPRTZYvVtFNP5A9a0AY=;
 b=PX+9pIWlHOqTiHbn3juxDEnFSGlFxQORVqEqYBRSiHf5b+FTZG9hFC3xiQQUrMgkksXOn9
 mf82lQPNdRUFMmozs/pQ8P/rVLxHrhw/ltM4bR9Ahwdgz0fIDQp80/zlRfb8t3Y8nkuE9C
 Nn8Wr9W5QCNOeErrSezV02oz1PPrdRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648569839;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aycQia48k446wUbZhLoKad7OdPRTZYvVtFNP5A9a0AY=;
 b=pg1kcWBMeQMhCM0HOfOuecwKtiDil2mR7aZ4T4hCzKRRSLMKP2HFwQhnMnH5U9LfO2yIsK
 K5Bqubz2LRhzNzDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D8DD13A7E;
 Tue, 29 Mar 2022 16:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ekVCJu8tQ2JqCQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 29 Mar 2022 16:03:59 +0000
Date: Tue, 29 Mar 2022 18:03:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YkMt7jRjMwdoIduD@gacrux.arch.suse.de>
References: <20220328123114.31881-1-andrea.cervesato@suse.de>
 <YkHNxNcEy/xHv5wz@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YkHNxNcEy/xHv5wz@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix wqueue09 according with 5.17 kernel updates
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

Hi Cyril, Andrea,

> >  testcases/kernel/watchqueue/wqueue09.c | 8 ++++----
...
> >  	key = wqueue_add_key(fd);
> > -	keyctl(KEYCTL_UPDATE, key, "b", 1);
> > -	keyctl(KEYCTL_REVOKE, key);
> > +	for (i = 0; i < 256; i++)
> > +		keyctl(KEYCTL_UPDATE, key, "b", 1);

> Have you tried this on any machine with 64k pages? If the minimal size
> is rounded to a PAGE_SIZE and we get 32 messages in 4k page that would
> mean that we would fit 512 messages in 64k page. So maybe we would need
> 512 messages on 65k page size?

FYI while test works on small -i, it blocks on higher:

./wqueue09 -i1000
...
common.h:153: TINFO: NOTIFY[000]: ty=000000 sy=01 i=00000008
wqueue09.c:48: TPASS: Meta loss notification received
common.h:134: TINFO: Reading watch queue events
common.h:153: TINFO: NOTIFY[000]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[010]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[020]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[030]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[040]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[050]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[060]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[070]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[080]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[090]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[0a0]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[0b0]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[0c0]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[0d0]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[0e0]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[0f0]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[100]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[110]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[120]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[130]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[140]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[150]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[160]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[170]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[180]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[190]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[1a0]: ty=000001 sy=01 i=00000110
common.h:134: TINFO: Reading watch queue events
common.h:153: TINFO: NOTIFY[000]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[010]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[020]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[030]: ty=000001 sy=01 i=00000110
common.h:153: TINFO: NOTIFY[040]: ty=000001 sy=01 i=00000110
common.h:134: TINFO: Reading watch queue events
common.h:153: TINFO: NOTIFY[000]: ty=000000 sy=01 i=00000008
wqueue09.c:48: TPASS: Meta loss notification received
common.h:134: TINFO: Reading watch queue events
=> timeouts

I tested this on ppc64le with 65k page size on 5.17.0-rc5-150400.9-default
But it's not page size specific, as it fails also on x86_64 with the default 4k
page size.

And *without* this patch it's also broken with higher -i (tested on both x86_64
with the default 4k page size and ppc64le with 65k):

./wqueue09 -i1000
wqueue09.c:48: TPASS: Meta loss notification received
common.h:134: TINFO: Reading watch queue events
common.h:152: TINFO: NOTIFY[000]: ty=000001 sy=01 i=00000110
common.h:134: TINFO: Reading watch queue events
common.h:152: TINFO: NOTIFY[000]: ty=000000 sy=01 i=00000008
wqueue09.c:48: TPASS: Meta loss notification received
common.h:86: TBROK: add_key error: EDQUOT

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
