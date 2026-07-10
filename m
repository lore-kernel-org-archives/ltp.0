Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B85CC43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 13:10:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEFAF3E5BC9
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 15:10:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0FDA3C1D3E
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 15:10:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C4D58600717
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 15:10:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 610BD76790;
 Fri, 10 Jul 2026 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783689004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/XnEeyuQWxfSyxph2h18EMXsSga2kwWIdMMHbHTyak=;
 b=23sQqn4EdqhNtuG5uMGhCmkeFz0KO7oC61PcrJHaJpRjh+o34nYOzHMlrXpAGE2vuDib0X
 Ot8O6JukVSBK9Mt+gbAeWG/Bb04MJ6ll51Djo2r/UidEGez19VexDXcAxB4j1zLalQzPAm
 VUs8kOxziOdGfn9aJ44Z8055SgUEDqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783689004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/XnEeyuQWxfSyxph2h18EMXsSga2kwWIdMMHbHTyak=;
 b=rVN/IweyNHXUA75gf19WBUOo28wnUNnSo0KbRCKB+LkYRvepmbyMuKnP+CJjBKNKPwD8xq
 YcvLce3FKiL1BaCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=23sQqn4E;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="rVN/Iwey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783689004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/XnEeyuQWxfSyxph2h18EMXsSga2kwWIdMMHbHTyak=;
 b=23sQqn4EdqhNtuG5uMGhCmkeFz0KO7oC61PcrJHaJpRjh+o34nYOzHMlrXpAGE2vuDib0X
 Ot8O6JukVSBK9Mt+gbAeWG/Bb04MJ6ll51Djo2r/UidEGez19VexDXcAxB4j1zLalQzPAm
 VUs8kOxziOdGfn9aJ44Z8055SgUEDqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783689004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/XnEeyuQWxfSyxph2h18EMXsSga2kwWIdMMHbHTyak=;
 b=rVN/IweyNHXUA75gf19WBUOo28wnUNnSo0KbRCKB+LkYRvepmbyMuKnP+CJjBKNKPwD8xq
 YcvLce3FKiL1BaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D45C779BD;
 Fri, 10 Jul 2026 13:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oCiaESzvUGpLeAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 Jul 2026 13:10:04 +0000
Date: Fri, 10 Jul 2026 15:09:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <alDu_o0TCVP7aMtQ@rei>
References: <20260710130303.1210731-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260710130303.1210731-1-pvorel@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 610BD76790
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] test macros: Fix TST_EXP_FD_OR_FAIL()
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
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index f06c8aeb77..e18f1d33f3 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -8,6 +8,12 @@
>   * DOC: tst_test_macros.h -- helpers for testing syscalls
>   */
>  
> +/*
> + * NOTE: for all TST_EXP_*() macros SCALL in first macro needs to be stringified
> + * otherwise constants in syscalls will be evaluated (e.g. O_RDONLY becomes 0).
> + * That is the reason for underscore variants (e.g. TST_EXP_FAIL_()).
> + */
> +
>  #ifndef TST_TEST_MACROS_H__
>  #define TST_TEST_MACROS_H__
>  
> @@ -149,7 +155,10 @@ extern int TST_PASS;
>   * This is a variant of the TST_EXP_POSITIVE() for a more specific case that
>   * the returned value is a file descriptor.
>   */
> -#define TST_EXP_FD(SCALL, ...)                                                 \
> +#define TST_EXP_FD(SCALL, ...)                                  \
> +	TST_EXP_FD_(SCALL, #SCALL, ##__VA_ARGS__)
> +
> +#define TST_EXP_FD_(SCALL, SSCALL, ...)                                     \
>  	({                                                                     \
>  		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
                                           ^
					   SSCALL
> @@ -174,11 +183,14 @@ extern int TST_PASS;
>   * Internally it uses TST_EXP_FAIL() and TST_EXP_FD().
>   */
>  #define TST_EXP_FD_OR_FAIL(SCALL, ERRNO, ...)                                  \
> -	({                                                                     \
> +	TST_EXP_FD_OR_FAIL_(SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
> +
> +#define TST_EXP_FD_OR_FAIL_(SCALL, SSCALL, ERRNO, ...)                 \
> +	({                                                                 \

This indirection is not needed as long as TST_EXP_FD_OR_FAIL() is not
called from other macros.

>  		if (ERRNO)                                                     \
> -			TST_EXP_FAIL(SCALL, ERRNO, ##__VA_ARGS__);             \
> +			TST_EXP_FAIL_(SCALL, SSCALL, ERRNO, ##__VA_ARGS__);    \
>  		else                                                           \
> -			TST_EXP_FD(SCALL, ##__VA_ARGS__);                      \
> +			TST_EXP_FD_(SCALL, SSCALL, ##__VA_ARGS__);             \
>  		                                                               \
>  		TST_RET;                                                       \
>  	})
> @@ -488,10 +500,13 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   * printed by the pass or fail tst_res() calls. If omitted the first parameter
>   * is converted to a string and used instead.
>   */
> -#define TST_EXP_FAIL(SCALL, EXP_ERR, ...)                                      \
> +#define TST_EXP_FAIL(SCALL, EXP_ERR, ...) \
> +	TST_EXP_FAIL_(SCALL, #SCALL, EXP_ERR, ##__VA_ARGS__)
> +
> +#define TST_EXP_FAIL_(SCALL, SSCALL, EXP_ERR, ...) \
>  	do {                                                                   \
>  		int tst_exp_err__ = EXP_ERR;                                   \
> -		TST_EXP_FAIL_ARR_(SCALL, #SCALL, &tst_exp_err__, 1,            \
> +		TST_EXP_FAIL_ARR_(SCALL, SSCALL, &tst_exp_err__, 1,            \
>                                    ##__VA_ARGS__);                              \
>  	} while (0)
>  
> -- 
> 2.54.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
