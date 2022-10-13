Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44076C433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 22:27:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E7103CAF25
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 00:27:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DDC23CA91F
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 00:26:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A0679601A86
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 00:26:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB2BC2258B;
 Thu, 13 Oct 2022 22:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665700016;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4t1xbpqKegZAGIcr4Oh1lvlHFPH3CRNt/tPEbiq++7g=;
 b=W8WhkU/c4DWuJ5MgYsfvxPab1SVQhcXItdY1kAtVLpNKVJJp65E68hV20gdkdZGUipjyi5
 U2qVvtm+pcQNTl/l53dTTAXMPrnKbYEZQ+mUsf36THIb1DItZoYIvH2KrHHANRj4G5ZZFR
 DwR5TUAXcCxv1RD8sRyfnYoIrgSLaq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665700016;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4t1xbpqKegZAGIcr4Oh1lvlHFPH3CRNt/tPEbiq++7g=;
 b=pYNPuvvV+raCHAS29vIosT4eCRzwdDIbZf/TB9LL9ZLVgWCcviE2jVhM2TJehtS/44YWFo
 EgOVdEOzHfMK8GBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA58C13AAA;
 Thu, 13 Oct 2022 22:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 45IgLLCQSGNeZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Oct 2022 22:26:56 +0000
Date: Fri, 14 Oct 2022 00:26:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <Y0iQr4eSi4aLACOf@pevik>
References: <56be207009104d16b9c49624db3c6f32@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56be207009104d16b9c49624db3c6f32@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] needs_root: Add setting of needs_root
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,


> > > Hi Petr,

> > > It is failed on my system:

> > > sh-4.4$ ./msgget03
> > > tst_test.c:1535: TINFO: Timeout per run is 0h 00m 30s
> > > msgget03.c:42: TINFO: Current environment 0 message queues are
> > already
> > > in use
> > > msgget03.c:45: TBROK: Failed to open FILE '/proc/sys/kernel/msgmni'
> > > for writing: EACCES (13)

> > Ah, b740bfac5 ("msgget03: Set custom queue limit") causes the need for
> > root. IMHO this one is valid.

> > I'd suggest to remove needs_root for needs_device and mount_device
> > now (i.e. send v2).

> Just remove the patch 1 and keep adding needs_root in patch 2?

If you haven't added it to any test which would have needs_device or
mount_device, then v2 can be kept.

But process_vm_readv02 works for me (on master, on Debian) without root:

$ ./process_vm_readv02
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
process_vm_readv02.c:32: TINFO: child 0: memory allocated and initialized
process_vm_readv02.c:49: TINFO: child 1: reading string from same memory location
process_vm_readv02.c:61: TPASS: expected string received

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0

Also process_vm_readv03, process_vm_writev02 (I stopped checking now).

Why you need it?

Kind regards,
Petr


> > nit: FYI most of the people use bottom posting on mailing lists, you use top
> > posting. Combine both makes it hard to follow.

> > https://en.wikipedia.org/wiki/Posting_style

> Thanks for your reminder, I will reply to emails according to the posting_style.

Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
