Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2331BC32772
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 15:48:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85AE13CA34D
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 17:48:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B05C3C285E
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 17:47:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AEB12100047A
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 17:47:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 910161F979;
 Tue, 23 Aug 2022 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661269674;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kg2T67DEazudxVQGZf+5mgrNlMmIaZYvjIbA9T/Hkl0=;
 b=ev6K+Do+HWR60355k/w8GmJnBz+g9QLvk45hBuAGXWClKUdjV2FfkkUenOx4uZCubg3Q72
 /XTh7dCw5MK8TSrSRVj/MeqXyVytY968U1K1WcZvckQh0QM27dWvFLzb5hsXwjdz2MNpW7
 Al5CPh9h2vTCQE2z3Pq3G3acmTsF9QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661269674;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kg2T67DEazudxVQGZf+5mgrNlMmIaZYvjIbA9T/Hkl0=;
 b=gNMAFl7iRRI5mTdw8XNibUznDfSrsIEQs2v6FxAL1gSK5AQxcqm50DSDftvppIquPCiGhs
 MA0NmG0dOCALRyDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5692513A89;
 Tue, 23 Aug 2022 15:47:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RLZME6r2BGMYJQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 23 Aug 2022 15:47:54 +0000
Date: Tue, 23 Aug 2022 17:47:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YwT2qDFIK3Q2EkhG@pevik>
References: <YEigO2gryF1Kp6Gq@pevik>
 <b11680c3-7878-b06b-e87a-8991bd3cb305@163.com>
 <YEkAH6xJlSK99bp+@pevik> <YEnx4V3Il/VrThv/@pevik>
 <YEn0BK8xHVU1e52X@yuki.lan> <YEtK/A2mGoEZjF8Q@pevik>
 <YEtox4nFn3DO1KHv@yuki.lan> <YEtrkUmj9j0ej/r6@pevik>
 <YhjNpL9C3PP6Yd4U@pevik> <YwTjBO6ko9SoDVjd@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YwTjBO6ko9SoDVjd@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: Use anonymous .resource_files for
 docparse
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> >   "execveat02": {
> > -   "resource_files": "resource_files",
> > +   "resource_files": [
> > +     "TEST_APP"
> > +    ],

> > => improvement => I'd merge this patch.

> Agreed, can we merge this patch? Or is there a reason not to?
I just merge it.

> > NOTE: It'd be nice if even TEST_APP was changed to execveat_child,
> > not sure what needs to be one for it. NOTE the definitions are mostly in C
> > source:

> > #define TEST_APP "execveat_child"

> I guess that this point has been discussed in the

> "metaparse: Replace macro also in arrays"

> where we agreed that we will need a list of macros that should not be
> expandened.

Yes, I'll still plan to finish it, but first more urgent work must be done :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
