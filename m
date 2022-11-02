Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7269FC4332F
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 07:52:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36A683CAD0D
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 08:52:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26CCB3CA8A4
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 08:52:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4E4611A00925
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 08:52:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C4CD33968;
 Wed,  2 Nov 2022 07:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667375561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GwLFUTSz7a1rT+Vp98IPaK0jtCSH0RlNIa3YitBi9Y=;
 b=sLJFgU5Qck70eDrLwAquoPcqFTXZVnPi1nXG1XJ3RpjbCYAm8BdV5g0FEj/3mHVQyya+IV
 z4j8Sy8q4LlYrBylyqTXuHhaR+7Dhzv5evEcFRuySdtV8OKmu/7gHYeQnDHN++5ik4sIJ0
 /0tV9LX95A6UypuNE6DWLKY0X6Nkzls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667375561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GwLFUTSz7a1rT+Vp98IPaK0jtCSH0RlNIa3YitBi9Y=;
 b=2cYVHp1+2bA2DytHfZINu1ytOzndGppHuZ/jOc1H//ltjvq5VibHIJXJcZVKAYzHR+ioAh
 WonXfs7sDG80bhDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AE801376E;
 Wed,  2 Nov 2022 07:52:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bGODMschYmNQdQAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 02 Nov 2022 07:52:39 +0000
From: Avinesh Kumar <akumar@suse.de>
To: rpalethorpe@suse.de
Date: Wed, 02 Nov 2022 13:22:37 +0530
Message-ID: <4268642.s8uzx1A9P8@localhost>
Organization: SUSE
In-Reply-To: <87tu3j9h64.fsf@suse.de>
References: <20221027140954.4094-1-akumar@suse.de> <Y2BA6UBSrVQS6HiI@pevik>
 <87tu3j9h64.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: using -1 as invalid fsuid for
 setfsuid()
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

Hi Richie,

On Tuesday, November 1, 2022 2:33:00 PM IST Richard Palethorpe wrote:
> Hello,
> 
> Petr Vorel <pvorel@suse.cz> writes:
> 
> >> Hello,
> >
> >> Avinesh Kumar <akumar@suse.de> writes:
> >
> >> > a uid which does not have an entry in the /etc/passwd
> >> > file is not really an invalid fsuid for setfsuid(), so changing
> >> > the test to use -1 as an invalid fsuid.
> >> > And second setfsuid(-1) call is to verify that preceding call has
> >> > actually failed and there is no change in the fsuid.
> >
> >> I think the original test is flawed and testing what using -1 does is
> >> not very interesting as the kernel uses standard boilerplate to deal
> >> with this.
> >
> >> AFAICT we don't test what happens if a non-root user tries to set the
> >> fsuid to a uid that is not the euid, ruid or saved uid or 0/-1.

> >
> >> Possibly that is something for a new test though.
I'll post a new patch for this. Thank you for the suggestion.

> >
> > Ah, sorry, I overlooked this, merged now.
> 
> No problem, I think that is the correct thing to do. I'll leave it to
> Avinesh or someone else to extend the test (or not).
> 
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
