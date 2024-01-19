Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EC4C4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 11:20:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B37903CE2CB
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 12:20:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 504C73CAC5F
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 12:20:17 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 746DE600D50
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 12:20:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E88421F43;
 Fri, 19 Jan 2024 11:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705663216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJs8aQLoIkbaKLxyVRevGwC/ZpI79hqpJBp8+ee239c=;
 b=sZoPVP2TpffhHte1bK4/JS67lb+Zfr0g/6IKTsvTvpDNyV2VRoyh/tB738JJw19wEBTSPz
 QcMVPA13CDlSI8fq9i4ZKe6HzczvI9fvE4lNB/qrH1zbroUNhF2O6EAHN5TslYvPB+pfG7
 Ud3w1XQH+L1mn5jl/LX+1iELrpf8TPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705663216;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJs8aQLoIkbaKLxyVRevGwC/ZpI79hqpJBp8+ee239c=;
 b=sWeNkfLGNMg+ugdujH3HGZ1DxtzdzPCq0djwN/dBWZ37IjFTPytcpg7JfBfHt4HvVbEfUb
 KdmEeNwynA/iEaDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705663215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJs8aQLoIkbaKLxyVRevGwC/ZpI79hqpJBp8+ee239c=;
 b=3OX09qm2MxuQ5t6PF0jtKTKmRNhrL7U90Aj81+O2yuVw6SnpRO8dNRV/rCDGD6Rcn1KsNw
 udHcq4KzRnF2wOngCZ0ntiZH2mw9UtEF9ZBesZcAksdE3bGPFGsLGYsWi5Gne79ETlAjBp
 zrkh1lmUgMfEyFkVGWXOPzNGlyTWisA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705663215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJs8aQLoIkbaKLxyVRevGwC/ZpI79hqpJBp8+ee239c=;
 b=5MoEt3yXYfudKYQ03KWeFOk4R7UkbV4TkX9agFPhRBgVr/drUnSl4XJPBvbcpMN7jDinRS
 gvGSm4j1PFIb/RDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11AD81388C;
 Fri, 19 Jan 2024 11:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ycItAu9aqmWAdQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Jan 2024 11:20:15 +0000
Date: Fri, 19 Jan 2024 12:20:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zapa-P9vY--8BrdW@yuki>
References: <20231011160822.578637-1-pvorel@suse.cz>
 <20231011160822.578637-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231011160822.578637-3-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3OX09qm2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5MoEt3yX
X-Spamd-Result: default: False [-0.35 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.54)[80.78%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2E88421F43
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] tst_fs.h: Improve tst_fibmap() doc
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  /*
> - * test if FIBMAP ioctl is supported
> + * Check if FIBMAP ioctl is supported.
> + * Tests which use tst_fibmap() should use .needs_root = 1 to avoid EPERM.
               ^
	       Maybe just:

	       Tests nees to set .needs_root = 1 in order to avoid EPERM.

> + * @return 0: FIBMAP is supported, 1: FIBMAP is *not* supported.

Otherwise it looks good.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
