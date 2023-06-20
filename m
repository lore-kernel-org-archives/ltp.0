Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AF3EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 21:08:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD5803CCEB9
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 23:08:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CBBD3CB419
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 23:08:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4B601100053D
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 23:08:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 95408218E0;
 Tue, 20 Jun 2023 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687295309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7/MvuT5ekiHZMR2iaYzjAiGSkZfCHzn79VTuIVm5lZ4=;
 b=kTx5QhpwBGp39Hps+WLfweXKKfQizHf5nkE8hI2BXKtDGn2IxeEDyUYKgUky8N6WSA2fPt
 kPrKUqPXo+8QZQ6R8fWPv/yfMqSdn3w6hvtwDRfmhqPQ9H8G7ihQHJGzJmjCbkaSLzpqaB
 KxiSwgUveTkWNPzAfm9OAb/88dRO0B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687295309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7/MvuT5ekiHZMR2iaYzjAiGSkZfCHzn79VTuIVm5lZ4=;
 b=JUJ7C80GTq6dZPpb1o4jZ3wVg9Wk7nGN4dsu+wagZSG0CRlQMv+VUG3SAolQqAS7tBJ/6/
 W3DGsLo+YFfvnDBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE112133A9;
 Tue, 20 Jun 2023 21:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NzccMEwVkmQnBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jun 2023 21:08:28 +0000
Date: Tue, 20 Jun 2023 23:08:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230620210826.GB334441@pevik>
References: <80595ab205ea7b3f633bf4228bb43ee999aef3a1.1687247273.git.souta.kawahara@miraclelinux.com>
 <CAEemH2doFsjjQwDA2P_-_vDrFSBtNoCXLXh3U__3W6jED4mhTw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2doFsjjQwDA2P_-_vDrFSBtNoCXLXh3U__3W6jED4mhTw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] runtest/cve: Add some existing CVE tests
 to runtest file
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

Hi Li, all,

...
> > +cve-2017-5669 shmat03

> This one looks like being dropped from the CVE list purposely,
> according to:

> commit 2588dafd4651706ed7ae34ae3b744b0ee8cd6384
> Author: Cyril Hrubis <chrubis@suse.cz>
> Date:   Wed Aug 14 14:13:28 2019 +0200

>     syscalls/shmat03: Remove it from runtest/cve

>     The original POC[1] and CVE-2017-5669 are not tested by this test
>     anymore as it turned out that the CVE was bogus. See:

>     https://marc.info/?l=linux-mm&m=152510978123755&w=2

>     And the test became regression test for:

>     commit 8f89c007b6dec16a1793cb88de88fcc02117bbbc
>     Author: Davidlohr Bueso <dave@stgolabs.net>
>     Date:   Fri May 25 14:47:30 2018 -0700

>         ipc/shm: fix shmat() nil address after round-down when remapping

>     Hence we will keep the test but remove it from the CVE runtest file and

Good catch, Li. I'm for merging this without "cve-2017-5669 shmat03" line.
With this change:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> adjust
>     the top level comment in the test code.
Do you plan to do this?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
