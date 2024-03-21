Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F3AC54E58
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 08:26:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B1A03CE639
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 09:26:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9F0C3CB56D
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 09:26:04 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 13C6B10167D4
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 09:26:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B21D420A13;
 Thu, 21 Mar 2024 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711009560;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJJDLU89Rh9rR3nzEFNFSx02cPgXkqtioUVKDmjwZ94=;
 b=3aYsGWgStTTmOSNxYglVg3WnCgprV2Qr39wgYiqZpeOkbWyK3JhLjUV3QUwI1GxVd6PPdD
 N4sYOZXyNkag9xeBjOBJs8vuMe5syoM1XJbbtl0JA0QrmqN2bCcesOapkOd7OqUKnFWTuw
 Org2c8uzOvMPRxXyrheoH3YLzBhsTdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711009560;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJJDLU89Rh9rR3nzEFNFSx02cPgXkqtioUVKDmjwZ94=;
 b=cg8vzRTUMx0rqFReTVHfu7iRvpAPryO/PUY76zeMinNB+kCTrQvGVsVeNIzSv2nn9vKy7l
 oIXS7wPiKrjlJEDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711009560;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJJDLU89Rh9rR3nzEFNFSx02cPgXkqtioUVKDmjwZ94=;
 b=3aYsGWgStTTmOSNxYglVg3WnCgprV2Qr39wgYiqZpeOkbWyK3JhLjUV3QUwI1GxVd6PPdD
 N4sYOZXyNkag9xeBjOBJs8vuMe5syoM1XJbbtl0JA0QrmqN2bCcesOapkOd7OqUKnFWTuw
 Org2c8uzOvMPRxXyrheoH3YLzBhsTdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711009560;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJJDLU89Rh9rR3nzEFNFSx02cPgXkqtioUVKDmjwZ94=;
 b=cg8vzRTUMx0rqFReTVHfu7iRvpAPryO/PUY76zeMinNB+kCTrQvGVsVeNIzSv2nn9vKy7l
 oIXS7wPiKrjlJEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BA62136AD;
 Thu, 21 Mar 2024 08:26:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mhy8JBjv+2V4cgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 21 Mar 2024 08:26:00 +0000
Date: Thu, 21 Mar 2024 09:25:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240321082559.GA535362@pevik>
References: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
X-Spamd-Result: default: False [-4.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[29.85%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/10] New LTP documentation
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

Hi Andrea,

> The new LTP documentation is meant to use Sphinx as the main
> documentation framework, with ReconStructedText as the main language.
> All the conversion has been done step-by-step, each chapter at time,
> updating english syntax and fixing typos. There are minor improvements,
> but overall the structure is the same.

> C / Networking / KVM API are not documented yet, because they will be
> probably integrated in the LTP library. C API documentation is already
> on going, but the others not.

> For a demo, please take a look at:

> https://ltp-acerv.readthedocs.io/en/latest/index.html

Out of curiosity, we need to register LTP on readthedocs.io.
Then we need GitHub Action hook (including some secret for auth) for publishing.
Correct?

https://docs.readthedocs.io/en/stable/guides/setup/git-repo-manual.html

I guess you now deploy to your fork manually, otherwise you would add GitHub
Action config in the patchset.

Also, what I like (for the future) offline formats (PDF, ePub, HTML) are
supported:

https://docs.readthedocs.io/en/stable/downloadable-documentation.html

Also, I would prefer when this merged it would actually replace the old github
docs (otherwise we maintainers endup maintaining both - getting fixes for both).
E.g. in the final version first deleting the old docs + github update hook.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
