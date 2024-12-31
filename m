Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BF1E77188
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 11:51:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E1463EC823
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 12:51:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74DBC3D5280
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 12:50:46 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7709F10103FF
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 12:50:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F0AB21F37C;
 Tue, 31 Dec 2024 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735645844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iUjbYuI5H3bb+jd62EvRMMkYQsf/Nx4dj/q78dBbdGM=;
 b=IGnnBp031Wltt1q1625ibX6pvhn9GHGPOKIcTT3ZAu/Yy3/dEWFz72NyUku5dU9yvB98VM
 q6VZGjLAUYhnVbVoGqGlQaCB2fcdHUxVNOx6Je3kp2xQD0dU0aWHd/9iGwEmWQn7UFoK6g
 lLlauF1+5vScnKkzMGy08AY7LFjVugg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735645844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iUjbYuI5H3bb+jd62EvRMMkYQsf/Nx4dj/q78dBbdGM=;
 b=F2EutD07d4/WA0i/N/tFiYn9+8FFvMQHgMXzQihuWeiZTeT4e/0sNe4XW5Wq3arVaMN1d8
 G5dorPdb2fMboBBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735645843;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iUjbYuI5H3bb+jd62EvRMMkYQsf/Nx4dj/q78dBbdGM=;
 b=XSAblsiqmqXuq5gW2uDuvD/UQpJWEiuE6q7pfawJyxH2Eg7rJNBLGSPd1wU+osPb/XOyd5
 VV+ySuCPBgvWMZUcfePXL7zonFKcIdQCYO1IFiRmbPg85AMnWrj3iQd91AIKKPKyO4+Row
 6uJC5XaWvpsJMAzCETXAEvCvXwa0VpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735645843;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iUjbYuI5H3bb+jd62EvRMMkYQsf/Nx4dj/q78dBbdGM=;
 b=1HbfK26Ss9ldA4UXlYv3MngBvB5n5+5LEoQY3EyIScj/vKtOjx6Q9j+b/CiEtGk/vx9rJ8
 oCboISLNVf87ugAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F298613A30;
 Tue, 31 Dec 2024 11:50:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kVwhM5Lac2cSKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 31 Dec 2024 11:50:42 +0000
Date: Tue, 31 Dec 2024 12:50:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Message-ID: <20241231115040.GD36475@pevik>
References: <20241227160042.363309-1-pvorel@suse.cz>
 <20241231043457.270557-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241231043457.270557-1-po-hsu.lin@canonical.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] device-drivers: *module: Use helpers for
 module signature enforcement
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
Cc: rbm@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Po-Hsu Lin,

> > +++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
> > @@ -22,7 +22,6 @@
> >  #include <stdlib.h>

> >  #include "test.h"
> > -#include "tst_kconfig.h"
> >  #include "old_module.h"
> >  #include "safe_macros.h"

> > @@ -129,20 +128,12 @@ static void test_run(void)
> >  int main(int argc, char *argv[])
> >  {
> >  	int acpi_disabled;
> > -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> > -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");

> >  	tst_parse_opts(argc, argv, NULL, NULL);
> > -
> >  	tst_require_root();
> > -
> > -	tst_kcmdline_parse(&params, 1);
> > -	tst_kconfig_read(&kconfig, 1);
> > -	if (params.found || kconfig.choice == 'y')
> > -		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
> > -
> >  	tst_sig(FORK, DEF_HANDLER, cleanup);

> > +	tst_check_module_signature_enforced();

> One question, should we put this tst_check_module_signature_enforced()
> before or after tst_sig()? Asking because it's different in tpci.c

I suppose either way is ok, because we don't call the cleanup function anyway.
Best would be to convert the test to the new LTP API.
But I'll move it in tpci.c below tst_sig().

...
> > +++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
> > @@ -17,7 +17,6 @@
> >  #include <errno.h>
> >  #include "lapi/init_module.h"
> >  #include "tst_module.h"
> > -#include "tst_kconfig.h"

> >  #define MODULE_NAME	"finit_module.ko"

> > @@ -27,14 +26,7 @@ static char *mod_path;

> >  static void setup(void)
> >  {
> > -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> > -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
> > -
> > -	tst_kcmdline_parse(&params, 1);
> > -	tst_kconfig_read(&kconfig, 1);
> > -	if (params.found || kconfig.choice == 'y')
> > -		sig_enforce = 1;

> This test will expect an EKEYREJECTED error if the module signature is
> enforced. So I think:

> if (tst_module_signature_enforced())
> 	sig_enforce = 1;

> And remove tst_check_module_signature_enforced() below, otherwise the
> test will be skipped.

+1. I have this in other tests, but obviously I omitted this in
finit_module01.c. I'll fix it in v2.

Thanks for your review!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
