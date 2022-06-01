Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FAAC433F5
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 11:21:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1BA53C65EF
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 13:20:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C71B03C2F2A
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 13:20:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5433B10005C5
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 13:20:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B5D221AFE;
 Wed,  1 Jun 2022 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654082444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5TtkNYEcPo3s6gT99uXPxdCFhDGRxbtpVHcJsHvnOw=;
 b=mfnOd1+I9x3kL3VzK20yT9H3G/4+KQxRFx9pYAlECF3YCadr6LjPerPwY/y4d+wOj7jL95
 59T1XwlTL7dFaolqoPN3WlpwFLMxRejPqb65esQfsymjStbUw0b36pyoTtWrD1Qlm61YQJ
 08lv05kSIsAkFu9H4KWuSeQw9JnHj7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654082444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5TtkNYEcPo3s6gT99uXPxdCFhDGRxbtpVHcJsHvnOw=;
 b=iL5qVR6V0gng0p1XwHKa1EpgV2IuRE2Y/TAghg8q9isyFldWPhv2R24HKBd6Jo7tI1QXwb
 8W+ZUxIujlYWDJDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 375F61330F;
 Wed,  1 Jun 2022 11:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Df7PDIxLl2KRLgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 01 Jun 2022 11:20:44 +0000
Date: Wed, 1 Jun 2022 13:22:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YpdMC5l/C+arTzCb@yuki>
References: <20220512194557.30911-1-pvorel@suse.cz>
 <20220512194557.30911-6-pvorel@suse.cz> <YpTexs/dQDZdxr4m@yuki>
 <YpdAmGFZR01I6zmA@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YpdAmGFZR01I6zmA@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/8] shell: Add tst_clear_device
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Can't we just add clear command to the tst_device.c instead?
> Not sure what you mean, can you be more specific?

We do have tst_device binary that has two commands acquire and release,
why can't we add clear command for that binary instead?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
