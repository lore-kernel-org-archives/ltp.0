Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38232ECE564
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 08:42:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2207D3C1A24
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 10:42:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E08E3C19E4
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 10:42:28 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8A9C0200078
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 10:42:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4CB41FCE4;
 Tue, 10 Sep 2024 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725957744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P5+u9zfmoImaQweUAuS5EZ1mu/FO5L0Q3uzFWwEeaug=;
 b=j3ivJXiD9W5N6cX10fIrVfjWquU3eXv7ay+LBWeAYAO6N69BBdatrtzbZuXRg4+NPDPrKX
 SK9wwqb9+FkwvHd3Hj0Y12ZluV3lX78JnIySck//5qcSNQX9FeIu72oFzVY3p6jV4CKT1y
 zxjsVyLULHnS0Rl10HCHvIVheYGjBPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725957744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P5+u9zfmoImaQweUAuS5EZ1mu/FO5L0Q3uzFWwEeaug=;
 b=odo1zV+xVzLhicmDGqLdJWSenT/vdPDrZ3AU5qePKlvqdBM6tgpcHNHVAW4Q9ragREv8Cb
 C18cjoGtc7Hn9DBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725957744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P5+u9zfmoImaQweUAuS5EZ1mu/FO5L0Q3uzFWwEeaug=;
 b=j3ivJXiD9W5N6cX10fIrVfjWquU3eXv7ay+LBWeAYAO6N69BBdatrtzbZuXRg4+NPDPrKX
 SK9wwqb9+FkwvHd3Hj0Y12ZluV3lX78JnIySck//5qcSNQX9FeIu72oFzVY3p6jV4CKT1y
 zxjsVyLULHnS0Rl10HCHvIVheYGjBPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725957744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P5+u9zfmoImaQweUAuS5EZ1mu/FO5L0Q3uzFWwEeaug=;
 b=odo1zV+xVzLhicmDGqLdJWSenT/vdPDrZ3AU5qePKlvqdBM6tgpcHNHVAW4Q9ragREv8Cb
 C18cjoGtc7Hn9DBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90C09132CB;
 Tue, 10 Sep 2024 08:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YGojInAG4GYDPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 10 Sep 2024 08:42:24 +0000
Date: Tue, 10 Sep 2024 10:41:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZuAGHuH9araamSrF@yuki.lan>
References: <20240909-regen_shutup_lsp-v1-1-d65ad07b822f@suse.com>
 <Zt8C3wF_zgpBtrxC@yuki.lan>
 <126dde73-c309-4fa2-80dd-d3ae4373a23d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <126dde73-c309-4fa2-80dd-d3ae4373a23d@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:email]
Subject: Re: [LTP] [PATCH] Remove cleanup.c inclusion from syscalls
 generation
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
> > Can we remove the cleanup.c as well? It does not seem to be used
> > anywhere after this change.
> Do we want to touch old library? I actually don't mind since we are 
> going to remove everything there anyway, one day.

I would remove any parts that are not used anymore. That way it's more
clear how much old API mess we have to clean up.

> >>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
> >> index 97027e2f3..0dd3269bb 100755
> >> --- a/include/lapi/syscalls/regen.sh
> >> +++ b/include/lapi/syscalls/regen.sh
> >> @@ -33,7 +33,6 @@ cat << EOF > "${output_pid}"
> >>   #include <errno.h>
> >>   #include <sys/syscall.h>
> >>   #include <asm/unistd.h>
> >> -#include "cleanup.c"
> >>   
> >>   #ifdef TST_TEST_H__
> >>   #define TST_SYSCALL_BRK__(NR, SNR) ({ \\
> >> @@ -41,8 +40,11 @@ cat << EOF > "${output_pid}"
> >>   		"syscall(%d) " SNR " not supported on your arch", NR); \\
> >>   })
> >>   #else
> >> +static void dummy_cleanup(void) __attribute__ ((unused));
> > I do not think that we need this part, the function is always used
> > because it's passed to the tst_brkm().
> I actually had some warnings and that is needed unfortunately.

Hmm, that is strange, the function is passed to the tst_brkm(). Maybe
the compiler is smart enough to figure out that it's not used when the
header is included and the tst_syscall() is not used.

The standard way how to define functions in header is 'static inline' so
maybe drop this line and add inline to the function definition instead?

> >> +static void dummy_cleanup(void) {}
> >> +
> >>   #define TST_SYSCALL_BRK__(NR, SNR) ({ \\
> >> -	tst_brkm(TCONF, CLEANUP, \\
> >> +	tst_brkm(TCONF, dummy_cleanup, \\
> >>   		"syscall(%d) " SNR " not supported on your arch", NR); \\
> >>   })
> >>   #endif
> >>
> >> ---
> >> base-commit: d3f1f93eda69905932bde4f66b44d72f9211909a
> >> change-id: 20240909-regen_shutup_lsp-a35606a887b6
> >>
> >> Best regards,
> >> -- 
> >> Andrea Cervesato <andrea.cervesato@suse.com>
> >>
> >>
> >> -- 
> >> Mailing list info: https://lists.linux.it/listinfo/ltp
> Andrea

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
