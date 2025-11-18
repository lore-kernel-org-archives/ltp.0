Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81B5CEDDA1
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 14:55:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 056443CF54A
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 15:55:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F8DE3CF523
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 15:54:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8078C2005EC
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 15:54:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C2D91FF02;
 Tue, 18 Nov 2025 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763477687;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtiTsN8nM3JP/8j544g0HB1iAvnSzKxmSdR4oUBxfAU=;
 b=gXQs/sK4pEse5xzbq9NhBCk73Gje7Sa/crMJnzF1B9gQJibx5IXe9PJMYJDdGTk2HNW5H2
 sgty/Asonk1nRwUj+6Z2m9DZpfAiEI/LQGEljiIsEXwJ4y4OmWu6HMm6CH5viZrS9hDps7
 T1nIMniRm4ckVJQYkAhPyrhXRzd3r2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763477687;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtiTsN8nM3JP/8j544g0HB1iAvnSzKxmSdR4oUBxfAU=;
 b=bOfH0RUEfbqEXEZ0HNsoM3t8jdCKQuh2itWzyvKfrJmR/gkgDTAWmpj2Zpj3wHTEEHVO2x
 pFNJmgvHT8icALDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763477687;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtiTsN8nM3JP/8j544g0HB1iAvnSzKxmSdR4oUBxfAU=;
 b=gXQs/sK4pEse5xzbq9NhBCk73Gje7Sa/crMJnzF1B9gQJibx5IXe9PJMYJDdGTk2HNW5H2
 sgty/Asonk1nRwUj+6Z2m9DZpfAiEI/LQGEljiIsEXwJ4y4OmWu6HMm6CH5viZrS9hDps7
 T1nIMniRm4ckVJQYkAhPyrhXRzd3r2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763477687;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtiTsN8nM3JP/8j544g0HB1iAvnSzKxmSdR4oUBxfAU=;
 b=bOfH0RUEfbqEXEZ0HNsoM3t8jdCKQuh2itWzyvKfrJmR/gkgDTAWmpj2Zpj3wHTEEHVO2x
 pFNJmgvHT8icALDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1A373EA61;
 Tue, 18 Nov 2025 14:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1WIkNbaIHGmmGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Nov 2025 14:54:46 +0000
Date: Tue, 18 Nov 2025 15:54:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Stephen Bertram <sbertram@redhat.com>
Message-ID: <20251118145445.GA45810@pevik>
References: <20251112180319.630584-1-sbertram@redhat.com>
 <20251112201124.GA157071@pevik>
 <CAD_=S2=jJFLvESH9c0-a41-tTKFDQDovX3T47af7-2WXmH8rgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD_=S2=jJFLvESH9c0-a41-tTKFDQDovX3T47af7-2WXmH8rgw@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add new tests for clone and clone3
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

Hi Stephen,
...
> > > +/*\
> > > + * This test verifies that clone() fals with EPERM when CAP_SYS_ADMIN
> > s/fals/fails/

> > If new version is needed, could you please use :man2:`clone` ?
> > This will link man clone(2) [2] in our test catalog [3].

> So I'm clear, a lot is new to me here, I should replace "clone()" with
> :man:`clone`
> Will the same work for clone3? i.e. :man:`clone3`?

FYI man2 is for man 2 section, man 3 is for man 3 section:

doc/conf.py

    'man2': ('https://man7.org/linux/man-pages/man2/%s.2.html', '%s(2)'),
    'man3': ('https://man7.org/linux/man-pages/man3/%s.3.html', '%s(3)'),

i.e. :man2:`clone` leads to man clone(2)
https://man7.org/linux/man-pages/man2/clone.2.html

which describes both syscalls:
clone, __clone2, clone3 - create a child process

But sure man clone3(2) links also works (the same page as man clone(2)).
https://man7.org/linux/man-pages/man2/clone3.2.html

FYI (if you have time) this should generate doc

$ cd doc; make setup && make

which is under ./html/users/test_catalog.html
and online:
https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html

> I understand the other comments and will implement them, nit or not :).

Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
