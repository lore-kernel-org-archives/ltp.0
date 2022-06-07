Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D2AC433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 09:27:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81CB13C8F8E
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 11:27:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF7003C01AA
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 11:26:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6F25140017C
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 11:26:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1C111F9B7;
 Tue,  7 Jun 2022 09:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654594010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CkMTW2aF+jhJRPu96EBzx3OSfryMvyVxFELHSzk8syY=;
 b=dK7LZuwjohFAZ3EU64w5wZJwAY2NSkXvN94cKHkAXpi1DBoebO3aoKlvs+SvV+tYtJnobD
 M3TdTkWeHyYldZ8pL3/aFORtbWOFHzwWjTD2u5EhqtD4gdhKiciK72bU+77zHW2oH5zXkz
 dgEKCiol0ipbwIx6wxpmE8BQ+72Exv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654594010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CkMTW2aF+jhJRPu96EBzx3OSfryMvyVxFELHSzk8syY=;
 b=i6PbMk+yBNpp73hI+kPGCiD9eNRlNLLNNWNWlmEpsNRxRj6AcsFUrSP2UV96zPXqhhs3i0
 fJhTLyd5ccyennBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF91013638;
 Tue,  7 Jun 2022 09:26:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id t06/NdoZn2IEMwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 07 Jun 2022 09:26:50 +0000
Date: Tue, 7 Jun 2022 11:28:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yp8aWeaGHDGxLHVZ@yuki>
References: <20220606100034.169493-1-liwang@redhat.com>
 <20220606100034.169493-3-liwang@redhat.com>
 <Yp5kCbzQQyMFnpdI@pevik>
 <CAEemH2er+xvO=Z52KjcAZVnd5QHOukj0xSTES2Q4n0+e32nKLA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2er+xvO=Z52KjcAZVnd5QHOukj0xSTES2Q4n0+e32nKLA@mail.gmail.com>
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> >
> > Very nice, thanks :). I guess move_pages12.c can also use .hugepages,
> > right?
> >
> 
> Hmm, I guess that is a bit different from using .hugepages, it needs
> reserve page against each node. But our improvement only target for
> test does not care about huge page from which nodes:).

I guess that it would be probaly easier to add support for numa into the
include/tst_numa.h library. But may not be worth of the effort as long
as we have only one test of that kind.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
