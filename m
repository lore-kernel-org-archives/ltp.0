Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24476C61DFD
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 09:07:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1C523E6162
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:07:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D30513E5822
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 11:07:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6E6C060100D
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 11:07:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B08B41FB32;
 Wed,  2 Sep 2026 09:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788340019;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bX0pRpTtBUozk3JgUeNCQ2TGNwKYUqBg0I4igpffRiI=;
 b=eVav2CfOMVp+eWo9M+TwXfh97JbFBNmDOjGC3lYfjC5cI5ikR0v9LfQz5uYfXZuDHEH1I6
 j3lcJd0hsZsFS8VXgtFSf0BVo4NjEwqMy81RYUi6cO8FZ09EvTiNu0G2CqWcDfqTzzQ/td
 f44v4WU+foHUZTI1SWP1MIOqH2oPpoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788340019;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bX0pRpTtBUozk3JgUeNCQ2TGNwKYUqBg0I4igpffRiI=;
 b=CzqSkLUTCJS0BvTuR5UqlYCBUqpFJSlIDZtIMPfmG1aCbRgAx/2bNWqqbMi7ISkBuGlUvc
 FcHd9FC/+NTl5vBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788340015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bX0pRpTtBUozk3JgUeNCQ2TGNwKYUqBg0I4igpffRiI=;
 b=C9hx2QtBKiNlWsFiTsJVcXQHvY8JhEssNT4GFajwPIYOCVTVwabOfBfgzdcXGLitpoT/Mf
 YcLXlqxbZwQ4sR2RaHpPOZuLdj7D7Hk9fdFIKVxPGFXy9H2sulwYnsLfe7n/nIT8qeQUG1
 8txbSEP1RR7Jr2QSv9xJO7r2ypr+MbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788340015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bX0pRpTtBUozk3JgUeNCQ2TGNwKYUqBg0I4igpffRiI=;
 b=OjQUg01I8rtVOi2gmsRbgLC/PyLSIcMKI35xfZ0x8J7TCkv8f6MjTRIrhJpDwzx6ulNX6t
 LEN7MmoxOA2opgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65D8C13515;
 Wed,  2 Sep 2026 09:06:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QzHdFi/nl2qQTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 02 Sep 2026 09:06:55 +0000
Date: Wed, 2 Sep 2026 11:06:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260902090645.GB910767@pevik>
References: <20260831081638.19539-1-wegao@suse.com>
 <20260831081638.19539-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831081638.19539-3-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 2/2] shmctl03: Fix 32-bit compat mode failure
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> On 64-bit kernels, the default shmmax and shmall values often exceed
> the range of a 32-bit unsigned long or are clipped differently by
> the kernel's compat syscall layer than they appear in /proc.

> Fix this by utilizing the new TST_ASSERT_ULONG() flags to properly
> clamp and truncate the expected values under compat mode.
...
> -	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> -	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
> -	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
> +	int c = tst_is_compat_mode();
> +
> +	/*
> +	 * On 64-bit kernel, shmmax is clamped to INT_MAX for 32-bit
> +	 * compat syscall, while shmmni and shmall are truncated
> +	 * to 32-bit.
> +	 */
> +	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax, c ? TST_ASSERT_SATURATED_INT : TST_ASSERT_NONE);
> +	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni, c ? TST_ASSERT_TRUNC_32BIT : TST_ASSERT_NONE);
> +	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall, c ? TST_ASSERT_TRUNC_32BIT : TST_ASSERT_NONE);

Obviously correct (with the fact I already noted, that I'd use 0 instead adding
TST_ASSERT_NONE into enum).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
