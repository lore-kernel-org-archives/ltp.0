Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ED2C02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 12:50:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D07A3C9A11
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 13:50:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 867B43C8938
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:50:17 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3C8A4141530C
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:50:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CB193370C;
 Wed, 12 Feb 2025 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739364614;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jYVecW17TM7TY/aSelwnLnqpoIw1IbLgTZOwq3/lFY=;
 b=xhEOYiFYk4a6ZdSxs2ZDv7GN9I62iEOmMIgJIg5ldQhfeI2WaYC178mSY7NksC/yAfhzrW
 VEQo1x0h+atk7qO/E57ZrgPTqVui+L1wOdf1xhZgEvPAJOVoE0eSEPM8Y7dAfL8wJKaRtA
 HLAY59QQKytxJMH7w+7aN7QbN1tWEB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739364614;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jYVecW17TM7TY/aSelwnLnqpoIw1IbLgTZOwq3/lFY=;
 b=HUqDPIi6T5BHkG/DRWNGmIjd1XIP+TgZdM7ThcIf9w1I0CfwW53+CGT6Q2Qfu/5dFMP4RQ
 dFrrJBS/cvYQwMDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739364614;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jYVecW17TM7TY/aSelwnLnqpoIw1IbLgTZOwq3/lFY=;
 b=xhEOYiFYk4a6ZdSxs2ZDv7GN9I62iEOmMIgJIg5ldQhfeI2WaYC178mSY7NksC/yAfhzrW
 VEQo1x0h+atk7qO/E57ZrgPTqVui+L1wOdf1xhZgEvPAJOVoE0eSEPM8Y7dAfL8wJKaRtA
 HLAY59QQKytxJMH7w+7aN7QbN1tWEB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739364614;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jYVecW17TM7TY/aSelwnLnqpoIw1IbLgTZOwq3/lFY=;
 b=HUqDPIi6T5BHkG/DRWNGmIjd1XIP+TgZdM7ThcIf9w1I0CfwW53+CGT6Q2Qfu/5dFMP4RQ
 dFrrJBS/cvYQwMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51C1013AFD;
 Wed, 12 Feb 2025 12:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dMvvEgaZrGcZDwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Feb 2025 12:50:14 +0000
Date: Wed, 12 Feb 2025 13:50:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250212125013.GA2036911@pevik>
References: <20250211233552.1990618-1-pvorel@suse.cz>
 <e96883c0-42c3-48ff-884f-4971d1c2b726@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e96883c0-42c3-48ff-884f-4971d1c2b726@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] doc/Makefile: Allow to create and use .venv
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!

> This somehow resolves the problem of not explicitly using virtualenv, but=
 I
> have the impression that it has some critical issues.
> virtualenv is not part of the buildsystem, but it's an external tool that
> collect python packages and it's up to the developer using it or not, and
> this makes it optional.=A0 By introducing it in the Makefile, we end up m=
ixing
> things a little bit.

> Also, this patch complicates the Makefile, since we might need one command
> before running "make" (source our_venv/bin/activate) and two commands once
> in a while to create it (venv + pip).

> In short, I have the impression there's no additional value to the patch,
> but mostly an over-engineered Makefile :-)

Well, the additional value is obvious - help people to actually build docs.
I'm not sure how many people generated asciidoc{,tor} documentation, I susp=
ect
not many due having to install tooling. That's why I'm trying to make it as=
 easy
as possible. Sure, they can copy paste commands, but why when simple 'make
.venv' does it for you?

Also, if we even decide to generate offline docs formats, it will be needed=
 to
add these commands to tools/create-tarballs-metadata.sh make sure anybody is
able to produce the release.

If this is not going to be accepted, I'll wrote my own script to do it (as I
often remove whole git tree as a cleanup).

Kind regards,
Petr


> Andrea

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
