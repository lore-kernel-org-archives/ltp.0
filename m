Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88E0C021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 10:17:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 523463C8E3E
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 11:17:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC7513C0134
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:17:11 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0DCCE231D32
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:17:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 592241F45B;
 Fri, 21 Feb 2025 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740133029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzsQxgJhnO22lCMSUMyFaOr/LuOUPe3MNQ1FpfKkkko=;
 b=cNpI9U2Xk+witLnCcWYD3ONoQC/3qzSgOoSt9Uvzk0UwWy7XEk0Jz30F5oecBctTUm1XGT
 mLDTdKenonmPsLFKx81DgsywpLAmSxp2OMwMfNRfKD/ekwtmReQcWhgcpXA5I40XUX6SSs
 3KurnrN4Qx1oydoVY90ZcijaX/uAtDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740133029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzsQxgJhnO22lCMSUMyFaOr/LuOUPe3MNQ1FpfKkkko=;
 b=arssngCHIZaq2pH7S9vnrShrOMtXaxsP9Iv7MWEHUBUjC0wS6oBlbr+H80zw93ztOVBL4H
 qmagu+5K1HnzbzCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cNpI9U2X;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=arssngCH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740133029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzsQxgJhnO22lCMSUMyFaOr/LuOUPe3MNQ1FpfKkkko=;
 b=cNpI9U2Xk+witLnCcWYD3ONoQC/3qzSgOoSt9Uvzk0UwWy7XEk0Jz30F5oecBctTUm1XGT
 mLDTdKenonmPsLFKx81DgsywpLAmSxp2OMwMfNRfKD/ekwtmReQcWhgcpXA5I40XUX6SSs
 3KurnrN4Qx1oydoVY90ZcijaX/uAtDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740133029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzsQxgJhnO22lCMSUMyFaOr/LuOUPe3MNQ1FpfKkkko=;
 b=arssngCHIZaq2pH7S9vnrShrOMtXaxsP9Iv7MWEHUBUjC0wS6oBlbr+H80zw93ztOVBL4H
 qmagu+5K1HnzbzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ADF3136AD;
 Fri, 21 Feb 2025 10:17:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VOlREaVSuGdhNgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 21 Feb 2025 10:17:09 +0000
Date: Fri, 21 Feb 2025 11:17:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <ricardo@marliere.net>
Message-ID: <Z7hSqqK4PjZMEqPU@yuki.lan>
References: <20250218-conversions-pause-v2-0-8c72960fe1ec@suse.com>
 <20250218-conversions-pause-v2-1-8c72960fe1ec@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250218-conversions-pause-v2-1-8c72960fe1ec@suse.com>
X-Rspamd-Queue-Id: 592241F45B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] syscalls/pause01: Clean up
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
Cc: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Ricardo B. Marli=E8re <rbm@suse.com>
> ---
>  testcases/kernel/syscalls/pause/pause01.c | 34 +++++++++++++------------=
------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> =

> diff --git a/testcases/kernel/syscalls/pause/pause01.c b/testcases/kernel=
/syscalls/pause/pause01.c
> index c88248da0d9961c5414a694a91cf1aef40ff263a..adce0ddcf2e0639407b4e21de=
0a1be7b30efaa01 100644
> --- a/testcases/kernel/syscalls/pause/pause01.c
> +++ b/testcases/kernel/syscalls/pause/pause01.c
> @@ -1,10 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2016 Linux Test Project
> + * Copyright (c) 2025 Ricardo B. Marli=E8re <rbm@suse.com>
>   */
> -#include <errno.h>
> -#include <signal.h>
> -#include <stdlib.h>
> +
> +/*\
> + * Verify that, pause() returns -1 and sets errno to EINTR after receipt=
 of a
> + * signal which is caught by the calling process.
> + */
> +
>  #include "tst_test.h"
>  =

>  static void sig_handler(int sig LTP_ATTRIBUTE_UNUSED)
> @@ -14,32 +18,22 @@ static void sig_handler(int sig LTP_ATTRIBUTE_UNUSED)
>  static void do_child(void)
>  {
>  	SAFE_SIGNAL(SIGINT, sig_handler);
> -
> +	TST_EXP_FAIL(pause(), EINTR);
>  	TST_CHECKPOINT_WAKE(0);
> -
> -	TEST(pause());
> -	if (TST_RET !=3D -1)
> -		tst_res(TFAIL, "pause() succeeded unexpectedly");
> -	else if (TST_ERR =3D=3D EINTR)
> -		tst_res(TPASS, "pause() interrupted with EINTR");
> -	else
> -		tst_res(TFAIL | TTERRNO, "pause() unexpected errno");
> -
> -	TST_CHECKPOINT_WAKE(0);
> -	exit(0);

This reorders how things are called which is wrong. The checkpoint wake
call before the pause() is there for a reason. The process may sleep in
kernel for any other reason not related to the test, so we need to
ensure that we are just about to call the pause() syscall before we wait
for the process state to change in the run() function.

If anything should be removed it's the second pair of checkpoints after
the pause() because the new test library has build-in timeout and there
is no reason to depend on checkpoint timeouts at the end of the test.

And there is no reason to wait() the child in the new test library
either. So (on the top of your patch) we can do:

diff --git a/testcases/kernel/syscalls/pause/pause01.c b/testcases/kernel/s=
yscalls/pause/pause01.c
index adce0ddcf..680fa2c05 100644
--- a/testcases/kernel/syscalls/pause/pause01.c
+++ b/testcases/kernel/syscalls/pause/pause01.c
@@ -18,8 +18,8 @@ static void sig_handler(int sig LTP_ATTRIBUTE_UNUSED)
 static void do_child(void)
 {
        SAFE_SIGNAL(SIGINT, sig_handler);
-       TST_EXP_FAIL(pause(), EINTR);
        TST_CHECKPOINT_WAKE(0);
+       TST_EXP_FAIL(pause(), EINTR);
 }

 static void run(void)
@@ -32,15 +32,9 @@ static void run(void)
                exit(0);
        }

+       TST_CHECKPOINT_WAIT(0);
        TST_PROCESS_STATE_WAIT(pid, 'S', 0);
        SAFE_KILL(pid, SIGINT);
-
-       /*
-        * TST_CHECKPOINT_WAIT has built-in timeout, if pause() doesn't ret=
urn,
-        * this checkpoint call will reliably end the test.
-        */
-       TST_CHECKPOINT_WAIT(0);
-       SAFE_WAIT(&status);
 }

 static struct tst_test test =3D {


-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
