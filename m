Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840ACC44506
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 09:31:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BE113E5BC6
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 11:31:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 599AF3E28B4
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 11:31:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C5B6514000E8
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 11:31:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE81D7640C;
 Fri, 10 Jul 2026 09:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783675868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CoGYgA9qOcAxqqqcsFRYy7rirOTdbloShsQH+MXQ+uI=;
 b=RizJlCTc0wk8BtSD17FpYiIph3Sy09HTosG6e+AYA2tiGB3QYFWrmW7Oyp1HCk/V0bgV3H
 BhIBkOizg4REz12+fpk/dhWmzmjzJ3ugfzBkbHOiglgjX4ZFd8lfjzHZI6X9swncQYydf4
 0Iu6klING43kQsKebyF51ry39gN+Phs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783675868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CoGYgA9qOcAxqqqcsFRYy7rirOTdbloShsQH+MXQ+uI=;
 b=/WEbVfFzLOiSIRNWZeFrnwq/55lihnLRv7n22jxHU3MPbpI94S4YVgGbRJOISDP9orD+5R
 aGpDnwRWW4bX0FAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PbBELvV4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=t5Z7ULZf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783675867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CoGYgA9qOcAxqqqcsFRYy7rirOTdbloShsQH+MXQ+uI=;
 b=PbBELvV4lhZCVyxUOGGntA4xl2iAoMf8bYbzcyQmy1YYAtlLD7nvbeVc2f45EbdqnbU5D7
 L8mEOTQv0E+PLki1rPFp6P/fvcyqsr3H4tdw83p3dSfYKdPxjXZ2qAQ4ZpkVf9Is9d+0re
 j09RNP/g+y3wGyiAb+e7AbBZG9yDO5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783675867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CoGYgA9qOcAxqqqcsFRYy7rirOTdbloShsQH+MXQ+uI=;
 b=t5Z7ULZfV/eG4tk5y8skXgj9LtjA7jxELBuC54oUXTnx5QwmFoKRGE0hkxl9uby9YYn6DZ
 OmiRi1c40IVlaNCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D972779BD;
 Fri, 10 Jul 2026 09:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 18t7Jdu7UGq/HwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 Jul 2026 09:31:07 +0000
Date: Fri, 10 Jul 2026 11:30:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <alC7rUcJTSvI3r61@rei>
References: <20260710083337.1185184-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260710083337.1185184-1-pvorel@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AE81D7640C
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] test_macros: Add TST_EXP_PASS_OR_FAIL()
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
>  include/tst_test_macros.h | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index f06c8aeb77..e980cc6022 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -168,7 +168,7 @@ extern int TST_PASS;
>   * @ERRNO: Expected errno or 0.
>   * @...: A printf-like parameters.
>   *
> - * Expect a file descriptor if errno is 0 otherwise expect a failure with
> + * Expect a file descriptor if ERRNO is 0 otherwise expect a failure with
>   * expected errno.
>   *
>   * Internally it uses TST_EXP_FAIL() and TST_EXP_FD().
> @@ -354,6 +354,29 @@ extern int TST_PASS;
>  			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
>  	} while (0)
>  
> +/**
> + * TST_EXP_PASS_OR_FAIL() - Test syscall to and expect to pass or fail with
> + * expected errno.
> + *
> + * @SCALL: Tested syscall.
> + * @ERRNO: Expected errno or 0.
> + * @...: A printf-like parameters.
> + *
> + * Expect to pass if ERRNO is 0 otherwise expect a failure with
> + * expected errno.
> + *
> + * Internally it uses TST_EXP_FAIL() and TST_EXP_PASS().
> + */
> +#define TST_EXP_PASS_OR_FAIL(SCALL, ERRNO, ...)                                \
> +	({                                                                     \
> +		if (ERRNO)                                                     \
> +			TST_EXP_FAIL(SCALL, ERRNO, ##__VA_ARGS__);             \
> +		else                                                           \
> +			TST_EXP_PASS(SCALL, ##__VA_ARGS__);                      \
> +		                                                               \
> +		TST_RET;                                                       \
> +	})

I do not think that this is working as expected. If I remmeber correctly
we have to stringify the SCALL in the first macro is passed into
otherwise it may get expanded and produce unexpected results.

E.g. if we pass something with macro constants such as open() with
O_RDONLY the O_RDONLY will be replaced with 0. This is the reason why
the rest of the macros pass #SCALL to any macros it uses.

We need to change the TST_EXP_FAIL() and TST_EXP_PASS() so that they
have underscore variant first, e.g.:

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index f06c8aeb7..d391bdb9e 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -488,10 +488,13 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  * printed by the pass or fail tst_res() calls. If omitted the first parameter
  * is converted to a string and used instead.
  */
-#define TST_EXP_FAIL(SCALL, EXP_ERR, ...)                                      \
+#define TST_EXP_FAIL(SCAL, EXP_ERR, ...) \
+       TST_EXP_FAIL_(SCAL, #SCAL, ##__VA_ARGS__)
+
+#define TST_EXP_FAIL_(SCALL, SSCAL, EXP_ERR, ...)                                      \
        do {                                                                   \
                int tst_exp_err__ = EXP_ERR;                                   \
-               TST_EXP_FAIL_ARR_(SCALL, #SCALL, &tst_exp_err__, 1,            \
+               TST_EXP_FAIL_ARR_(SCALL, SSCALL, &tst_exp_err__, 1,            \
                                   ##__VA_ARGS__);                              \
        } while (0)


Then we can build the _OR_FAIL() macros on the top of that. And the
TST_EXP_FD_OR_FAIL() should be fixed too.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
