Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE42C64EC4
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 09:38:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 585453CB986
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 10:38:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 147203CB005
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 10:38:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DA6501A0116F
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 10:38:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C01D22A64;
 Fri,  3 Mar 2023 09:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677836319;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6DAF7KvEvZICteAs36tLTrNi9W25l63B9RF4JSKOqHo=;
 b=yK1e2DIt0FLCnU54dGhY3y+4oivtpJQWQqEZu5NSlrxjWurn1OUgRx2Bbws6Lqggb71xn2
 4EYS/qFP7X6//8qTZnxLqPr4NaeK6VNkZbkARPgq//FUDmuwi4Lt/1AKKwCxhvvcs1kh8t
 ahsswltJDxG6oOBLwInEvTnIZlllKUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677836319;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6DAF7KvEvZICteAs36tLTrNi9W25l63B9RF4JSKOqHo=;
 b=BQBRluEyuBbpoDg+RZ7l18EchJQf690jdwxloguGnFBTmdmBfILJ0UD7sMnALFEkw2KhQF
 t55XmbMIqFqbMLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE6B21329E;
 Fri,  3 Mar 2023 09:38:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3n3zIh7AAWSccQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Mar 2023 09:38:38 +0000
Date: Fri, 3 Mar 2023 11:22:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20230303102256.GA15936@pevik>
References: <20230301152818.4427-1-andrea.cervesato@suse.com>
 <20230301152818.4427-4-andrea.cervesato@suse.com>
 <20230303092526.GD4255@pevik>
 <30a9ec9f-4b14-da27-83c4-ffbbf8b0c0cb@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30a9ec9f-4b14-da27-83c4-ffbbf8b0c0cb@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/6] Refactor mqns_03 using new LTP API
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

Hi Andrea,

...
> > >   #define _GNU_SOURCE
> > I wonder why _GNU_SOURCE was used here and in mqns_04.c. I don't see anything
> > in man mq_open(3), both tests are working without it.
> Because of MAP_ANONYMOUS for mmap

Hm, I see MAP_ANONYMOUS and MAP_ANON not being guarded in glibc nor in musl.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
