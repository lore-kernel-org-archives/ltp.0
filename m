Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2527D10F2843
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 15:30:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD8DD3D0080
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 16:30:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADBED3D0080
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 16:29:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 460541000A00
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 16:29:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 084B25BDCA;
 Fri, 27 Mar 2026 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774625394;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gTTsTd/+/AN4ocXXH83F/dPo/Pja0zHwLc6QNGdUFdo=;
 b=j0OSJD7ZZzKtyix4GeTXc00vMIkmCcgbiOsJQDp750dV6WUPCYd74f/1/WDJqzEsK8wq94
 evAZGYoYSm8R6PTCvIAE2tHEnHR5eqiTM8gkBoXK4iJFi87AcXGdzjxGKY8+uit4FYOV1J
 w1mYDBezsGJJIo0cJLqyZzMbM5dEO4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774625394;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gTTsTd/+/AN4ocXXH83F/dPo/Pja0zHwLc6QNGdUFdo=;
 b=CgMNOL+DFr6n1guIJks5frLTmx988hCzq0aiUoiZmlnLf7ms5x6q/WnMqH5PuZdXjzTQvV
 v3Jtq1JMyQuneWCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774625394;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gTTsTd/+/AN4ocXXH83F/dPo/Pja0zHwLc6QNGdUFdo=;
 b=j0OSJD7ZZzKtyix4GeTXc00vMIkmCcgbiOsJQDp750dV6WUPCYd74f/1/WDJqzEsK8wq94
 evAZGYoYSm8R6PTCvIAE2tHEnHR5eqiTM8gkBoXK4iJFi87AcXGdzjxGKY8+uit4FYOV1J
 w1mYDBezsGJJIo0cJLqyZzMbM5dEO4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774625394;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gTTsTd/+/AN4ocXXH83F/dPo/Pja0zHwLc6QNGdUFdo=;
 b=CgMNOL+DFr6n1guIJks5frLTmx988hCzq0aiUoiZmlnLf7ms5x6q/WnMqH5PuZdXjzTQvV
 v3Jtq1JMyQuneWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C754B4A0A2;
 Fri, 27 Mar 2026 15:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rGs8LnGixmkbEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 15:29:53 +0000
Date: Fri, 27 Mar 2026 16:29:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260327152952.GB1092845@pevik>
References: <20260316130320.138328-1-japo@linux.ibm.com>
 <69c66196.5d0a0220.2a94f1.b1f7@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69c66196.5d0a0220.2a94f1.b1f7@mx.google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] editorconfig: add consistent formatting
 rules for LTP
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > # Python and Perl: default to tabs (most test files use tabs, checkpatch.pl which we modify)
> > [*.{py,pl}]
> > indent_style = tab
> > indent_size = 8

> Not 100% sure about this.

> The Python test files in the tree (e.g. pm_sched_domain.py, pm_ilb_test.py)
> all use 4-space indentation, not tabs. The default for *.py should be
> indent_style = space / indent_size = 4. Perl (checkpatch.pl) does use tabs,
> so it should get its own section.

> Also kirk uses 4 tabs indentation. So I guess we need to invert the two rules
> at this point.

Would it work if kirk has it's own .editorconfig? I mean, it should have anyway,
but if it will be applied on it as a submodule.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
