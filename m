Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE79C0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 21:26:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 134313CF903
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 23:26:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B1D53CEC45
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 23:26:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D7B2F20004A
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 23:26:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 64FE41F895;
 Wed, 25 Oct 2023 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698269200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TcMRwltpjHXDccJs1KOu6W1oonp9sbET1jJpkaT5a0Y=;
 b=Rgad+/G3H9cXhMMmddz4TrezZ89iCiOM/VQ+cuk1Z/+tGA9ZZtFzManZklroZG7DoqvHz6
 nfrPDvnSiklLvKUXc58yY/Pc2Id2wZA9rEuScnsv3ouChTOX945WaBivAjGilx7wAg9yLk
 4ocqk8GesA/zSyeD7YEfl1VcZLaUx7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698269200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TcMRwltpjHXDccJs1KOu6W1oonp9sbET1jJpkaT5a0Y=;
 b=jBeMu8Z7ppUe8YBOAuUu5HcwulzdMcI4mZuNuCKlJvHqDI3kKIacNRv0ZsYENoddQsoprM
 2VehyaIiGd36q+Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E6BF138E9;
 Wed, 25 Oct 2023 21:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2h8CDhCIOWVtMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 21:26:40 +0000
Date: Wed, 25 Oct 2023 23:26:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <20231025212638.GA477570@pevik>
References: <20231025110835.28832-1-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231025110835.28832-1-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 0/4] Improve ioctl02.c
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

Hi Marius,

> I implemented again the changes requested for the first and last
> patch.

+1

> That means I removed quite a few comments; I totally agree that
> this code was over-commented. I kept a few comments (mainly in the
> prepare function for the struct) because some struct members are
> over-abbreviated (e.g. `c_cc`) so the comments actually do help
> understanding the code. Some comments were also stating the
> intention of the code which also seemed not completely useless.

+1

> I dropped the intermediate patch to use just termios.

I don't know why, but that was for sure discussed in some previous versions.
Or do you want to get back to it after this effort gets merged?

> In the last patch I decided to use the double-assignment
> suggestion after all because the fields in termios are consistently
> wider than the fields in termio so when just swapping the
> assignment order this should be fine (there can never be a lossy
> conversion). I also decided to make the loop a macro as well
> because at this point we might as well go all-in with the macros.

We usually prefer functions, which are more readable. But I'll comment that more
at the 4th patch.

> Btw, you're sure you don't want to give C++ a try at some point :-)
> (Just mentioning this because I really would have liked using C++
> templates in this case and with C++ you can really pick what you
> like and keep everything else in the usual C-style.)

I don't think either C++ templates for LTP would be a good idea.
The code is very simple to include any templating system.
Also testing (g)libc headers should be IMHO done with plain C.

Kind regards,
Petr

> Marius Kittler (4):
>   Refactor ioctl02.c to use the new test API
>   Make checks for termio flags more strict
>   Remove disabled code in ioctl02.c
>   Extend ioctl02 to test termio and termios

>  testcases/kernel/syscalls/ioctl/ioctl02.c | 551 +++++++---------------
>  1 file changed, 171 insertions(+), 380 deletions(-)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
