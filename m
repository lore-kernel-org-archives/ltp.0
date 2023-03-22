Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35DFC6FD1C
	for <ltp@archiver.kernel.org>; Wed, 22 Mar 2023 16:35:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 741D13CD299
	for <ltp@archiver.kernel.org>; Wed, 22 Mar 2023 17:35:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6D653C5624
 for <ltp@lists.linux.it>; Wed, 22 Mar 2023 17:35:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6ECC46007B9
 for <ltp@lists.linux.it>; Wed, 22 Mar 2023 17:35:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A882A33D06;
 Wed, 22 Mar 2023 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679502911;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+xSTp32YeB1D08b+4O5mwG7IERtvhBUtx94Lkc+l48=;
 b=qU1XWgKndMcdE/whG6AhLlgwZGCZZHcKNtWbpRg+l0c0PsXez4Q0nOt35niPjLAxIwgRb5
 6UahrHM5D8PZlJUChfIz0qACS7Q+NiRXFlpFFPEj3iN5F2adka1ppW5ir+Scu0xaD/YBhy
 fsZx++KRZbiAM7eWRUWP7LVoDKK84Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679502911;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+xSTp32YeB1D08b+4O5mwG7IERtvhBUtx94Lkc+l48=;
 b=s0erNOu+1fBd3mNBq3sFFduc9Dgqe+kNK+u3dFdnRMpi3tXM0Yd+mwUka96gKJ7iqkCLVA
 tNfF94S6gUAKj7Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80FD213416;
 Wed, 22 Mar 2023 16:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nfaaHT8uG2TXcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Mar 2023 16:35:11 +0000
Date: Wed, 22 Mar 2023 17:35:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20230322163509.GB369840@pevik>
References: <20230217151036.10295-1-pvorel@suse.cz>
 <20230217151036.10295-2-pvorel@suse.cz> <ZBr9v2cz6/gmksAW@yuki>
 <20230322162046.GA369840@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230322162046.GA369840@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] tst_net.sh: Detect IPv6 disabled via sysct
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > > +	cmd='sysctl -n net.ipv6.conf.all.disable_ipv6'

> > I'm not sure why we should use sysctl when this the same as doing

> > cat /proc/sys/net/ipv6/conf/all/disable_ipv6
> > Or is there any added value from the sysctl command?

> No, but we already use sysctl in tst_init_iface():
> sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
> tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?

> and we don't check for sysctl (expecting is everywhere). I'd also allow using
> sysctl (and then add a check via tst_require_cmds) or change also these with
> cat for reading and echo ... > for writing. WDYT?

BTW tst_set_sysctl() and it's use would need to be rewritten to get benefit of
getting rid of using sysctl. But I can use cat in this case to not extending
sysctl dependency.

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
