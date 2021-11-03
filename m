Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6878CC433F5
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 12:05:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95C761051
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 12:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D95C761051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 133D63C71EC
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 13:05:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2596E3C1414
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 13:05:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B0CDB600297
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 13:05:27 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 37C5021916;
 Wed,  3 Nov 2021 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635941127;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6lbWBteoC4LbsrLW2UNdV1uBzgwyNywhzL6dIdqZqk=;
 b=gjwNWaCOfqor4QBB+vCc9HyNUlWfBhPCW3OFb4ibQiVuNtrxhRJFwV02t9e/W9M1eysSxr
 LNWC+ANNwBqaIKZweQ5aeYvXYO7CCufacCFRZRdta1yFjcJCgPpSZ053XUlh+vnDmGj0ac
 AvEeKpMic6njjoGAYOw4gOgJnle9N2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635941127;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6lbWBteoC4LbsrLW2UNdV1uBzgwyNywhzL6dIdqZqk=;
 b=f3AoM8lDQ8TDU5zCy2+Onjqlrf+WZOgN4M82+KPgSNHiGTE3UnXv1sqPYr7ZbRDFnR9+Oa
 sbmpSBWN0OAlkOBg==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 38BDCA3B85;
 Wed,  3 Nov 2021 12:05:23 +0000 (UTC)
References: <20190615042048.29839-1-liwang@redhat.com>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Wed, 03 Nov 2021 12:00:44 +0000
In-reply-to: <20190615042048.29839-1-liwang@redhat.com>
Message-ID: <877ddpo35n.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: adding .arch field in tst_test
 structure
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

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Testcases for specified arch should be limited on that only being supported
> platform to run, we now create a function tst_on_arch to achieve this new
> feature in LTP library.  All you need to run a test on the expected arch is
> to set the '.arch' string in the 'struct tst_test' to choose the required
> arch list. e.g. '.arch = "x86_64 i386"'.

What is the status of this patch series? Is there a V3?

Maybe another option would be to check the kernel config?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
