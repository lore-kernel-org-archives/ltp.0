Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B76BC28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 09:12:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D22FF3CA305
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 10:12:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56E343CA17D
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 10:12:20 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 68AE31A0027B
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 10:12:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 435EC1F388;
 Fri, 28 Mar 2025 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743153138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fCp8ZLQu8F58z7muNFPf5sEgehTQ3C5JP2BBLuvD86g=;
 b=vMJeg8cjr2mcU8SDco2yJvx7VnKAW9zMqYDKKM3Qt/DZFqROHahlCAszcEEA0J515lvQaH
 FP9BP5d+TgV2fOaDsnk2kusZ/rQDErfU8mJJAz0H+mEDE/MErOEsUVQ4M+xEoWMVTcEA4/
 pPmHNbyOvW6TLrUJEbAqdnk5FL82UtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743153138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fCp8ZLQu8F58z7muNFPf5sEgehTQ3C5JP2BBLuvD86g=;
 b=PKGvbuTZpDCRfDl/ykPrBbpgdkmT9BBb02u/Awxcjcq0Ojo/dhp17tC3wwRQ2muibRRq1y
 0RJPE/mWphLQKtCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743153138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fCp8ZLQu8F58z7muNFPf5sEgehTQ3C5JP2BBLuvD86g=;
 b=vMJeg8cjr2mcU8SDco2yJvx7VnKAW9zMqYDKKM3Qt/DZFqROHahlCAszcEEA0J515lvQaH
 FP9BP5d+TgV2fOaDsnk2kusZ/rQDErfU8mJJAz0H+mEDE/MErOEsUVQ4M+xEoWMVTcEA4/
 pPmHNbyOvW6TLrUJEbAqdnk5FL82UtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743153138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fCp8ZLQu8F58z7muNFPf5sEgehTQ3C5JP2BBLuvD86g=;
 b=PKGvbuTZpDCRfDl/ykPrBbpgdkmT9BBb02u/Awxcjcq0Ojo/dhp17tC3wwRQ2muibRRq1y
 0RJPE/mWphLQKtCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 162D113927;
 Fri, 28 Mar 2025 09:12:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X/TSA/Jn5mcfEAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Mar 2025 09:12:18 +0000
Date: Fri, 28 Mar 2025 10:12:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250328091216.GA134125@pevik>
References: <20250324234016.367228-1-pvorel@suse.cz>
 <20250324234016.367228-4-pvorel@suse.cz>
 <D8R0YF9GVL4S.276WLTALPPSQ5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D8R0YF9GVL4S.276WLTALPPSQ5@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 TAGGED_RCPT(0.00)[ricardo=marliere.net];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] Makefile: Update 'doc' target,
 add 'doc-clean'
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

> On Mon Mar 24, 2025 at 8:40 PM -03, Petr Vorel wrote:
> > 'doc' target previously run docparse documentation. Point it to doc/
> > directory so that it build sphinx docs. doc/ dir has metadata/ dir as
> > dependency, no need to specify it. Call also '.venv' target.

> > NOTE: it's still possible to avoid virtualenv by calling 'make -C doc'

Thanks for testing.

> From the root dir ?

Yes, this is noted in the 4th patch
https://patchwork.ozlabs.org/project/ltp/patch/20250324234016.367228-5-pvorel@suse.cz/

> $ make -C doc
> make: Entering directory '/mnt/ext/src/linux/ltp/mail/doc'
> make -C /mnt/ext/src/linux/ltp/mail/metadata
> make[1]: Entering directory '/mnt/ext/src/linux/ltp/mail/metadata'
> /mnt/ext/src/linux/ltp/mail/metadata/parse.sh > ltp.json
> make[1]: Leaving directory '/mnt/ext/src/linux/ltp/mail/metadata'
> if [ -d .venv ]; then . .venv/bin/activate; fi; sphinx-build -b html . html
> /bin/sh: line 1: sphinx-build: command not found
> make: *** [Makefile:24: all] Error 127
> make: Leaving directory '/mnt/ext/src/linux/ltp/mail/doc'

As I wrote, I'll add sphinx to requrements.txt (as Andrea suggested).

Kind regards,
Petr

> > Add 'doc-clean': to remove only generated data (not optional .venv).

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
