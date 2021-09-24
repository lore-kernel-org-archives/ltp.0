Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C046CC433EF
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 10:40:58 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3915460F70
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 10:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3915460F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E8393C8F29
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 12:40:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EA463C848C
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 12:40:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 908A6100142F
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 12:40:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC3B522427;
 Fri, 24 Sep 2021 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632480045;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1F/qGEgqwREzNL57qMLLRQYu6bbrn2H4P4m3+Hcq3RU=;
 b=ZsLoK0fqyd+1UPuruhmAhBuhyf413G+tdmqpX19v4+m1XTDfD7Ix8sEfcbYkLDfXCW8DXE
 KJ47/Wuw/kYeCHbaTjwmuYu9JEM0v1Ip48L9I5TFPS0X9R6Oi81lnLurj8soU5ui23rwNz
 95YquUn47r5wcaTK+T4BAyfYGuBwQE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632480045;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1F/qGEgqwREzNL57qMLLRQYu6bbrn2H4P4m3+Hcq3RU=;
 b=aQVnAcTZ7SdKwkSvnXZR5szQY238xnB+2eeIPc8whHEJ5p2kh8YqIb0+Yd3IotT2/c3LYk
 miZLCfu6HSmVH8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74A0913E14;
 Fri, 24 Sep 2021 10:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UBjrGC2rTWEEWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 24 Sep 2021 10:40:45 +0000
Date: Fri, 24 Sep 2021 12:40:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YU2rKkEib9F3yLJ7@pevik>
References: <20210924070756.3916953-1-liwang@redhat.com>
 <20210924070756.3916953-3-liwang@redhat.com>
 <YU2foq6v5PUBNUeD@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YU2foq6v5PUBNUeD@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] lib: unlimit the tmpfs size when test on
 small systems
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

Hi Cyril, Li,
> Hi!
> > Since commit c305a53c5 (lib: limit the size of tmpfs in LTP, Jul 9)
> > Ltp set tmpfs mount size according to the tdev.size. This cause a
> > new problem on small RAM system, which consume too much memory and
> > finally trigger OOM.

> > To fix this, let's cancel the tmpfs size limitation when MemAvailable
> > is less than twofold of tdev.size.

...
> > +	if ((tst_available_mem() / 1024) < (tdev.size * 2))
> > +		return mnt_data;

> I'm starting to think that we should do it the other way around, i.e.

> - unless the test defines .min_dev_size we should set the size for tmpfs to be really small 16MB or 32MB
> - if .min_dev_size is defined and there is not enough free memory -> TCONF
> - if .min_dev_size is not set and there is not even 64MB of free memory (for 32MB limit) -> TCONF

> I think that this is going to work because most of the tests does not
> actually consume more than a megabyte or so of the disk space for the
> actuall test, the only reason why we kept bumping the loop device size
> is that there are limits on minimal size imposed by filesystems.

Also LGTM, thanks Li for working on v2.

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
