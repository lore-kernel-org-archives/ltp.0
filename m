Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68000C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 14:13:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DCAD3C93D0
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 16:13:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A0033C2A6C
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 16:12:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 00EE5140054A
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 16:12:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3DEF821C3D;
 Tue, 21 Jun 2022 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655820776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+TeT4ZwFQudR9WGTQ/brWI4SLn3ea8f0ve/OTXW8J8=;
 b=FkJDVNq+fbKgSXE/PJ6skJHye5TdJhqoPviTJ1hYeIh59AynIzNpftdaRw2UfOtJEAWM7v
 VOlTlpoxseYKhD3zmDVvWAfiP/kZ2wvTPaDUp0GWoPQCQzrIjq+zC9txIkwGYX3uISOz4E
 SDwBnuwMZ8sxao3CxNXxK+vw9riL2Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655820776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+TeT4ZwFQudR9WGTQ/brWI4SLn3ea8f0ve/OTXW8J8=;
 b=EKN4j9hcVE2niktqIwU1dVwdk8nh9cS+9l1edB0ZmJHvrZf09FjuKBXzZTVVbbSQfuG/zF
 0zLrbshZ4gvpVxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 267C013638;
 Tue, 21 Jun 2022 14:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C9CGCOjRsWIRRQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Jun 2022 14:12:56 +0000
Date: Tue, 21 Jun 2022 16:15:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: David Laight <David.Laight@ACULAB.COM>
Message-ID: <YrHSaLombzbJwLhF@yuki>
References: <20220621120355.2903-1-chrubis@suse.cz>
 <a26ab9bfc27a430bb8a7b6aa2f39d724@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a26ab9bfc27a430bb8a7b6aa2f39d724@AcuMS.aculab.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dhowells@redhat.com" <dhowells@redhat.com>,
 "zack@owlfolio.org" <zack@owlfolio.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > This changes the __u64 and __s64 in userspace on 64bit platforms from
> > long long (unsigned) int to just long (unsigned) int in order to match
> > the uint64_t and int64_t size in userspace for C code.
> > 
> > We cannot make the change for C++ since that would be non-backwards
> > compatible change and may cause possible regressions and even
> > compilation failures, e.g. overloaded function may no longer find a
> > correct match.
> 
> Isn't is enough just to mention C++ name mangling?

I just picked up the argument that was brought up in the discussion
about the v1 patch and used it as a concrete example. Mangling is I
guess more straightforward example of a breakage. I can change the
description if there is consensus that such description would be better.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
