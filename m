Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C17FED9E4
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 15:32:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88B7F3E2B83
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 16:32:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC65D3C940A
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 16:32:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 18E801400E5C
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 16:32:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 118CE4D37A;
 Tue, 17 Mar 2026 15:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773761548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMiziHj9LzfDwAJVdw2kvMdIVoaU2Y8sWB5PnTYMso8=;
 b=EE/OBNuMs0Vl0qBu78qMjuQVzl8LT/xPFeVsPuguQi2CF/y5X8xb6bT0r9UXdepg8ZAW9K
 sWmUa9Wz3duxDnn7+F3JlIepHvvoZOozFdqePuoKZ8Pj5QBHoy4+8noPfAvNtpbEnKlTDc
 Jrjzqad+ztmcYVWLaewzeYw2dd1P40U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773761548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMiziHj9LzfDwAJVdw2kvMdIVoaU2Y8sWB5PnTYMso8=;
 b=reuktML7CdGXf2DnMBTqYQY78xnis4W5FC6VZY6LFobpF87RcDASbYArw6gWN7dP+zpAgE
 1BD1/bZ/LHPDuHDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773761548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMiziHj9LzfDwAJVdw2kvMdIVoaU2Y8sWB5PnTYMso8=;
 b=EE/OBNuMs0Vl0qBu78qMjuQVzl8LT/xPFeVsPuguQi2CF/y5X8xb6bT0r9UXdepg8ZAW9K
 sWmUa9Wz3duxDnn7+F3JlIepHvvoZOozFdqePuoKZ8Pj5QBHoy4+8noPfAvNtpbEnKlTDc
 Jrjzqad+ztmcYVWLaewzeYw2dd1P40U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773761548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMiziHj9LzfDwAJVdw2kvMdIVoaU2Y8sWB5PnTYMso8=;
 b=reuktML7CdGXf2DnMBTqYQY78xnis4W5FC6VZY6LFobpF87RcDASbYArw6gWN7dP+zpAgE
 1BD1/bZ/LHPDuHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 011AA4273B;
 Tue, 17 Mar 2026 15:32:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jnD8Ogt0uWmyQwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 17 Mar 2026 15:32:27 +0000
Date: Tue, 17 Mar 2026 16:32:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <abl0DkVFXKT-pS34@yuki.lan>
References: <69b93029.050a0220.2e2929.5885@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69b93029.050a0220.2e2929.5885@mx.google.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP old API conversion
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> .. and tests conversion for tests which are smaller than 200 lines of code
> requires minimal (if no) edit. I will continue to adapt the ltp-convert skill
> in order to tweak and to improve this process for bigger tests.

I would disagree here withe the minimal edit. The old tests are quite
often garbage. So the human in the process should asses if the test is
actually doing anything useful and guide the machine to implement better
test in a case that the original wasn't doing anything useful.

> ~~ Said so..
> 
> .. since this process seems to be quite straight forward, and with the usage
> of LLM we could easily generate hundreds of patches per month, we don't really
> want to flood the ML with garbage and to overwhelm who's involved into
> maintenance review.

I'm pretty sure that you will get this down to smaller set as long as
you actually spend some time thinking about what the test does. At least
for me I'm able to spend 30% time on a test conversion because LLM, but
you have to spend some time understanding what the test does and making
sure it makes sense. Otherwise it's garbage in - garbage out.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
