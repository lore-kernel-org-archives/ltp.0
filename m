Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526A8C54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 08:10:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CEAE3CAAEA
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 10:10:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4893E3C952D
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 10:09:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C09EF6000F6
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 10:09:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1104B5BFA7;
 Tue, 13 Sep 2022 08:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663056588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mSjVIsbgXSxT8gQU028g9CZFk5+uGJlTwwqOg/IUjGY=;
 b=N5CIC6pxNxTApk9+faIyNAf/jFHg0HPQ6kFF8wD+beqJds+RV/gaOU+y1OPyQlNAO7NcXM
 h29UNPUT493F3y8Bu40/TlCfc7PEdcmoZxJBBk+KgSuHfEoeWnetSiD6eZoeMGteSHjmP7
 G59YwaOcAgU/NsEv9e+exmtYQLQKwSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663056588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mSjVIsbgXSxT8gQU028g9CZFk5+uGJlTwwqOg/IUjGY=;
 b=ScUBx7IG8aUUUpmS9yMyA/L1O/d/MN7+di1OhGJXADWNMkiL6LSk4hX4MEtvk24MUIh/uI
 r2wNX7hVlZE0KkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F217913AB5;
 Tue, 13 Sep 2022 08:09:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Rg2uOcs6IGNcEQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 13 Sep 2022 08:09:47 +0000
Date: Tue, 13 Sep 2022 10:11:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YyA7P/eci29BIMI5@yuki>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-4-pvorel@suse.cz> <Yx9Fa69/ukgEJylz@yuki>
 <Yx+WwsY6xXV8t+62@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yx+WwsY6xXV8t+62@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 03/10] tst_supported_fs: Print TCONF if no
 filesystem supported
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
> > Shouldn't we rather than this add tst_res(TCONF, "...") messages to the
> > lib/tst_supported_fs_types.c so that we get consistent messages between
> > C and shell?
> 
> Well, in v4 I add TCONF in tst_fs_is_supported_skiplist()
> (lib/tst_supported_fs_types.c), but you asked for TST_FS_UNSUPPORTED [1].

I guess that we misunderstand each other. I'm fine with the library
printing messages, what I didn't like was the tst_brk() which made the
whole program execution flow obscured.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
