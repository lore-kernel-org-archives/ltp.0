Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464E0C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 12:34:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C40E3CC8C7
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 13:34:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80A433CC89D
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:34:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B1588140013F
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:34:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E8492189A;
 Fri, 25 Nov 2022 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669379686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5G3Puj8o9Ffe0xOmbXriBHOJuRCFjCaZM/h2OVOvZw=;
 b=if6I1HVhPFMyDKq/oo9oeVYEoF1dU890iQpYZGLP9Tl+B40i12JSBi5FK06w7Nhx5s5eKE
 SQ0GeKmvR75C+lD+gkjNudaUJFMAKSl6UU1DFzkTC8fKAIUOoNL/yn0Vcyxb2PoYSheqNw
 waiBzZyn9m8jr8VNjPZtcYFJW1gsp1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669379686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5G3Puj8o9Ffe0xOmbXriBHOJuRCFjCaZM/h2OVOvZw=;
 b=G2AEIYlDHvdMh8O+vJ78rgkI0NguU3RMXXHjwPp9jwYsvNZ1Du3yEn8EpbIG/bzCac5lbI
 /erZLXQryyoXhOCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F59B13A08;
 Fri, 25 Nov 2022 12:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XR3HFWa2gGNTMAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Nov 2022 12:34:46 +0000
Date: Fri, 25 Nov 2022 13:34:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: David Hildenbrand <david@redhat.com>
Message-ID: <Y4C2ZF1C95FKH1NQ@pevik>
References: <20221125105201.59048-1-david@redhat.com> <Y4CjI7S/MHnQa7ex@pevik>
 <6184eaf7-aee4-669c-aa20-0485c1474e47@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6184eaf7-aee4-669c-aa20-0485c1474e47@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] security/dirtyc0w_shmem: Fix remaining cases
 where UFFD_FEATURE_MINOR_SHMEM is absent
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

> On 25.11.22 12:12, Petr Vorel wrote:
> > Hi David,

> > > When UFFD_FEATURE_MINOR_SHMEM is not defined, we still have to make the
> > > checkpoint happy, otherwise our parent process will run into a timeout.
> > > Further, we have to test if UFFD_FEATURE_MINOR_SHMEM is really returned by
> > > the UFFD_API ioctl: if the kernel knows about the feature but doesn't
> > > support it, it will be masked off.

> > > Reported-by: Martin Doucha <mdoucha@suse.cz>
> > > Cc: Petr Vorel <pvorel@suse.cz>
> > > Cc: Cyril Hrubis <chrubis@suse.cz>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >   .../dirtyc0w_shmem/dirtyc0w_shmem_child.c        | 16 ++++++++++++----
> > >   1 file changed, 12 insertions(+), 4 deletions(-)

> > > diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> > > index cb2e9df0c..c117c6f39 100644
> > > --- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> > > +++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> > > @@ -24,12 +24,12 @@
> > >   #include <linux/userfaultfd.h>
> > >   #endif

> > > -#ifdef UFFD_FEATURE_MINOR_SHMEM
> > Shouldn't be the check and TST_TEST_TCONF() actually be in dirtyc0w_shmem.c?
> > I overlooked that, but IMHO test does not make sense at all if
> > UFFD_FEATURE_MINOR_SHMEM not defined, right?

> > Also Martin noted that ("The parent process should not even fork() when
> > UFFD_FEATURE_MINOR_SHMEM is not defined in config.h.").


> I tried that first, but then we can still run into the runtime absence of
> UFFD_FEATURE_MINOR_SHMEM. Checking that also in the parent resulted in some
> IMHO unpleasant code while I worked on that.

> This is certainly the easiest approach, because we still have to make the
> child program compile either way.

Right, it needs to be in child. Using TST_TEST_TCONF() also in master does not
look to me as too unpleasant code, but take it just a suggestion. Obviously the
only requirement is code compiles and works on both defined and undefined
UFFD_FEATURE_MINOR_SHMEM.

> Anyhow, I'll do whatever you decide, because I want to cross this off my
> list. So any guidance on how to complete this would be appreciated.

Understand.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
