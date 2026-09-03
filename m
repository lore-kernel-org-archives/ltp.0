Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25531C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:35:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 569C13EB094
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 17:35:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA2DA3E9844
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 17:34:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 57ECC6000FD
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 17:34:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D558D1FE6C;
 Thu,  3 Sep 2026 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788449693;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M90uZdvgjSjJ+mZOQadznF7I7uoYkmkrP8aqgPHCA90=;
 b=fjGBIfGx1m33U7yVl9m/7F7KbGN0Bl0Em7nnObnbGyx9B5fC9L5u5br40neFqUk3B3wEba
 bbkd+fp6BaTjkiL8hentbTI6BbiEjiNYkpp/nZAGeEOjMYnBr4OcD6LtirT3lFP8KgEFja
 tD2nmMQA79P4Jryucm1/9PWLV+K5f2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788449693;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M90uZdvgjSjJ+mZOQadznF7I7uoYkmkrP8aqgPHCA90=;
 b=SasOj3IdCUage62RAMYBajQZBiOjC4N+yxuMcl6ZinzRXtyHde0h1UXmlavacMwh/fHR14
 jpyTw9YapO6S56DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788449688;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M90uZdvgjSjJ+mZOQadznF7I7uoYkmkrP8aqgPHCA90=;
 b=G5hFZbYDogIxu4ah0GY8pNhCtCorwz06H2i3DYn3K7g2Cx8t/9NrIOgyV666fAuBHgtp4w
 KCKfZCGC9XEpaF+oOfNbSYj/5Om/lTYUGCGiSObxhdQJFRsB0qnxiU78C/zQfYL2htfws0
 G5LmH4BrvnBrEIohKyHlZETuZTFxqyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788449688;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M90uZdvgjSjJ+mZOQadznF7I7uoYkmkrP8aqgPHCA90=;
 b=4NWe2IEGOuOO2JJkLG/LPnU+bw2Zao8EQrb5KVhPdJh1QGxI40iFqtP6T2EZcwANq+GdyE
 Ibyz9x57lteFxPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4260136D9;
 Thu,  3 Sep 2026 15:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qDoOJ5iTmWoaVwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 15:34:48 +0000
Date: Thu, 3 Sep 2026 17:34:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260903153447.GA1141610@pevik>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260827112157.1748734-2-chrubis@suse.cz>
 <20260903145740.GB1107507@pevik> <apmNciM1Wnfdj5OF@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <apmNciM1Wnfdj5OF@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 01/31] lib: Add tst_sysfs_assert
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
> > doc related nit: If you use
> > :c:enum:`TCONF <tst_res_flags>`

> > TCONF will be clickable in the docs, link to:
> > https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#c.tst_res_flags

> > I admit it's really ugly construct (I haven't found better), but newcomers can
> > find quickly TCONF related doc.

> Sigh, that's one thing doxygen got right it's just #TCONF there...

I miss something simple as this as well. I wonder if it'd be worth to at least
ask for this feature at sphinx-doc github. I might force myself to ask, maybe
there is much easier way.

> Anyways I can do that before merge.

Sure!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
