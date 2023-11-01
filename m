Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9202C4332F
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 16:34:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9C153CE9A9
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 17:34:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54D8F3CC8EB
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 17:34:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CFBB160110B
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 17:34:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8545521A47;
 Wed,  1 Nov 2023 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698856471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/U2Z/UnknLR+dDlIQ95rWHiNcaWVI6Ympn3Y0Ze/QYI=;
 b=IqDNXwAS1LsATa3KD1X8+Rbuef7TczPEfqHQ+DXeUb04qfCVZMqiMKUe1fq79gMSdWZut+
 W1NXdf7DgAvP9x+yAFTfY6lLchluBDFqkAut4/GN5SBLNHBLBszC3FYgk67/B+jvVSDidx
 AJlTjiimR9T0YCJgq1vdh2zXgBCe5P8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698856471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/U2Z/UnknLR+dDlIQ95rWHiNcaWVI6Ympn3Y0Ze/QYI=;
 b=qnV/5ga2JTOc8OXhpWSkoVd2ntMrLZMCVJ3BzbBZvWTLIO8AI0EFeJgIpNEpa/OTxfQcka
 3wmWgGvP324tx+Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F3CA13460;
 Wed,  1 Nov 2023 16:34:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 85+LGRd+QmX+QwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 01 Nov 2023 16:34:31 +0000
Date: Wed, 1 Nov 2023 17:35:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZUJ-N8ji_KdOOfyr@yuki>
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-3-pvorel@suse.cz> <ZUJ8K9nna0Poa9FS@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZUJ8K9nna0Poa9FS@yuki>
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >  	if (tst_test->mount_device)
> >  		tst_test->format_device = 1;
> >  
> > @@ -1362,6 +1402,19 @@ static void do_cleanup(void)
> >  
> >  	tst_sys_conf_restore(0);
> >  
> > +	if (tst_test->modprobe) {
> > +		const char *name;
> > +		int i;
> > +
> > +		for (i = 0; (name = tst_test->modprobe[i]); ++i) {
> > +			if (!modules_loaded[i])
> > +				continue;
> > +
> > +			const char *const cmd_rmmod[] = {"rmmod", name, NULL};
> 
> modprobe -r please, rmmod has been deprecated for ages.

And one more minor point, we should attempt to remove the module only if
it has shown up in the /proc/modules.

Assuming that we want to skip the tst_module_is_buildin() check on some
systems as Ritchie suggested we would attempt to remove build in modules
here if we blindly trusted the return value from modpprobe.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
