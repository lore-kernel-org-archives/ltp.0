Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80A8C433EF
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 05:45:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4C433CA958
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 07:45:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D92B43CA93A
 for <ltp@lists.linux.it>; Tue, 10 May 2022 07:45:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4D481600704
 for <ltp@lists.linux.it>; Tue, 10 May 2022 07:45:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75B3D1F8FB;
 Tue, 10 May 2022 05:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652161519;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p4xgOUL4J6n0+5x8QLE4oSl0Ti+lwQ5ttmIOUcEPKKU=;
 b=RzjlmacNoZViBVPdUnr3U+Kqj8tR61DxxPcUkuDruTxl2ptxNtsKfDwNqkzP1ypoog5Phx
 NUTa+ZcdIHO5aLjb+cdKB21so+YQrmxZEiiMOHzmFXpGgZRx9oKOil8Cg7qzP8exIw07lJ
 MzZ8XCcH0ZNf1nkwrnOD7MAXaCsGCzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652161519;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p4xgOUL4J6n0+5x8QLE4oSl0Ti+lwQ5ttmIOUcEPKKU=;
 b=fi+20j6NDX3UvboULKxmNxCkoAfiAvlTbaz6K4RA915YWszBdQHXBUhEbAiEUHeM0qlI1T
 oJVDAJTk4FTjW0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C4D8139F5;
 Tue, 10 May 2022 05:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1KrgEO/7eWLKTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 May 2022 05:45:19 +0000
Date: Tue, 10 May 2022 07:45:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ynn77amLZR/Scql4@pevik>
References: <20220310104457.764-1-pvorel@suse.cz>
 <YnkzFzxszzAo26Oc@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YnkzFzxszzAo26Oc@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] smoketest: Add macsec02.sh
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

Hi Cyril,

> Hi!
> > macsec02.sh is a network tests which uses macsec_lib.sh, which uses
> > ipsec_lib.sh and virt_lib.sh which use tst_net.sh.

> > Adding this test to smoketest to cover functionality of nested
> > libraries. Use macsec02.sh as it requires more setup (unlike macsec01.sh).

> I'm not 100% sure how big should the smoketest be. I guess adding this
> will be still fine, but we should stop adding new tests in there after a
> while, it's supposed to be small and fast.
Understand. I'd still prefer to test macsec02.sh, which uses ipsec_lib.sh,
virt_lib.sh, tst_net.sh and tst_test.sh via macsec_lib.sh.
How about replacing "ping01 ping01.sh" with it?

Because there still would be "ping602 ping02.sh -6".

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
