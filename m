Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D96FC433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 14:28:53 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F7860F26
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 14:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61F7860F26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DFAD3CA24F
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 16:28:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8849E3C703D
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 16:28:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B0921400070
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 16:28:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A98B420204;
 Wed, 22 Sep 2021 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632320919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9204RwDYvNIr29x8TdjhjT0V8p25+/G/ScI2zNT57h8=;
 b=W7a24g7QCNrskTTB3WjMRUrKwvDq58CxAeTX4FCUQzbNiLcdZZeSCKOU4GhP242qmLg0yC
 4Kmv5HVd5DiNwnPDBNd++nqbvjUAt2u3gi49QglhGnKzrkwk1aZDs2XVAEd0pVBGLwiX4D
 D5y5CAgonvFsjgCyn3QX/6DKnW6jWp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632320919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9204RwDYvNIr29x8TdjhjT0V8p25+/G/ScI2zNT57h8=;
 b=hGnGdq6ZGfqSdhpUiJZdpO7+LkKsTUAy/st1BnhyUSqjxK3MESKW01scl9ob7dONAOWLmK
 e2BvNgLgpEnHI6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9648B13D85;
 Wed, 22 Sep 2021 14:28:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PmksI5c9S2FpZgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 22 Sep 2021 14:28:39 +0000
Date: Wed, 22 Sep 2021 16:29:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwan@redhat.com>
Message-ID: <YUs9tz0wjk2LJiAL@yuki>
References: <8b4c1fad2914aee00c8a160d1f9e482574b8e5ae.1632242721.git.jstancek@redhat.com>
 <CAEemH2dQ7NyWSoSwEcyeug6phJKja5=affWzWxt0fQLvHrtODw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dQ7NyWSoSwEcyeug6phJKja5=affWzWxt0fQLvHrtODw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugeshmat04: don't attach at specific address
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
> > The test intermittently fails on ppc64le, when heap
> > happens to overlap with segment that the test is trying
> > to attach at 1GB boundary.
> >
> > Let the kernel find suitable address.
> >
> 
> I'm not sure why the original way uses fixed address, but
> it should be fine to cancel that limitation.

It seems to be regression test for:

commit c5c99429fa57dcf6e05203ebe3676db1ec646793
Author: Larry Woodman <lwoodman@redhat.com>
Date:   Thu Jan 24 05:49:25 2008 -0800

    fix hugepages leak due to pagetable page sharing

    The shared page table code for hugetlb memory on x86 and x86_64
    is causing a leak.  When a user of hugepages exits using this code
    the system leaks some of the hugepages.

    -------------------------------------------------------
    Part of /proc/meminfo just before database startup:
    HugePages_Total:  5500
    HugePages_Free:   5500
    HugePages_Rsvd:      0
    Hugepagesize:     2048 kB

    Just before shutdown:
    HugePages_Total:  5500
    HugePages_Free:   4475
    HugePages_Rsvd:      0
    Hugepagesize:     2048 kB

    After shutdown:
    HugePages_Total:  5500
    HugePages_Free:   4988
    HugePages_Rsvd:
    0 Hugepagesize:     2048 kB
    ----------------------------------------------------------

    The problem occurs durring a fork, in copy_hugetlb_page_range().  It
    locates the dst_pte using huge_pte_alloc().  Since huge_pte_alloc() calls
    huge_pmd_share() it will share the pmd page if can, yet the main loop in
    copy_hugetlb_page_range() does a get_page() on every hugepage.  This is a
    violation of the shared hugepmd pagetable protocol and creates additional
    referenced to the hugepages causing a leak when the unmap of the VMA
    occurs.  We can skip the entire replication of the ptes when the hugepage
    pagetables are shared.  The attached patch skips copying the ptes and the
    get_page() calls if the hugetlbpage pagetable is shared.


As far as I can tell there is no reason to allocate the memory on a
fixed address to trigger this bug but it should be easy enough to check
if the test fails on a kernel that has the two lines this patch adds
commented before and after the change it test.

Also can we pretty please add the commit hash to the test metadata?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
