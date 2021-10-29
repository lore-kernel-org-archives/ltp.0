Return-Path: <SRS0=M8Fp=PR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED5BC433EF
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 07:51:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DFC60234
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 07:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19DFC60234
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 594A13C6ED8
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 09:51:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D38ED3C6C87
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 09:50:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AD5B31400BF8
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 09:50:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6135E1FD39;
 Fri, 29 Oct 2021 07:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635493853;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WQq7HTdQhkuUpyJSxNmmQLkmoXK8+W4rl3TPl20Lu5w=;
 b=hJDixmcdMWnntuPh1xwcyJi0lc4RidJ6GKwv+/Ek+qP9sDp0AEfOxg5Gl+xn35EUMQayed
 ikzrMBPviUJrf5r6Vzz0EocxzaUGSH2PlYwQ4dyRTq+uo0hw5AIf3IAkJlOFnf7HRtnbZv
 8eug1ly6XI+hPjTSI17lQIkkGTvEbnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635493853;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WQq7HTdQhkuUpyJSxNmmQLkmoXK8+W4rl3TPl20Lu5w=;
 b=WTIzw6/mNE/Rkmqa8RPPAp3RGkJTY5d7OEiLmRoouXzModlseeGUMacjhYHNo2pfoeTL2n
 ERi4uKFr5UQpKFCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 216A813B27;
 Fri, 29 Oct 2021 07:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ENG1Bd2ne2FzAQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Oct 2021 07:50:53 +0000
Date: Fri, 29 Oct 2021 09:50:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Egor Petrov <egor.petrov@oracle.com>
Message-ID: <YXun2wCKLDRiueSR@pevik>
References: <20211028085620.2499-1-egor.petrov@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211028085620.2499-1-egor.petrov@oracle.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_kvercmp.c: Update tst_parse_kver()
 condition
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

Hi Egor,

> tst_parse_kver() fails with kernel names like current
> mainline kernel "5.15-rc7". Updated condition to fit
> this template.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
