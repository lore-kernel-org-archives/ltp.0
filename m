Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3805C54E64
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 11:57:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E0E63C207F
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 12:57:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7DDF3C1C18
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 12:57:28 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10824200045
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 12:57:27 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 454382085B;
 Thu, 28 Mar 2024 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711627046;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/RJrgGeJwpsgWlY5qT0/p+vfRNIHSuqys9OpqMCiTA=;
 b=IhcyOu+Juy3fPczJVDrDJQKudL6SAUDPPH8U4QS42ssKRSp3zLTiFpj7i8ZDBuFWbulNKL
 1hmLTTS3jqWZ12ly1s9/VTHQ8dRBqJvhdfGL5NzEKG8Kj/HeoOjjX+x16SK9gXrIv9GABm
 1V0wlXsgeZgDyhkmYlBrbevNKFG9LRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711627046;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/RJrgGeJwpsgWlY5qT0/p+vfRNIHSuqys9OpqMCiTA=;
 b=6EeEFbCtpadLvQDn74LNH1D6Ob8+HjSfV6Hp4oqKUmk00b1s07i6Ci9zSnr9eX97S33YK4
 iSJ981ScoJAqiLBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711627046;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/RJrgGeJwpsgWlY5qT0/p+vfRNIHSuqys9OpqMCiTA=;
 b=IhcyOu+Juy3fPczJVDrDJQKudL6SAUDPPH8U4QS42ssKRSp3zLTiFpj7i8ZDBuFWbulNKL
 1hmLTTS3jqWZ12ly1s9/VTHQ8dRBqJvhdfGL5NzEKG8Kj/HeoOjjX+x16SK9gXrIv9GABm
 1V0wlXsgeZgDyhkmYlBrbevNKFG9LRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711627046;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/RJrgGeJwpsgWlY5qT0/p+vfRNIHSuqys9OpqMCiTA=;
 b=6EeEFbCtpadLvQDn74LNH1D6Ob8+HjSfV6Hp4oqKUmk00b1s07i6Ci9zSnr9eX97S33YK4
 iSJ981ScoJAqiLBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 132BA13AF7;
 Thu, 28 Mar 2024 11:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id t97pASZbBWZ6IQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 28 Mar 2024 11:57:26 +0000
Date: Thu, 28 Mar 2024 12:57:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
Message-ID: <20240328115720.GD51940@pevik>
References: <20240208013224.859-1-wegao@suse.com>
 <20240327034923.30987-1-wegao@suse.com>
 <20240327034923.30987-2-wegao@suse.com>
 <20240328114932.GC51940@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240328114932.GC51940@pevik>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[46.37%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,
> Hi Wei,

...
> #define TEST_MACRO(macro, macro_arr, fail_fn, pass_fn, inval_fn) \
> 	do {                                                                   \
> 		tst_res(TINFO, "Testing macro macro"); \
> 		macro(fail_fn(), EINVAL, "fail_fn()"); \
> 		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
> 		macro(fail_fn(), ENOTTY, "fail_fn()"); \
> 		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
> 		macro(pass_fn(), ENOTTY, "pass_fn()"); \
> 		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
> 		macro(inval_fn(), ENOTTY, "inval_fn()"); \
> 		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
> 		macro_arr(fail_fn(), exp_errs_pass, "fail_fn()"); \
> 		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
> 		macro_arr(fail_fn(), exp_errs_fail, "fail_fn()"); \
> 		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
> 	} while (0)

Actually this (print real function with #macro and #macro_arr,
2x skip message parameter (to test also macro without error parameter):

#define TEST_MACRO(macro, macro_arr, fail_fn, pass_fn, inval_fn) \
	do {                                                                   \
		tst_res(TINFO, "Testing " #macro " macro"); \
		macro(fail_fn(), EINVAL, #fail_fn"()"); \
		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
		macro(fail_fn(), ENOTTY); /* skip msg parameter */ \
		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
		macro(pass_fn(), ENOTTY, #pass_fn"()"); \
		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
		macro(inval_fn(), ENOTTY, #inval_fn"()"); \
		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
		macro_arr(fail_fn(), exp_errs_pass, #fail_fn"()"); \
		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
		macro_arr(fail_fn(), exp_errs_fail); /* skip msg parameter */ \
		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
	} while (0)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
