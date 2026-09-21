Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075F4C982ED
	for <ltp@archiver.kernel.org>; Mon, 21 Sep 2026 11:52:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2168C3E6E59
	for <ltp@archiver.kernel.org>; Mon, 21 Sep 2026 13:52:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54CCF3E536C
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 13:52:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CAE8914002A6
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 13:52:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B81B621BE2;
 Mon, 21 Sep 2026 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789991544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S6hy651cGcYg0ByLvk1RWMCeYq2UE1CIbS35fRNah5g=;
 b=nVF6uovXZ+3ke7N7voF5BnCZ8RNa+sLTJs417IhWGrWDNfs8hziSKb5nEww50CrvKHXnPx
 voZXwJ2PHluu9WJpOXmCUSPOIEiIset5j4tSf+usicJeJZJQyeVvG/Wq5vtNV9P0TuUbuw
 LuQ4d8SmSmN6fzkF11/slJAzbKAvkWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789991544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S6hy651cGcYg0ByLvk1RWMCeYq2UE1CIbS35fRNah5g=;
 b=sLxf2nZEGS2cLuWfyoe0TGOIhD0BPtuwWFglLGAOEw0VJFs4KnMLiCgYLevwAeswzQ0lyv
 PRyNCWRq1agu1wCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789991540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S6hy651cGcYg0ByLvk1RWMCeYq2UE1CIbS35fRNah5g=;
 b=DYuF3einqOkKUoBK3uxRZzwKkSahtODm/lbHwHIxKhnLtilmaj8L9M8DtpPK2dBh6R+PnV
 3+aNP18i+WE/zbxtKjcQEgWRuiZej4UzSsT8N4UqpcAQjHfCSBvxa+Kmuzp2+Lzztv+8Hl
 aKq4yLa1hmchKivEht8oryLkUFYXo6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789991540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S6hy651cGcYg0ByLvk1RWMCeYq2UE1CIbS35fRNah5g=;
 b=BNoap+3wlKG/URDOcFgOzbBscUaJmz5z6m9KdTh+kptKPsE+RX6mzhaUd/PEY6Nxjpj15d
 hfdIQbPuYoDtBrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AAEC13793;
 Mon, 21 Sep 2026 11:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RYv+GHQasWpIGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 21 Sep 2026 11:52:20 +0000
Date: Mon, 21 Sep 2026 13:52:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <arEagQKsecxyn8dy@yuki.lan>
References: <20260921111407.2137467-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260921111407.2137467-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,linux.dev,suse.com,gmail.com];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lapi/keyctl.h: Fix compilation on old kernel
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
> index fdb68d1725..e1e46b7865 100644
> --- a/include/lapi/keyctl.h
> +++ b/include/lapi/keyctl.h
> @@ -69,6 +69,12 @@ struct keyctl_dh_params {
>  };
>  #endif
>  
> +/* Fix for kernel < v4.20 */
> +#if defined(HAVE_STRUCT_KEYCTL_DH_PARAMS) && \
> +	!defined(HAVE_STRUCT_KEYCTL_DH_PARAMS_PRIV)
> +# define priv private
> +#endif

I do not like this one, we may end up redefining wrong priv and break
everything.

Given that the private stil exists in the structure for C code:

(/usr/include/linux/keyctl.h)
/* keyctl structures */
struct keyctl_dh_params {
        union {
#ifndef __cplusplus
                __s32 private;
#endif
                __s32 priv;
        };
        __s32 prime;
        __s32 base;
};

We may as well use private in the tests consistently and update our
fallback with the union as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
