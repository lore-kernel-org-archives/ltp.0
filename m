Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FA8C25B74
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 18:35:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A82CF3D00A0
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 20:35:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FCCC3C5583
 for <ltp@lists.linux.it>; Tue, 21 May 2024 20:35:04 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DDCF41A01103
 for <ltp@lists.linux.it>; Tue, 21 May 2024 20:35:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 007A7348F1;
 Tue, 21 May 2024 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716316503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OVBagSbz3PZopKYXdwzBwcx6p9RL4p2jtpjk/n/H5mA=;
 b=oQs40YHi/MeF2KDX0C4Adv8sgrGTIaRF3MjWU3r38ypzkYQtO2DrDPEcN8lCuq/R0FljdM
 J/lw4q2zjcYQzL7B6DYDEgeyqt+zQGUuKi2k6VG/wuqnXTgts06YVU/EBSu+4fRnw1Zb1r
 KYRgT3xdhn1ct/vfakrrTrlaI9EaXUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716316503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OVBagSbz3PZopKYXdwzBwcx6p9RL4p2jtpjk/n/H5mA=;
 b=ZVK9eesTTI9DQyLtR8Iyq2zk9lGQlM73cXkNato2BWBOqie6Mmuw0AkYLAXGQe3ZQuAn4a
 JQEVn67qLIS9tJDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716316503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OVBagSbz3PZopKYXdwzBwcx6p9RL4p2jtpjk/n/H5mA=;
 b=oQs40YHi/MeF2KDX0C4Adv8sgrGTIaRF3MjWU3r38ypzkYQtO2DrDPEcN8lCuq/R0FljdM
 J/lw4q2zjcYQzL7B6DYDEgeyqt+zQGUuKi2k6VG/wuqnXTgts06YVU/EBSu+4fRnw1Zb1r
 KYRgT3xdhn1ct/vfakrrTrlaI9EaXUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716316503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OVBagSbz3PZopKYXdwzBwcx6p9RL4p2jtpjk/n/H5mA=;
 b=ZVK9eesTTI9DQyLtR8Iyq2zk9lGQlM73cXkNato2BWBOqie6Mmuw0AkYLAXGQe3ZQuAn4a
 JQEVn67qLIS9tJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C719613A1E;
 Tue, 21 May 2024 18:35:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id W3Y8LlbpTGamPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 May 2024 18:35:02 +0000
Date: Tue, 21 May 2024 20:34:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240521183456.GA206767@pevik>
References: <20240521105348.126316-1-pvorel@suse.cz>
 <20240521105348.126316-6-pvorel@suse.cz> <Zky53rMVsqvgTCxG@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zky53rMVsqvgTCxG@yuki>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] setsockopt0[38]: Use tst_is_compat_mode()
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

Hi Cyril, all,

> I guess this is something that should be looked into after the release,
> either we will need .needs_compat flag or relax the condtions...

OK, the previous 4 got a review thus merged, this one is left out.

Thanks for your time!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
