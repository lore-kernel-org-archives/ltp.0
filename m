Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A942C6FD1D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 13:12:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D4E43CD49E
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 14:12:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DF493CACA3
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 14:11:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A29D1600C44
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 14:11:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8D14521995;
 Wed, 15 Mar 2023 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678885909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJePJEk8/kldbOOYa966vni0KNGe21pl0gbPDqQT6uQ=;
 b=sLl1mY5D17he3tqck1+88L8mYQ1a7lMpVEqlovJ1tJxVKni7v2H0TpbZCGNRwy3CPUWcb7
 Wt2oaGKx4JVa5cdO7AVM87u2nGv9TRDRPKnX0FHdy41JVArVVwHfeF7qHPHAa6tT5XBAJI
 Sp2GthnUOsGE04BjoafThvjBkKhPIec=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3F0013A00;
 Wed, 15 Mar 2023 13:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qH5tJRTEEWQUIQAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 15 Mar 2023 13:11:48 +0000
Date: Wed, 15 Mar 2023 09:11:46 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230315131146.GD10248@localhost>
References: <20230120010533.11202-1-wegao@suse.com>
 <20230302071555.18420-1-wegao@suse.com>
 <20230302071555.18420-2-wegao@suse.com>
 <20230315123119.GA164307@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230315123119.GA164307@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] Move semaphore/ tests to semop/
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Mar 15, 2023 at 01:31:19PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> > There is no point in having two different directories with semop()
> > testcaes so it would make sense to move these two tests into the
> > syscalls/ipc/semop/ directory as semop04 and semop05.
> > So we move ipc/semaphore/ tests to syscalls/ipc/semop/.
> > Also update runtest files accordingly.
> 
> As I already stated, I'm not really sure this is good to do, but maybe I'm
> missing something.  I wonder what others thing about it.
> 
Ah, you also start work on this?  Should i still continue work on this patch or not?
To me this is not bad thing at least, we do some clean work and reorganize the test cases.
> ...
> >  rename testcases/kernel/{ipc/semaphore/sem01.c => syscalls/ipc/semop/semop04.c} (100%)
> >  rename testcases/kernel/{ipc/semaphore/sem02.c => syscalls/ipc/semop/semop05.c} (100%)
> 
> > +++ b/runtest/syscalls
> > @@ -1239,6 +1239,8 @@ semget06 semget06
> >  semop01 semop01
> >  semop02 semop02
> >  semop03 semop03
> > +semop04 semop04
> > +semop05 semop05
> You renamed files, you need to remove sem01 sem02 from runtest/ipc.
Ack!
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
