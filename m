Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF69EC5DF85
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 14:58:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 439903CD74F
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 16:58:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1882A3CD74C
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 16:58:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B39CD20033A
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 16:58:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F2B663EB3;
 Thu, 20 Aug 2026 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787237892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5iVdSy8onlWkRPH+tsVOGWFOGDvnopxQ3ecgIeAYIM=;
 b=rU3wX85a/hT5YPxZIZeYSrkQI7ySDbnqwdCqcu24ZF50eCO7E3GSVxGxPwlLO3Zkl9djTO
 S1zPc47SgOev8Nk036HhIZKleFgJY141SdwnTqb3FdzZbtfi4zZlNeE8Ykw0eh9HJ0pgnL
 /kyG8QMgjvrsAQIVeHWfbNFlAdUA7fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787237892;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5iVdSy8onlWkRPH+tsVOGWFOGDvnopxQ3ecgIeAYIM=;
 b=7pmLfM7Xlq/FD4l5m/gjk1l+0fe+2/AmfwbTXXRDKZoPjcwymPMbBwL5xPMCFcn4DFZRWX
 aLGHdyLXQeSEeqBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=P5pvV8AT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a+MlfmW8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787237887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5iVdSy8onlWkRPH+tsVOGWFOGDvnopxQ3ecgIeAYIM=;
 b=P5pvV8AT0GVz4G+GCuk1x0bYbPXZhO0dAPQtfs7Yjs8tnEt8h0zBPEQS35qEf6tyvMF1Kt
 NRAQ1rvSoWk9UafW2ViD1dJyk1ixMnT+UpcQnA8IIG1AnM01ZXO+5w+xtC38vWiffvza4m
 6qaVnyOjl5rc6QkDvgUuEt1u+GAvD5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787237887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5iVdSy8onlWkRPH+tsVOGWFOGDvnopxQ3ecgIeAYIM=;
 b=a+MlfmW8pJxQp3j4f+TIM+JT+OkAzVribVfzP/p+UfJh3BziQ9sLbNj7CB3EVAchuso5wJ
 JDLTDyxONOpLiaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B822027A8;
 Thu, 20 Aug 2026 14:58:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3kQnKP8Vh2pPCwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 20 Aug 2026 14:58:07 +0000
Date: Thu, 20 Aug 2026 16:58:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aocWA2gHUoSVXQKG@yuki.lan>
References: <aocLlPNLd_0O8VP-@yuki.lan>
 <6a870dfa.332d3c56.afc7f.5723@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a870dfa.332d3c56.afc7f.5723@mx.google.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: F2B663EB3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v2 04/16] fchroot01: test fchroot() with a
 directory fd
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > + * The syscall runs in a forked child so that the root of the parent
> > > + * process, which the test framework needs for its cleanup, is left
> > > + * untouched.
> > 
> > I do not think that we need this. The process that runs the run()
> > function is forked from the library process in order for the test to be
> > isolated from the library.
> > 
> > As long as we do not have a custom cleanup() function that needs to run
> > outside of the jail we do not have to fork in the run().
> 
> the fork() ensures that if fchroot() passes (instead of failing) at the next
> iterations we don't have a dirty environment. This is done for all tests,
> so iterations always starts from scratch.

Ah, right, that makes sense with -i 10. But then all the comments about
library cleanup are wrong.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
