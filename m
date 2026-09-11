Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA40C88E4D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:21:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FD573E9210
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:21:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7F6C3E2E82
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:20:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 064EE1000A50
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:20:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4FBEB1FEF1;
 Fri, 11 Sep 2026 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789132845;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vOHubThyLlw0oNe1hwxEpxmS3dnayqX7S8BA6fDiduQ=;
 b=vVzSQJ/2+60lL2y10hSHF1WbZpVq5tqJNxfPirJAZP5sWXqMNk5euHiwE2ID966OWey3Tz
 m2Ifn1rBInTQ6BF44tJb/bOevyUKS15XyCYvcISjM/uda9fPk/jrOaR8EByi8J2bNNBq9R
 b0IjUo5YIhsr2ESWKPitSg7MQfohUTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789132845;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vOHubThyLlw0oNe1hwxEpxmS3dnayqX7S8BA6fDiduQ=;
 b=eKhgEQuUlDJCEPxoYp6q2V64Txj4jqtq0hBksDKqZ8VFkcgdxsD/mGT6AzpOi9Fwhwbc33
 pm43PyuhbXOgOGCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0Hkm7nWI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CKsYiFjX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789132841;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vOHubThyLlw0oNe1hwxEpxmS3dnayqX7S8BA6fDiduQ=;
 b=0Hkm7nWIKHVkWbKONqxpKaQpNpFrpPhEmjX3TomteIM3a1x26x6dAWVfKESmtebujrjJpi
 +QrGOttICR53u+2CDA+iYTUFN6owhfu7acycHhwHqs67lABBMcrTzW7BQ5jauej1qr7ylt
 TKeVZL/x88F+sJKEn/NLlYHrX/XoWHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789132841;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vOHubThyLlw0oNe1hwxEpxmS3dnayqX7S8BA6fDiduQ=;
 b=CKsYiFjXooE/ZzH6z3yksApB8DMnQsNvimK/Yic+a3nVyiiJtoOkMPmpD47OcXlsymVHEx
 aA+Ably/k1oeBlAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C10A132D3;
 Fri, 11 Sep 2026 13:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dt9bGigApGqDNAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 13:20:40 +0000
Date: Fri, 11 Sep 2026 15:20:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260911132038.GA1488703@pevik>
References: <20260828-mmap_32bit_coverage-v1-0-7f0b8b589773@suse.com>
 <20260828-mmap_32bit_coverage-v1-1-7f0b8b589773@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260828-mmap_32bit_coverage-v1-1-7f0b8b589773@suse.com>
X-Rspamd-Queue-Id: 4FBEB1FEF1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lapi/mmap: add MAP_32BIT fallback
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> +++ b/include/lapi/mmap.h
> @@ -91,6 +91,10 @@
>  # define MAP_DROPPABLE 0x08
>  #endif

> +#ifndef MAP_32BIT
> +# define MAP_32BIT 0x40

I know you guard the tests with .supported_archs to x86_64, but even that
wouldn't be safer to define 0x40 only for x86_64?

#ifndef MAP_32BIT
# if defined __i386__ || defined(__x86_64__)
#  define MAP_32BIT 0x40
# else
#  define MAP_32BIT 0
# endif
#endif

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
