Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7484E77198
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 15:45:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA46D3C61BA
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 16:45:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A5C13C00CC
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 16:45:26 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7D51421CBD3
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 16:45:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A60B31F454;
 Mon,  6 Jan 2025 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736178324;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7ASlbNzeiGxNlJOmeeUZSczTEAmfen/oPwhodR+7n0=;
 b=zOBdPMDjqe4Xym27YqQZmycawCCP4Av3B4ZBsntwrLiQHHSkBeDbVYrFZ6WJ3AKIgSS+0s
 WADmGdG0EWGAYXQ+LB1IHhJyLeGQw/cWQVCFyTbRQp8ymzLvB8rH4868XC/QFhAEts2KCG
 BNkBhz/ye/far1yvbhyMJWvoQ1HN1Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736178324;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7ASlbNzeiGxNlJOmeeUZSczTEAmfen/oPwhodR+7n0=;
 b=V7sNWpLhacmoTMHGrgOh9LhAZmTwtQlziyCHEY031WeIvHZVVCv/6VJx2i0aZpwttvm4ip
 46maGqgEm71dQkDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736178323;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7ASlbNzeiGxNlJOmeeUZSczTEAmfen/oPwhodR+7n0=;
 b=beXK8HQKnnxa/p9NiWyI8VhLazMWmihCv+4RVQ2KipM/Z/+j8Ip62HUdJOxkMYHAcY32pa
 JM2d9EPtZA0ZlcP2fK++qkoc8NOqEWYRLm+BnkTBb4Nm5NoeQllumBD4G3yac/LuvKrk92
 VQHIlH4RhL3yhHSD/QvyBsQ5uZVNWDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736178323;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7ASlbNzeiGxNlJOmeeUZSczTEAmfen/oPwhodR+7n0=;
 b=pUq5cbTAG1XKbR35YqhdD1zn/AQRjQEP7emcgq660ajqJzHs5iaohhFrQdE7acD9SUUKEW
 ++1H2pVWWwhA+TAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B1EF139AB;
 Mon,  6 Jan 2025 15:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uWx/F5P6e2ddTgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 Jan 2025 15:45:23 +0000
Date: Mon, 6 Jan 2025 16:45:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250106154521.GC323533@pevik>
References: <Z3vJ6zXDVPACBIGd@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z3vJ6zXDVPACBIGd@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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

Hi Cyril,

> Hi!
> We are supposed to produce another LTP release at the end of January.
> As usuall I will try to look at the patchwork and get as much as
> possible reviewed in the next two weeks. If there is something that you
> think should get reviewed ASAP please let me know.

When is actually the git freeze?

Do you plan to do tst_brk() change you had in RFC? Or you want to postpone after
the release? I have related fixes, but whole tst_brk could be relaxed if we
change the API.

* tst_test.sh: Fix TBROK => TWARN evaluation
https://patchwork.ozlabs.org/project/ltp/patch/20241211001418.392890-1-pvorel@suse.cz/

* tst_net.sh: Fix calling tst_brk with TFAIL
https://patchwork.ozlabs.org/project/ltp/patch/20241217213245.29778-1-pvorel@suse.cz/

IMHO these could be merged:

* Li's patchset on fuzzy sync:
https://patchwork.ozlabs.org/project/ltp/list/?series=437898

* device-drivers: Fix module build on kernel >= 5.18
https://github.com/linux-test-project/ltp/issues/1216

* ci: run shell loader tests
https://patchwork.ozlabs.org/project/ltp/list/?series=436135
I already got review from Li, I'd like to merge it soon.

* doc: Update timeout related doc
https://patchwork.ozlabs.org/project/ltp/patch/20241113151258.182353-1-pvorel@suse.cz/

I also hoped to send v3 for IMA loading policy patchset. If I manage to add it
and acked by Mimi Zohar it would be nice to have it in the release.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
