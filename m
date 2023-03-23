Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E9EC761AF
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 09:22:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 165293CCB62
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 10:22:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DBE23C0277
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 10:22:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2B76D1A00CC2
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 10:22:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C4F301FE54;
 Thu, 23 Mar 2023 09:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679563334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sB9zOMIA94IUIN9yI07ewPY7CiwLHtRsNROsfv2S+pc=;
 b=aarh/0Wih5VoqEYOcZOy9I+UvAFSgBrKNJVJ39q/P/mllmG9dqrZQr0OWvnTKwUf68IjwO
 lhtHw7ALYH8LfpIRqgHlfKbeDcrkSWMkh8S7tdxSZrJitVYZzwTDD4Bf9AXfbR1pKOOncz
 KNH6ore30y3rPmvVgC3Nxb14ONw+Afg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679563334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sB9zOMIA94IUIN9yI07ewPY7CiwLHtRsNROsfv2S+pc=;
 b=3R4sW6FICHbG0GgH9EudDeFeLHOBFV784TxkvrZMgzn2pV1Enehx25507SBgUB6QEgDzdN
 pWhbHNng/VHW4MAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB12B13596;
 Thu, 23 Mar 2023 09:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GIBgKEYaHGSoQwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 09:22:14 +0000
Date: Thu, 23 Mar 2023 10:22:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20230323092213.GE405493@pevik>
References: <20230310124125.14279-1-pvorel@suse.cz> <ZA87677RI2ddqkJm@yuki>
 <20230313153056.GB10305@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230313153056.GB10305@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Move container utils to testcases/lib/
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

> > Hi!
> > > Preparation for https://github.com/linux-test-project/ltp/issues/991.

> > > NOTE: this patch conflicts with my other patch [1]
> > > (touching testcases/lib/{Makefile,.gitignore}).

> > > Kind regards,
> > > Petr

> > > [1] https://patchwork.ozlabs.org/project/ltp/patch/20230307145517.1359-2-pvorel@suse.cz/


> > > Petr Vorel (3):
> > >   ns_exec.c: Rename to testcases/lib/tst_ns_exec.c
> > >   ns_create.c: Rename to testcases/lib/tst_ns_create.c
> > >   ns_ifmove.c: Rename to testcases/lib/tst_ns_ifmove.c

> > >  doc/namespaces-helper-tools.txt               | 14 ++++++------
> > >  .../ns_common.h => include/tst_ns_common.h    |  6 ++---

> > I'm not sure about moving this header into top level include, it would
> > probably make more sense to add it next to the C files that include it.

> Sure, I'll put it there before merge (if it's the only thing to change).

BTW having header in testcases/lib/ will require to move ns_create.c together
with ns_exec.c in single commit (squash these 2 commits). But that should not be
a big deal.

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
