Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BB5C0218D
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 09:09:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40C703C7AD2
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 10:09:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F2353C6609
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 10:09:13 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A445D644712
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 10:09:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E09DF2116C;
 Fri, 31 Jan 2025 09:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738314551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tifupT8B0EFk3lwX4ttMDlQdLnYLklWvKQJga73r8sE=;
 b=S8rRsiCVQ/Hs9VLWOZyEDU6M+tWGBbozWZ6xUU4cgrjxP7TmVRbfmpHCzgd7o2kn07/08g
 YtcjEMid4f0tVBjvT5fqjksxAIO0LsJLma5zmgWgPgLxd1AxQgwCWl8+2ncmfvk9TA146U
 +H86ADzmZvtdvjRSazl2Vbu3hxGScPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738314551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tifupT8B0EFk3lwX4ttMDlQdLnYLklWvKQJga73r8sE=;
 b=DALMgQyM/YiKVQai7qUK7HJQN7w7gr04AAxNXNc3Ny6bkC+T+lhz9GI1qA5vg8n5qGvTRE
 7g+5iEUcP2gxeNDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738314550;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tifupT8B0EFk3lwX4ttMDlQdLnYLklWvKQJga73r8sE=;
 b=gpDWkmhvNF3AcS2rOq8pTIvPoHLBzhh8aa9ja1iNnO9fuLcxcvCChlSvt0fGXQZMiSqtCM
 6Gb3WV9to2sU+3qOSDFvl6oNg9RifoHCZxV1QFwPiKYffP5oXDIkZ564nxNnNu0eA2iItK
 cHyUakRaOsAdYOi38/othdVDZjIy1Ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738314550;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tifupT8B0EFk3lwX4ttMDlQdLnYLklWvKQJga73r8sE=;
 b=/1OgLmtPCPf/LIFLt1L4V9RpDm18jqVFMm2SK7+1SMOLGgy7bUbzJWHYtn9+HN99FnCy5Q
 7U38WBkW2M7F5iDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B09D01364B;
 Fri, 31 Jan 2025 09:09:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yO5aKTaTnGdUFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jan 2025 09:09:10 +0000
Date: Fri, 31 Jan 2025 10:09:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250131090909.GA1090737@pevik>
References: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
 <20250127-xattrat-v1-1-c3ee31e2543b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250127-xattrat-v1-1-c3ee31e2543b@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/8] syscalls: add *xattrat syscalls
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

> Add following syscalls:

> - setxattrat
> - getxattrat
> - listxattrat
> - removexattrat

Obviously correct, thank you!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Your generate_arch.sh script is really helpful :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
