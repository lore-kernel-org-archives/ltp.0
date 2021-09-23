Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42317C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 09:15:02 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9AC6124C
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 09:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE9AC6124C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B1D63C8F79
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 11:15:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 521943C8F57
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 11:14:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D07E3201098
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 11:14:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1D4C1FD77;
 Thu, 23 Sep 2021 09:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632388489;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hjEblAiuGNbLAlz7cWIUzWMmxgmFSh7dc4Xmm8c/hlc=;
 b=II5LAtdmSFIfgYb7p+C9dc9GpELTacSqcNWCM9Dw7UqydrQIR0cglyKiQSZrJNZr3NZcOm
 CdLM9+PSuhrQ8fpgMZW03ynWaIjmHf+CZhOHBOsLF6EIl+mUC3aSoZLrW8imteoFYbDKr1
 vdMM2ZQHweOz5GZyd/nUmylNojFagQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632388489;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hjEblAiuGNbLAlz7cWIUzWMmxgmFSh7dc4Xmm8c/hlc=;
 b=wO07WqoB8a+0KayhCvAg0lnof9fBZRs39RYBwkc/NrwBmdoa2zJdxbWM6pXeyLpYYCTBPj
 afEpYkvmGkET8WCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59E3913DCA;
 Thu, 23 Sep 2021 09:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gBEDE4lFTGHBNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Sep 2021 09:14:49 +0000
Date: Thu, 23 Sep 2021 11:14:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alex Henrie <alexh@vpitech.com>
Message-ID: <YUxFh1Gp231NftEY@pevik>
References: <20210922115310.5927-1-pvorel@suse.cz>
 <20210922115310.5927-4-pvorel@suse.cz>
 <20210922110620.cf7530d5120d2f0173ed2f05@vpitech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210922110620.cf7530d5120d2f0173ed2f05@vpitech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/3] IMA: Add tests for uid, gid, fowner,
 and fgroup options
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Wed, 22 Sep 2021 13:53:10 +0200
> Petr Vorel <pvorel@suse.cz> wrote:

> > From: Alex Henrie <alexh@vpitech.com>

> > Requires "ima: add gid support".

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Signed-off-by: Alex Henrie <alexh@vpitech.com>
> > [ pvorel: add test_file parameter to ima_check(), add
> > verify_measurement() (DRY) ]
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Thanks Petr for taking over and making the changes you want directly,
> that makes my life much easier.
yw. FYI I'll merge v7 after it's merged into mainline, I expect it'll be in v5.16-rc1.
Could you please notify me if I forget?

I'll try to have look into kernel patch itself.

Kind regards,
Petr

> -Alex

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
