Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0573C4332F
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 13:12:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C96C03CC8DD
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 14:12:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A08183C99B0
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 14:11:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 04910608A7E
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 14:11:49 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3868A219C3;
 Thu,  2 Nov 2023 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698930709;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WqKi+8YEt010l24uIgan4M8+amf8pi/2aye7mqMzYL0=;
 b=m2HjGxezQ3wknVU0twHOt8uC9xqfWiPC3hz81Ee1QUX6MlbqurG+96IzLR8P7TjMzheam+
 7PEBmewz4KkhD+AKes/xPytsrJUlT553UYH++QUT1wsQaALIprpWoagon7EkMD8VmDjlT0
 6ShQSO+wJdCMNjLmkS8JG7YCC+up4qA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698930709;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WqKi+8YEt010l24uIgan4M8+amf8pi/2aye7mqMzYL0=;
 b=fNcyuHbsovq53h/KxiVKVSBEi5OVkMPraMev/N6YyK8nk6+ojjqtsRh+e7/QDwzyD0MoS6
 G+r2djFGYEq8hXCw==
Received: from g78 (rpalethorpe.udp.ovpn2.prg.suse.de [10.100.204.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A745D2C4B8;
 Thu,  2 Nov 2023 13:11:48 +0000 (UTC)
References: <20230907150538.16772-1-andrea.cervesato@suse.de>
 <ZUJydZgdGTcPQAxt@yuki>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 02 Nov 2023 12:56:33 +0000
Organization: Linux Private Site
In-reply-to: <ZUJydZgdGTcPQAxt@yuki>
Message-ID: <87edh8s3jf.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor fork09 using new LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> Honestly I'm struggling to understand the point of this test, the
> description says:
>
> "Check that child has access to a full set of files"
>
> What is that supposed to mean? I guess that if we wanted to check that
> the child has inherited the file descriptors ee should open a few files,
> do some changes in the child/parent and check that they are not propagated to
> the other one. I.e. reading from a file in child/parent does not change
> file offset in parent. Closing a file descriptor from a child/parent
> does not close the file in the other one, etc.

This is what the fork10 rewrite does unless I am mistaken? So possibly
they can be combined.

fork12's description sugggests it does the same thing, but thhe test
just seems to test forking until a resource limit is hit. This overlaps
other tests and can probably be deleted.

>
> Also why do we use fopen() instead of just open()?
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
