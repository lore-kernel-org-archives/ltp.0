Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4317FC433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 09:35:43 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A042610D1
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 09:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A042610D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67B993C89B0
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 11:35:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF83B3C2E5D
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 11:35:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 51178600726
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 11:35:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 622B81FD39;
 Wed, 15 Sep 2021 09:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631698528;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NJzDExTQC7QWli1EQzb6FnaPpW4EOMv0S8zJ/6cqsE=;
 b=vHJ6Na3QW3+Ad317Wz/IhHcvsUhoJhijAmAvzLa9+xAbuHRrjbhvA/mrC2NrKs7CEbKQQJ
 d7MZPC8xrkr8Qoxonfg1ThAgqdSYklXv1CmSzP0wy3hEyeLaneZ3qMMIeZim9r8MT/RaNC
 RxLBHTHrSQlSLBCQDSAX5TtnmjMWi+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631698528;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NJzDExTQC7QWli1EQzb6FnaPpW4EOMv0S8zJ/6cqsE=;
 b=ritB3esjmW/8PKgvFFHv6MFE+GsPChXhf956TiZbj0msgSOnydIuBKBIQpowIHoUu+w7Js
 J+aCMz13Wa70S+Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4301A13AD4;
 Wed, 15 Sep 2021 09:35:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 05iADmC+QWEwWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Sep 2021 09:35:28 +0000
Date: Wed, 15 Sep 2021 11:35:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Message-ID: <YUG+XlCf83X4TP26@pevik>
References: <20210913123935.10761-1-aleksei.kodanev@bell-sw.com>
 <YUA3UIvykJPNyyi4@pevik>
 <82b63456-0ba6-dedc-9688-cc74c40e4982@bell-sw.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <82b63456-0ba6-dedc-9688-cc74c40e4982@bell-sw.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib/tst_net.sh: ignore errors on rhost with
 -i option in tst_net_run()
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
Message-ID: <20210915093526.Ytgp-LxHEp_UuY1-2Dz7ci8JpfOUSPuJ8NH2ZGM3M9M@z>

Hi Alexey,

> Hi Petr,
> On 14.09.2021 08:46, Petr Vorel wrote:
> > Hi Alexey,

> > good catch!
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > BTW are you going to send patch / report it to busybox? (I haven't find anything on ML)

> Looking at busybox history, seems expected from the beginning there:

> commit 64309f8669f08f2c3c16a3b5bf82d9cae84ec388
> Author: Denis Vlasenko <vda.linux@googlemail.com>
> Date:   Thu Nov 29 06:40:28 2007 +0000

>     sysctl: add -e: supress warnings about invalid key (Jeremy Kerr <jk@ozlabs.org>)

> -e option unsets FLAG_SHOW_KEY_ERRORS.

> busybox/sysctl: "-e	Don't warn about unknown keys"
> (Though, -q option can be used for that, which was added later, in 2012)
> vs
> procps/sysctl:  "-e, --ignore         ignore unknown variables errors"

Hm, IMHO it'd be good change to -e have 0 exit status. Because that's the
behavior in procps-ng (tested on 3.3.17).

If you do it, please let me know and/or Cc me in your patch. Otherwise I'll do it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
