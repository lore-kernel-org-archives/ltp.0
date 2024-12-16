Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFFCE7717F
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 12:29:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A56733EBCDE
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 13:29:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBFF13EB674
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 13:28:57 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 33AFF102F414
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 13:28:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7EEAB1F37E;
 Mon, 16 Dec 2024 12:28:54 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6263D137CF;
 Mon, 16 Dec 2024 12:28:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7l8MFwYdYGduSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 16 Dec 2024 12:28:54 +0000
Date: Mon, 16 Dec 2024 13:28:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241216122848.GA587325@pevik>
References: <20241212060448.204158-1-liwang@redhat.com>
 <20241213224041.GB1577592@pevik>
 <CAEemH2dRjvTkvmJ1tXGq9FXbKZETjhAbe90s4-ayCzygc5jonQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dRjvTkvmJ1tXGq9FXbKZETjhAbe90s4-ayCzygc5jonQ@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7EEAB1F37E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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

Hi Li,

...
> > > +/*
> > > + * List of kernel config options that may degrade performance when
> > enabled.
> > > + */
> > > +static struct tst_kconfig_var slow_kconfigs[] = {
> > > +     TST_KCONFIG_INIT("CONFIG_PROVE_LOCKING"),
> > > +     TST_KCONFIG_INIT("CONFIG_LOCKDEP"),
> > > +     TST_KCONFIG_INIT("CONFIG_DEBUG_SPINLOCK"),
> > > +     TST_KCONFIG_INIT("CONFIG_DEBUG_RT_MUTEXES"),
> > > +     TST_KCONFIG_INIT("CONFIG_DEBUG_MUTEXES"),
> > > +     TST_KCONFIG_INIT("CONFIG_DEBUG_PAGEALLOC"),
> > Does CONFIG_DEBUG_PAGEALLOC itself prolong the run? Isn't it that only when
> > debug_guardpage_minorder=... or debug_pagealloc=... is set?

> Good catch.

> I guess that won't impact the kernel performance if not set any
> of the parameters, because from the doc it is disabled by default.

>   "When CONFIG_DEBUG_PAGEALLOC is set, this parameter
>   enables the feature at boot time. In default, it is disabled.
>   ....
>   if we don't enable it at boot time and the the system will work
>   mostly same with the kernel built without CONFIG_DEBUG_PAGEALLOC."

> So I would like to remove CONFIG_DEBUG_PAGEALLOC from
> the detecting.

Or maybe to detect if debug_pagealloc kernel cmdline is set with tst_kcmdline_parse()?

OTOH we run with debug_pagealloc=on only syscalls and some long running tests
(e.g. bind06) are even slightly faster than when running without it. But that
may be affected by QEMU host. Therefore let's skip CONFIG_DEBUG_PAGEALLOC until
I find a time to test how it affects the runtime.

> > https://www.kernel.org/doc/html/v5.2/admin-guide/kernel-parameters.html

> > I would need to run the test with these to see the difference.


> Any new found?

I'm sorry I haven't tested yet. Feel free to not to wait and merge. I'll try to
do it soon.

Kind regards,
Petr


> > > +     TST_KCONFIG_INIT("CONFIG_KASAN"),
> > > +     TST_KCONFIG_INIT("CONFIG_SLUB_RCU_DEBUG"),
> > > +     TST_KCONFIG_INIT("CONFIG_TRACE_IRQFLAGS"),
> > > +     TST_KCONFIG_INIT("CONFIG_LATENCYTOP"),
> > > +     TST_KCONFIG_INIT("CONFIG_DEBUG_NET"),
> > > +     TST_KCONFIG_INIT("CONFIG_EXT4_DEBUG"),
> > > +     TST_KCONFIG_INIT("CONFIG_QUOTA_DEBUG"),
> > > +     TST_KCONFIG_INIT("CONFIG_FAULT_INJECTION"),
> > > +     TST_KCONFIG_INIT("CONFIG_DEBUG_OBJECTS")
> > > +};
> > > +
> > > +int tst_has_slow_kconfig(void)
> > > +{
> > > +     unsigned int i;
> > > +
> > > +     tst_kconfig_read(slow_kconfigs, ARRAY_SIZE(slow_kconfigs));
> > > +
> > Maybe here TINFO message "checking for options which slow the execution?
> > Or print it (once) only if option detected? Because it's not obvious why
> > we are
> > detecting it. Or after searching print what we did (4x prolonged runtime).


> Agree, the rest comments all look good.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
