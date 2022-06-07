Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB56C43334
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 09:41:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D6443C8DD5
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 11:41:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 651973C0162
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 11:41:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E2D514004F0
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 11:41:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7766221B7A;
 Tue,  7 Jun 2022 09:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654594900;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjpc/U7z8VZbEYPmpc1dmqHvRBIhBH95hsmHh2wkOyM=;
 b=3W10+G8F3eHZWlux56Ifa5wcpXR3UBU7JesBPqB/atOM3gbg+xFfHDXCfnJEPO1ilqEUnS
 9DE6ID/URSUrp4Aq3ChssAaiGV/rIuC64Qc7tASZDfArrwO9rnPuBSy2AMPCXFahbFsUE2
 HMBYwuy6Vhd7sMekLiMphyuOF/cFEr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654594900;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjpc/U7z8VZbEYPmpc1dmqHvRBIhBH95hsmHh2wkOyM=;
 b=PdZq8pY+vaBXEuSbflkL1ZB11C1+VzWvgsReZbZMLR/N5MnEP9GSYpZ50lcy5IdXQNavkn
 Cp1AEodf+g+CUvDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B6B213638;
 Tue,  7 Jun 2022 09:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hozqEFQdn2KWOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 07 Jun 2022 09:41:40 +0000
Date: Tue, 7 Jun 2022 11:41:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yp8dUum3uFxjNkbt@pevik>
References: <20220606100034.169493-1-liwang@redhat.com>
 <20220606100034.169493-3-liwang@redhat.com>
 <Yp5kCbzQQyMFnpdI@pevik>
 <CAEemH2er+xvO=Z52KjcAZVnd5QHOukj0xSTES2Q4n0+e32nKLA@mail.gmail.com>
 <Yp8aWeaGHDGxLHVZ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yp8aWeaGHDGxLHVZ@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] memfd_create03: make use of new .hugepages
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > > Very nice, thanks :). I guess move_pages12.c can also use .hugepages,
> > > right?


> > Hmm, I guess that is a bit different from using .hugepages, it needs
> > reserve page against each node. But our improvement only target for
> > test does not care about huge page from which nodes:).

> I guess that it would be probaly easier to add support for numa into the
> include/tst_numa.h library. But may not be worth of the effort as long
> as we have only one test of that kind.

Agree. Thanks both for your explanation.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
