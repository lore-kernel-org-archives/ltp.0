Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43072C36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 12:09:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2C973CAEFE
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:09:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E7D03CA0EF
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:09:01 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 74E9A140097F
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:08:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 404A11F38D;
 Mon,  7 Apr 2025 12:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744027739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34OHIAeUXWK0nPhZEZarmSW+ewM5QzsVPU3r349QopU=;
 b=HL4eF4whmnc8mewndsHrb/WuDPPX1bIDxJUvUHLZUe/O5FBIZAHyvHExRFcjLZ0Hw3tO5g
 m6iH1/Z7ExJWoNgm1LIq4jT9LQigmmeZvCLrRptNY+WduErbcYz7Lyq9m1Uq33aaL0sAob
 Wvg7E3KPBjkaDbi6eZfP75K1Oj+I+go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744027739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34OHIAeUXWK0nPhZEZarmSW+ewM5QzsVPU3r349QopU=;
 b=P7CKdj2xsEc9OJIlHWn09z3JNSM3ptGCuPz70CAVBg6iMMEwZUB8eubkPd6m4Rb7eNTwYG
 w6dYhc+UMo0X0kCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744027739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34OHIAeUXWK0nPhZEZarmSW+ewM5QzsVPU3r349QopU=;
 b=HL4eF4whmnc8mewndsHrb/WuDPPX1bIDxJUvUHLZUe/O5FBIZAHyvHExRFcjLZ0Hw3tO5g
 m6iH1/Z7ExJWoNgm1LIq4jT9LQigmmeZvCLrRptNY+WduErbcYz7Lyq9m1Uq33aaL0sAob
 Wvg7E3KPBjkaDbi6eZfP75K1Oj+I+go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744027739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34OHIAeUXWK0nPhZEZarmSW+ewM5QzsVPU3r349QopU=;
 b=P7CKdj2xsEc9OJIlHWn09z3JNSM3ptGCuPz70CAVBg6iMMEwZUB8eubkPd6m4Rb7eNTwYG
 w6dYhc+UMo0X0kCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F48113691;
 Mon,  7 Apr 2025 12:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NM2bClvA82cdeQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 07 Apr 2025 12:08:59 +0000
Date: Mon, 7 Apr 2025 14:09:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <Z_PAd1a_oIVnREsQ@yuki.lan>
References: <20250402-conversions-modify_ldt-v6-0-2e4b0e27870e@suse.com>
 <20250402-conversions-modify_ldt-v6-1-2e4b0e27870e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250402-conversions-modify_ldt-v6-1-2e4b0e27870e@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] syscalls/modify_ldt: Add lapi/ldt.h
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
> +static inline int modify_ldt(int func, const struct user_desc *ptr,
> +			     unsigned long bytecount)
> +{
> +	return tst_syscall(__NR_modify_ldt, func, ptr, bytecount);
> +}
> +
> +static inline int safe_modify_ldt(const char *file, const int lineno, int func,
> +				  const struct user_desc *ptr,
> +				  unsigned long bytecount)
> +{
> +	int rval;
> +
> +	rval = modify_ldt(func, ptr, bytecount);
> +	if (rval == -1)
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			 "modify_ldt(%d, %p, %lu)", func, ptr, bytecount);

We should make sure that we only accept the success value here (as we do
in the rest of the safe macros) so that we catch the cases when kernel
returns an invalid value.

This should be:

	if (rval == -1) {
		tst_brk_(...);
	} else if (rval) {
		tst_brk_("modify_ltd(...) invalid retval %i", ...);
	}


With that fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
