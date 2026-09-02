Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ECEC61DFD
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 09:04:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC6863E585D
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:04:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 278D13DE96E
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 11:04:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7221C1000D97
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 11:04:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8BB141F7A9;
 Wed,  2 Sep 2026 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788339868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3963Lav4L3pY10IXkhisWwPDmajAGkEZvwxMtrWg+w=;
 b=W91lv4+0CyD2TiAuGa2AiW8kQAN47UNuASSCXISA0qBZYGutp3JFcdUikvq/oaS4FnThoe
 Zpz6YjtYa9/u8eg0QR0rk/R0R/tSAmY17QxRS2KHH8OwlnS9aLcM3eslsAf7i3dxWSbJtY
 3NkosoY3RN88+aD8oaF1WxquBzJc07o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788339868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3963Lav4L3pY10IXkhisWwPDmajAGkEZvwxMtrWg+w=;
 b=a/zMhtQGYReGZVuosZpPVyDnW/4BRwyxkH9Y0huNNjLhU1nPI/mWc2w+fQzOmroRGocF91
 u1o1ipZBZHSIHQCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788339864;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3963Lav4L3pY10IXkhisWwPDmajAGkEZvwxMtrWg+w=;
 b=ats8FPwp2i/mL7THjZljptMMrioXGcIXaj5gAFtptPs4KbHtK4GfdvuGnQ5O3gkMNUUt3e
 C6w+VIb0/Dy1ketAlwKM1jqlM2e1AkukYX1ZtHSR9a/qwd77Ilzb5fX0OeTPdsHghl/vCI
 2nfG1mzZFX1vY22H+nexw9RomNMhb9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788339864;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3963Lav4L3pY10IXkhisWwPDmajAGkEZvwxMtrWg+w=;
 b=3c1tBvH5Se/5QGArIX2wraeh7Y4+WIbzZiluAFrM64pN1GeuoGHtQRO80qyavSeNFIyjxx
 54EKJndF/0bSTQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37C1A13515;
 Wed,  2 Sep 2026 09:04:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7CXEC5jml2rESQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 02 Sep 2026 09:04:24 +0000
Date: Wed, 2 Sep 2026 11:04:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260902090418.GA910767@pevik>
References: <20260831081638.19539-1-wegao@suse.com>
 <20260831081638.19539-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831081638.19539-2-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 1/2] lib: Extend tst_assert_ulong() with enum
 flags
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

> Introduce enum tst_assert_flags (including TST_ASSERT_NONE,
> TST_ASSERT_SATURATED_INT, and TST_ASSERT_TRUNC_32BIT) to
> tst_assert_ulong(). This enables type-safe handling of 32-bit
> compat-mode truncation and clamping behaviors on 64-bit kernels
> when verifying sysfs/procfs limits.

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/tst_assert.h | 36 +++++++++++++++++++++++++++++++-----
>  lib/tst_assert.c     | 26 ++++++++++++++++++++------
>  2 files changed, 51 insertions(+), 11 deletions(-)

> diff --git a/include/tst_assert.h b/include/tst_assert.h
> index dcb62dfea..9154b7249 100644
> --- a/include/tst_assert.h
> +++ b/include/tst_assert.h
> @@ -21,14 +21,40 @@ void tst_assert_int(const char *file, const int lineno,
>  #define TST_ASSERT_FILE_INT(path, prefix, val) \
>  	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)

> -/*
> - * Same as tst_assert_int() but for unsigned long.
> +/**
> + * enum tst_assert_flags - Flags for tst_assert_ulong().
nit: I'd use "Bitwise flags" as you write below.

> + *
> + * @TST_ASSERT_NONE: No flags, default direct comparison.
> + * @TST_ASSERT_SATURATED_INT: Clamps the value at %INT_MAX if it exceeds it.
> + * @TST_ASSERT_TRUNC_32BIT: Keeps only the low 32 bits of the read value,
> + *                          truncating any higher bits.
> + */
> +enum tst_assert_flags {
> +	TST_ASSERT_NONE          = 0x00,
IMHO TST_ASSERT_NONE is overkill, I'd just use 0. But others might have a
different opinion.

> +	TST_ASSERT_SATURATED_INT = 0x01,
> +	TST_ASSERT_TRUNC_32BIT   = 0x02,

Also, I'd use decimal numbers instead of hexadecimal when we have just 3 values
(specially 0x00 looks really strange).

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
