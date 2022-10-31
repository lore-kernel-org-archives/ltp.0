Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2591CECAAA1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 13:50:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E6873CABEB
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:50:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28A443C04BF
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:50:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3EA621A007EB
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:50:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5134822897;
 Mon, 31 Oct 2022 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667224212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GiAzGrUF2CHGSn+yhjcwJ1FjoZVk2BYT01EzdqjgnkE=;
 b=FM1QQj09vwKq7vKCAeDKY52OJWHjyuHjNpEltXTpcISBqDLuqPcPdyonCVXts7zBgvdY3l
 33onN9gpo8Mw0Xlk/3fBZ4hJA/HSNUjr4g4X4jMC45tp6s4ZxPpKILLbY81M3S7pi8wcuU
 CzVBQrhRzpnLgj9eMZyOrNdYy3M1jNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667224212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GiAzGrUF2CHGSn+yhjcwJ1FjoZVk2BYT01EzdqjgnkE=;
 b=zUlRtLzs2xRwcLocPmPlK95y7so+VrA0pCbd0sfA+j3bVVSQLxTWExvZbWBcNH76lv+Aka
 CPELOwLHhoFi38Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B2CD13AAD;
 Mon, 31 Oct 2022 13:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8aiZCJTSX2OrZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 31 Oct 2022 13:50:12 +0000
Date: Mon, 31 Oct 2022 14:50:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y1/SkicyE3Mg9Fpc@pevik>
References: <20221027140954.4094-1-akumar@suse.de> <Y1+zeo9kmWOl2yE3@pevik>
 <ad63ddb5-b443-c0ee-fb1b-748bded5f151@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad63ddb5-b443-c0ee-fb1b-748bded5f151@suse.cz>
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin, Avinesh,

> On 31. 10. 22 12:37, Petr Vorel wrote:
> > Hi Avinesh,

> > > a uid which does not have an entry in the /etc/passwd
> > > file is not really an invalid fsuid for setfsuid(), so changing
> > > the test to use -1 as an invalid fsuid.
> > > And second setfsuid(-1) call is to verify that preceding call has
> > > actually failed and there is no change in the fsuid.

> > Here was supposed to be
> > Fixes: 85f0b8478 ("setfsuid02: Rewrite using new LTP API")

> > as the problem was introduced in your rewrite, right?

> No, the original test was already broken, it just didn't do any real failure
> checks so it always passed.
Right, thanks!

> > It also does not make sense to check invalid_uid, it should have been
> > current_uid in 85f0b8478 (my bad not catching this):

> > UID16_CHECK(current_uid, setfsuid);

> No, UID16_CHECK(invalid_uid, setfsuid); is the correct test call. The test
> is supposed to verify that trying to set invalid_uid will fail, and the only
> way to verify that it failed is to call setfsuid(invalid_uid) again and
> check that it returns current_uid.
I'm somehow blind today. UID16_CHECK() in compat_tst_16.h calls
UID_SIZE_CHECK(), which just checks the uid value. I don't see setfsuid() call,
IMHO that's done in SETFSUID().

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
