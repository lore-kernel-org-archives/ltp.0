Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEBDC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 07:58:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2674F3CA4EE
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 09:58:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 700F13CA2AE
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 09:58:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D13DE600269
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 09:57:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 093F5210E1;
 Wed, 27 Apr 2022 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651046279;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HK/iXwa8uZB49u0Az/Bfr9ViN/qNpYS4tkln/ttfJuM=;
 b=DyAg2cwHzmBifwQGp3s0nqgd7T8K8SFkBx2A8Rr5lROe5O1Tx+kks833i5IpoaYRf0dv/m
 Iv2jxL0DqhgCxA/kpBfgKdYfR19BovTF5UWH3e9xZG+SHB5k5oduDzROMrK9p6fyGIZUgF
 cG1tQk0TyRvTTEMVNK6WTXlGUycMdhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651046279;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HK/iXwa8uZB49u0Az/Bfr9ViN/qNpYS4tkln/ttfJuM=;
 b=CgwxXLDNkn6Sfp2awLOhpyAl5R+AzUL3Tn5aAl8QQaoG1PZv3hhd8H+POTFwUDMXlpCf0F
 EW/9+1vC2jIyIIBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8B5713A39;
 Wed, 27 Apr 2022 07:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c38+M4b3aGJaNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Apr 2022 07:57:58 +0000
Date: Wed, 27 Apr 2022 09:57:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ymj3hZF7ktNY4Tn9@pevik>
References: <20220425092118.21619-1-rpalethorpe@suse.com>
 <YmZrVzxghAnmxIud@rei> <YmaBJM8piHx4Juay@pevik>
 <YmaBfMmDa4O/Lc2N@pevik> <YmaEmnRY9CNL9+Bu@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YmaEmnRY9CNL9+Bu@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sighold02: Fix muslc builds by removing __SIGRTMIN
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
> > Ah, looking at the code "if (sig >= __SIGRTMIN && sig < SIGRTMIN)",
> > we need both underscore and non-underscore.

> This is code to actually skip signals used internally by libc, so
> anything between 32 and SIGRTMIN. It's pretty safe to hardcode the first
> value to 32 since that is the number of signals allocated by kernel
> which is not going to change.
Ah, right!

> I guess that we can add something as SIGRTMIN_KERN or SIGRTMIN_BASE and
> define it to 32 in some LTP header instead of hardcoding 32 into
> testcases, which would be way better than misusing glibc internal
> __SIGRTMIN.
+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
