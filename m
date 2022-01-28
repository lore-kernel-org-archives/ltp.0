Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBDFC433FE
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 12:32:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C31743C9760
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 13:32:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DE813C973F
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 13:32:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 76E911000BE3
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 13:32:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9CB0B21100;
 Fri, 28 Jan 2022 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643373149;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MiyQUmQ6ENlHBMwCuzZtIOfiNcLHf/yrFjj3ssODNYs=;
 b=eeDUS+lsmJrOnOlE5qHLWsCjFC2xDc4jNZCdOSfWwRIAZLnFvCezuk9wr8XTAIcIUM+lr2
 MBfc3fSdjhA1cxpotFoXbwlQp7lZkUyP3zQY1v9LISKqs7vgyzEtESCGG/Wcgol5FgijB9
 bP1v+0ojweu7CCZMAImpI4jaVHSmOh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643373149;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MiyQUmQ6ENlHBMwCuzZtIOfiNcLHf/yrFjj3ssODNYs=;
 b=HtB/tAiEE53QjJaGWMbX0apToM/JVW8H69oOk2VSGYoWUZs/IYxi61sbAaLfbXtej+wuGb
 C5OrVu0yDmCP7RAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 600D213A9F;
 Fri, 28 Jan 2022 12:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id COpGFV3i82HVXgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Jan 2022 12:32:29 +0000
Date: Fri, 28 Jan 2022 13:32:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>,
	Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YfPiW998P4/j7RWi@pevik>
References: <20211220180748.36A90A3B8E@relay2.suse.de>
 <20211221113042.21357-1-rpalethorpe@suse.com>
 <YdW/0BUm+vBY3PHy@yuki> <YdXAhgvstNcDz7WY@yuki>
 <87ilus0zwo.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ilus0zwo.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] API: Allow testing of kernel features in
 development
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

Hi all,

> Hello,

> Cyril Hrubis <chrubis@suse.cz> writes:

> > Hi!
> >> I would be even tempted to add this to the default syscalls runtest file
> >> but render the test resultless, e.g. replace the tst_res() and tst_brk()
> >> handlers in tst_res.c so that it will print only INFO messages.

> > And that would also allow us to have env variable switch that would
> > enable all tests for unrelased features, something as
> > LTP_ENABLE_UNRELASED or so. Also with that we can really just TCONF if
> > that variable is not set which would be much simpler.

> I worry this will cause extra work for people reviewing
> TCONFs. Obviously the meta-data can be used to avoid any issues. However
> few people have integrated that into their tooling and workflow yet.

Can we solve this to have the policy? I don't have preference between having
special foo-unstable (or foo-staging) runtest files or TCONF unless
LTP_ENABLE_UNRELASED

(If we chose the latter, we could add this info into -h, thus people could run
./foo -h | grep ... to catch this before running; there could be even --json to
print metadata in json, which would include this info).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
