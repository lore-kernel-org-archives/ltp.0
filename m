Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D708C25B75
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 10:48:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30A353CF087
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 12:48:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 917C13CDB41
 for <ltp@lists.linux.it>; Mon, 13 May 2024 12:47:48 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8DBA610006CC
 for <ltp@lists.linux.it>; Mon, 13 May 2024 12:47:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF440343EC;
 Mon, 13 May 2024 10:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715597262;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQwl7gNkT1qdstBRoxsfamovWFhvTx2VrRz2QVuf3G4=;
 b=pG8Z4rRID/Bo4I0ESo/6jivZtJz8awod2UoQ+0y6dX21TQ0HCT/6jJw1BrlQh2At84a2+/
 ZzILeoBOC3cO5vaNCfKcjRFELw4gZ2CZC6XjT/JYIR7R7V6I64KtS/FCBwnpXdV8MtLcZI
 9s7W74lFtm8Io80X5c5c//sfbPnFnhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715597262;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQwl7gNkT1qdstBRoxsfamovWFhvTx2VrRz2QVuf3G4=;
 b=lNQPmS2njCcvWHMj/d9EwaW8xv+cdndPI7GyKuK5czK3b5zhR7h6b8tR6pm0LqcTQ7aZpG
 UHvp6oSRO9Dh/4Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715597261;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQwl7gNkT1qdstBRoxsfamovWFhvTx2VrRz2QVuf3G4=;
 b=tu6KaUWjzr+cAPOCabwZnq2UjMPcP3RqpJwjH+i2TAtm0Sp2hGRgwO26ha0dHE3IJMm51l
 9JreIWX0JMurJkDn9pZ01xo2dP9oHAykTe1zdzRZ3yiK77jKDZfVwEgJBXqOIyTYZ6COsx
 fQXsfYVnJGmaVPFiIlJcTmP914t66n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715597261;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQwl7gNkT1qdstBRoxsfamovWFhvTx2VrRz2QVuf3G4=;
 b=cGOfqp8WVd2ui6IEwSOFR4YufH518Zq0NMRJWewmRB8etCzKJZmlt4rEFq8BRi5ZZe1/zc
 EhC7x0rmhiaMyvCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5491013A52;
 Mon, 13 May 2024 10:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Da1wD83vQWatWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 May 2024 10:47:41 +0000
Date: Mon, 13 May 2024 12:47:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Joerg.Vehlow@aox.de
Message-ID: <20240513104731.GA63875@pevik>
References: <trinity-73a44add-26d5-4c8b-b6ad-0576beafb79a-1715202092298@3c-app-webde-bap44>
 <ZjyVgVUs6wWt5cd2@yuki>
 <a182355e-d425-4646-90da-a6c86d11262c@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a182355e-d425-4646-90da-a6c86d11262c@jv-coder.de>
X-Spamd-Result: default: False [-7.49 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-2.99)[99.96%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,web.de,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,gnu.org:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix_testsuite: Remove inclomplete warning
 commandline argument
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
Cc: Detlef Riekenberg <wine.dev@web.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi,

> Am 5/9/2024 um 11:21 AM schrieb Cyril Hrubis:
> > Hi!
> >> The Open Posix testsuite calls the compiler with the commandline argum=
ent
> >> "-W", but that is not a supported gcc warning option
> >> and breaks other compiler.

> >> This patch removes the broken "-W" commandline argument.

> > Isn't -W old name for -Wextra?
> exactly that is what gcc and clang documentation states.

> On top of that

> Additionally it is nothing introduced by 8071ba7, but already by
> ff4e69314c1 back in 2013 by no one else but you Cyril ;)

Yes, it should be:

Fixes: ff4e69314 ("open_posix_testsuite: Enable warnings.")

> I guess changing it to -Wextra wouldn't hurt and is what gcc recommends.

+1 for replacing -W with -Wextra


FYI if we are interested what is behind -Wextra

https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-W
https://github.com/llvm-mirror/clang/blob/master/include/clang/Basic/Diagno=
sticGroups.td

Kind regards,
Petr

> J=F6rg

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
