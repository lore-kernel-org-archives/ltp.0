Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21220E77173
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 10:36:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 880563E6BC7
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 11:36:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8421C3E69E4
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 11:36:39 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6F6342127E7
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 11:36:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3E3521190;
 Fri,  6 Dec 2024 10:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733481396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s71inocfX8DXN3NZ3bLs9T8zWPxYaR6Ga4/UqOrDWOA=;
 b=GE+SFA2NPmb206JEu66YAwBeKIbOwULGyG3Yr/ahBP/cV17uZSbIB0BxML/xwp64pq+/I1
 O95f857pcwClG5OpxARQtQgszV2ou8Ds2ZEDtxv5mp60ulqr1aPqxQIGEN9BsbmQFR04L4
 Ad72fvZaAftSAgzJEjjc46zlblgg53I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733481396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s71inocfX8DXN3NZ3bLs9T8zWPxYaR6Ga4/UqOrDWOA=;
 b=dXWqeOmDLNM1t0U7Ent14WMotEAs0MJieEoWxUa/P2HCvimb1ZE/04HEg41vpU0YWqiu5R
 N8ueiz4lKwTpeNDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733481396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s71inocfX8DXN3NZ3bLs9T8zWPxYaR6Ga4/UqOrDWOA=;
 b=GE+SFA2NPmb206JEu66YAwBeKIbOwULGyG3Yr/ahBP/cV17uZSbIB0BxML/xwp64pq+/I1
 O95f857pcwClG5OpxARQtQgszV2ou8Ds2ZEDtxv5mp60ulqr1aPqxQIGEN9BsbmQFR04L4
 Ad72fvZaAftSAgzJEjjc46zlblgg53I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733481396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s71inocfX8DXN3NZ3bLs9T8zWPxYaR6Ga4/UqOrDWOA=;
 b=dXWqeOmDLNM1t0U7Ent14WMotEAs0MJieEoWxUa/P2HCvimb1ZE/04HEg41vpU0YWqiu5R
 N8ueiz4lKwTpeNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FBB4138A7;
 Fri,  6 Dec 2024 10:36:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fLQVIrTTUmfUIQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 06 Dec 2024 10:36:36 +0000
Date: Fri, 6 Dec 2024 11:36:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Z1LTvZEBUvK744Ye@yuki.lan>
References: <e1dc1e7f686bfed84f048294b3f3608e2f3e9491.1733321853.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1dc1e7f686bfed84f048294b3f3608e2f3e9491.1733321853.git.jstancek@redhat.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/getrandom05: use tst_syscall
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> With glibc-2.40 and recent kernel (6.12) the test uses
> vdso implementation which runs into SIGSEGV for EFAULT test:
> 
>   #0  __arch_chacha20_blocks_nostack () at arch/x86/entry/vdso/vgetrandom-chacha.S:146
>   146             movups          state0,0x00(output)
> 
>   (gdb) bt
>   #0  __arch_chacha20_blocks_nostack () at arch/x86/entry/vdso/vgetrandom-chacha.S:146
>   #1  0x00007fcd3ce6417a in __cvdso_getrandom_data (rng_info=0x7fcd3ce5f280, buffer=0xffffffffffffffff, len=64, flags=1, opaque_state=0x7fcd3ce5df00,
>       opaque_len=<optimized out>) at arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:237
>   #2  __cvdso_getrandom (buffer=<optimized out>, len=64, flags=1, opaque_state=0x7fcd3ce5df00, opaque_len=<optimized out>)
>       at arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:259
>   #3  __vdso_getrandom (buffer=0xffffffffffffffff, len=64, flags=1, opaque_state=0x7fcd3ce5df00, opaque_len=<optimized out>)
>       at arch/x86/entry/vdso/vgetrandom.c:11
>   #4  0x00007fcd3cc7faf3 in getrandom_vdso (buffer=0xffffffffffffffff, length=64, flags=0, cancel=<optimized out>)
>       at ../sysdeps/unix/sysv/linux/getrandom.c:204
>   #5  0x0000000000401ff7 in verify_getrandom (i=0) at getrandom05.c:40
> 
> Change the test to use syscall implementation of getrandom().
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/getrandom/getrandom05.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/getrandom/getrandom05.c b/testcases/kernel/syscalls/getrandom/getrandom05.c
> index 92098deb723d..8f7ce45785c5 100644
> --- a/testcases/kernel/syscalls/getrandom/getrandom05.c
> +++ b/testcases/kernel/syscalls/getrandom/getrandom05.c
> @@ -16,6 +16,7 @@
>  
>  #include "tst_test.h"
>  #include "lapi/getrandom.h"
> +#include "lapi/syscalls.h"
>  
>  static char buff_efault[64];
>  static char buff_einval[64];
> @@ -36,7 +37,7 @@ static void verify_getrandom(unsigned int i)
>  {
>  	struct test_case_t *tc = &tcases[i];
>  
> -	TST_EXP_FAIL2(getrandom(tc->buff, tc->size, tc->flag),
> +	TST_EXP_FAIL2(tst_syscall(__NR_getrandom, tc->buff, tc->size, tc->flag),
>  		tc->expected_errno, "%s", tc->desc);

This means that we will not cover the EINVAL error for VDSO anymore.

Also the rest of the tests seems to use syscall only, which means that
we will not test the VDSO that is going to be used by default. I suppose
that we should add test variants to these testcases and run them both
for libc getrandom() and the syscall and just skip the EFAULT here on
glibc.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
