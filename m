Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7288EC1B0FF
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 16:27:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7D993C9E27
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 17:27:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 426A33C9D01
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 17:27:21 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 19E9B637AAF
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 17:27:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 87D2821174;
 Thu, 27 Feb 2025 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740673639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5onbA2WIywHo1A93q2l25+1CAz1oyxdsJy7s2487UPs=;
 b=vfVzmzV8Swmxn5lqdy3975tKI8+BgWRcEiq6FBtocuzwK2wluJDGZKpkSEzTTjTpooF/KO
 7Ryto96vJRICPrd7HtoFUiZxfyAXMlhN90XReWIx9BhxXa4dReD+G2ucyvhFW6jTvSD51d
 1ZECLNf8EYCnJJ74tsbOA89sGv14alE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740673639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5onbA2WIywHo1A93q2l25+1CAz1oyxdsJy7s2487UPs=;
 b=WnFcmR0g7U+f0fBwRiUbXLarcVbCIsD+TGG91H9YGkewuq9vMvGXN5za5stOZ2gzB+K2W3
 c/VGI/05hg5zZeCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vfVzmzV8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WnFcmR0g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740673639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5onbA2WIywHo1A93q2l25+1CAz1oyxdsJy7s2487UPs=;
 b=vfVzmzV8Swmxn5lqdy3975tKI8+BgWRcEiq6FBtocuzwK2wluJDGZKpkSEzTTjTpooF/KO
 7Ryto96vJRICPrd7HtoFUiZxfyAXMlhN90XReWIx9BhxXa4dReD+G2ucyvhFW6jTvSD51d
 1ZECLNf8EYCnJJ74tsbOA89sGv14alE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740673639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5onbA2WIywHo1A93q2l25+1CAz1oyxdsJy7s2487UPs=;
 b=WnFcmR0g7U+f0fBwRiUbXLarcVbCIsD+TGG91H9YGkewuq9vMvGXN5za5stOZ2gzB+K2W3
 c/VGI/05hg5zZeCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FC4F1376A;
 Thu, 27 Feb 2025 16:27:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id el/xFWeSwGftIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Feb 2025 16:27:19 +0000
Date: Thu, 27 Feb 2025 17:27:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250227162717.GF3130282@pevik>
References: <20240415114652.22687-1-wegao@suse.com>
 <20241212085058.29551-1-wegao@suse.com>
 <20241212085058.29551-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241212085058.29551-2-wegao@suse.com>
X-Rspamd-Queue-Id: 87D2821174
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] tst_safe_macros.h: Add SAFE_STATVFS
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

Hi Wei,

> +++ b/include/tst_safe_macros.h
> @@ -429,6 +429,27 @@ static inline int safe_statfs(const char *file, const int lineno,
>  #define SAFE_STATFS(path, buf) \
>  	safe_statfs(__FILE__, __LINE__, (path), (buf))

> +static inline int safe_statvfs(const char *file, const int lineno,
> +                              const char *path, struct statvfs *buf)
> +{
> +	int rval;
> +
> +	rval = statvfs(path, buf);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"statvfs(%s,%p) failed", path, buf);
> +	} else if (rval) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid statvfs(%s,%p) return value %d", path, buf,
> +			rval);
> +	}

@Wei We usually add only function signature to headers, the rest goes into
lib/tst_safe_macros.c. The only exception are functions in
include/tst_safe_macros_inline.h due off_t or structs which contain it, which is
not this case.

Besides following ioctl_fiemap01.c it could be used also in libs/swap/libswap.c
and lib/tst_fill_fs.c, where we don't even check return code. Not that many
cases but probably useful.

FYI fstatvfs() with TBROK is used in fsync02.c not sure if to add it as well.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
