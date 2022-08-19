Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAE8C32771
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 12:09:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EDCB3CA295
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 14:09:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 984653C2A8C
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 14:08:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DAB201400E40
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 14:08:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEA9A1FFF5;
 Fri, 19 Aug 2022 12:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660910936;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V1c9be4b9x+IBVYnyOoD2Fffa85mYvPUcDp5Pzexrec=;
 b=cEx8IgfEYIUbGBJv2qNzxIP2FhjyqJtBh9wigc2scSkqGNoOiaY4xBbQuegvRrXYNv/Un8
 +vrClbSUEUC/6gDszBNS1VIV6pkVyjeWIWXJ3u8kAfFoGXdxarMXH5VxuTnlkh4WDLDStg
 9hici1wqWwyDEslSYAh1p/vBbi4cYBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660910936;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V1c9be4b9x+IBVYnyOoD2Fffa85mYvPUcDp5Pzexrec=;
 b=91Oj1X4pd/M+vjCcv5a3eXUwQ6jYslS9j1pZiwRSrbJkhyysokvEvmkMNzsNDCPtZReg6S
 n5gmUABL1HOcW/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 823D113AC1;
 Fri, 19 Aug 2022 12:08:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id g830HFh9/2JbPgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 19 Aug 2022 12:08:56 +0000
Date: Fri, 19 Aug 2022 14:08:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yv99VtoOhs2m3lSP@pevik>
References: <20220818171724.9182-1-pvorel@suse.cz> <Yv9Jafy8AzSCH437@yuki>
 <Yv9lxML3bw61wI1o@pevik> <Yv9tWKCKQUcct66H@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yv9tWKCKQUcct66H@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] bpf_prog0[5-7]: Run with
 kernel.unprivileged_bpf_disabled = 0
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
> > I.e. 1 or 2 kernel.unprivileged_bpf_disabled results bpf() returning EPERM for
> > *all* users including root. 0 allows running again for all users, but we need
> > root to set it 0 via .save_restore:

> > tst_sys_conf.c:106: TBROK: Failed to open FILE '/proc/sys/kernel/unprivileged_bpf_disabled' for writing: EACCES (13)

> > Maybe we could change tst_sys_conf_save() not to write the value if value can be
> > read and is the same (and not run tst_sys_conf_restore() if value was the same).

> That would be a good idea either way.

> The unprivileged_bpf_disabled is more complicated that this though. It's
> a three state as:

> 0 - enabled
> 1 - disabled and can't be enabled
> 2 - disabled and can be enabled
Good point, I didn't realize 1 means "no" also for root :).

> So either we add special handling for 'cannot be changed' value to
> save_restore or we have to move that code to the test setup and check
> it manually.
Yes, because ? check for failure only in tst_sys_conf_save() (saving original
value), but writing new value (0) fails in tst_sys_conf_set() due
SAFE_FILE_PRINTF(). Adding new symbol or changing '?' to to use FILE_PRINTF()
and prints warning would IMHO help. I'll try to send patch soon.

> > That way we would not need to require root if value is the same.

> > But it'd be nice to have some tag saying: maybe root is needed, depend on sysfs
> > value...

> I wouldn't overly complicate the situation and just require root here.
Makes sense.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
