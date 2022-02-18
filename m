Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F8BC433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 10:31:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 678EC3CA0F3
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 11:31:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C27173C9DE5
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 11:31:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48B206015AB
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 11:31:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D2D11F37D;
 Fri, 18 Feb 2022 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645180293;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4D+EJcQL1x/WHCf4PC0bIN+dL4k9G/Vkctty3MOL8g=;
 b=n219V83WOOiDsoq//0LVna9fRiaR4A5j0+gYsYqASEWsvzU0tjedIlqwgRR5SmREV+VGXY
 0yBX3Uj1I1NZ25RYYY41D4sHhiMC3UJ7GB8Zf23nCAkhPUeUjP41JHNj6WOu2qZFjLiVSf
 JKtMFOXDxtGvN18sAoKtHQRGLfcFrrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645180293;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4D+EJcQL1x/WHCf4PC0bIN+dL4k9G/Vkctty3MOL8g=;
 b=65Zg4waCZlHNc5mgTQ/kay6G3wbzeNZDgbHD3bKalcoGbmT6uWxBvk+t4n2pRRT1h4MkV7
 kaicni3+CSJcCEAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0864913C47;
 Fri, 18 Feb 2022 10:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GDaXO4R1D2KSDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 10:31:32 +0000
Date: Fri, 18 Feb 2022 11:31:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yg91g+y5IgF0zifz@pevik>
References: <20220217142730.19726-1-chrubis@suse.cz> <Yg56J2hVIMMO3cvX@pevik>
 <Yg9s2lzZmavrQCuf@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yg9s2lzZmavrQCuf@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_macros: TST_EXP_EXPR() add auto
 stringification
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Good idea.

> It occured to me that this is probably not the best result though, since
> in the case of the failure it does not print the expected and actual
> value. So maybe it would be better to add TST_EXP_EQ() macro instead. I
> will send a patch later on.

I wonder can't we have both - print stringified parameters and also their
values? Would it be too confusing?

> > BTW I'm thinking to add some comments to "top level" macros.
> > because it's getting hard to read these macros.

> Well yes, it's getting a bit hard to read indeed.
I mean it's good to have documented in our wiki. But even we document all
macros most of us will endup reading the header, thus why useful to document
at least end user ("top level") macros.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
