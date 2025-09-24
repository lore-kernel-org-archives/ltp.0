Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC69CAC5B0
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 12:07:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61F7E3CDC9E
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 14:07:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7CD43CD955
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 14:07:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 50EA76006E5
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 14:07:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EBAA220026;
 Wed, 24 Sep 2025 12:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758715640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CRGWHuYFzmJ3oPaRpfkDt8ePPMktnoaShe5EXPwS1fc=;
 b=rJTuSrXx5ARw9YnELHQG+xvX5KWf/IfJak+ShvsZAU2ZnQLL/8bg8nI8mZZ3KAbaUZQzde
 kUDM3TrRDsvSl10jiV+xplx4YFnBa5CAIsia9mzF2alDjpSPZZNamo94UZ1Cg4m2McGUcp
 5TA9Ra+BOXyQL4tCo3//Kds0jkVYP+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758715640;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CRGWHuYFzmJ3oPaRpfkDt8ePPMktnoaShe5EXPwS1fc=;
 b=PUqJ2GjGxldOXJiARUGf4b/2yc+MX3JLzpTF3qB5xQzoEJGQB3PsliBxP+NN0cellmg2IH
 vcl5U7QsBc8pEbDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758715639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CRGWHuYFzmJ3oPaRpfkDt8ePPMktnoaShe5EXPwS1fc=;
 b=zg3ECKENZGE8D86PDNpt1ZvJSDHIfSiouh/OAW7zdGgAjR2+OAPT54QIVF/F/twvchLB6H
 wSyrUD+MKyh0N77XCdeIeHZDH+qCSlgJTWq4MubE1+oKaac09LRzXaUZGAA5ktsPSPTSI6
 1ujxCLB9ClJDuEaK6+JqcPWQMFOJdvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758715639;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CRGWHuYFzmJ3oPaRpfkDt8ePPMktnoaShe5EXPwS1fc=;
 b=gVDUmYDmi4yM9ulGOgr0j6FpQ9OP8xDwKvRazwcSeC2BALAMIrgNpT35/mDHMel4nLh+2Z
 JPgunzp6rv3OoxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA9AA13647;
 Wed, 24 Sep 2025 12:07:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 56aLNPfe02hoSwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Sep 2025 12:07:19 +0000
Date: Wed, 24 Sep 2025 14:08:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aNPfJMs4nWRSeEu8@yuki.lan>
References: <20250923154827.74305-1-mdoucha@suse.cz>
 <aNOyLCG_Yhv4Rk30@yuki.lan>
 <1c7404a7-87aa-4c1f-a8f5-08fab2c69fea@suse.cz>
 <aNPbb6IDKO2IaMaj@yuki.lan>
 <48487e51-0e3d-4dcd-b25f-2dc9dba74172@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48487e51-0e3d-4dcd-b25f-2dc9dba74172@suse.cz>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] epoll_pwait06: Skip BPF map file descriptor
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
> I'll accept EPERM only for the file descriptor types which are now 
> unconditionally skipped. The only file descriptor type which could then 
> get skipped incorrectly will be BPF. But that's not a problem because 
> verifying epoll support is out of scope of this test. The primary 
> purpose is to verify that small epoll_pwait() timeouts won't get 
> misinterpreted as infinity. In theory, verifying that on a single file 
> descriptor type should be sufficient.

Ah, I had no idea that this is a regression test for a generic epoll
code, it never occured to me that we run something like that for all
types of file descriptors. For that test it makes sense to just skip
unsupported fds.

I guess that we are actually mixing two tests and it would make sense to
separate these two. I.e. one that is a regression test for the epoll bug
and second, probably called epoll_ctl06.c that would hammer the
EPOLL_CTL_ADD with all kinds of fds and expect either success or error.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
