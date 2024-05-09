Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3564DC10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 09:44:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6905C3CE128
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 11:44:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 582803CDE83
 for <ltp@lists.linux.it>; Thu,  9 May 2024 11:43:50 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CCAE41A00922
 for <ltp@lists.linux.it>; Thu,  9 May 2024 11:43:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A6685381DD;
 Thu,  9 May 2024 09:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715247828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QTOXprxaPvGPtZWa1SWEB9PeCSISmn+I7hcyWZogvxM=;
 b=P6NjHteubO2lBpJjdgWLsCElO0HVIxQ38rpPAXzZ8lTsOhRU/q5+qW4Gq/IHKsexIRiJMv
 JpadkBYa+fAQfY2OnWPvbYuLl5Ns6rRFOjm3pk2A6R6WcAb9911Z80VJ8Ts0yxO1oNV3hi
 zuesxGJmZ5E9yVyizyihZbRa1d2F7PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715247828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QTOXprxaPvGPtZWa1SWEB9PeCSISmn+I7hcyWZogvxM=;
 b=zE7SizrjDOIIVt7IR086j9FxGyfyELfXGI0iLwXZ9KTR07n3hCr46nPdwZafITTV95KYga
 K1FffwzWPF63I+Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=P6NjHteu;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zE7Sizrj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715247828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QTOXprxaPvGPtZWa1SWEB9PeCSISmn+I7hcyWZogvxM=;
 b=P6NjHteubO2lBpJjdgWLsCElO0HVIxQ38rpPAXzZ8lTsOhRU/q5+qW4Gq/IHKsexIRiJMv
 JpadkBYa+fAQfY2OnWPvbYuLl5Ns6rRFOjm3pk2A6R6WcAb9911Z80VJ8Ts0yxO1oNV3hi
 zuesxGJmZ5E9yVyizyihZbRa1d2F7PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715247828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QTOXprxaPvGPtZWa1SWEB9PeCSISmn+I7hcyWZogvxM=;
 b=zE7SizrjDOIIVt7IR086j9FxGyfyELfXGI0iLwXZ9KTR07n3hCr46nPdwZafITTV95KYga
 K1FffwzWPF63I+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96D0013941;
 Thu,  9 May 2024 09:43:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xuUGJNSaPGbmMgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 May 2024 09:43:48 +0000
Date: Thu, 9 May 2024 11:42:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZjyaoluhhQrHW7xP@yuki>
References: <20240130073507.662414-1-pvorel@suse.cz>
 <20240130073507.662414-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240130073507.662414-2-pvorel@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A6685381DD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] runtest: Move capability related tests to new
 capability
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
> Move cap_bounds content to syscalls
> 
> runtest/cap_bounds and runtest/filecaps had both only single entry.
> That's a waste of starting SUT, therefore create new runtest file
> capability and move it there. Add there also runtest/securebits.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> ---
> Maybe it'd be safer to verify if the tests are still relevant now.
> Because name is more promising than the actual content :).
> Also we have other tests which use libcap.
> Alternatively, we could just move them to syscalls.

I would just merge them for now, since it's better than having one or
two tests per file.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
