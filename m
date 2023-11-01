Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35228C4332F
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 10:12:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26BD53CE9BC
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 11:12:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6CF13C8919
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 11:12:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2DD686009F0
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 11:12:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1586A1F74D;
 Wed,  1 Nov 2023 10:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698833522;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CnG4XsQDy98b2d09HoP650LzuLZGOJ3A4A2+qrtQ9SE=;
 b=qCei7xjvrmnyQ2QgwPnVmVj48FZISxvxOB2oSoTvj+X+d42te5YKUVVaLQSBalY9GvRh2k
 L9bAmXV1l3vGV6ikOES8mz0URbkw5rKp68/bAdodGHRpvcroVnHTnDLYnQ+zf4fnHklLX4
 wqbZ20fnn1hA8tBJ2WvhHu6D2HiU8RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698833522;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CnG4XsQDy98b2d09HoP650LzuLZGOJ3A4A2+qrtQ9SE=;
 b=nm1peVE5ziexeNtR5j+egRQEJbjtE1+FgjmkfHQyrByDi9wSjzfJqsVzr2127uJc3R9LMw
 kMc9DiFJEhjpPyBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C44581348D;
 Wed,  1 Nov 2023 10:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xKc2LnEkQmUEGgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 01 Nov 2023 10:12:01 +0000
Date: Wed, 1 Nov 2023 11:12:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20231101101200.GB884786@pevik>
References: <875y33vsks.fsf@suse.de> <87lebpu02a.fsf@suse.de>
 <87msvxst71.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87msvxst71.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 1st of November 09:00 UTC
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
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hello,

> Thanks to everyone who attended the meeting. Some outcomes:
Also thanks to all attenders.

> 1. There were audio and connection issues with Jitsi, we should try
>    something else next time

Could anybody test if meet from google works for him?
https://meet.google.com/udc-ncrs-wxx

Kind regards,
Petr

> 2. We'll make best efforts to chase reviewers for their tags, but we
>    don't have a better solution for tracking contributions to review.

> 3. I'll be more aggressive in adding changes requested. Most of the
>    responsibility is with contributors to remember to resubmit their own
>    patches.

> 4. Petr vorel will move patchwork instances. We accept there will be
>    issues caused by the changeover.

> 5. 30 minutes is good meeting time (IMO 15-30 minutes is fine)

> 6. We shall write down an agenda next time

> Richard Palethorpe <rpalethorpe@suse.de> writes:

> > Hello,

> > After reviewing the responses to the RFC I have come up with the
> > following meeting details.

> > Time and date: First Wednesday each month at 09:00 UTC.
> > Platform: https://meet.jit.si/linux-test-project

> > The first meeting will be on the 1st of November at 09:00 UTC.

> > I haven't tried to address the lack of chat brought up by Li. I suggest
> > trying Jitsi and if there are issues then we go from there.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
