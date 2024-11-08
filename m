Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7342ED5C0F5
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 15:53:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD23E3D4A8A
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 16:53:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C1A53C5A6C
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 16:53:29 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C44C41BCD69E
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 16:53:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 99C3B1FB93;
 Fri,  8 Nov 2024 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731081207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MHaY5mVhEA68/EDCNSkMfQIlVDSsedq+iwRA1+qmCnI=;
 b=yK0wVKFAVNyBzxBa0GOC34Ny0T2CtHHAza+Z4n05j8as9T0IhrZ9xFTlU0CJdXEh1+NBuG
 IhbfjyBi52DcnQ12H9jr7C1gFLm/+KIPkuz0j2WuKvy3FMDp14yQSRAUQ4CJLFli2DbnR4
 QWOtFeXppgzzLWWgMqgA2lv3uxntmmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731081207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MHaY5mVhEA68/EDCNSkMfQIlVDSsedq+iwRA1+qmCnI=;
 b=81x91Ez6y5oulQv/AjLMNv8CKm87oCRei97aMX5IBbHiq5iSRjjI1wvCdNVecq1Wi1pgTL
 PHZ+DOCl/4C1myDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731081207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MHaY5mVhEA68/EDCNSkMfQIlVDSsedq+iwRA1+qmCnI=;
 b=yK0wVKFAVNyBzxBa0GOC34Ny0T2CtHHAza+Z4n05j8as9T0IhrZ9xFTlU0CJdXEh1+NBuG
 IhbfjyBi52DcnQ12H9jr7C1gFLm/+KIPkuz0j2WuKvy3FMDp14yQSRAUQ4CJLFli2DbnR4
 QWOtFeXppgzzLWWgMqgA2lv3uxntmmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731081207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MHaY5mVhEA68/EDCNSkMfQIlVDSsedq+iwRA1+qmCnI=;
 b=81x91Ez6y5oulQv/AjLMNv8CKm87oCRei97aMX5IBbHiq5iSRjjI1wvCdNVecq1Wi1pgTL
 PHZ+DOCl/4C1myDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8466713967;
 Fri,  8 Nov 2024 15:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3SIMIPczLmccIQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 08 Nov 2024 15:53:27 +0000
Date: Fri, 8 Nov 2024 16:53:29 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zy4z-VvTyGScU5tQ@yuki.lan>
References: <20241106-landlock_network-v3-0-855b14df63c6@suse.com>
 <20241106-landlock_network-v3-1-855b14df63c6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241106-landlock_network-v3-1-855b14df63c6@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Fallback landlock network support
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
> +#if !HAVE_DECL_LANDLOCK_RULE_PATH_BENEATH

I asked these to be changed to ifndef since they are more standard and
more visible.

> +# define LANDLOCK_RULE_PATH_BENEATH 1
> +#endif
> +
> +#if !HAVE_DECL_LANDLOCK_RULE_NET_PORT

Here as well.

> +# define LANDLOCK_RULE_NET_PORT 2
>  #endif

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
