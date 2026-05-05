Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A087CD342F
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 12:02:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDB6F3E6533
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 14:02:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 345243D0E76
 for <ltp@lists.linux.it>; Tue,  5 May 2026 14:02:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 97A4F60094F
 for <ltp@lists.linux.it>; Tue,  5 May 2026 14:02:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C5D66AA48;
 Tue,  5 May 2026 12:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777982548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YIQV1XaoOC+o5u6SImZzH+aL9PfkSbVa4Fndx+9bzjs=;
 b=pCAjs8JSjbEeeVcYbtXu9TD8Tc935slUTR99vaJRWfMS5LKgqX/4ZaQ/KIsLndxjoGGE+G
 nnwfADh9BylxrZvnYzfsYQ8ZAy8Zj7HF4ONaeJaszbVFJfW24TSAN7FYLUz6wxZWy05tAp
 ZxiP9fCRygI8AmOh3gOQjb0gFLYTv7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777982548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YIQV1XaoOC+o5u6SImZzH+aL9PfkSbVa4Fndx+9bzjs=;
 b=F2oE1mGIRgDDKywPu5tZTQ84gdVzGSZ6xZ8zvswEnAFO3RLEcwKYp2MFwNGDDb2Zu2tIsT
 HA2pULVe2XI5sZAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=f66B1X+v;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XYMZ9EKp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777982544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YIQV1XaoOC+o5u6SImZzH+aL9PfkSbVa4Fndx+9bzjs=;
 b=f66B1X+vUf91hRuEOaN1vHxegQ3+Kls0NxW32KOI3GzuL8TICjTaI07fjrPrNlo0PgPTLE
 rAYTzoyWmia4mAOuzkCeohPw//ecqnDD/Oni8qnKfdSVA2fQz0INd3HvtwGDqFEKaD1+Gk
 O3Pkrn47xC6CfGSMzIuasWcs+TRbumM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777982544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YIQV1XaoOC+o5u6SImZzH+aL9PfkSbVa4Fndx+9bzjs=;
 b=XYMZ9EKpd/RQldjSpDd8Vw93IdR5ngTR+56r1gHNaWkGZJxiwF38N2VOA/UsxGRJtPLXi2
 QHcxBL972eAcPrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5976A593A3;
 Tue,  5 May 2026 12:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GmHlFFDc+Wm+dAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 May 2026 12:02:24 +0000
Date: Tue, 5 May 2026 14:02:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <afncUgcF3YQ5BzIw@yuki.lan>
References: <20260327160157.76906-1-rbranco@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260327160157.76906-1-rbranco@suse.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6C5D66AA48
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] userfaultfd: Minor fixes
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
> -static void *handle_thread(void)
> +static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
>  {
>  	static struct uffd_msg msg;
>  	struct uffdio_writeprotect uffdio_writeprotect = {};
> @@ -53,7 +56,7 @@ static void *handle_thread(void)
>  	SAFE_READ(1, uffd, &msg, sizeof(msg));
>  
>  	if (msg.event != UFFD_EVENT_PAGEFAULT)
> -		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
> +		tst_brk(TFAIL | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);

Agree with Andrea that the TERRNO here is wrong. The rest is okay.

With the TERRNO removed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
