Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26043C433FE
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 15:16:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 455EC3C987A
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 16:16:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25D1F3C071A
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 16:16:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 12D691A000BE
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 16:16:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F09BD21111;
 Tue,  1 Feb 2022 15:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643728576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhKIlxJNeBr4NgrlUWAZgyVJbKfY3QkYe//HL6AmNpg=;
 b=YdjislTSAfZip6jLH3oKL6jbPDf6oRcfxLAgJEYTRL3vualQYnfwvKX4OGO85gYyAAf8qH
 6tFBVPBgQv7zdIe3+l2lT8Xt7/qsrF/vVbCvXQcgJLlFN9brHiQYGCgXSUwGHuw1JNiM2T
 i9GdBlAIrNDJS1jK2uR6SWfxVhly+E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643728576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhKIlxJNeBr4NgrlUWAZgyVJbKfY3QkYe//HL6AmNpg=;
 b=NzVdIC7PB6HBX3eiT2KpjUzTZYQ0dzh3hCFnB9jvyDnjJKQaQPQsJSnmzir1qLrwViLVb+
 3n9DDrDvaPEYP2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7A8213D91;
 Tue,  1 Feb 2022 15:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EYWwJsBO+WHDKwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 01 Feb 2022 15:16:16 +0000
Date: Tue, 1 Feb 2022 16:16:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YflOvov3Ui9OxRPf@pevik>
References: <20220201094451.7651-1-pvorel@suse.cz> <YfkMR3oM/QD9a3I9@yuki>
 <YfkPfjqRz9j2Jbuw@pevik>
 <CAEemH2di8y4qiyn45EOgdxQo-oebEsZRhYmyCfkifpvS1rpsaw@mail.gmail.com>
 <YfkueuaAfXqVGOO5@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YfkueuaAfXqVGOO5@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ci: Remove CentOS 8
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > We have CentOS 7 (EOL 2024) and also fedora:latest, which is 35
> > > (their devel called rawhide is currently 36).

> > Is there any possibility to convert from CentOS 8 to CentOS Stream 8?

> Is there an official docker image for it? As far as I can tell I do not
> see it at: https://hub.docker.com/_/centos

Here some unofficial:
https://hub.docker.com/r/tgagor/centos-stream
=> I'm not sure if we want to use unofficial

which also mention official at quay.io:
https://quay.io/repository/centos/centos?tab=tags
=> we'd have to figure out how they could work with GitHub Actions.
Li, feel free to look into it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
