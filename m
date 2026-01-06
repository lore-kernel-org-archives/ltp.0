Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2A2CDC174
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 12:05:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B90F3C235D
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 13:05:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61DBA3C1B25
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 13:04:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3E5D11400432
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 13:04:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E60B339E6;
 Tue,  6 Jan 2026 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767701089;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwRksh/8aVGixJ4Q7r8s4Ogl0L4ZgCRShAoKxKo54TI=;
 b=hfvNSy8iUq2RXEOIkTjPYy/gunftr9KEgpqUkhXbQI/qNr+uXFGse89UrCC7Pg1lotQhI3
 22nNocvq69Dbd8XD/KWrcCzJH6Te8WxPTjbA0L/EGaMUC44yJLpPeFfjiVdYvROxsygBcZ
 vDm2+fGAp+Ae6UBA0x1ugPtKyzvnRS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767701089;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwRksh/8aVGixJ4Q7r8s4Ogl0L4ZgCRShAoKxKo54TI=;
 b=cjXja2ttmilxSVRTZoSUaBy2NTKaeQdvVI2lYOUPwHST3NcsIs1fIfFM0G/kqIsTSFf1kj
 03bKRYtWoJGyQpAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767701089;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwRksh/8aVGixJ4Q7r8s4Ogl0L4ZgCRShAoKxKo54TI=;
 b=hfvNSy8iUq2RXEOIkTjPYy/gunftr9KEgpqUkhXbQI/qNr+uXFGse89UrCC7Pg1lotQhI3
 22nNocvq69Dbd8XD/KWrcCzJH6Te8WxPTjbA0L/EGaMUC44yJLpPeFfjiVdYvROxsygBcZ
 vDm2+fGAp+Ae6UBA0x1ugPtKyzvnRS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767701089;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwRksh/8aVGixJ4Q7r8s4Ogl0L4ZgCRShAoKxKo54TI=;
 b=cjXja2ttmilxSVRTZoSUaBy2NTKaeQdvVI2lYOUPwHST3NcsIs1fIfFM0G/kqIsTSFf1kj
 03bKRYtWoJGyQpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 824B63EA63;
 Tue,  6 Jan 2026 12:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 18c/HWH6XGnPcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 Jan 2026 12:04:49 +0000
Date: Tue, 6 Jan 2026 13:04:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Message-ID: <20260106120447.GB712536@pevik>
References: <20260102115147.2256900-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260102115147.2256900-1-po-hsu.lin@canonical.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] listmount04.c: update struct mnt_id_req support
 to kernel >= 6.17
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

> The kernel change 78f0e33cd6c93 ("fs/namespace: correctly handle errors
> returned by grab_requested_mnt_ns") from 6.18 has been ported to upstream
> 6.17.9 [1][2].

Good catch.

> Therefore change the expectation from >= 6.18 to >= 6.17 accodingly.

> [1] https://lwn.net/Articles/1047684/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.17.9&id=8ff97ade

...
>  static void setup(void)
>  {
> -	if (tst_kvercmp(6, 18, 0) >= 0)
> -		kver = AFTER_6_18;
> +	if (tst_kvercmp(6, 17, 0) >= 0)

Shouldn't we match 6.17.9 then?
It's not about the fix but about a kernel change.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
