Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639D9C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:47:08 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFF561178
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CFF561178
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9366F3C0924
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:47:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DB203C0574
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:46:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 57682602085
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:46:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6355121639;
 Tue,  9 Nov 2021 10:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636454814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0knAH02DD2R5S3x5NWJv0XmYLg3n6rBxNztgmIeE/wA=;
 b=HotP616ZG0DKthwY51p/TI9IkBWL9r8m6nrkLxGZX8O19ZsUKp6QdtG5J0Zd3HfTcMlaqg
 XV+JTgjayjA43FUOaVYuXdnAE8YH/Xap6vIw/3b1tZeNscQpPpeca3diZ4QVqs5wK3lbaO
 o8nN1H6WZbfbqQaCalLqT2VTjhg/I14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636454814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0knAH02DD2R5S3x5NWJv0XmYLg3n6rBxNztgmIeE/wA=;
 b=my5qXst3g7E93qNz9QTHBJLYHDZZC9x0jsKjWONsRYXBukWoUe/ZfVB3jXETep263QNVXq
 ZH2crMbMBTsyzUBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5230D13AF4;
 Tue,  9 Nov 2021 10:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1q/oEp5RimFPfQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 09 Nov 2021 10:46:54 +0000
Date: Tue, 9 Nov 2021 11:47:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YYpR201x6Ew7D9Zf@yuki>
References: <20211108021450.1460819-1-liwang@redhat.com>
 <20211108021450.1460819-3-liwang@redhat.com>
 <YYkbujntxMkANsG6@yuki>
 <CAEemH2cw=cSgoX=5-A_Q0_N4rhSBUYmqvWdtPEZoEngc1wZxsA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cw=cSgoX=5-A_Q0_N4rhSBUYmqvWdtPEZoEngc1wZxsA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] max_map_count: replace ifdefs by tst_arch
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
> > > +     switch (tst_arch.type) {
> > > +     case TST_X86:
> > > +     case TST_X86_64:
> > > +             /* On x86, there's an old compat vsyscall page */
> > > +             if (!strcmp(buf, "[vsyscall]"))
> > > +                     return true;
> > > +     break;
> > > +     case TST_IA64:
> > > +             /* On ia64, the vdso is not a proper mapping */
> > > +             if (!strcmp(buf, "[vdso]"))
> > > +                     return true;
> > > +     break;
> > > +     case TST_ARM:
> > > +             /* Skip it when run it in aarch64 */
> > > +             if ((!strcmp(un.machine, "aarch64"))
> > > +                             || (!strcmp(un.machine, "aarch64_be")))
> > > +                     return false;
> >
> >                 I wonder if this would be better as:
> >
> >                 if (tst_kernel_bits() == 64)
> >                         return false;
> >
> 
> Actually, we have TST_AARCH64 already, I'd go with switch to that.

That wouldn't work right? Since we are checking here if 32bit ARM binary
runs on 64bit AARCH64 kernel. The tst_arch defines for which
architecture the binary was build while the tst_kernel_bits() checks if
the kernel is 32bit or 64bit.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
