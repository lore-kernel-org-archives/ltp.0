Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C39ECA0FE6
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 12:27:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1C1A3CBE90
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 14:27:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D003E3CBBDE
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:27:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 42EEB1400966
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:27:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED2F31F45F;
 Fri,  1 Sep 2023 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693571248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dds3CyP6S/3uUrCSq1ISqVelu9nYmurnkC/wpldCKtk=;
 b=2Kcc715jyS9kjxjVCCXT5gxh8Y1/d837peQ60hQLxNkdVfsvlARSrWavnSdJsHLOUvDzKB
 3ByK/wbhVzkhFGyOq6jEhksx8afjALH9coQxWCEfOScEzDCbjp807PSiZXYpdldtpNTzBC
 7f7/LQH1Su7lMzhYLgH6eGHiAYyXcm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693571248;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dds3CyP6S/3uUrCSq1ISqVelu9nYmurnkC/wpldCKtk=;
 b=e/8A+bDz9HcYq1tgVn3kk31AxFFkEP6FycW9aDJretebp8pI6ktC9iPATTSKfEsSJ8BoAp
 Pa1itaSo/gawefCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA3941358B;
 Fri,  1 Sep 2023 12:27:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Wnn3M7DY8WQvIwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 01 Sep 2023 12:27:28 +0000
Date: Fri, 1 Sep 2023 14:28:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZPHY1CtYogkqUHzQ@yuki>
References: <20230818112023.18159-1-akumar@suse.de>
 <20230818112023.18159-4-akumar@suse.de> <ZO3CghC11RzXJjuq@rei>
 <2556714.ltBL1Nq8q0@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2556714.ltBL1Nq8q0@localhost>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] syscalls/mmap04: Rewrite the test using new
 LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > This is nearly identical to the mmap02.c and the same comments apply
> > here.
> > 
> > Also the test does not check the PROT_EXEC part at all. If we wanted to
> > properly test PROT_EXEC we would have to copy a function code to the
> > file first then execute it, something that mprotect04 does, but since
> > that flag is already tested in mprotect04 it does not make that much
> > sense to have it here as well.
> 
> Yes, I agree this test does not cover PROT_EXEC scenario. So, if this case is 
> covered in mprotect04, do you recommend dropping this test altogether from 
> here?

Testing that the flag is accepted by mmap() and mmap succeeds is
actually enough of test, that validates that the flag parsing in
sys_mmap() function in kernel works fine.

One option how to make the test more interesting would be to:

1) create mappings with different PROT_* flags
2) parse /proc/self/maps and check that the flags match what is there

That way we would validate that all valid flag combination are parsed
fine and printed correctly in /proc/self/maps.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
