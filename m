Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F15C00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 17:12:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 685343C97FA
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 19:12:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 864BB3C01CC
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 19:12:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7AEC420005D
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 19:12:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 225FB2061A;
 Mon, 15 Aug 2022 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660583548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kasGf2SR0PAhdgkZmhCF+JTwMAgv3Fg/SNp2oz4Xo5c=;
 b=OJWoXdInhvn9ySAZ8bPtwOr0Dmn5xx3RvwDHS+T3JKZNRNGvfZiYS3BpcCc3jVyScKR9ED
 d8M7Y8YXwQ9yd9riRBEvkPjkfDpz2oFJd1M6QWmO88dYsl0dZFsIdHysvHahaAgrkRi94n
 sc7KgmJzgMqV0tW9ph1pYl+TePMsDO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660583548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kasGf2SR0PAhdgkZmhCF+JTwMAgv3Fg/SNp2oz4Xo5c=;
 b=37gOmBw0/uht0p1tm4q8mwsEUSt+buRjwUuQzzr6Tm6Opji7dYwLQZ/afFFwSyMi1JxPtE
 leM8Krm8s4RncvBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D36A613A99;
 Mon, 15 Aug 2022 17:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nzbALnt++mKBKAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 15 Aug 2022 17:12:27 +0000
Date: Mon, 15 Aug 2022 19:12:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yvp+b0B879B1mjnP@pevik>
References: <20220808071439.741-1-pvorel@suse.cz>
 <20220808071439.741-3-pvorel@suse.cz> <YvoXwcdWvQvWYZ8r@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvoXwcdWvQvWYZ8r@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc/c-test-tutorial-simple.txt: Use links,
 README.md
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Symlinks to LTP wiki are more friendly for people reading web (likely
> > the most of the people) while styl readable when reading locally.
>                                 ^
> 				still
Lol, merged with this fixed + adding 'at' at previous commit.
Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
