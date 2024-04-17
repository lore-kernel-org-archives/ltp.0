Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229BAC4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 18:33:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0676C3CFBB3
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 20:33:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4EA63CD2A0
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 20:33:04 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4761E1A00E50
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 20:33:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4DA9F3403C;
 Wed, 17 Apr 2024 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713378781;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqRDyqS5k/8Ycu1LcSdJkGpX5hvDq07XMCgYDOy4MYg=;
 b=1ZQ4+a/kRZtw0W3TzPiJQaU1Sz3saHIAbKXKAPbvoWT7tx/bJqGEQ3Wp3wggMEepYPQVQ8
 zmEGvjUXd0nY01r2DuI2gXN6XC+2IKsWP6NqyMVREDE+xptmD5HktHHm64S67QT+jtBP8f
 hrD7n0oJISx06sdZZkt9rXouCGWqo1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713378781;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqRDyqS5k/8Ycu1LcSdJkGpX5hvDq07XMCgYDOy4MYg=;
 b=qXkLJbiD5ZKRBVux8rxTFynw5+0ZWn8673F8KoPYIq1nt3AZ8XPdr7ShS9B0YHjuK49v2S
 FBAYsfJM5xmO1LCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713378781;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqRDyqS5k/8Ycu1LcSdJkGpX5hvDq07XMCgYDOy4MYg=;
 b=1ZQ4+a/kRZtw0W3TzPiJQaU1Sz3saHIAbKXKAPbvoWT7tx/bJqGEQ3Wp3wggMEepYPQVQ8
 zmEGvjUXd0nY01r2DuI2gXN6XC+2IKsWP6NqyMVREDE+xptmD5HktHHm64S67QT+jtBP8f
 hrD7n0oJISx06sdZZkt9rXouCGWqo1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713378781;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqRDyqS5k/8Ycu1LcSdJkGpX5hvDq07XMCgYDOy4MYg=;
 b=qXkLJbiD5ZKRBVux8rxTFynw5+0ZWn8673F8KoPYIq1nt3AZ8XPdr7ShS9B0YHjuK49v2S
 FBAYsfJM5xmO1LCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2437413977;
 Wed, 17 Apr 2024 18:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JE5jB90VIGYhJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 18:33:01 +0000
Date: Wed, 17 Apr 2024 20:32:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240417183255.GA35911@pevik>
References: <20240417101201.715518-1-pvorel@suse.cz> <Zh-lvOimOYLd2Z4H@yuki>
 <20240417121910.GA727397@pevik> <Zh_QlPB2Sjo-kUAN@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zh_QlPB2Sjo-kUAN@yuki>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: documentation: Fix typo other => older
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

> Hi!
> > BTW how does these spellchecker feature in sphinx works? Did you find it to run something
> > (tox -e spelling -r [1] or did you spot it manually?

> You have to run make spelling as described in the documentation.

> > I hoped that errors like this would be caught, e.g. we might want to have CI
> > check for it, right?

> The problem is that there are false possitives, so we can't simply plug
> it into a CI as it is now.

Sure, agree. It'd be good just time to time to run it.

github actions also have a warning message [1] (to check it time to time and fix or
whitelist), but looking at the spelling output it's quite noisy (tests also
venv, the only real thing I see is "Spell check: nr" => whitelist "nr").

Kind regards,
Petr

[1] https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#setting-a-warning-message

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
