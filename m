Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849EFCDB47F
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:18:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E3203E5BB0
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 14:18:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 498C33E594D
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:17:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C7D751A00981
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:17:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A8C971391;
 Wed, 24 Jun 2026 12:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782303470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FY2OlIFtJnJAvmEWSXjsCrJ3qjN41hcJEPrq3p9kaGQ=;
 b=WcENItA22YiDGXgbMB/jlTlt77f7wNsgvvOzSj3Ey3+xQEqLvndP2ol8rZ6wykgfB1QkNj
 VLNS63PMehybHIRF95VuSJHv0aCPAKe3VWJBFL+kyWy1iO2W4HYFwTCBlw87Reaz8Wk9Xg
 gFb50Uaq89b5BDsTLRlqevDNOCxIeA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782303470;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FY2OlIFtJnJAvmEWSXjsCrJ3qjN41hcJEPrq3p9kaGQ=;
 b=6SkuIoQbZG+CWbNWEh3PePJtqwOYcY8Dc+Lmy9XblbsxhwPcxn4I3Zt0uPNQKWGwRwbize
 fEO26DXlfdoCtoAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782303470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FY2OlIFtJnJAvmEWSXjsCrJ3qjN41hcJEPrq3p9kaGQ=;
 b=WcENItA22YiDGXgbMB/jlTlt77f7wNsgvvOzSj3Ey3+xQEqLvndP2ol8rZ6wykgfB1QkNj
 VLNS63PMehybHIRF95VuSJHv0aCPAKe3VWJBFL+kyWy1iO2W4HYFwTCBlw87Reaz8Wk9Xg
 gFb50Uaq89b5BDsTLRlqevDNOCxIeA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782303470;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FY2OlIFtJnJAvmEWSXjsCrJ3qjN41hcJEPrq3p9kaGQ=;
 b=6SkuIoQbZG+CWbNWEh3PePJtqwOYcY8Dc+Lmy9XblbsxhwPcxn4I3Zt0uPNQKWGwRwbize
 fEO26DXlfdoCtoAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED480779A8;
 Wed, 24 Jun 2026 12:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dBLmOO3KO2o4QgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jun 2026 12:17:49 +0000
Date: Wed, 24 Jun 2026 14:17:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ajvK8VLm1vdTCCCo@yuki.lan>
References: <20260624091900.4107041-7-chrubis@suse.cz>
 <6a3bc7d7.49afda34.2c585d.d686@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a3bc7d7.49afda34.2c585d.d686@mx.google.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 06/13] mem/ksm05: Add proper runtime support
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >  static void sighandler(int sig)
> > @@ -91,7 +95,8 @@ static void sighandler(int sig)
> >  static struct tst_test test = {
> >  	.needs_root = 1,
> >  	.forks_child = 1,
> > -	.test_all = test_ksm,
> > +	.test_all = run,
> > +	.min_runtime = 10,
> 
> Even if this is technically correct, I'm not 100% sure about it.
> Now if we want to manually test the binary, we have to wait 10
> seconds by default, while before we had to explicitly use -I.

I would say that the defaults should be geared towards testing not
development. If a test needs 10 seconds to trigger the bug, the default
run without any parameters should run for 10 seconds.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
