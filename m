Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8C1ECAAD3
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 10:54:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 375D03CA846
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 12:54:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E422A3CA729
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 12:53:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5A4261000D06
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 12:53:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 62ADE1FAD9;
 Thu,  1 Sep 2022 10:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662029632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNkb3jh3iz2WqX7asCECCcbT7IyrB1Pzy5M60U4lCY8=;
 b=L/X5VyWqWhh07aVyo4cFR743OsKHxNPFr9lXOV3JQTsA8oktfwlxh0phT5Y8etQ0khMV2j
 IO5g+0Xj91536LV2efbtGqqk4Hr1b1h7T86MaxWgaEPWSoFHSkfHvYB+RekZ9U1UGPHZN/
 eIq5F3nwlI23JNbUjl/QeQZ67oGOOVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662029632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNkb3jh3iz2WqX7asCECCcbT7IyrB1Pzy5M60U4lCY8=;
 b=EuWwZD2Xf83K2VdHAY7qdB5BFqmATCzut/1tKmdtfRdATuJ4fszMpO0aY/KpGm66A+vOrw
 zPPw9LbBWiUyzFBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D76913A79;
 Thu,  1 Sep 2022 10:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JcfOEj+PEGMwdgAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 01 Sep 2022 10:53:51 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it, Li Wang <liwang@redhat.com>
Date: Thu, 01 Sep 2022 16:23:48 +0530
Message-ID: <13092651.uLZWGnKmhe@localhost>
Organization: SUSE
In-Reply-To: <CAEemH2fTpsMf_j3rRHw+Uy+D5nEes1tPpSbqVfKDavSWoGOk6Q@mail.gmail.com>
References: <20220830072028.1115-1-akumar@suse.de>
 <CAEemH2fTpsMf_j3rRHw+Uy+D5nEes1tPpSbqVfKDavSWoGOk6Q@mail.gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getsid01.c: Convert to new LTP API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

On Wednesday, August 31, 2022 12:05:32 PM IST Li Wang wrote:
> Hi Avinesh,
> 
> Avinesh Kumar <akumar@suse.de> wrote:
> 
> 
> > -       for (lc = 0; TEST_LOOPING(lc); lc++) {
> > -               /* reset tst_count in case we are looping */
> > -               tst_count = 0;
> > +       TEST(getsid(0));
> > +       p_sid = TST_RET;
> >
> 
> We'd better examine TST_RET not equal -1, otherwise, the test can
> still report pass with two wrong values (-1) returned. isn't it?
> 
> 
> > +               c_sid = TST_RET;
> >
> 
> Here as well.
Yes, thank you for pointing this out, sending v2.

> 
> 
> 

Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
