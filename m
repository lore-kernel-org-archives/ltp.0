Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77302C02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 14:25:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2CAF3C02C4
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 15:25:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63A7F3C02C4
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 15:24:54 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF3071A0D2FA
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 15:24:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AF6FA1F7B8;
 Mon, 20 Jan 2025 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737383092;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ka4AOHupBld25/uXaK2IaNQqvN9amw1CyD69AR/9aDI=;
 b=fw7gMXM+0wQUjcQx9TfvG1VA8clkLElKXnXUO6aMDeyRe2fYR6btJIYUeWGT+4UKdXCu1Z
 vld4Z3Z39qYTiPY+fe6U18xdSrN34uVMNBZpXNlUr3VL2yXQRUwlUfAvNg+R9PBIB42Qln
 SXRZuS+3SQ9giKJy2jCPsZWhIKt9/yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737383092;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ka4AOHupBld25/uXaK2IaNQqvN9amw1CyD69AR/9aDI=;
 b=bWxUoQwfqGQOhPR2BqoCE4BVXF4WYRUOICHxbzO/r1gjrp9Aw7U1A86xsSO9/Ta1x5l85u
 3PdjMlXWwUJEC7DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fw7gMXM+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bWxUoQwf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737383092;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ka4AOHupBld25/uXaK2IaNQqvN9amw1CyD69AR/9aDI=;
 b=fw7gMXM+0wQUjcQx9TfvG1VA8clkLElKXnXUO6aMDeyRe2fYR6btJIYUeWGT+4UKdXCu1Z
 vld4Z3Z39qYTiPY+fe6U18xdSrN34uVMNBZpXNlUr3VL2yXQRUwlUfAvNg+R9PBIB42Qln
 SXRZuS+3SQ9giKJy2jCPsZWhIKt9/yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737383092;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ka4AOHupBld25/uXaK2IaNQqvN9amw1CyD69AR/9aDI=;
 b=bWxUoQwfqGQOhPR2BqoCE4BVXF4WYRUOICHxbzO/r1gjrp9Aw7U1A86xsSO9/Ta1x5l85u
 3PdjMlXWwUJEC7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75982139CB;
 Mon, 20 Jan 2025 14:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ExiQG7RcjmcmfQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Jan 2025 14:24:52 +0000
Date: Mon, 20 Jan 2025 15:24:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alessandro Carminati <acarmina@redhat.com>
Message-ID: <20250120142447.GA812655@pevik>
References: <20250120102831.63646-1-acarmina@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250120102831.63646-1-acarmina@redhat.com>
X-Rspamd-Queue-Id: AF6FA1F7B8
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,lists.linux.it,suse.com,suse.cz];
 RCPT_COUNT_SEVEN(0.00)[7]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] sched/starvation: Add disclaimer for
 virtualized/emulated environments
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
Cc: ltp@lists.linux.it, Alessandro Carminati <alessandro.carminati@gmail.com>,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Alessandro,

> This patch adds a disclaimer message to the starvation test case, warning
> users against running the test in virtualized or emulated environments.
> The test produces expected results only on bare-metal systems and is prone
> to failure when executed in non-bare-metal setups.

> While detecting virtualization or emulation is possible in some cases,
> the methods are unreliable.
> Rather than attempting to prevent the test from running in such
> environments, this patch provides a warning to inform users of the
> limitations.

> Change:
> - Added a TINFO message to notify users that the test should be run
>   on bare-metal systems for meaningful results.

> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> ---
>  testcases/kernel/sched/cfs-scheduler/starvation.c | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
> index c620c9c3e..b779a5f0a 100644
> --- a/testcases/kernel/sched/cfs-scheduler/starvation.c
> +++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
> @@ -115,6 +115,9 @@ static void setup(void)
>  	if (tst_has_slow_kconfig())
>  		tst_brk(TCONF, "Skip test due to slow kernel configuration");

> +	tst_res(TINFO, "This test is designed to run on bare-metal systems. "
> +		"Running it in a virtualized or emulated environment may produce unreliable results.");

We should at least wrap it with tst_is_virt(), make it shorter and add WARNING:

	if (tst_is_virt(VIRT_ANY))
		tst_res(TINFO, "WARNING: Running on a virtualized or emulated environment may produce unreliable results");

But OTOH I haven't seen any problem with it on various SLES versions nor in
openSUSE Tumbleweed (which uses latest mainline kernel). Therefore I would not
put TCONF, but just TINFO as you suggested (other tests which use tst_is_virt()
detection usually do TCONF).

Any idea what can cause instability on virtualized environments? Which kernel
options could be affected? ATM test is disabled due slow kernel config detection
on SLES/Tumbleweed (non-RT, tested on qemu) where it's working and this is not 
enough to detect unstable results on the kernels you test.

I also send a patch to remove CONFIG_LATENCYTOP as option causing slow kernel.

Kind regards,
Petr

> +
>  	tst_set_runtime(timeout);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
