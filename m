Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB79CF11F4
	for <ltp@archiver.kernel.org>; Thu, 10 Oct 2024 13:27:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DFA53C4C5F
	for <ltp@archiver.kernel.org>; Thu, 10 Oct 2024 15:27:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26A6A3C0FB6
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 15:27:24 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C6AAB141104D
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 15:27:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB4A721DC3;
 Thu, 10 Oct 2024 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728566843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zk5v14/O65KXhj7ipovI3lIi8pzXUVdO3kj4M0gkPd0=;
 b=ndOKwCUNNgiP/YkACCPs+L42/3w8sYfEl02pOonPynnoOZ5Uxhoz6YPY493yrbep+XvkK4
 EdjpTFXZxvgAkEF4ftK9U3h1dMUrXWuMkmlveAi70qxQDazcSkImqtFbR0tbG2LYbNEQPi
 yKoYobX67DDuZE2tSUfyc9Dwk3Fthic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728566843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zk5v14/O65KXhj7ipovI3lIi8pzXUVdO3kj4M0gkPd0=;
 b=j2Q77w18R5vmfIpRiopadQIL9k1s63sQiMc9RZ7vTp8d+ncCPIn1nfZ425U4nIMbBGsBAf
 Hfe4lZwfAhXWjWBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728566842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zk5v14/O65KXhj7ipovI3lIi8pzXUVdO3kj4M0gkPd0=;
 b=usyXiGquhzJZk/ITn9wIxpJNYMik2aHBjasyfejaFky0qyLxvM7r5XtL8cy9XWN2+1e1t5
 M+QcOhdGKv8lL0MlkBtpEA5fvGMyqemLmTd5Mp9DHU6z9FYujQ/0S/qe+auq2p8iE9ZeVV
 bSv+m+3X39M3wzkPGZ9fNTyZ+HREVcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728566842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zk5v14/O65KXhj7ipovI3lIi8pzXUVdO3kj4M0gkPd0=;
 b=fm/qx3J/giFb0Ds8H3N8MCAO/L7IVRWMEDlWXKoi8MRMI05DK2Lo4SoKOa4Ba1FlZ5PyLq
 9f6Ipd4GxvdOwcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9B6C13A6E;
 Thu, 10 Oct 2024 13:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZmRCMDrWB2dtVAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 10 Oct 2024 13:27:22 +0000
Date: Thu, 10 Oct 2024 15:26:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZwfV_f89AbQpQX-l@yuki.lan>
References: <20241009-ioctl_ficlone01_fix-v5-0-943238be9923@suse.com>
 <20241009-ioctl_ficlone01_fix-v5-1-943238be9923@suse.com>
 <ZwfUcY7ShiepjJ7J@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZwfUcY7ShiepjJ7J@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] Filter mkfs version in tst_fs
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
> > @@ -1832,7 +1839,7 @@ static int run_tcases_per_fs(void)
> >  		if (!fs)
> >  			continue;
> >  
> > -		run_tcase_on_fs(fs, filesystems[i]);
> > +		ret = run_tcase_on_fs(fs, filesystems[i]);
> 
> I guess that I didn't explain it clearly enough, I would like to have a
> patch merged that only fixes this (ideally with your reviewed-by) rather
> than fixing this in a patchset that adds new functionality. I've send
> the patch here quite a while ago:
> 
> http://patchwork.ozlabs.org/project/ltp/patch/20241001151918.12097-1-chrubis@suse.cz/

And other than this the rest of the patchset is fine.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
