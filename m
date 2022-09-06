Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF655ECAAD5
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 16:14:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B3E33CA972
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 18:14:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52B9E3CA409
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 18:14:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7497F1A009B6
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 18:14:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1968A33991;
 Tue,  6 Sep 2022 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662480850;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KYUOuHAswEJOARm3kNANAHUg5hqSlum4RbO19cJl38A=;
 b=juY8b0aGiWwRm1ErKPYNwltvuB05njrTjv6PLPZzlQFhf7UfFVw5aEuBBwg9Kc/pH4/62W
 p5rWAJ265l4jp+EZIbvNL4rnsrdhegOHgH8wneS8tKUN5Kh2kTxkCxJ8elsYCErDjOKkBD
 iaPZXRCcjN18ulqsYx9LgGUs4YpJTDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662480850;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KYUOuHAswEJOARm3kNANAHUg5hqSlum4RbO19cJl38A=;
 b=LfPqTTpnOCOF4d4nhlob4dehM6dm3Z1PGFXsoke2jrsaPL4oyctgl+i5q51Zlqs+iSVp1K
 diOCDIv58NxbGqCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB6AD13A19;
 Tue,  6 Sep 2022 16:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RqvDM9FxF2O/MQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 06 Sep 2022 16:14:09 +0000
Date: Tue, 6 Sep 2022 18:14:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>, LTP List <ltp@lists.linux.it>,
 Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>
Message-ID: <Yxdxz82bpextLG6H@pevik>
References: <20220906092615.15116-1-pvorel@suse.cz>
 <20220906092615.15116-3-pvorel@suse.cz>
 <CAOQ4uxjiAqFJajosfa5pkN-4=iDOWtiYFvNy7EU1Fd1=trRmMA@mail.gmail.com>
 <YxdtSXUyX6E5S2Ff@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxdtSXUyX6E5S2Ff@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify20: Simplify code
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > What is this change for?
> > It makes the code less readable.
> > fd is quite an unspecific name for a global variable.
> The motivation was: fanotify_fd is quite long and there are quite a lot of long
> lines which needs to be split. I also thought that the only file descriptor in
> fanotify tests does not have to have "fanotify_" prefix. But sure, No problem, I
> merge it without this change.

FYI what I would particularly prefer to change on fanotify code style are many
wrapped strings (hard to grep).

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
