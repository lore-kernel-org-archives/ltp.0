Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2257CCD184
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 15:25:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1002A3CE89E
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 17:25:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 663153C6F50
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 17:24:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AD46760091B
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 17:24:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD67E20252;
 Tue, 14 Oct 2025 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760455496;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9K6KZdjr65L+GP/1VDSLOg99X1SXmowvxfmMIDCAfNc=;
 b=GeJn2y6NXUzWKjaJP+APfrSSuowIP8IO6wKvj6s0e0hQhGS90Dw0NkSMsgeCQlBJkHz72r
 YX5FRaYILACgmZq2OYG3qSeUIZ4LHimE98bIeP9C/CkZVVD84r71HfS2PLCjifuyM3aQ/+
 1uGPh69ZiGPyLo6TE6grQ5tug1HYq0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760455496;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9K6KZdjr65L+GP/1VDSLOg99X1SXmowvxfmMIDCAfNc=;
 b=AiWK1X4l+qBqI7Oc0GikIzC+9dsFC9mL3pqvKoUDXFDSyfx0pVhE1fz1xEZAWhXagUM/83
 vUrYRLeCVS8f/9DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WFDoOdo4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DYdg08yQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760455495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9K6KZdjr65L+GP/1VDSLOg99X1SXmowvxfmMIDCAfNc=;
 b=WFDoOdo4FrghbRLphUQ0fWe+hLovLhM+LINdCs96CHyoswG6dUJrNTJajsoQjbWu2o2HAd
 NuBrP0VHjnqxlAv841nApyRNN00ipeduzik2cyeC8qv1WY8fI5Unpe/TmqaeZ6ACAyzNpi
 bjmNK/peVVqTdzphk8tCgQ5VO/nXsRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760455495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9K6KZdjr65L+GP/1VDSLOg99X1SXmowvxfmMIDCAfNc=;
 b=DYdg08yQOlDWbK7S89nJ7gvJIrPKjsGMsZpAxnba1MrQTk8lRK3Uvj8tB5TrR4KKdMiF88
 8jlk8QwqXicuLXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92F61139B0;
 Tue, 14 Oct 2025 15:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z3ovIkdr7miJNAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Oct 2025 15:24:55 +0000
Date: Tue, 14 Oct 2025 17:24:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251014152446.GA181869@pevik>
References: <20251007160516.145121-1-pvorel@suse.cz>
 <aOY8SAGEklIur9eW@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aOY8SAGEklIur9eW@yuki.lan>
X-Rspamd-Queue-Id: CD67E20252
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,gnu.org:url,suse.cz:dkim,suse.cz:replyto];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] fs: Remove acl/tacl_xattr.sh
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Old script which is not using LTP API, not in any runtest file.

> > It tests acl (getfacl, setfacl) and attr (getfattr, setfattr) tools, but
> > both project have their own tests [1] [2]. LTP concentrates on kernel
> > part of testing nowadays, therefore remove it.  Script is very simple
> > that it does not have any benefit for upstream.

> > [1] https://cgit.git.savannah.gnu.org/cgit/acl.git/tree/test
> > [2] https://cgit.git.savannah.gnu.org/cgit/attr.git/tree/test

> While I agree that this is testing an userspace tools we do not have
> much acl coverate in LTP, there seems to be some network nfsv4 tests but
> that seems to be all. I guess that we should at least create an github
> issue that we should write a few tests for that. I guess that writing a
> simple test that sets up right extended attributes and expecte a file to
> be accessible or not shouldn't be that hard.

Add test for filesystem extended attributes
https://github.com/linux-test-project/ltp/issues/1265

Please have a look to the ticket and improve it if needed.

I'm ok to keep this until we have a proper ACL test.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
