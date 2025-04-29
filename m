Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3A6C369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 21:23:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFC0B3CBC38
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 23:23:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7455B3C5446
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 23:22:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CC569200746
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 23:22:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5617121171;
 Tue, 29 Apr 2025 21:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745961775;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6SfsY8f4qg2IbeLryge2s+GhFAB390eAF1C4/qF5Po=;
 b=CG1Dk/8d9VF1VE60/imqdo1ZGFfR+lYlFxR+E/AyxIabvkQS4+QC/zw7a/Um+HRElVPZly
 aOfD2/iBcvgZsPiowXu8SSelNS9LFKmq01VuVhLEKQO+PnHErvOKO+5VIR0OG9pv6d+TyR
 6w2DIxMYyCIVcHds1EkmOGU5NuHuGMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745961775;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6SfsY8f4qg2IbeLryge2s+GhFAB390eAF1C4/qF5Po=;
 b=cGZGe4e3alIpvlLYwaaeQ3P1Ohvw0AUQk8M+aDx8JlEmsyQtr1USZwPr89hQTfHf1Q22RJ
 SY4YU68dextqv3CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745961775;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6SfsY8f4qg2IbeLryge2s+GhFAB390eAF1C4/qF5Po=;
 b=CG1Dk/8d9VF1VE60/imqdo1ZGFfR+lYlFxR+E/AyxIabvkQS4+QC/zw7a/Um+HRElVPZly
 aOfD2/iBcvgZsPiowXu8SSelNS9LFKmq01VuVhLEKQO+PnHErvOKO+5VIR0OG9pv6d+TyR
 6w2DIxMYyCIVcHds1EkmOGU5NuHuGMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745961775;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6SfsY8f4qg2IbeLryge2s+GhFAB390eAF1C4/qF5Po=;
 b=cGZGe4e3alIpvlLYwaaeQ3P1Ohvw0AUQk8M+aDx8JlEmsyQtr1USZwPr89hQTfHf1Q22RJ
 SY4YU68dextqv3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20C141340C;
 Tue, 29 Apr 2025 21:22:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4sQnBS9DEWioZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Apr 2025 21:22:55 +0000
Date: Tue, 29 Apr 2025 23:22:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250429212253.GA273859@pevik>
References: <20250429135542.19680-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250429135542.19680-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: do_setup(): Check for supported arch first
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

Hi Cyril,

> This commit moves the check for supported architecture before the check
> for test function existence. This allows us do ifdef out the run
> function pointer initialization and properly TCONF on unsupported
> platform.

LGTM. Ideally could you also convert some test (as example which others
can follow - like they do for docparse fixes).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Example usage:

>  #include "tst_test.h"

>  #ifdef __x86_64__
I would personally did not bother with #ifdef, but it's true it makes resulted
binary smaller (for non-intel arch).

Kind regards,
Petr

>  static void run(void)
>  {
> 	...
>  }
>  #endif

>  struct tst_test test = {
>  #ifdef __x86_64__

> 	.run = run,
>  #endif
> 	.supported_archs = {"x86_64", NULL},
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
