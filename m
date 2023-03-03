Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E72C64EC4
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 14:38:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E14583CB9BF
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 15:38:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C0693CB90E
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 15:38:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A9D1C600A75
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 15:38:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 07BC922C0C;
 Fri,  3 Mar 2023 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677854302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AiT7SGpAgYSCvw+2Zi2zbM/Z3Q1mE/c6vpHILfeqq/o=;
 b=P1C7NsTyqY0/CU/ts+1cGG8EwrBrXxAxEZn+Z/UG7cbWcfNjyGPzjsQMdZ61YM5mtgjtsk
 hjWjeuZ0fQXG4wK3k6feXSG4T0fMKypkoDW0UmNEzxEIjB6iiDja6CvK+IKikYqNsMBALB
 Hx4NCtX1dDeJwWX0+8sOyM6B4zf6CTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677854302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AiT7SGpAgYSCvw+2Zi2zbM/Z3Q1mE/c6vpHILfeqq/o=;
 b=nUKVC+IzcIOho8E93PsyDmc0r6LhqQEwwS/JGcu3lIVnLR9JUlox7VbzkJO2WD02TJ+LkP
 dRb9u4D0OFcg5ZCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9637139D3;
 Fri,  3 Mar 2023 14:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PKZ3L10GAmSIHwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Mar 2023 14:38:21 +0000
Date: Fri, 3 Mar 2023 15:38:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZAIGXHd3u1RMn5uZ@pevik>
References: <20230303094253.20952-1-andrea.cervesato@suse.de>
 <20230303142943.GA24485@pevik>
 <72ff2c7a-4054-6a5c-c801-0188af5a3edd@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <72ff2c7a-4054-6a5c-c801-0188af5a3edd@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite ns_exec tool using new LTP API
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

> Hi Petr,

> On 3/3/23 15:29, Petr Vorel wrote:
> > Hi Andrea,

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > I'm going to merge without struct tst_test workarounds.
> > IMHO it works without it. Or am I missing something?
> Unfortunately it's needed because of SAFE_CLONE. We can't use it without
> forcing "forks_child = 1".
Yes, I read that in the comment. But the problem was somehow hidden.
It looks like Segmentation fault appear only if run on fresh reboot, that's why
I got confused it's not needed. Sorry for asking without looking into
safe_clone() before.

Also we had some discussion in the past whether tools should use the test
library at all (see below), but in this case I'd be for keeping it
(we don't want to reimplement tst_clone() and TST_RETRY_FUNC()).

> > Kind regards,
> > Petr

> Beware that this patch will touch the whole network testing suites since
> it's used in "tst_net.sh".
Yes, I know :). That was the reason why I also started to rewrite these tests,
with intention to move them to testcases/lib/ (although these files are both
tests and tools, we agreed with Cyril it's better to move them).

> Regards,
> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
