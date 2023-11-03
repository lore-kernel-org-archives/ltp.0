Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C454C4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 15:54:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA5D93CC8DD
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 16:54:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73ED23CA26E
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 16:54:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EDD0D610210
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 16:54:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 86B011F45F;
 Fri,  3 Nov 2023 15:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699026851;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h7byKl2FJ/LmTiDNVJ4WXPTMq29xDNpuPcTBorvRYDo=;
 b=rzD/qF+BOON39JGSpwiLvy2gV2RRphZlG6b/pvS1/o3jr3h1aoeRhOelf+J9HrG6SWDOKO
 pe6qlCM3GEjV5hP1sYMLnMPVu3qHKuzFKJLImRQgqqflc964VxhphjMHFc7H9IDXj77KRi
 B6Y0t52BWDVLXkzzp0qcEVEoxowynQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699026851;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h7byKl2FJ/LmTiDNVJ4WXPTMq29xDNpuPcTBorvRYDo=;
 b=C8GVuN2FkvyQY8Q4XZ8PbLczSb2w8RDwtUWyv+VM3oWfotw9x09V/mMJ8JfaDqDcwNkyMS
 EbV26BHB0w0KNTBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 325821348C;
 Fri,  3 Nov 2023 15:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 27caCqMXRWXvOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 15:54:11 +0000
Date: Fri, 3 Nov 2023 16:54:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231103155409.GB1087887@pevik>
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-3-pvorel@suse.cz> <ZUJ8K9nna0Poa9FS@yuki>
 <ZUJ-N8ji_KdOOfyr@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZUJ-N8ji_KdOOfyr@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] lib: Add .modprobe
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > >  	if (tst_test->mount_device)
> > >  		tst_test->format_device = 1;

> > > @@ -1362,6 +1402,19 @@ static void do_cleanup(void)

> > >  	tst_sys_conf_restore(0);

> > > +	if (tst_test->modprobe) {
> > > +		const char *name;
> > > +		int i;
> > > +
> > > +		for (i = 0; (name = tst_test->modprobe[i]); ++i) {
> > > +			if (!modules_loaded[i])
> > > +				continue;
> > > +
> > > +			const char *const cmd_rmmod[] = {"rmmod", name, NULL};

> > modprobe -r please, rmmod has been deprecated for ages.

> And one more minor point, we should attempt to remove the module only if
> it has shown up in the /proc/modules.

+1

> Assuming that we want to skip the tst_module_is_buildin() check on some
> systems as Ritchie suggested we would attempt to remove build in modules
> here if we blindly trusted the return value from modpprobe.

I guess for most of distros tst_check_builtin_driver() (which reads
modules.builtin) makes sense. And with it we will have valid info if we should
remove module or not.

Then there is:

1) AOSP (Android), we should ask Edward what makes sense in Android.
IMHO old AOSP versions used insmod and rmmod, but newer could support it [2].
@Edward, am I correct? Also do AOSP even care about tests which use
tst_module_unload()?

2) NixOS
This should be IMHO fixed by checking also the correct directory (ideally
wrapped by some #ifdef, but can be even without it, if there is none).

BTW, there is also /proc/sys/kernel/modules_disabled [1], I'm not sure if we
want to just ignore it.

Kind regards,
Petr

[1] https://www.kernel.org/doc/Documentation/sysctl/kernel.txt
[2] https://source.android.com/docs/core/architecture/kernel/loadable-kernel-modules

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
