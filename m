Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEEBECAAA1
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:37:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29A003CAA94
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:36:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FF3C3CA9C9
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:36:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D5A541A01165
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:36:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E222922D30;
 Fri,  9 Sep 2022 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662734206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qZ4F65NNE3zZuzehhnv23aTuZOFPodlGudgQTPnT7y8=;
 b=fqkeJ0RZhW6Eju0G/8d9LTlA/W+yxU40Z9hz5DxOmKlpXEPjlU72+DrIP0rQVfikXV7lq1
 ztT6WBMgGz86kn/LNyYYy0JuZAxnjuCtDXGzi6Payol7yMGoHbBFboA3kiZQlpytWts86a
 vcGGhaBZUF8X8UhegheNtnI3CF4nELY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662734206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qZ4F65NNE3zZuzehhnv23aTuZOFPodlGudgQTPnT7y8=;
 b=2E9IrOMbDXqe+3hrcrBsTKyX73oWRl1yjUhtTM6Td5Y1woqW80i/uL05W1VwiF2knygEPn
 8QdIqMNjlvWDAPAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90D1813A93;
 Fri,  9 Sep 2022 14:36:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cDOLIX5PG2PfXgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 14:36:46 +0000
Date: Fri, 9 Sep 2022 16:36:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YxtPfXA6I64lS2oK@pevik>
References: <Yxr+EpKTnKQbKXTb@yuki>
 <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
 <YxsfGUpRLAx6uIU7@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxsfGUpRLAx6uIU7@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Martin Doucha <martin.doucha@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

[ Cc automated-testing ML ]

> Hi!
> > Maye split this work into pieces? something like:
> >     - announcement email,
> >     - collecting patch lists for a new release,
> >     - writing release notes, or paperwork,
> >     - uploading tarballs
> >     - pre-testing against different Linux distribution

> > You can still send the announcement email, and other volunteers do the rest.
> > (if applicable, I can take patch reviews or upload tarballs work)

> I guess that would work too, as long as we have volunteers.
I could do part of work as well. I volunteer to upload the tarballs.
I also try to help with reviewing and testing pre release fixes.
I usually do network tests changelog, which is tiny part of whole changelog.

I try to do at least some of runtime tests on SLES and Tumbleweed, I suppose
Martin helps with it as usually. Obviously more people should do pre-release
testing.

And in my non work time build testing on Buildroot (finds various build problems
on other libc and generally the embedded world).

> > Btw, I'll also cover the full pre-test against the RHEL series before
> > release.


> > > And in order not to delay things further, please start pointing out
> > > patches that should go in before the release. I guess Martin runtime
> > > fixes should go in. Anything else?


> > The "Track minimal size per filesystem" from Petr should be included as
> > well.
> > (I guess it is still WIP)
Yes, it's still in WIP.  I'll finish the "Track minimal size per filesystem"
patchset after merging $TST_ALL_FILESYSTEMS.

I'd really prefer to get reviewed and merged "v5 shell: df01.sh:
$TST_ALL_FILESYSTEMS (.all_filesystems)" [1] [2]. Martin has suggested for v4 to
use 2 different enums (TST_FS_UNAVAILABLE and TST_FS_UNSUPPORTED instead of
TST_FS_UNSUPPORTED) [3]. I'm willing to implement that in Monday if are others
ok and hope this is the last change and whole thing can be merged.

> Ah, right, we have to do something about xfs, I guess that if we do not
> manage until the release a minimal fix would be to increase the minimal
> device size.

I don't mind to merge "Fix mkfs.xfs 300MB min size requirement (v5.19.0)" [4]
[5] as a temporary fix before release.

Kind regards,
Petr


[1] https://patchwork.ozlabs.org/project/ltp/list/?series=317639
[2] https://lore.kernel.org/ltp/20220909141840.18327-1-pvorel@suse.cz/
[3] https://lore.kernel.org/ltp/70df29e7-0097-c698-b6ba-e3f87da3893f@suse.cz/
[4] https://patchwork.ozlabs.org/project/ltp/list/?series=314303&state=*
[5] https://lore.kernel.org/ltp/20220818100945.7935-1-pvorel@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
