Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F101AD111BC
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 08:17:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4DA93D023B
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 09:17:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31C093CFED0
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 09:17:04 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DB9641401700
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 09:17:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1549C1F7E8;
 Mon,  4 Nov 2024 08:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730708222;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wVeeVqEDTJv+Dp1VMpAnLD0JfYAES2cErW6Ivrbot4s=;
 b=NieZfM7BvJkAwaSe7/IyVaoqfuRVl2IFODPv/+YeSmjpX6ni2uGMZ+Qkl7DQt8kXPdKzDq
 bgXW+tHOOo4MfonZ+eEb6iHvjVnic1/2AVIhujWn6g9vkWx/XwdLigCkmoDLKLmYHaZzTh
 1xwTCKbC99YSVxHue0xUn09/voX0fw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730708222;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wVeeVqEDTJv+Dp1VMpAnLD0JfYAES2cErW6Ivrbot4s=;
 b=RJE2Ip3BtKPSO35I6IAyw5JGM5cQPSE5cYDaf9amTfjZwN8w7GJbQf53NVftA9+MuCTc17
 M22wmRvakGGOmKDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730708222;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wVeeVqEDTJv+Dp1VMpAnLD0JfYAES2cErW6Ivrbot4s=;
 b=NieZfM7BvJkAwaSe7/IyVaoqfuRVl2IFODPv/+YeSmjpX6ni2uGMZ+Qkl7DQt8kXPdKzDq
 bgXW+tHOOo4MfonZ+eEb6iHvjVnic1/2AVIhujWn6g9vkWx/XwdLigCkmoDLKLmYHaZzTh
 1xwTCKbC99YSVxHue0xUn09/voX0fw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730708222;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wVeeVqEDTJv+Dp1VMpAnLD0JfYAES2cErW6Ivrbot4s=;
 b=RJE2Ip3BtKPSO35I6IAyw5JGM5cQPSE5cYDaf9amTfjZwN8w7GJbQf53NVftA9+MuCTc17
 M22wmRvakGGOmKDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF05313A1D;
 Mon,  4 Nov 2024 08:17:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WuWQNf2CKGceBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 04 Nov 2024 08:17:01 +0000
Date: Mon, 4 Nov 2024 09:17:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241104081700.GB1376811@pevik>
References: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
 <20241101-generate_syscalls-v9-5-d2c3820b0323@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241101-generate_syscalls-v9-5-d2c3820b0323@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 5/5] Add documentation about syscalls.h
 generator
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

Hi Andrea,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, thanks!

> diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
> index be9a0ea8bac1d690b4ed4879d110f87c3f2a381a..97f385e5853a9041ac3e5ded7fb99e8355d84742 100644
> --- a/doc/developers/test_case_tutorial.rst
> +++ b/doc/developers/test_case_tutorial.rst
> @@ -302,24 +302,27 @@ for a distribution's C library version to be older than its kernel or it may use
>  cut down C library in comparison to the GNU one. So we must call ``statx()``
>  using the general ``syscall()`` interface.

> -The LTP contains a library for dealing with the ``syscall`` interface, which is
> +LTP contains a library for dealing with the ``syscall`` interface, which is
very nit: This was added by Richie in 7324ee19de. I also think that the "The"
article should not be there, but I'm surprised that he would make a make a mistake
(native speaker).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
