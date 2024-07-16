Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B59C3DA49
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 16:59:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5254E3D1ABE
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 18:59:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86CEA3D199A
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 18:59:34 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E24F910009F0
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 18:59:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5E7F21AB6;
 Tue, 16 Jul 2024 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721149172;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrBPNm0NbKh5SYHRpLKYuzuFYXVXtodbaLPYznj4g0E=;
 b=iJXvi52Eye9ln5ohaqrcmdcXXadbE14XflLTqEjhUu/zHPhPKa7qIi+4C1a9XMzcjipLkc
 L36DM6ZNIZeEQNQl2t5svyr8Pl7e/Qr4aX4lML6GLW/LYDfUTQ75L7nWTZ5DsQxJdapjBO
 9PaSXdYYEtv5CqTTsyoHeg4KxkXKJwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721149172;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrBPNm0NbKh5SYHRpLKYuzuFYXVXtodbaLPYznj4g0E=;
 b=4n20KpAkOCC5Psfy1nlPEmjw5LN370yNTkDbDs9M/SB2nl9FCCv1/c8FnqvAYJbrn2jNXB
 3a+DEVM65YpDjEBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721149172;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrBPNm0NbKh5SYHRpLKYuzuFYXVXtodbaLPYznj4g0E=;
 b=iJXvi52Eye9ln5ohaqrcmdcXXadbE14XflLTqEjhUu/zHPhPKa7qIi+4C1a9XMzcjipLkc
 L36DM6ZNIZeEQNQl2t5svyr8Pl7e/Qr4aX4lML6GLW/LYDfUTQ75L7nWTZ5DsQxJdapjBO
 9PaSXdYYEtv5CqTTsyoHeg4KxkXKJwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721149172;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrBPNm0NbKh5SYHRpLKYuzuFYXVXtodbaLPYznj4g0E=;
 b=4n20KpAkOCC5Psfy1nlPEmjw5LN370yNTkDbDs9M/SB2nl9FCCv1/c8FnqvAYJbrn2jNXB
 3a+DEVM65YpDjEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92F06136E5;
 Tue, 16 Jul 2024 16:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nm3cIfSmlmbcLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Jul 2024 16:59:32 +0000
Date: Tue, 16 Jul 2024 18:59:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
Message-ID: <20240716165927.GA549165@pevik>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-6-c7b0e9edf9b0@suse.com>
 <20240711203256.GB85696@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240711203256.GB85696@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 06/11] Add landlock02 test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, Li,

> Hi Andrea,

> Thanks for whole testsuite, generally LGTM.

> For this one:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Reviewed-by: Li Wang <liwang@redhat.com>
> (Li added his RBTs in v1, you moved it to v2 but forget to add to v3)

> ...
> > +static struct tcase {
> > +	int *fd;
> > +	enum landlock_rule_type rule_type;
> > +	struct landlock_path_beneath_attr **attr;
> > +	int access;
> > +	int parent_fd;
> > +	uint32_t flags;
> > +	int exp_errno;
> > +	char *msg;
> > +} tcases[] = {
> > +	{
> > +		&ruleset_fd,
> > +		0,
> > +		&path_beneath_attr,
> > +		LANDLOCK_ACCESS_FS_EXECUTE,
> > +		0,
> > +		1,
> > +		EINVAL,
> > +		"Invalid flags"
> > +	},
> nit: we've been talking about it in other tests - using designated initializers
> would make things more readable and allows avoid to specify zeros (feel free to
> ignore, sure no need for yet another version).

I dared to change this to use designated initializers and merged.
(+ follow up fixing size_t printf format)

Thanks!

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
