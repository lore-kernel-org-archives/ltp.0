Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79221C3DA63
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 15:20:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E13E3D1B05
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 17:20:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B5183C74E7
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 17:20:42 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 85CBE1009BC8
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 17:20:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E11571F44B;
 Thu, 18 Jul 2024 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721316040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aopbVFYZipmQ3kBoLl3nWj4jqeDiZcOUHuG+acx9uYU=;
 b=DBvESrFs+ZJ4foRPl5gJ+Q5J0ezP18jzZ+WGwD0JzLDUv1U9ACMrxrYTKCr0UQLi/jYleB
 rP4MqiPrFNnP+nc1If5PpJvuGZdrTzB9Xykm8IuBuXTnC5HCeGwrdj7a1U/QirnmVsm9V/
 wUOX6OkANmkDD9FxnjLMdf+a75De1R4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721316040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aopbVFYZipmQ3kBoLl3nWj4jqeDiZcOUHuG+acx9uYU=;
 b=yeaa2aGIUXxQrRDL28Ajy49/Qb6hGvRah//wOeans8/uz/fGYFqkq3WikJgIjAL1sdzpVY
 a22cQOn6GbCBoeDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O7GmlSS6;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PKbQVoXZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721316039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aopbVFYZipmQ3kBoLl3nWj4jqeDiZcOUHuG+acx9uYU=;
 b=O7GmlSS6t8riVPaLkrgWzn9gJ7d5mfDKBA+aA304IYrURRR8ukY1vhryRMmhKF1kC+oqPy
 FQqIKhJafgWGSTha55JK79RWeMX29CaD8ymvePxm8Z+duiQvWIYuYLIN2C54l+0eR1dJPW
 AGduxAPe3ZGFkFWU8ZD4UMmFIJT2BCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721316039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aopbVFYZipmQ3kBoLl3nWj4jqeDiZcOUHuG+acx9uYU=;
 b=PKbQVoXZnFw6TIOJUug34Kd5aU8YG3MTy1sR2zYJ53NzShP0f0xBj1tM60uF66mWgsmGet
 hF3mH66URJwOG1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFFA4136F7;
 Thu, 18 Jul 2024 15:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o7sPMccymWYWKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 18 Jul 2024 15:20:39 +0000
Date: Thu, 18 Jul 2024 17:20:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZpkytUBtKfJ1Dfkk@yuki>
References: <20240705031502.9041-1-liwang@redhat.com> <ZpeBVwXDVbJwLFu7@rei>
 <d7014164-0d1f-4ab5-be80-042d4da5cca2@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d7014164-0d1f-4ab5-be80-042d4da5cca2@suse.cz>
X-Rspamd-Queue-Id: E11571F44B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] perf_event_open: improve the memory leak detection
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
> >> +		/*
> >> +		 * Every 1200000 iterations, calculate the difference in memory
> >> +		 * availability. If the difference is greater than 10 * 1024 (10MB),
> >> +		 * increment the sample counter and log the event.
> >> +		 */
> >> +		if ((i % 1200000) == 0) {
> >> +			mem_avail = SAFE_READ_MEMINFO("MemAvailable:");
> >> +			diff = mem_avail_prev - mem_avail;
> >> +			diff_total += diff;
> >> +
> >> +			if (diff > 20 * 1024) {
> > 
> > Shouldn't this be 10 * 1024 or possibly slightly less than 10 * 1024?
> 
> This should be fine. The test leaks around 38MB between sample checks 
> and over 350MB in a whole test run.

Then we should fix the comment.

> > 
> >> +				sample++;
> >> +				tst_res(TINFO, "MemAvailable decreased by %ld kB at iteration %d", diff, i);
> >> +			}
> >> +
> >> +			mem_avail_prev = mem_avail;
> >> +		}
> >> +	}
> >>   
> >> -	if (diff > 50 * 1024)
> >> -		tst_res(TFAIL, "Likely kernel memory leak detected");
> >> +	if ((sample > 5) || (diff_total > 100 * 1024))
> > 
> > Maybe this can rather be if ((sample > 5) && (diff_total > 100 * 1024))
> > 
> > That means that the available memory has been eaten by something and
> > that it happened more or less in a linear fashion when the program was
> > running.
> 
> Imagine that some other process releases 300MB of memory while the test 
> is running. If you change the || to &&, you'll get a false negative in 
> that case. The sampling approach will protect against such interference.
> 
> That being said, if the available memory on your test system fluctuates 
> by 100+MB during a test run that takes <10 seconds, I'd recommend 
> investigating what's causing such fluctuation. On the test machine I 
> used to verify this patch, I can see <10MB of difference before and 
> after running the test on a fixed kernel.

So shall we remove the diff_total completely?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
