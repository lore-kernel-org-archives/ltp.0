Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4A0C4332F
	for <ltp@archiver.kernel.org>; Wed, 13 Dec 2023 19:16:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D1FF3CF528
	for <ltp@archiver.kernel.org>; Wed, 13 Dec 2023 20:16:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E26103CD510
 for <ltp@lists.linux.it>; Wed, 13 Dec 2023 20:16:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0D4CB1A00E55
 for <ltp@lists.linux.it>; Wed, 13 Dec 2023 20:16:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4BF0F1F458;
 Wed, 13 Dec 2023 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702494971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GSs1LtnFNwys6SDx28U2alr6QSRrbD0cSzcsQMULWDg=;
 b=1N97jMknB54wTbYJiBwkO5skxa1OGYbE7C7X2G9AL875wMn94akCuEDaBgBDrOdSNoMsun
 CC4Gg9SZZNqulDEgbkTfLZThi65/16DxduHz1E7Uxt9WK0HqA7P9pRGlTKaxl2fsW/ncu1
 89nC7r8nCwnLD6vIfBrXH4dJNa++Lbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702494971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GSs1LtnFNwys6SDx28U2alr6QSRrbD0cSzcsQMULWDg=;
 b=NvciUvo9DxsIg41vvB1yaRnZ+uGfPwgvc37suB1TDQ4gIbq6badVgen3ZZzGzkj9xEJDh5
 7ifGP+9fkAepymDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702494971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GSs1LtnFNwys6SDx28U2alr6QSRrbD0cSzcsQMULWDg=;
 b=1N97jMknB54wTbYJiBwkO5skxa1OGYbE7C7X2G9AL875wMn94akCuEDaBgBDrOdSNoMsun
 CC4Gg9SZZNqulDEgbkTfLZThi65/16DxduHz1E7Uxt9WK0HqA7P9pRGlTKaxl2fsW/ncu1
 89nC7r8nCwnLD6vIfBrXH4dJNa++Lbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702494971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GSs1LtnFNwys6SDx28U2alr6QSRrbD0cSzcsQMULWDg=;
 b=NvciUvo9DxsIg41vvB1yaRnZ+uGfPwgvc37suB1TDQ4gIbq6badVgen3ZZzGzkj9xEJDh5
 7ifGP+9fkAepymDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27C991377F;
 Wed, 13 Dec 2023 19:16:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gFalBvsCemWOeQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 Dec 2023 19:16:11 +0000
Date: Wed, 13 Dec 2023 20:15:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZXoC6LUE8ePDPRIU@rei>
References: <20231211161807.526714-1-pvorel@suse.cz>
 <20231211161807.526714-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231211161807.526714-3-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.983]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] lib: Add support for TDEBUG tst_res() flag
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index e0896eb05..5125001f7 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -157,6 +157,7 @@ const char *strttype(int ttype)
>  		PAIR(TCONF)
>  		PAIR(TWARN)
>  		PAIR(TINFO)
> +		PAIR(TDEBUG)
>  	};
>  
>  	PAIR_LOOKUP(ttype_pairs, TTYPE_RESULT(ttype));
> @@ -174,8 +175,10 @@ static void tst_res__(const char *file, const int lineno, int ttype,
>  	int len = 0;
>  	int ttype_result = TTYPE_RESULT(ttype);
>  
> -	if (file && (ttype_result != TPASS && ttype_result != TINFO))
> +	if (file && (ttype_result != TPASS && ttype_result != TINFO &&
> +		     ttype_result != TDEBUG))
>  		len = sprintf(tmesg, "%s:%d: ", file, lineno);
> +
>  	EXPAND_VAR_ARGS(tmesg + len, arg_fmt, USERMESG - len);
>  
>  	/*
> @@ -193,7 +196,7 @@ static void tst_res__(const char *file, const int lineno, int ttype,
>  	 * Set the test case number and print the results, depending on the
>  	 * display type.
>  	 */
> -	if (ttype_result == TWARN || ttype_result == TINFO) {
> +	if (ttype_result == TWARN || ttype_result == TINFO || ttype_result == TDEBUG) {
>  		tst_print(TCID, 0, ttype, tmesg);
>  	} else {
>  		if (tst_count < 0)
> @@ -411,7 +414,7 @@ void tst_exit(void)
>  
>  	tst_old_flush();
>  
> -	T_exitval &= ~TINFO;
> +	T_exitval &= ~(TINFO | TDEBUG);
>  
>  	if (T_exitval == TCONF && passed_cnt)
>  		T_exitval &= ~TCONF;

I woudln't add it to the old library. None of the old tests uses it so
there is no reason to export it there.

I suppose that we just abort if we get this flag in old library:

diff --git a/lib/tst_res.c b/lib/tst_res.c
index e0896eb05..e87918ed1 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -174,6 +174,11 @@ static void tst_res__(const char *file, const int lineno, int ttype,
        int len = 0;
        int ttype_result = TTYPE_RESULT(ttype);

+       if (ttype_result == TDEBUG) {
+               printf("%s: %i: TDEBUG is not supported\n", __func__, __LINE__);
+               abort();
+       }
+

What do you think?

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index c2f8f503f..f5c87ed9e 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -60,6 +60,7 @@ static pid_t main_pid, lib_pid;
>  static int mntpoint_mounted;
>  static int ovl_mounted;
>  static struct timespec tst_start_time; /* valid only for test pid */
> +static int tdebug;
>  
>  struct results {
>  	int passed;
> @@ -224,6 +225,9 @@ static void print_result(const char *file, const int lineno, int ttype,
>  	case TINFO:
>  		res = "TINFO";
>  	break;
> +	case TDEBUG:
> +		res = "TDEBUG";
> +	break;
>  	default:
>  		tst_brk(TBROK, "Invalid ttype value %i", ttype);
>  		abort();
> @@ -352,6 +356,9 @@ void tst_res_(const char *file, const int lineno, int ttype,
>  {
>  	va_list va;
>  
> +	if (ttype == TDEBUG && !tdebug)
> +		return;
> +
>  	va_start(va, fmt);
>  	tst_vres_(file, lineno, ttype, fmt, va);
>  	va_end(va);
> @@ -511,6 +518,7 @@ static struct option {
>  	{"h",  "-h       Prints this help"},
>  	{"i:", "-i n     Execute test n times"},
>  	{"I:", "-I x     Execute test for n seconds"},
> +	{"v",  "-v       Prints debug information"},

Maybe thi should now be called -d since we call it TDEBUG and that will
avoid having a bit confusing parameters with both -v and -V used.

>  	{"V",  "-V       Prints LTP version"},
>  	{"C:", "-C ARG   Run child process with ARG arguments (used internally)"},
>  };
> @@ -692,6 +700,10 @@ static void parse_opts(int argc, char *argv[])
>  			else
>  				duration = SAFE_STRTOF(optarg, 0.1, HUGE_VALF);
>  		break;
> +		case 'v':
> +			tdebug = 1;
> +			tst_res(TINFO, "Run with -v, printing debug info");
                                           ^
					   Maybe just "Enabling debug info"
> +		break;
>  		case 'V':
>  			fprintf(stderr, "LTP version: " LTP_VERSION "\n");
>  			exit(0);
> -- 
> 2.43.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
