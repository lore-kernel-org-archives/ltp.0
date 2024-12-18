Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D71E77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 18:59:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0DEC3ED62A
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:59:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE2F13D8325
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 19:58:50 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 18C4761D9A2
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 19:58:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0679D1F396;
 Wed, 18 Dec 2024 18:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548329;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DntRaL+gjr+384cVJaMmOOZZMLaA+bEc4gQ+Rk2VnUI=;
 b=1IdY+eJvcwV1Lvd2vcUEIYbQal4xpH5rQNhjzNk+udUsuNpu5xhFajraSxOqbn6ICslrSH
 1zthLyIUQsQqK0F0KN78FyAmVRCfrkREYSgRADApbZvOc8lPKrNQ+1fw9VY2iMMapQxKt9
 1rKclom/++6c6oY1TxJA27eo3WxuPWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548329;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DntRaL+gjr+384cVJaMmOOZZMLaA+bEc4gQ+Rk2VnUI=;
 b=J2b8COonDhQ20WOFcSOmQAB4C/tcQcnpfmFBlwHfh3wdCTUU+45erBMyxZJazyLJGxU5KD
 nFyUkA69i80dPsCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548329;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DntRaL+gjr+384cVJaMmOOZZMLaA+bEc4gQ+Rk2VnUI=;
 b=1IdY+eJvcwV1Lvd2vcUEIYbQal4xpH5rQNhjzNk+udUsuNpu5xhFajraSxOqbn6ICslrSH
 1zthLyIUQsQqK0F0KN78FyAmVRCfrkREYSgRADApbZvOc8lPKrNQ+1fw9VY2iMMapQxKt9
 1rKclom/++6c6oY1TxJA27eo3WxuPWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548329;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DntRaL+gjr+384cVJaMmOOZZMLaA+bEc4gQ+Rk2VnUI=;
 b=J2b8COonDhQ20WOFcSOmQAB4C/tcQcnpfmFBlwHfh3wdCTUU+45erBMyxZJazyLJGxU5KD
 nFyUkA69i80dPsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAF65137CF;
 Wed, 18 Dec 2024 18:58:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4TtTJWgbY2c3dQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Dec 2024 18:58:48 +0000
Date: Wed, 18 Dec 2024 19:58:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241218185847.GA75387@pevik>
References: <20241218184518.16190-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241218184518.16190-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.98%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/13] Get rid of testcases/kernel/mem/lib library
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

> This patchset slowly untangles the mess called kernel/mem/lib/ library.

> The library is split into several places, functions that are used by
> more than one group of tests are either reimplemented in the top level
> library or in the case of numa moved into numa_helper library in
> testcases/kerne/include/ and testcases/kernel/lib/.

> The rest of the code is either moved into respective test directories or
> in the case of unused code removed.

> This is not a coplete cleanup of the mem/ testcases as it mostly just
> moves code, but it's a nice first step that removes most of the unneeded
> dependencies and prepares for a possible refactoring later on.


> The CI run:

> https://github.com/metan-ucw/ltp

https://github.com/metan-ucw/ltp/actions/runs/12398352035

Thanks for this cleanup and verifying in CI.
On a quick look LGTM, I'll have deeper look tomorrow.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
