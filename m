Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EEAC433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 09:17:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C326103B
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 09:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48C326103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08F473C883A
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 11:17:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DF1F3C17C6
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 11:17:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 921FD1000F61
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 11:17:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 83339223FD;
 Fri, 17 Sep 2021 09:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631870260;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4vW223L0uRBYAdbOCYEeUDhVklvDZ1xH/1Nog0CTCcc=;
 b=uiAazkLtwkOVYkJds8CiKhPpZYzHClAIDktvrNUVwljmuR8vKpWYalDhK4t1Z4nQh+6fCY
 Zp1RBtU3vXMobHYiIP6fsn+r2pRQrjrkztwLZ2LOiTnxmPmYDqUUhO9SHhU3v28icZy3oL
 fhs+p2eYKBRoSz32Bj08td8b2UCtvro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631870260;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4vW223L0uRBYAdbOCYEeUDhVklvDZ1xH/1Nog0CTCcc=;
 b=ZdB4XN5Ugd4j/0wKEsQslSR0Ib2iYDVeuVdmfnYhrA8Vk5UDfhL00v7lxcAgci4n1D/ZNv
 kGjDFpfVoLKloJDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0228213A8D;
 Fri, 17 Sep 2021 09:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OPv8MjNdRGFNUQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Sep 2021 09:17:39 +0000
Date: Fri, 17 Sep 2021 11:17:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YURdMRsvyGRcF77X@pevik>
References: <20210519085812.27263-1-liwang@redhat.com> <YUJ2XA7W3JPODyNC@pevik>
 <YUJ7SC/FoA8wTaf2@pevik> <YURW7NKNSSr0J6pL@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YURW7NKNSSr0J6pL@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_test: using SIGTERM to terminate process
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
Cc: ltp@lists.linux.it, Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210917091737.7BWBvdS3fr6Kx8eDkiX1or6YgooAK6VZOjUTl5LVAaQ@z>

Hi Cyril,

> Hi!
> > setup()
> > {
> > 	tst_brk TCONF "quit now!"
> > }

> > do_test()
> > {
> > 	tst_res TPASS "pass :)"
> > }

> > tst_run
> > EOF

> > # while true; do ./debug.sh; done

> I managed to reproduce this in dash. I bet that this is a bug where
> signal handler inside dash is temporarily disabled when we install the
> trap and if we manage to hit that window the signal is discarded. At
> least that is my working theory. After I've installed debug prints, in
> the cases where it hangs the signal was sent just before have installed
> the trap. And in some cases when the signal arrives the timer process is
> killed but the trap is not invoked. So it really looks like signal
> handling in dash is simply broken. Not sure what we can do about bugs
> like this apart from switching to a real programming language.

Thanks for the debugging. *bash* is also affected, at least some releases.
I reproduced it also on some older SLES, with bash 4.4.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
