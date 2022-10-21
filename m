Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2775C433FE
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 08:57:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6152F3CB228
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 10:57:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E42AD3C1351
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 10:57:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 07F83600F43
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 10:56:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 78EB71F8B4;
 Fri, 21 Oct 2022 08:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666342618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f8tMuxHSe4d/IHaSSZ9OpJx8uUsBCo4To5EopgEG4Rc=;
 b=bGPBbvyJH8AwJ1woz5Xin6i+Rlu1CsQ/8FBF2lC7UgAnpQ0Cy0APo4LuDDn1G8Q3y+9YF1
 mXYYsT5uJaxgGOie6aHWWL8I/LiBDfm2aeJmoLk23LGGdxmg+TgA8M1oXeOcTd3hywXrFc
 MyqGcXew0+2bytWYZB+Dp9ruyxgI4bA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666342618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f8tMuxHSe4d/IHaSSZ9OpJx8uUsBCo4To5EopgEG4Rc=;
 b=CNCvjuKNtjBcHEophIj2XEAmZ8OLdG4u45kwbFQbPc1Zr03mXnQUm8BC0HI48GAVMrnYmO
 77L1HQYgGEvH6SCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BFDA1331A;
 Fri, 21 Oct 2022 08:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VvVLFdpeUmMbZgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Oct 2022 08:56:58 +0000
Date: Fri, 21 Oct 2022 10:58:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y1JfP6TMo2BdMr5Y@yuki>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-2-tsahu@linux.ibm.com>
 <Y00g0NZYO8pVvC6M@yuki>
 <8ae7d26f5635cc858a657e78b0b806b576a98241.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8ae7d26f5635cc858a657e78b0b806b576a98241.camel@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 01/29] Hugetlb: Migrating libhugetlbfs
 brk_near_huge
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, ltp@lists.linux.it,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> -- skip
> > > +	p = SAFE_MMAP(hugemap_addr, hpage_size, PROT_READ|PROT_WRITE,
> > > +			MAP_PRIVATE|MAP_FIXED, fd, 0);
> > > +	if (p != hugemap_addr) {
> > > +		tst_res(TFAIL, "mmap() at unexpected address %p instead
> > > of %p\n", p,
> > > +		     hugemap_addr);
> > > +		goto fail;
> > 
> > Can we just do return here instead. The failure has been reported
> > there
> > is no point in calling tst_brk(TBROK, ...) as well.
> When we run one iteration only, tst_brk does not make sense, I agree.
> But if we are running more than one iteration (i >= 2), test
> should not continue to next iteration if the current iteration fails.
> Only way I could find is to use tst_brk(TBROK,... , as tst_brk(TFAIl...
> is deprecated.

I do not see why we should abort on first failure as long as it's not
unrecoverable error. The TBROK status is only for cases where something
went really wrong and we cannot continue.

> > > +static void cleanup(void)
> > > +{
> > > +	if (fd >= 0)
> > > +		SAFE_CLOSE(fd);
> > > +	umount2(Hopt, MNT_DETACH);
> > 
> > We whould umount here only if we actually have mounted something.
> umount only, will require explicit unmap when test fails or break.
> For
> that, all the local variable for address mapping will have to be
> static defined so that they can be accessed in cleanup() function.
> 
> I tried to avoid it by using umount2 which eventually umount when
> process unmaps all the mappings after it finishes.

That's not what I meant, as long as you pass Hopt on a commandline
the test shoud not attempt to umount it at all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
