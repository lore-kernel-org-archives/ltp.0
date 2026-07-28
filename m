Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A3CC54F4C
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 14:03:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDFF63E658A
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 16:03:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2EBB3E5274
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 16:02:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6EF0E1A002EF
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 16:02:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0CA893E02;
 Tue, 28 Jul 2026 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785247365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vG++ZvEoR4Gep6BPH0jlrMAKr7diUe/aBtVwHEYlpFM=;
 b=XWVa+QlmlmCoTp4UAv+gyUnqH3t/1XqITijR2eLCvAZCrKxwIdKxHoesXEuSfPICO7zoOI
 2eIAYkKbRCGdwoh/q+vq1HOhTHDt6cH5cXwbfzSwVqNatJzlshla3KjHXPL/13nCZgc/yM
 Mmd+0Xkzy4YA4vJjbZPvidwZF4GfPBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785247365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vG++ZvEoR4Gep6BPH0jlrMAKr7diUe/aBtVwHEYlpFM=;
 b=Vn8onZ0aVhs0o5AFL+pj443z2FA+Pb/dEIthkMeFrrzQVQRmaoejuF6kBuYjAEYylcWbBD
 QaUKPX19g3V4TSAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785247361;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vG++ZvEoR4Gep6BPH0jlrMAKr7diUe/aBtVwHEYlpFM=;
 b=Hm9UiaPcNv3BkBqbWQKG0n+bysRF3zHU1mMD1fsw92/aOCyM4gR5kxFn/ruKDkToSpoEfh
 FSAJUJk/WgqOxABOFl90C1cHmFkLC8Z91B4FOmCz7UdxpJDAui9IeLkExxbT0BxcOmtNKQ
 BGAtEJV1W0/bOYDqTBFM5/I7rrrVEPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785247361;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vG++ZvEoR4Gep6BPH0jlrMAKr7diUe/aBtVwHEYlpFM=;
 b=a5kJQnnROXK5vNe/xlWfDPOvuR76l34Hp5kz58dkiuXrNqqUK8fAfnvvXDbAp3uUN9eomz
 XH0TPkQwahGdWpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C34BD779B1;
 Tue, 28 Jul 2026 14:02:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ILaNLIC2aGrGegAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Jul 2026 14:02:40 +0000
Date: Tue, 28 Jul 2026 16:02:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260728140235.GD1128467@pevik>
References: <20260717-fix_core_library-v1-0-c575fcbb2cb3@suse.com>
 <20260717-fix_core_library-v1-3-c575fcbb2cb3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260717-fix_core_library-v1-3-c575fcbb2cb3@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] lib: Fix wrong field in tst_iovec_alloc
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

...
>  			iovec[i].iov_base = NULL;
> -			iovec[i].iov_base = 0;
> +			iovec[i].iov_len = 0;

Good catch!
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Fixes: ee761d81b9 ("lib: Add support for guarded buffers")

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
