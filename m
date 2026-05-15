Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789FCCD4F25
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 14:33:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08FA83E49DB
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 16:33:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C641B3E241E
 for <ltp@lists.linux.it>; Fri, 15 May 2026 16:33:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8C78A600769
 for <ltp@lists.linux.it>; Fri, 15 May 2026 16:33:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C75B25ECB8;
 Fri, 15 May 2026 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778855596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4T81Lm0oOhiT6uOs3Kdso7WMQJVB3LTP5F6aIQXYfQ=;
 b=vXP6wuD+yoT3yQWuSLcvJozzrnxpSBWJcqgNnwMQVI7PMZ45RC3v6VGqWEQbSLH3HjaAhW
 u1YM2NK2mEY718DkBboM7KwFTsrF0nF/wzFJcDqrEU4pEGkMTlHrnHsZEP8i2NbbCtgkaW
 BzVhJHNXXXFp5I5w7y//72VQ/9WM8DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778855596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4T81Lm0oOhiT6uOs3Kdso7WMQJVB3LTP5F6aIQXYfQ=;
 b=5bbV0cLCa8n7YlLjC0NtCgGFoBwKDFhg9ga3ES8sVn0ZJ3gs6aoZRmGi5Xv0EylX8+4qv9
 5vzx4x+CtXHOJ+Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778855596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4T81Lm0oOhiT6uOs3Kdso7WMQJVB3LTP5F6aIQXYfQ=;
 b=vXP6wuD+yoT3yQWuSLcvJozzrnxpSBWJcqgNnwMQVI7PMZ45RC3v6VGqWEQbSLH3HjaAhW
 u1YM2NK2mEY718DkBboM7KwFTsrF0nF/wzFJcDqrEU4pEGkMTlHrnHsZEP8i2NbbCtgkaW
 BzVhJHNXXXFp5I5w7y//72VQ/9WM8DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778855596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4T81Lm0oOhiT6uOs3Kdso7WMQJVB3LTP5F6aIQXYfQ=;
 b=5bbV0cLCa8n7YlLjC0NtCgGFoBwKDFhg9ga3ES8sVn0ZJ3gs6aoZRmGi5Xv0EylX8+4qv9
 5vzx4x+CtXHOJ+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C927593A9;
 Fri, 15 May 2026 14:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5gktJawuB2pAKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 May 2026 14:33:16 +0000
Date: Fri, 15 May 2026 16:33:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260515143311.GA38814@pevik>
References: <afNbfCcv83zeMsgZ@yuki.lan>
 <agbG09eqwUp9Uwf8@rei.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <agbG09eqwUp9Uwf8@rei.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

Hi all,

> Hi!
> > Given that we have a SUSE Labs konference in the week starting 18. May I
> > would like to start LTP May release preparations a bit sooner.

> If you have anything that isn't a bugfix and should go to the release
> please point it out ASAP. I would like to start with the freeze and
> pre-release testing starting next week.

Could we please include these pre-release fixes?

tst_net.sh: tst_rhost_run(): Go to LTP temporary directory first
https://patchwork.ozlabs.org/project/ltp/patch/20260515133613.31249-1-pvorel@suse.cz/
https://lore.kernel.org/ltp/20260515133613.31249-1-pvorel@suse.cz/T/#u

checkpatch: Pass git root (tooling, not test itself)
https://patchwork.ozlabs.org/project/ltp/patch/20260513134948.77923-1-pvorel@suse.cz/
https://lore.kernel.org/ltp/20260513134948.77923-1-pvorel@suse.cz/T/#t

I'd really get thermal to be merged (at least 1 of 3 tests from Intel).
IMHO v20 is better than 21, I'll reply to it

[v20] thermal: add new test group
https://patchwork.ozlabs.org/project/ltp/patch/20260514093649.125287-2-piotr.kubaj@intel.com/

[v21] thermal: add new test group
https://patchwork.ozlabs.org/project/ltp/patch/20260514133446.144550-2-piotr.kubaj@intel.com/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
