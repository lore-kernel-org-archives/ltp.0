Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4686EC433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 12:56:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1A623CA36A
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 13:56:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3B273C9FE6
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 13:55:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5F89B1A00EDC
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 13:55:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 94FB221997;
 Thu,  3 Mar 2022 12:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646312155;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7f9VGYxCx9Fsw3mZOxxCL4n5HdmYkvTkuKOazUgJuw=;
 b=wpNBu9QYuyqHomob4gaeL52HzlSnmXBJPdDTagax5MS+J3klY+rKW8Hoyk+eX/4COzHZxy
 6QhWqghfb1IPisRrNet+jeV17ji6Ujpshzo+PcOlWEeEV9P7spVl/58ioGqTXhPfdNfnoB
 cfUHyHmIDYYW3TaYbH2L2sEuaidXHwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646312155;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7f9VGYxCx9Fsw3mZOxxCL4n5HdmYkvTkuKOazUgJuw=;
 b=HAAAJyDuLJPZpdg7e2HOTfrtlwA//tInUj0kI5MRtHtQpBPX8suORIHCZYDKtOiXv9sI+q
 e8sCT3D4FDWF61Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D11713BD4;
 Thu,  3 Mar 2022 12:55:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kRMYFdu6IGLBSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 03 Mar 2022 12:55:55 +0000
Date: Thu, 3 Mar 2022 13:55:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YiC62WfI3/0xuDuD@pevik>
References: <20220223153243.317-1-pvorel@suse.cz>
 <20220223153243.317-3-pvorel@suse.cz>
 <6216E3ED.1050700@fujitsu.com> <Yhz1+H3SAlwPaO8H@pevik>
 <621D72EF.50500@fujitsu.com> <Yh3SOwogWwWQdZ4O@pevik>
 <621DD533.50509@fujitsu.com> <Yh3y0b7WRfYfBWHF@pevik>
 <34bbc640-80d9-ad59-bb8f-d525e923ce91@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34bbc640-80d9-ad59-bb8f-d525e923ce91@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] quotactl08: Use do_mount()
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> On 01. 03. 22 11:17, Petr Vorel wrote:
> > FYI: in our case it was JeOS broken due missing quota_v2 kernel driver
> > (JeOS tries to be minimal, so it's always a fiddling between space and
> > functionality). I'm still not sure if we want to add check for .needs_drivers
> > quota_v2.

> .needs_drivers would probably be the cleaner solution.
Sure - I'm closing this as wrong approach. I just wasn't sure if we want to
check for .needs_drivers. Because there could be numerous of other tests which
require test for missing driver. And it's relevant just fo JeOS like
installations, which strive for minimal size. BTW in our case it endup with
module added to kernel-default-base package (thus to be always installed).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
