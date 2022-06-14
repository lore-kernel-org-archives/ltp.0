Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5C8C43334
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 12:15:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF7983C8D8E
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 14:15:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C5353C8D8E
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 14:15:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6F8901A009A1
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 14:15:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C338B21B93;
 Tue, 14 Jun 2022 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655208922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDpHH93dcKM0xbOEhDsLSbMH8rr8i+uPOmzDF+rcO0s=;
 b=ZkM6YSQmXyfOJMO1dbxd18c619q3pgGUbO5L3KCNjHELKwpfrIMZ+YpB1kQ6yvykmk8AkC
 eMJphsAesDKeikMAAFiH4AgMRXj+bh5FOVOOONOnT4TAC6iceAqVTjZ2bgw5Bi4D8jN36A
 r2XidnW5afLTdivPhpEAYlvzo6J6vzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655208922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDpHH93dcKM0xbOEhDsLSbMH8rr8i+uPOmzDF+rcO0s=;
 b=bDlz/qJYVW1dxvPGtGwKzbygGxuDPuwR0yqmqHEFMJCJiVDExnEzkXbSLEJ/elfZMfakFo
 i/b4UYAdJWxljTBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97641139EC;
 Tue, 14 Jun 2022 12:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NH1KItp7qGKzBwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Jun 2022 12:15:22 +0000
Date: Tue, 14 Jun 2022 14:17:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yqh8WQ15goPaFgew@yuki>
References: <20220613125153.20423-1-chrubis@suse.cz> <YqdA2P+NCeGKdB5q@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqdA2P+NCeGKdB5q@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/execve06: Add test for argv[0] = NULL
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
> > in order to fix all potential CVEs where userspace programs attempt to
> > blindly process the argv[] list starting at argv[1]. There was at least
> > one example of this caught in the wild CVE-2021-4034 in polkit but there
> > are likely more.
> 
> Great, thanks for addressing this.
> 
> > Fixes: #911
> 
> >  testcases/kernel/syscalls/execve/.gitignore   |  2 +
> >  testcases/kernel/syscalls/execve/execve06.c   | 49 +++++++++++++++++++
> >  .../kernel/syscalls/execve/execve06_child.c   | 27 ++++++++++
> >  3 files changed, 78 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/execve/execve06.c
> >  create mode 100644 testcases/kernel/syscalls/execve/execve06_child.c
> 
> This should go to runtest/syscalls and runtest/cve, right?
> (can be fixed before merge).

Sigh, sorry, I did forget about these.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
