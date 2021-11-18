Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A59CC433EF
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 11:41:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE84A610FB
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 11:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE84A610FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B2363C8915
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 12:41:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D3DB3C08C9
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 12:41:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DB3316010B4
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 12:41:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0DE1F2177B;
 Thu, 18 Nov 2021 11:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637235684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yuolOSp9iFI7Q6IqwEufRD8zxhFeRZg8TpgZM/2grEQ=;
 b=mNr5WlkiELO6KFzQH7n40YbU2rKi8MSx9nH8lKVWgrdVMVzZkj3ASFQTHGUDscqAHQkNkF
 Sr4yLSK4YWDV5c7/pSqHRPL/vbTKBISQgoQB7jIYAzNkAEaopva3qsEXtTciBXFsL4e+wk
 uKcNBKk4Dl/UjYmgLSN2VX7obuT4dY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637235684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yuolOSp9iFI7Q6IqwEufRD8zxhFeRZg8TpgZM/2grEQ=;
 b=dIrzzbGY2ZY8Jqu2nruIWk1f+mutbyKnTVh+VifZa3Xp99hA4oLBrnIt2+wl/p0UWqSqUl
 30hl0/ectqKMwvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E26C913D00;
 Thu, 18 Nov 2021 11:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v6NuNuM7lmGkMAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 18 Nov 2021 11:41:23 +0000
Date: Thu, 18 Nov 2021 12:42:29 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YZY8JQlE2EEVEIKX@yuki>
References: <20211117070708.2174932-1-liwang@redhat.com>
 <87zgq39j2b.fsf@suse.de>
 <CAEemH2cYn6XmsL+5m20aiadUrqWDwoE_+KQ5pm5rT5p34-Omug@mail.gmail.com>
 <87mtm2amkd.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mtm2amkd.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: adding .supported_archs field in
 tst_test structure
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
> >  These are not valid arch names AFAICT. There is no mapping from these to
> >  x86 in the tst_arch table above.
> >
> >  Perhaps we could replace them all with x86?
> >
> > Yes, that is also the unsure part I was concerned about in patch v4. 
> > Because x86 is also an invalid arch (it is just a conventional name),
> > if we use it in the arch_type_list we have to recognize it as a valid arch
> > name in test case as well. I'm not sure that will be accepted by other
> > people.
> 
> The folder in the kernel tree is arch/x86.

The x86 is basically a wildcard where the x could be substitued with any
of {3,4,5,6,7}. Also I think that 786 was last 32bit intel arch ever
released.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
