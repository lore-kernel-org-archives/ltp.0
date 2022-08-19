Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7C1C32771
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 10:58:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 430973CA227
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 12:58:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C9A73CA1A4
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 12:58:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9F573200342
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 12:58:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD5C43F88A;
 Fri, 19 Aug 2022 10:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660906722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nzjnVveXMOQV4ftuWBJbBuUl+d+tOpJJUqab/XgfpgA=;
 b=VHfrooidjh7Tz4UEvHtzptzS9Rya9/IVhYoWKH1epYUYyD4KUWMeAyqJQFTbY7jIhp8Wb1
 TnvbCxvJi+PjdWKEC2iwqclNIaqbb877zY8yGMG2U8bFhXyFT7Ly5q3wxopnfShO8svs2g
 2rBd7terdMzf5aY3swA1czGR4nDV6wA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660906722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nzjnVveXMOQV4ftuWBJbBuUl+d+tOpJJUqab/XgfpgA=;
 b=g1MekIBs5mjuHditna7HKaLpH7PutAsr+hD2qwc7sPBCqIPuMNV5yKvnPzOlbodqlredU1
 nTvAUN9F+psBsBDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8C1113AE9;
 Fri, 19 Aug 2022 10:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UP/1K+Js/2JmIwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 19 Aug 2022 10:58:42 +0000
Date: Fri, 19 Aug 2022 13:00:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yv9tWKCKQUcct66H@yuki>
References: <20220818171724.9182-1-pvorel@suse.cz> <Yv9Jafy8AzSCH437@yuki>
 <Yv9lxML3bw61wI1o@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yv9lxML3bw61wI1o@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I.e. 1 or 2 kernel.unprivileged_bpf_disabled results bpf() returning EPERM for
> *all* users including root. 0 allows running again for all users, but we need
> root to set it 0 via .save_restore:
> 
> tst_sys_conf.c:106: TBROK: Failed to open FILE '/proc/sys/kernel/unprivileged_bpf_disabled' for writing: EACCES (13)
> 
> Maybe we could change tst_sys_conf_save() not to write the value if value can be
> read and is the same (and not run tst_sys_conf_restore() if value was the same).

That would be a good idea either way.

The unprivileged_bpf_disabled is more complicated that this though. It's
a three state as:

0 - enabled
1 - disabled and can't be enabled
2 - disabled and can be enabled

So either we add special handling for 'cannot be changed' value to
save_restore or we have to move that code to the test setup and check
it manually.

> That way we would not need to require root if value is the same.
> 
> But it'd be nice to have some tag saying: maybe root is needed, depend on sysfs
> value...

I wouldn't overly complicate the situation and just require root here.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
