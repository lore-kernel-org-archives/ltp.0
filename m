Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02298C433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 21:19:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E097B3CAE31
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 23:19:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41DF33CA962
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 23:19:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2B396100157D
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 23:19:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A37321958;
 Fri,  7 Oct 2022 21:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665177555;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DgcoAmgBSdiu1ucDqdJQ/3CSuDQeiARGa2J5RwPHiSQ=;
 b=g3KOLRdZepm5ylds3EC+ZgOHTKhSvlLPDyPQ8qw625E0PM8BgYaTh9GEK4+tFLYovgz7yx
 o1pw7byU/L6yd90Xv0Dbmv+gcoCiyqepYwKKFZIVh/IzsxfgLy/E7DKdqBrndSuhkLstdz
 AKz/x6f7NwJ0m4GZMOJiiyf2PVZnSN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665177555;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DgcoAmgBSdiu1ucDqdJQ/3CSuDQeiARGa2J5RwPHiSQ=;
 b=CcQwDVD+4mA2h91aP2g9U/BParD/VlSxBd2kkTXIwEIJt+WMfZWW09w0X8mr9cyoyK8NAI
 P9rV3lar5tXnmSDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBBF113A3D;
 Fri,  7 Oct 2022 21:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8c6AN9KXQGM+IgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 07 Oct 2022 21:19:14 +0000
Date: Fri, 7 Oct 2022 23:19:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y0CX0GXeXn1TNeWi@pevik>
References: <20221005131529.15930-1-mdoucha@suse.cz> <Yz5knc+5gFFoPgdh@pevik>
 <46677216-f912-545f-389c-a7f386ce7614@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46677216-f912-545f-389c-a7f386ce7614@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/creat09: Add reference to CVE 2021-4037
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

> On 06. 10. 22 7:16, Petr Vorel wrote:
> > How about this change:

> > diff --git runtest/cve runtest/cve
> > index 9ab6dc282..6ad3f51fb 100644
> > --- runtest/cve
> > +++ runtest/cve
> > @@ -55,7 +55,7 @@ cve-2018-1000001 realpath01
> >   cve-2018-1000199 ptrace08
> >   cve-2018-1000204 ioctl_sg01
> >   cve-2018-12896 timer_settime03
> > -cve-2018-13405 creat09
> > +cve-2018-13405-cve-2021-4037 creat09
> >   cve-2018-18445 bpf_prog04
> >   cve-2018-18559 bind06
> >   cve-2018-18955 userns08

> I don't think we need to complicate the runfile name like this. As long as
> the CVE reference gets printed on failure and can be found via grepping the
> sources, it's good enough.

You're right, the original CVE is probably enough.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
