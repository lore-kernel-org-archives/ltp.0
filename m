Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30909C25B6B
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 11:41:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 285603CEC14
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 13:41:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98F3C3C8202
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 13:40:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 14F74200C39
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 13:40:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 817641F86B;
 Thu, 26 Oct 2023 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698320454;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJCCFWYPz/58GhyZL8EcYBmr8+cHqnbTGPUFpgf/GA0=;
 b=l1ZDH+ol1l8bOAI0p0WO4F9DsrkI55Ppp7nks35Zyo0VD1ZEWPukZynL6foImbt3msXo4y
 bFGVPoOQrjAfm1GHB3FBUbxklB0DJyro15XRGMFThXq9WuWIo7KDuvCGkrzxTT1xHyG/g6
 gm0arm8xV39LatSdKw+GAI+zYYdMAdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698320454;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJCCFWYPz/58GhyZL8EcYBmr8+cHqnbTGPUFpgf/GA0=;
 b=OcuebJLMTkGOyAPBmQpT6q16FfRsa2B9693WWAetgsVGyiV5/pkXaeLk6sjk/zVJEpawn+
 ADQPF4PHh4gjH+AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BF80133F5;
 Thu, 26 Oct 2023 11:40:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3BHYBEZQOmVjeQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Oct 2023 11:40:54 +0000
Date: Thu, 26 Oct 2023 13:40:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231026114052.GA597564@pevik>
References: <20230930000516.4063681-1-edliaw@google.com>
 <20230930065443.GC414289@pevik> <ZTpJUetaZJyPyDu5@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZTpJUetaZJyPyDu5@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-10.03 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.73)[98.82%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getpgid01: On Android, pgid(1) is 0 instead of 1
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

...
> > #ifndef __ANDROID__ 
> > 		TST_EXP_EQ_LI(TST_RET, 0);
> > #else
> > 		TST_EXP_EQ_LI(TST_RET, 1);
> > #endif

> > Because your code would loosen testing for other libc.
> > Cyril, Li, WDYT?

> @Peter what about the case where we bypass all init and boot with
> init=/bin/sh or init=ltx? I suppose that we will have pgrp set to 0
> as well.

Ah, so v1 version was better, right?

> What about parsing /proc/1/stat and checking that the value there is the
> same as reported here, that should work regardless of what pid is the
> init.

That sounds best to me. I'm sorry Edward, could you please send v3?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
