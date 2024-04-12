Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE0FC4345F
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 08:59:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DB1E3CF8B2
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 10:59:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 210D73CC256
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 10:58:54 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4915861E78D
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 10:58:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 06FC938099;
 Fri, 12 Apr 2024 08:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712912332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Rcqq/fenuVf4M/Yvmt+VeKqS5tOO2mpur48xU0jCqw=;
 b=cXNDJK7ATN9STKU55VlbvIPuM1hE5OdoTWtvmk+O4Y28wpESXfxQxkyKxaQC3k1wivK4uo
 uVyPg3ZBdDiuTX2AbJWWMHv86Fz/yxR7FpAdMuekQMzBlKGJKBEiH/NYnmZ590Nw918DO/
 8hTYbfcZfwOXhD7z4lxta0aGxTqOAOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712912332;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Rcqq/fenuVf4M/Yvmt+VeKqS5tOO2mpur48xU0jCqw=;
 b=JSckzTJ7ULWkJDJcgAWuv/Ov/N59zaVV8VXsCxV1Qc0TjLntnqxXByRhdgioMyMAnOcxtd
 DdeXXb5fo0iG7EAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cXNDJK7A;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JSckzTJ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712912332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Rcqq/fenuVf4M/Yvmt+VeKqS5tOO2mpur48xU0jCqw=;
 b=cXNDJK7ATN9STKU55VlbvIPuM1hE5OdoTWtvmk+O4Y28wpESXfxQxkyKxaQC3k1wivK4uo
 uVyPg3ZBdDiuTX2AbJWWMHv86Fz/yxR7FpAdMuekQMzBlKGJKBEiH/NYnmZ590Nw918DO/
 8hTYbfcZfwOXhD7z4lxta0aGxTqOAOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712912332;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Rcqq/fenuVf4M/Yvmt+VeKqS5tOO2mpur48xU0jCqw=;
 b=JSckzTJ7ULWkJDJcgAWuv/Ov/N59zaVV8VXsCxV1Qc0TjLntnqxXByRhdgioMyMAnOcxtd
 DdeXXb5fo0iG7EAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAD4A1368B;
 Fri, 12 Apr 2024 08:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jQTsN8v3GGYVCQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 12 Apr 2024 08:58:51 +0000
Date: Fri, 12 Apr 2024 10:57:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Zhj3laSMKRVUyg7C@yuki>
References: <20240411143025.352507-1-pvorel@suse.cz>
 <20240411143025.352507-8-pvorel@suse.cz> <Zhf6wC7Cxa4-Zs--@yuki>
 <20240411204631.GA368229@pevik> <ZhjkZ7PP5vS12Cvb@yuki>
 <617829ec-4b79-4147-9c64-b53adc925c77@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <617829ec-4b79-4147-9c64-b53adc925c77@suse.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 06FC938099
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 07/31] tlibio.c: Remove UCLINUX
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
> >> IMHO you are wrong here. IMHO uCLinux-ng [1], still used libc (used in Buildroot
> >> and openembedded). And log in e5e938f4b7 (2009) suggests that it's about libc.
> >> But the question is whether it's still needed. I could try to remove these and
> >> test, but as a separate effort.
> > You are right, these should be converted into configure checks later on.
> >
> > And the tlibio should probably be rewritten completely. So let's keep
> > the patch as it is.
> >
> I started to rewrite part of that library when I was working on 
> growfiles test rewrite, but the complexity of it, the amount of nested 
> statements and macro directives made me crazy.
> Waiting for a better moment to restart rewriting it, but work is on-going.

Maybe it would be better to do this in a steps, first remove everything
that is inside the ifdefs for hpux, sgi etc. and only then start working
with the actual code...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
