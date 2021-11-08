Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F615C433F5
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 10:11:03 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA7761179
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 10:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FA7761179
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B84C3C773C
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 11:10:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B74903C2435
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 11:10:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BB13514012A6
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 11:10:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12B0221AFC;
 Mon,  8 Nov 2021 10:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636366247;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FlDVkfUrclmUdojKog6aPIYRdtIIHNY0NNTAKYkMi00=;
 b=Z1SpJqGiuqisPT5gjnp84T4XdhLWytJzuH7nmiQfPk2rZGxkCO/8Y9S8R1CykLkO05f4Rb
 IsVydV7hf3dIdDhQBtQZHsqCZaM/F7XrhSPeMKJJSlXXooYDAkpbUQUW3v/O/nPAKPkgtf
 ogTUfcTZ1j/K3kAH5uCrYTf1ELjchNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636366247;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FlDVkfUrclmUdojKog6aPIYRdtIIHNY0NNTAKYkMi00=;
 b=xhzUYWyDCSsmJkx9PXnEb3y42DXGJaPPQJroJ7cmXv5bkb0gNiHiCSy2d+JP1NiQ2dCpYV
 wPyNtMtvUPHYTABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D810A13B2C;
 Mon,  8 Nov 2021 10:10:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YVkWM6b3iGHoEgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Nov 2021 10:10:46 +0000
Date: Mon, 8 Nov 2021 11:10:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YYj3pdugWJExKOt+@pevik>
References: <20211105143125.7858-1-pvorel@suse.cz>
 <YYjmO4H3Dsa3oDt/@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYjmO4H3Dsa3oDt/@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] CI: Remove Tumbleweed
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

> Hi!
> > Tumbleweed suffers with common timeouts during installing packages.

> > https://github.com/linux-test-project/ltp/runs/4102121237?check_suite_focus=true
> > 2021-11-04T07:12:04.5788989Z (110/114) Installing: pcre2-devel-10.38-1.1.x86_64 [.........done]
> > 2021-11-04T13:10:22.9205133Z (111/114) Installing: clang13-13.0.0-1.2.x86_64 [.
> > 2021-11-04T13:10:22.9326559Z ##[error]The operation was canceled.
> > 2021-11-04T13:10:22.9383287Z Stop and remove container: 3dab012d9d14480da05fc921cd0c0124_opensusetumbleweed_b0089d

> > While keeping restarting after some time usually helps, it's not useful
> > to have CI with false positives thus removed until problem gets
> > permanently fixed. But keep seccomp workaround introduced in 0aa9ebd30
> > for other distros with newest glibc.

> Thinking about it it tumbleweed may not be suited for CI, quite possibly
> new packages gets uploaded to the repository during our CI build which
> would explain these kind of failures.
I reverted Tumbleweed. Yes, probably some kind of out-of-sync repositories. I'm
investigating the issue. I'd have to be convinced it's working (+ testing in my
repo for some time) to try to investigate it again.

There was also problem with Leap repositories, but that's being fixed,
thus I restart jobs.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
