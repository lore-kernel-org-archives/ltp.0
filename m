Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C46BECAAD8
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 13:54:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 585373CAD3F
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 15:54:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 158943CAC37
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 15:54:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5D7ED2009F4
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 15:54:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 837CA1F85D;
 Wed, 21 Sep 2022 13:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663768439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rHdmP3paBAgAVz2/he8Xn8ex0RA53yeRqQkp1qC7zqI=;
 b=XiKU9U/5sF3yQHDqrLaYktIUCTROEX6zf4J5mq28jOmBDtaXbCxmsH72LCNtZyyokPfnur
 SnxX7rVWkzLuCPnXBFCQ6r2CB8LN1ESWk8ffnSTVjRVEmZatgnw0cHY0JdBjz+930JP6WU
 xKUF2ZPNY/k00GFI5XHMnUMURqhCJ3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663768439;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rHdmP3paBAgAVz2/he8Xn8ex0RA53yeRqQkp1qC7zqI=;
 b=REvSjphhH4kCc+4aOi8tEL8DwyoXjCzkJybGFQ+KGgJe5IUspQgMxRW1MGKya/zpb6SgHJ
 Bv6ooLurQnXHkzAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A81313A00;
 Wed, 21 Sep 2022 13:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id i7uZGHcXK2OzRwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 21 Sep 2022 13:53:59 +0000
Date: Wed, 21 Sep 2022 15:55:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YysX7FVAHO6HkLLZ@yuki>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YyG61JHO7iDAfJ1N@yuki>
 <bd50a9da-0b32-2318-31ec-67a78155cc25@fujitsu.com>
 <12eff5a1-bf6b-59bf-bfca-7a1d4f3ca009@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12eff5a1-bf6b-59bf-bfca-7a1d4f3ca009@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] syscalls/creat09: Add umask test condition
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
Cc: "brauner@kernel.org" <brauner@kernel.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Yes.  Please apply it with fix the messages. Thanks.
> 
> I guess you miss this patchset. so ping again.

Sorry for the delay.

I just did quick test and I got failures on XFS on kernel 5.19, wasn't
this supposed to be fixed in 5.19?

...
creat09.c:106: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
creat09.c:112: TPASS: mntpoint/testdir/creat.tmp: Setgid bit not set
creat09.c:106: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
creat09.c:112: TPASS: mntpoint/testdir/open.tmp: Setgid bit not set
creat09.c:120: TINFO: File created with umask(S_IXGRP)
creat09.c:106: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
creat09.c:110: TFAIL: mntpoint/testdir/creat.tmp: Setgid bit is set
creat09.c:106: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
creat09.c:110: TFAIL: mntpoint/testdir/open.tmp: Setgid bit is set
...

$ uname -r
5.19.0

$ git describe 1639a49ccdce
v5.19-rc7-3-g1639a49ccdce


Is there any in-flight patch for v6.0 that fixes this for XFS?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
