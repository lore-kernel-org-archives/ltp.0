Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB06C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 19:05:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B2B611C3
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 19:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11B2B611C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7ACCA3C8EA6
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 21:05:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2D0D3C2156
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 21:05:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2179F1A0092C
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 21:05:25 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0AACF2021E;
 Fri, 10 Sep 2021 19:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631300725;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kvtRhpP/5ZIW3Fa+rWljh35/hCzlohB/yPk/GM6StzM=;
 b=caRCOcZsnS4ztK6ydwB2mSm/i/3O1hvu9JsSOM6085YfcKDOymPDthQb88rbRj0cPitmeP
 ejDsHXYnuIu1/10w+Cm1DXZ18n+f3l51KbJlJsToJ6ShGBz0ms9JuKsmgZFuiIK+61LL0+
 rPaYs34mcdhhUt7ReNXPQHRlmsAT0Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631300725;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kvtRhpP/5ZIW3Fa+rWljh35/hCzlohB/yPk/GM6StzM=;
 b=5x7zrSc2ux5sz91Yb0/eLi63ejcrcYFz2C846tlp7sZVX25QSTOiW6272THl162uZTc8zI
 +8ab5gYHwb9gtwBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CAFE5132CD;
 Fri, 10 Sep 2021 19:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id TmhWL3SsO2GBOAAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Fri, 10 Sep 2021 19:05:24 +0000
Date: Fri, 10 Sep 2021 21:05:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YTuscwqkK552GHeR@pevik>
References: <20210909155126.2720-1-mdoucha@suse.cz>
 <20210909155126.2720-8-mdoucha@suse.cz>
 <287a9879ef8b3342cb88225e4e319733@suse.de> <YTtrwkSdUaQE/PnB@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YTtrwkSdUaQE/PnB@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 8/8] syscalls/setresuid03: Convert to new API
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
Cc: pvorel <pvorel@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210910190523.6gGm_Hr1_BqbmzFBBI4ikEUTBCrycxG4_kjOMY4tOnk@z>

Hi Cyril,

> Hi!
> > It's a second test where we could use TST_EXP_FAIL_SILENT() if we had it 
> > defined.

> Well the main point we test is that the call fails so I would just use
> TST_EXP_FAIL() that produces TPASS/TFAIL and the have additional check
> if the groups were changed or not.

> I can change the patche accordingly before applying if you agree.

You probably ask Martin. Certainly ok for me.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
