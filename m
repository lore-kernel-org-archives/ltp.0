Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07A5C6FD1D
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 05:17:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E96693CD2B2
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 06:17:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20B9C3C1BCE
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 06:17:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5A54660034E
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 06:17:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5D6F15C34C;
 Thu, 23 Mar 2023 05:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679548657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZ8Qc6t4yNLPJdNFKEUvNBJ8Fc+byVFQp9dN7Wf7lPA=;
 b=RuDvTJ4Dg+Y4YDBKNaZ+GM5vHIiamjhG3nrdt0we7eflr4zk54YjUqEuDfEbEpqEGxwcRm
 PmXzeK0+trGVEcA8anXZj3tpK1NlvnwzAnKfmH02p9bdf9HJZbU23jUGMuVtH0X/Dk9w2n
 NIp7bs4+DISKOz/PPHDOYMEB+tAzh/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679548657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZ8Qc6t4yNLPJdNFKEUvNBJ8Fc+byVFQp9dN7Wf7lPA=;
 b=IM0Omf9eQ+7Z6Hc5QSfT9gdUbxaYqV6r9812iXmxhP+oIHo2fJ7o6kcuvVmBVsxhrjVIW/
 rR8tyHz7ywSI/ZDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E14F13596;
 Thu, 23 Mar 2023 05:17:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qaz3DfHgG2TXSgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 05:17:37 +0000
Date: Thu, 23 Mar 2023 06:17:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230323051735.GA381848@pevik>
References: <20230217151036.10295-1-pvorel@suse.cz>
 <20230217151036.10295-2-pvorel@suse.cz> <ZBr9v2cz6/gmksAW@yuki>
 <20230322162046.GA369840@pevik> <ZBsuYsWXtnmw83cV@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZBsuYsWXtnmw83cV@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > No, but we already use sysctl in tst_init_iface():
> > sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
> > tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?

> > and we don't check for sysctl (expecting is everywhere). I'd also allow using
> > sysctl (and then add a check via tst_require_cmds) or change also these with
> > cat for reading and echo ... > for writing. WDYT?

> I would say that sysctl is useful when you have a config file with a
> bunch of values to be changed, but I would avoid using it in scripts,
> because all it does in that cases to perepend the proc part of the path
> and converts dots into slashes. And sometimes, when a path component
> contains a dot, it fails to replace the right dots into slashes too:

> http://lists.busybox.net/pipermail/busybox-cvs/2008-October/028382.html

Well, bug from 2008 (fixed in svn, probably that year). But I agree that
it's better to get rid of sysctl. I'll use cat here and prepare fix for the rest
of tst_net.sh sysctl usage.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
