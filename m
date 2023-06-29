Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F92FC001B0
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 13:16:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2A9A3CE150
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 15:16:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B65433C99AF
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 15:15:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BB967600F36
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 15:15:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 03A102185E;
 Thu, 29 Jun 2023 13:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688044558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gVAeo/aaD0tKD3j0PL9fhXBtUfj5ETiEbXSPILTOBhU=;
 b=iKKBk8ecz4gQABtRLfcAC39Q+5W8ZLxqwv0WVr7L7pTxaV4x/YNwPCZu5NKMLH0KD6mecP
 k0P6pW1A6srBlCuGI6WfUnlWw3pz0nQ8zuY6xIll6XOZPOL3mFkFOydnbuzcEfyujc9PZS
 mqCIj+p40kkLQFCAFuJlwf3LOa9Ircw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688044558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gVAeo/aaD0tKD3j0PL9fhXBtUfj5ETiEbXSPILTOBhU=;
 b=DZBf/e2EQwVWXcs8HFFA3KgYetpONrlBFCjJVv7mqpq5pUg9f9RDH31xGeV7lLVh/D9GXR
 xCglZeRGq67KmEBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB9DE139FF;
 Thu, 29 Jun 2023 13:15:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tw8UNQ2EnWRfcgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 29 Jun 2023 13:15:57 +0000
Date: Thu, 29 Jun 2023 15:17:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZJ2EUIqpqwUn0GzC@yuki>
References: <20230628130742.155724-1-pvorel@suse.cz>
 <20230628130742.155724-3-pvorel@suse.cz> <ZJw3Or-7pEXOnAjC@yuki>
 <20230629115137.GA207849@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230629115137.GA207849@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] fsstress/global.h: Use _GNU_SOURCE
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
Cc: NeilBrown <neilb@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Just a very minor nit, such cleanups should be in a separate patch.
> I'm sorry, I sometimes try to blance between separating changes and too many commits.
> I can put this to separate commit.

I tend to be picky in separating formatting changes from actuall fixes...

> > Otherwise the rest of the changes looks good:
> Is that that this is just this patch. Please let me know if you're meant whole
> patchset (it'd make sense, it's pretty simple).

That was for the whole patchset, sorry for not being clear.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
