Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69DEC624D6
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:03:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5024F3EB0B9
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 17:03:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C341E3E276C
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 17:03:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 24C451400E42
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 17:03:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9AD7A21F13;
 Thu,  3 Sep 2026 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788447803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJr7LaLb9IIMWJkrx4xmqdBqZUF9Vk1pm16Xyyrs8LY=;
 b=FKM3TV3c8JcP3G+hptHVSr5hJhbJSS+cg9crVb5KTvjmkOBry3gdzTM71h2HFfuOteMPS2
 NDJ18wPcIE21Vj5tWF6gIZAibNVfnUUjgU4ngGsHH6eN21+9NMLPPYCtp2GlZsAHz5MtfZ
 d+Y6t7O7MrUMVmZSQK/klwgxuK4hHLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788447803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJr7LaLb9IIMWJkrx4xmqdBqZUF9Vk1pm16Xyyrs8LY=;
 b=DbyvkeRUARFd9dXn03IpHpOHS/XiZ3//wzOoxycsHv5pqvxoPd4Y8xykiz9PATXzVfTKUA
 LyrNF/MONxuisCBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=piMzn3Fq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="8e1omx/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788447799;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJr7LaLb9IIMWJkrx4xmqdBqZUF9Vk1pm16Xyyrs8LY=;
 b=piMzn3FqLG03jNj5/raJN5NNPm1kmefldA18UnGIV46N5KvST47+43D0xb8RX2vWLWWFnR
 8SRX/qxyycxhGwbf0oEXRu7cWYDqE9tKqijBP6g69i21CMtQ+MjCxWErVhAzV2wG/LpnCY
 mbcnLSk3dLOW1Lh19pbAokcVgIiSglY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788447799;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJr7LaLb9IIMWJkrx4xmqdBqZUF9Vk1pm16Xyyrs8LY=;
 b=8e1omx/RB+YzydOGDLIde7lsD4w+bFOtdi6TClwceV/VU6gvfmIbABsC8u9XrCZ4tKQbbb
 J61l75Kp531mIHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68C09136E6;
 Thu,  3 Sep 2026 15:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K02SGDeMmWpVNwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 15:03:19 +0000
Date: Thu, 3 Sep 2026 17:03:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260903150313.GC1107507@pevik>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260827112157.1748734-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827112157.1748734-2-chrubis@suse.cz>
X-Rspamd-Queue-Id: 9AD7A21F13
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 01/31] lib: Add tst_sysfs_assert
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

Hi Cyril,

> +++ b/doc/developers/api_c_tests.rst
> @@ -105,3 +105,8 @@ Test macros
>  Uinput
>  ------
>  .. kernel-doc:: ../../include/tse_uinput.h
> +
> +Sysfs
> +-----
> +
> +.. kernel-doc:: ../../include/tst_sysfs_assert.h
very nit: I tried this file was sorted alphabetically.
Would you mind to keep it (just change before merge).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
