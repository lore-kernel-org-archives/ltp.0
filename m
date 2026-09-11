Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E68CC88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:36:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E5073E922E
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 17:36:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 323763E920E
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 17:36:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 728E51A00CBB
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 17:36:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 939001FB5D;
 Fri, 11 Sep 2026 15:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789140958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qijgygguwsglmkmGsPXR+g9Y7geOkF2laW0SId9JEY4=;
 b=T5qP4pOp1Ajn5ZGNgG8+OI3UYYAj7sfnTcaPlqzWmrTyGNBuY/h5OwwWXzgGYfKLflH42U
 lU5Rtxf0v00kqqk4y0QVGRZvVFPlVnRXkznL+WbpkjczhdaWOOXfjQ0pQvNOieyJKbcqNk
 E/Ms/ddWBrv858Oz/XSagDWXCRvVEkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789140958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qijgygguwsglmkmGsPXR+g9Y7geOkF2laW0SId9JEY4=;
 b=EM8xt99IbUkNPOGWWSVz0gOSX/ldL84I9gwQ4kYHz3XpjP6aFBjXsI+e+VemkrZK5n+Wya
 n/lu2qUOmf2jkbCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UxkZnjmx;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=A924lt6k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789140954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qijgygguwsglmkmGsPXR+g9Y7geOkF2laW0SId9JEY4=;
 b=UxkZnjmx3EtAV+tmb1eEbUqYIewBUsGpIE9M34WIlyw/88mvjBOtT1JWcdaJG+xwL7KiHQ
 pGUwy4DYhaqZtjdXl/9Is5Vilz02B/ayA147up9r50QX5peBpPomEczq+UgDOS2yak3Dz7
 r4cM9NwRFogTrBgihkvKdq5RHi2qIGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789140954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qijgygguwsglmkmGsPXR+g9Y7geOkF2laW0SId9JEY4=;
 b=A924lt6kOvYZaBsgvljCrEJbGTLqmRqNtZY3LbYBCEcHDwUmUTdPjaB3+D3Py1X5wk07Nn
 GZA35LHXklk6NVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5285A136ED;
 Fri, 11 Sep 2026 15:35:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T1kdFNofpGpWPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Sep 2026 15:35:54 +0000
Date: Fri, 11 Sep 2026 17:35:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqQf3pyEeS4q-y-K@yuki.lan>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-22-43b78b15ef9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-keyctl_coverage-v2-22-43b78b15ef9f@suse.com>
X-Rspamd-Queue-Id: 939001FB5D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 22/33] keyctl29: Test KEYCTL_PKEY_QUERY on
 public key
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl_common.h b/testcases/kernel/syscalls/keyctl/keyctl_common.h
> index c7290cc6e..723fe228b 100644
> --- a/testcases/kernel/syscalls/keyctl/keyctl_common.h
> +++ b/testcases/kernel/syscalls/keyctl/keyctl_common.h
> @@ -50,4 +50,24 @@ static inline key_serial_t search_ring(key_serial_t ring, const char *type,
>  		      (unsigned long)desc, 0);
>  }
>  
> +static inline key_serial_t add_asymmetric_key_or_tconf(const char *desc,
> +						       const void *payload,
> +						       size_t plen,
> +						       const char *parser_kconfig)
> +{
> +	TEST(add_key("asymmetric", desc, payload, plen, KEY_SPEC_PROCESS_KEYRING));
> +	if (TST_RET >= 0)
> +		return TST_RET;
> +
> +	if (TST_ERR == ENODEV)
> +		tst_brk(TCONF, "kernel does not support asymmetric keys");
> +	if (TST_ERR == EBADMSG)
> +		tst_brk(TCONF, "missing asymmetric parser (%s)", parser_kconfig);
> +	if (TST_ERR == ENOENT)
> +		tst_brk(TCONF, "missing crypto RSA / SHA256 algorithms");
> +
> +	tst_brk(TBROK | TTERRNO, "failed to add asymmetric key '%s'", desc);
> +	return -1;
> +}

Shall we turn this into a SAFE_MACRO() as well? Safe macros exitting the
test with TCONF are estabilished pattern as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
