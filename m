Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537DAECAAD8
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 12:26:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9960B3CACB2
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 14:26:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C6F93CA4DD
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 14:26:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2D80E60176D
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 14:26:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 37EDE20580;
 Fri, 16 Sep 2022 12:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663331181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qw7ukgXPZNVIKTVQgToXXXIGzEjPNjoz5C7x7i3gaSM=;
 b=JGLUjqn7sb3Gb8Va8DXIkws5E+yEv0PLtDrXnIlmStldCkMACaoTugXT863IqXpHBLaZD9
 bqxGfhlMRa9WmHNW4BkFJZ9AKulHuD5eza0ubsST27ViOPpOh/QNMag+q+tGA/TUVjR4cp
 zWRsEdYMaqrME4SX5zM4stjjGUOS26w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663331181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qw7ukgXPZNVIKTVQgToXXXIGzEjPNjoz5C7x7i3gaSM=;
 b=ptdDvNIcQDPnRnL92L7I1TBgegruqRbfKrtlQ7bhnpRbX+pUGbhdr9KZQ1WJq6aTqdO/1U
 RytaPMtzYPyHZyBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA2D51332E;
 Fri, 16 Sep 2022 12:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QWzzK2xrJGNtJwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 16 Sep 2022 12:26:20 +0000
Date: Fri, 16 Sep 2022 14:28:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YyRr4a9/oLNHd0ZK@yuki>
References: <20220915093639.2261-1-pvorel@suse.cz>
 <20220915093639.2261-4-pvorel@suse.cz> <YyRhxDnUoIDG0OCa@yuki>
 <YyRnjASQiGnww/ld@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyRnjASQiGnww/ld@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/8] tst_supported_fs: Support skip list when
 query single fs
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Shouldn't there be an getopt option to decide?
> e.g. by default both skip list and mkfs (no matter if -s is passed) and with
> option (e.g. -o) check only for a list? This is not needed when checking all
> filesystems, only for testing single filesystem, so I wonder if I should
> implement it for all filesystems mode.
> 
> But as this is not needed I'm ok to implement what you suggest:
> tst_supported_fs -s skiplist foo would check only if the used filesystem is not
> filtered by skip list (used in tst_test.sh).
> 
> tst_supported_fs foo would check only for mkfs.foo (used in prepare_lvm.sh).
> 
> What do you prefer?

I guess that I do not care that much what exact API we do have here as
long was we can check for just skiplist or just support separatelly.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
