Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8056FF4958
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 07:55:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B0583E4EDE
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 09:55:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AAB13C235D
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 09:55:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 984CB600688
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 09:55:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E0A065BE82;
 Mon, 30 Mar 2026 07:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774857330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjzdcpQjpoIcx4S3qlUTXHopMn4PgrO4q4bVof/GIeI=;
 b=e6gI6vR05qkm84QT830hFypOYS5VP0g4LuBT65Bm2iZ5bPUedP2H26V84nZ6XL+hRw9kI2
 t0toP5ZQA4s91V60PLcVT3e0+A12mGpTTp5EXPjLQ+barqcVK931nabCI6hlqah+nWpkaZ
 OYcM667lwjxu8sAZvRmj3BEE6MPVEGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774857330;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjzdcpQjpoIcx4S3qlUTXHopMn4PgrO4q4bVof/GIeI=;
 b=qCmfRxm+ouM3iypgzFZ6EuA3/6PYYWhOWVgthql+5zFhxl0xuV8Jhzy9gIA3EeXChxE9pa
 hLNeUTYGidAUPzAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="N/jk++gE";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zrCptPtS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774857329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjzdcpQjpoIcx4S3qlUTXHopMn4PgrO4q4bVof/GIeI=;
 b=N/jk++gEFMoXdewGJjIJunbQ2nZgBrztoF5wYUXc94CBIQnbM8cXiMP+SH0Bz8v+8Dhawz
 IJFmsg/D5hN6EMeo6TaQGNvteOQdIkht26ZdBV/1tPWGbcGIS9yZ08vPSzpBUH1VcyWxk/
 fix5bnezpDXY4XVg32QAA+1Y42eY30I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774857329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjzdcpQjpoIcx4S3qlUTXHopMn4PgrO4q4bVof/GIeI=;
 b=zrCptPtSBr+Eco/Mc7SfrnekrI4nKuGDr3fLz24FvTJOozNELeLY8aqhT1UipYa4gqYr2y
 frjtThbnvQim8NAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EF0D4A0A2;
 Mon, 30 Mar 2026 07:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0O/gInEsymmNOwAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 30 Mar 2026 07:55:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 32B27A0B2F; Mon, 30 Mar 2026 09:36:56 +0200 (CEST)
Date: Mon, 30 Mar 2026 09:36:56 +0200
From: Jan Kara <jack@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <t7hasa2l2vb6tgr53hq3i5snlgvca24oug7tbzdkid236m7yzg@zibyolzrgqbk>
References: <20260327123436.8195-1-wegao@suse.com>
 <69c691f1.050a0220.33d880.427e@mx.google.com>
 <acckSVyvtJTMsOGP@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acckSVyvtJTMsOGP@autotest-wegao.qe.prg2.suse.org>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_THREE(0.00)[3];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E0A065BE82
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] fanotify22.c: handle multiple asynchronous
 error events
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
Cc: Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Sat 28-03-26 00:44:21, Wei Gao wrote:
> On Fri, Mar 27, 2026 at 02:19:28PM +0000, Andrea Cervesato wrote:
> > Hi Wei,
> > 
> > we still have a problem with the patch. We are considering deterministic
> > events, where one event comes after the other.
> > 
> > consolidate_events() accepts events matching either ex->error or
> > ex->error2:
> > 
> > > +		if (info->error != ex->error && (ex->error2 == 0 || info->error != ex->error2)) {
> > 
> > but the first accepted event becomes the one passed to check_event().
> > Since event delivery order is non-deterministic, the first event could
> > have error == ESHUTDOWN (error2). check_error_event_info_error() then
> > only checks against ex->error:
> > 
> > > 	if (info_error->error != ex->error) {
> > > 		tst_res(TFAIL, "Unexpected error code value (%d!=%d)",
> > > 			info_error->error, ex->error);
> > 
> > So it compares ESHUTDOWN against EFSCORRUPTED, doesn't match, and
> > reports TFAIL.
> > 
> > We need to change that into:
> > 
> >   if (info_error->error != ex->error &&
> >       (ex->error2 == 0 || info_error->error != ex->error2)) {
> > 
> > Similar to the consolidate_events(), otherwise we will have a TFAIL when
> > events don't arrive in the same order. Did you try to run patch with a high
> > number of `-i` ? It should fails sometimes with the actual code.
> I remember i have tested in openqa with -i1000 without error in early version such
> as v4 or v5(The main logic not touched compared with v6/v7).
> 
> BTW: is this the final comments?

Andrea is correct, that strictly speaking the ordering of fanotify
notification events is not guaranteed. In practice however error events are
never reordered so you definitely won't be able to observe test failures
due to that currently. I'm fine with the test not handling reordering of
error events, we can always fix that up if the kernel ever decides it is
unavoidable (we'd have to have really strong reason for that).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
