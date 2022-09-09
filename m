Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2DFECAAA1
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 11:08:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FD033CAA54
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 13:08:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F20663C1B7E
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 13:08:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ABFA6601BF9
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 13:08:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 94920224BB;
 Fri,  9 Sep 2022 11:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662721702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Io9tbprm48FdBzEkJT6uDpUq6nwATWhtECPJqnIMDi0=;
 b=vBiZiPnG0z3yuWqZFsU6FwCY/F8eHFkWrh8l+hBRbFbSOpfISd0Pq+b8RseroiUvWxaxko
 MD1A4wCVjsy2nYmt361XorZeelIsdnMXAyUanwyrlt7InM4ZNoJVOBXPBS5fkHB2WkUD/C
 Wlqu8oT4ASDLv92rL+dGcFweZ7fNtMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662721702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Io9tbprm48FdBzEkJT6uDpUq6nwATWhtECPJqnIMDi0=;
 b=d7JFoVbNF5GSvkofKm6YAXAIXUqs3hCNa0xVfiyJVJjxjfnp4y1sT/XWIIp3WlfQPRPMGC
 K0OkChnsbpWZcKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F992139D5;
 Fri,  9 Sep 2022 11:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pJRFHqYeG2NZCgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 09 Sep 2022 11:08:22 +0000
Date: Fri, 9 Sep 2022 13:10:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YxsfGUpRLAx6uIU7@yuki>
References: <Yxr+EpKTnKQbKXTb@yuki>
 <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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
> Maye split this work into pieces? something like:
>     - announcement email,
>     - collecting patch lists for a new release,
>     - writing release notes, or paperwork,
>     - uploading tarballs
>     - pre-testing against different Linux distribution
> 
> You can still send the announcement email, and other volunteers do the rest.
> (if applicable, I can take patch reviews or upload tarballs work)

I guess that would work too, as long as we have volunteers.

> Btw, I'll also cover the full pre-test against the RHEL series before
> release.
> 
> 
> > And in order not to delay things further, please start pointing out
> > patches that should go in before the release. I guess Martin runtime
> > fixes should go in. Anything else?
> >
> 
> The "Track minimal size per filesystem" from Petr should be included as
> well.
> (I guess it is still WIP)

Ah, right, we have to do something about xfs, I guess that if we do not
manage until the release a minimal fix would be to increase the minimal
device size.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
