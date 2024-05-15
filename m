Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6099C25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 06:50:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 719343CF334
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 08:50:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47A803C86A8
 for <ltp@lists.linux.it>; Wed, 15 May 2024 08:49:56 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 27586600923
 for <ltp@lists.linux.it>; Wed, 15 May 2024 08:49:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC03E202E8;
 Wed, 15 May 2024 06:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715755795;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/jzWDVQ2MpxU2XySO8Z3oWn/iX+RfmHWvVnY/ix/FY=;
 b=E+tGgY1ra1eQm2ope5tYOr7oy6dTdoOyFflGDOyWsOqQimZ4gsJtUTkBCZBM6DY4kd2s0Q
 ooks1cBpHDKvRB3FJXbJ4DIT7zpMliPJBISZxsc/xNPrfeS2XZm7DWsB0tWhPnL46Tjp/F
 3rZ0JSn3NfDp6930wUMkp5L7hhWaBAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715755795;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/jzWDVQ2MpxU2XySO8Z3oWn/iX+RfmHWvVnY/ix/FY=;
 b=T7RbKq2dlqDMY44hTiUnOOoDaiL3l5P2dYlKKlQupueNoaOO1trlSol4x1LtV2VChJ4AQL
 qtXqov9IYQhCAADw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="k/g9orrc";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=e2beJsVj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715755794;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/jzWDVQ2MpxU2XySO8Z3oWn/iX+RfmHWvVnY/ix/FY=;
 b=k/g9orrcWGPUACImT9qBEqjM8Uzmnw23MKmrAzc3JDrvC6MM7nhKg8wYE4HysQNqUMKZRF
 0lLqiETiFMrCcNerj85WqXuwg0EKZBrbqF/G8RDxHwOHINHUu59prjTu/SJIpLDRS08EsW
 A3vwsfH9Wzx3P0yMK7lkv3o/bOx0sS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715755794;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/jzWDVQ2MpxU2XySO8Z3oWn/iX+RfmHWvVnY/ix/FY=;
 b=e2beJsVjmIOvDOhCiLwqLr4t/t5/qHYV3jirFLLcsOHHRnb6dlHDnogwoyc2RCZWIRR9o1
 xd2qxAmwpXqn/FBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA711139B3;
 Wed, 15 May 2024 06:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7vtwKBJbRGbNMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 06:49:54 +0000
Date: Wed, 15 May 2024 08:49:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <20240515064952.GA197249@pevik>
References: <20240425052536.68290-1-xuyang2018.jy@fujitsu.com>
 <2689176.lGaqSPkdTl@localhost>
 <26b3c58d-ff1b-4f2c-82de-8692aacaed5a@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <26b3c58d-ff1b-4f2c-82de-8692aacaed5a@fujitsu.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CC03E202E8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lseek: Add negative tests for lseek
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Avinesh

> Thanks for your reviewing.

> According to the man page, not all file systems support SEEK_DATA/SEEK_HOLE.

> Users may run LTP on an old kernel, or on a file system that does not 
> support SEEK_DATA/SEEK_HOLE If returning TFAIL directly, this may make 
> user confused.

> So in the case I check the errno of lseek(), and return TCONF if 
> SEEK_DATA/SEEK_HOLE are not supported.

Sounds good.

Kind regards,
Petr

> I think this is easier to understand for users.

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
