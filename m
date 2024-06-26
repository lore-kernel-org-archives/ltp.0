Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDABC27C4F
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 11:54:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CD963D115E
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 13:54:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D22F3C1037
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 13:53:49 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C4782201DAA
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 13:53:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B5C5321AD0;
 Wed, 26 Jun 2024 11:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719402827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gA9DHKV2krdoTX4nljEESJX4Q430PZbADfSP19NTfh8=;
 b=VSxade9TOSpTU+Y40zwF+4+CtHhiDeWkD8T27r04d7AGs37escR/E40Tcw7l9WCrigPkHb
 8WX8A3/bYq7Y3ZV8mj5Q6A5IrgGF3AJMIq6q4YcIrazPPzw/eUYTUm0xyLL+EjB0f88Em6
 m2citmBbC3t0xD85PeQ/dAbt4Rk7eAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719402827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gA9DHKV2krdoTX4nljEESJX4Q430PZbADfSP19NTfh8=;
 b=BRWuv5Xjq0rYOLMuDpiL+/0dyipKnhkqRuZLQBwrAqc2lrbtYJtWalt3cXO0nqD7ggJs2h
 WPrISTBM9s0denAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719402826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gA9DHKV2krdoTX4nljEESJX4Q430PZbADfSP19NTfh8=;
 b=PfvVu5VdR9eqtJ4QRSB2+2nhtsGD4O4eSZAHhVSZlYcN6C2wzmpOWZCCSu18Pm45bN8ylH
 I6j9aCk3jWp38eM6DnAwBy+HzkuP6FLLeMBICy60keVcln9ccThchOUq3SFpke6tE3gHQ/
 vZUpIxVhVj7Z5k234fGF2+ymOcJVZjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719402826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gA9DHKV2krdoTX4nljEESJX4Q430PZbADfSP19NTfh8=;
 b=dJ8NpDYCX9IwrsKQvPbEXkl9fPe0DCUjpJMEX5CeeWRxyLdv1ULrZV6fqe6UnwdIJgWYXY
 3rhm2bLKs13zAqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A600B13AAD;
 Wed, 26 Jun 2024 11:53:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2I1+J0oBfGbvIQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 26 Jun 2024 11:53:46 +0000
Date: Wed, 26 Jun 2024 13:53:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZnwBQRs6bLYkqoYx@yuki>
References: <20240626105431.746411-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240626105431.746411-1-liwang@redhat.com>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] lib: add TST_RES_ serious macros
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
> This patch introduces new macros to encapsulate existing tst_res and
> tst_brk functions in the LTP library. These macros simplify the usage
> of tst_ functions by providing a more user-friendly interface for
> generating standardized test output.
> 
>   TST_RES_TINFO()    -> tst_res(TINFO, ...)
>   TST_RES_TWARN()    -> tst_res(TINFO, "WARNING: ", ...)
>   TST_RES_TPASS()    -> tst_res(TPASS, ...)
>   TST_RES_TDEBUG()   -> tst_res(TDEBUG, ...)
>   TST_RES_TFAIL()    -> tst_res(TFAIL,  ...)
> 
>   TST_BRK_TCONF()    -> tst_brk(TCONF, ...)
>   TST_BRK_TBROK()    -> tst_brk(TBROK,  ...)
> 
>   TST_RES_TPASS_ER() -> tst_res(TPASS | errno, ...)
>   TST_RES_TFAIL_ER() -> tst_res(TFAIL | errno, ...)
>   TST_BRK_TBROK_ER() -> tst_brk(TBROK | errno, ... )
> 
> The macros handle various scenarios including simple messages and messages
> with error flags, ensuring consistent logging of file and line information.
> 
> Additionally, a new test case in tst_res_macros.c demonstrates the usage
> of these macros.

I actually like the function better. It makes sense to add macros when
they do something more complicated e.g. the TST_EXP_ macros save a lot
of code, but in this case I do not think that they add any value, the
change is only cosmetic.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
