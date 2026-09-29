Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F5AC9832A
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 15:23:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B44D3E5869
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 17:23:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB6BD3C5E52
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 17:23:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 338FB60069D
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 17:23:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA2E81F449;
 Tue, 29 Sep 2026 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790695413;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Os5Ctf4n41FJ9XgNouCAGTSvdBR/OnhL1gYxyANKCo=;
 b=CKkmlbgyVm0mubomO9HJa1rmfO5PW70E4fwmnNr5RBhtU9uQzFq4rCsZ/gyf7p6gDFP/ke
 TXzVSBJl68M7edsoe9NVQ8/1YpHKAWlu1e+CtPYepp5dSlljZWiF5Ze6AlwhVwKVdKxpRc
 ecA0IzJw+0GTuany/zyPsjmYbvIfwN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790695413;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Os5Ctf4n41FJ9XgNouCAGTSvdBR/OnhL1gYxyANKCo=;
 b=TbB6tJnbaNc7iHBdp/XhgoWXkbkD2AN7hezG4F0c/UrBiaDEq0DaDBOyPaTkNHz6Lht19V
 oTkoHrVnsyobBvCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790695408;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Os5Ctf4n41FJ9XgNouCAGTSvdBR/OnhL1gYxyANKCo=;
 b=isx1qL4Je+Fa8tPnHz8xA4maa4smlCc9z0z5HSl4voVP3shWJ0C1Atl+x/ZZrzUQ8Z7CwP
 cgsRElcBB6740PIZ64mOdltkKMG7H7h5NTktdPtRcT6wz5xy5vFwDRSAEfa8ZahwetWeYZ
 dM/xV/zW66/mAlJjXzuk/2BxidfaRls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790695408;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Os5Ctf4n41FJ9XgNouCAGTSvdBR/OnhL1gYxyANKCo=;
 b=QjjGmTFlSVNhYxpsXnVkdsBdXjq5/8gW6GaNNnNE/f3jYmcZFmdqVMIQU68cBycy6Rv7+J
 lH1YBReAV8v8GnDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D24E133F1;
 Tue, 29 Sep 2026 15:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n6MMGvDXu2pLGwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Sep 2026 15:23:28 +0000
Date: Tue, 29 Sep 2026 17:23:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260929152326.GF2462033@pevik>
References: <20260929-fix_fw_load02-v1-1-4cd5f95d172b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260929-fix_fw_load02-v1-1-4cd5f95d172b@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Handle empty saved configuration values
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

Hi Andrea,

> Empty string module parameters return EOF on older kernels, causing
> fw_load02 to abort with TBROK on v4.4.

> Accept empty values while retaining read-error handling and the original
> errno. Restore empty strings with a NUL byte: an empty write does not
> invoke the sysfs setter, while a newline would change the saved value.

Thanks for the fix, LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Fix the following behaviour on kernel < 4.14 96802e6b1dbf

Could you please put kernel version and git hash to the commit message?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
