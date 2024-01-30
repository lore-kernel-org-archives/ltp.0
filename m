Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64634C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 12:18:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D8353CF96B
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 13:18:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B28A43CB8E6
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:17:54 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2A9EC20173D
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:17:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0090E2202F;
 Tue, 30 Jan 2024 12:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706617073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5/WPYhqcwdRrl3CWeRLsf8679zH5fceoy/p2IMic44=;
 b=UPAJ8vbmB413xBh16+nF9u7Vkk3tjni016OC4e29yxkBVqLiBzBKZ+/fmxjouNUeLjmrLA
 7p0xUJhuRAv9HpVbYhRtCUWKFR1sjCswEI3JL5T4m0EUyxqYrsYXztUaO/ZvtAOZdDQL5v
 nRRRYOGPU1u5PcFc6i5B5WkWWeINdc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706617073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5/WPYhqcwdRrl3CWeRLsf8679zH5fceoy/p2IMic44=;
 b=Qdu9p2OJpuj19cblZnaKoB74GSY6KQyMfgZaNM179kwxAT2GIluwhfu6iheEnueukyZ6Ce
 LuvXZLybb7Eg96CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706617073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5/WPYhqcwdRrl3CWeRLsf8679zH5fceoy/p2IMic44=;
 b=UPAJ8vbmB413xBh16+nF9u7Vkk3tjni016OC4e29yxkBVqLiBzBKZ+/fmxjouNUeLjmrLA
 7p0xUJhuRAv9HpVbYhRtCUWKFR1sjCswEI3JL5T4m0EUyxqYrsYXztUaO/ZvtAOZdDQL5v
 nRRRYOGPU1u5PcFc6i5B5WkWWeINdc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706617073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5/WPYhqcwdRrl3CWeRLsf8679zH5fceoy/p2IMic44=;
 b=Qdu9p2OJpuj19cblZnaKoB74GSY6KQyMfgZaNM179kwxAT2GIluwhfu6iheEnueukyZ6Ce
 LuvXZLybb7Eg96CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9F4613A66;
 Tue, 30 Jan 2024 12:17:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id goMANPDouGXYTAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 30 Jan 2024 12:17:52 +0000
Date: Tue, 30 Jan 2024 13:18:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZbjpATp6cK9AkvBm@yuki>
References: <20240130103319.22763-1-andrea.cervesato@suse.de>
 <ZbjnEzmW0RvxWhg9@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZbjnEzmW0RvxWhg9@yuki>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UPAJ8vbm;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Qdu9p2OJ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.18)[70.11%]
X-Rspamd-Queue-Id: 0090E2202F
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix dio_append/aiodio_append tests
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
> >  	numchildren = 16;
> >  	writesize = 64 * 1024;
> > -	appends = 1000;
> > +	appends = 10000;
> 
> Since we are increasing this we should probably check the free space as
> well, so we should add something as:
> 
> 	if (!tst_fs_has_free(".", appends, writesize))
> 		tst_brk(TCONF, "Not enough space to run the test");
> 
> Or even better put a function:
> 
> void tst_assert_free_space(const char *path, unsigned int size, unsigned int mult)
> 
> into the test library and this function would tst_brk(TCONF, ) if there
> is not enough space and tst_res(TWARN, ) if the free space is let's say
> only 10% more than the test would need to run. And we can use that in
> all of these tests.

Also this can be done in a follow up patch. I guess that the cleanest
option would be to split the patch into two, one that fixes the race
condition, that one should go in ASAP. And second that raises the
appended file size followed by a patch to check for a free space.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
