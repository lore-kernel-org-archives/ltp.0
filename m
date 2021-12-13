Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14098C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 09:04:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5D7D3C8B38
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 10:04:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56BB43C136F
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 10:04:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E54D600B42
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 10:04:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 693D2212B5;
 Mon, 13 Dec 2021 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639386271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qBblgaWgtLUn6gUfSyKbH027j5r7gNzqjN4UhQFb2I0=;
 b=kpmb818yicuCK3zGZ+WULzEjfnHQF6ZWb8tbdm7rtivcmAvqVBOauZX7lJ+XxN1i40ISOC
 PsykFiTm8/UKmUqO1bdo/sHI3ocArJEy2VjJcJavoFfTpOOE1PActjwU9+fPIcPNuJMOUL
 k2k4uV7FIBctlCWNRKNgPx6uW1Tez7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639386271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qBblgaWgtLUn6gUfSyKbH027j5r7gNzqjN4UhQFb2I0=;
 b=oOZ6d9RUBHKOYPtlVAB3JImlJ16PWlnj7YIOTmYuRfi/qeQwBjMm18QWsrJcvbAR0VHqTb
 m3rCuXuHB1I8uyBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5615613B51;
 Mon, 13 Dec 2021 09:04:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 552JE58Mt2GKGAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 13 Dec 2021 09:04:31 +0000
Date: Mon, 13 Dec 2021 10:05:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YbcM8xKx7G0KQxWU@yuki>
References: <20211210134556.26091-1-pvorel@suse.cz>
 <87tufcao8l.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87tufcao8l.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/maintainer: Add policy for new
 functionality
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
> > +* Tests for new functionality in mainline kernel should be merged after final
> > +  release of kernel which contains that functionality (it's not enough when the
> > +  feature gets into rc1, because it can be reverted in later rc if
> > problematic).
> 
> What is the concern? All I can see is that we merge a test which is for
> a feature that is never included

Not only that, the interface may change subtly.

> The issue is we may forget to merge patch sets for features which are
> included (a far worse result). It's more stuff waiting around in the
> queue. At the least we should have a procedure for tracking them (like
> tagging github issues for review at each mainline release).
> 
> If a test requires a kernel config which doesn't exist in mainline we
> could also look for that automatically.

The main issue is that if we happen to release LTP meanwhile with a test
for a syscall that didn't get included in the mainline in the end we
have released LTP that is supposed to be stable and the test will start
to fail when the syscall number is allocated for something else which
will happen sooner or later.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
