Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A0AC433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 10:44:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 041683C8159
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 11:44:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FEF73C1D2E
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:43:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1CE18140125A
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:43:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 54D761F3A2;
 Fri, 10 Dec 2021 10:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639133036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugGl0CcftayOIpFbWJq+WHB/XfIpiQYh4X3LCVK93/w=;
 b=JFR1uNZtyZSJ1r1NByJbM7PuHATrBpMNttOPrUf0a3VyI70azuSXfSk4C8EDxayRBj8J2s
 4oLB+1ZDwK3Z1wiuVg/7Nw6JVU2byUGvzVjETS7t+hPQ1DKsgro5GcdyCplvqOFW6WmPJc
 9d486zyB9U/gX80jg9U2fnkfTZv1Sbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639133036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugGl0CcftayOIpFbWJq+WHB/XfIpiQYh4X3LCVK93/w=;
 b=YCkxrc4pprvW8SZi5w39gCQyCSmQIjeaACSKbVed8cyEBrgJWWVgn8E4m08qb7gY+yL7cu
 1FxEBgRisnYdkZAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41D6713DDE;
 Fri, 10 Dec 2021 10:43:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kfzXDmwvs2GBVwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Dec 2021 10:43:56 +0000
Date: Fri, 10 Dec 2021 11:45:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Message-ID: <YbMvvIOMQqsMRC3d@yuki>
References: <CAEemH2ed6DqKw80Xa_BTjUweT0HrhrUN2-7X+sS05K9gCr2F5A@mail.gmail.com>
 <CADS1e3cCXsu=y_GNM3ymwHtOq9R671YnQAWgyycG25FJYnOLaA@mail.gmail.com>
 <CAEemH2cZvK29mrN2xD_EOPx7w3UXFBHrWmAdg+rv5K2vcP3qNA@mail.gmail.com>
 <87pmqfcp4j.fsf@suse.de>
 <CADS1e3dXhKJ0NK0OSWYfu-KB__7OsOkRcGmTH66+Ah-tMW8ijA@mail.gmail.com>
 <CAEemH2cT76bRmeQQPQrALUjjK9VNaGRLY4jOYPNrMjkA4FF7_g@mail.gmail.com>
 <CADS1e3dkYtRibN7ADGh_c9T5uZ4BFTpjgPaXH1+xfBUS8xpKcA@mail.gmail.com>
 <87ilw2ccgv.fsf@suse.de>
 <CADS1e3dEh6YAnWmhizVpkuN_EAqwDOeeVnfT_C23mzN2LS-2XA@mail.gmail.com>
 <YbMurQKsabIfCOMu@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbMurQKsabIfCOMu@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] controllers/memcg: update stress test to work
 under cgroup2
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Let me know what you think. I wouldn't want to add anything huge to the API
> > without your blessing :)
> 
> Wouldn't it be easier to rewrite these test to the C then? I think that
> error handling in shell CGroup tests would always be more difficuilt
> than in C and given that we have a nice library for C it actually sounds
> like a better solution.

Also not to mention other problems, in shell you actually need at least
one fork to do anything which isn't ideal when you are stress testing
memory, which means that the fork() may fail. While in C you just call a
syscall which is less likely to fail or be stalled due to the load...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
