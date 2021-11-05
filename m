Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6880CC433F5
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 11:15:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B474F61262
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 11:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B474F61262
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F1A83C7531
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 12:15:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFAAC3C4B8F
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 12:15:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F36DF140117F
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 12:15:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08A8B217BA;
 Fri,  5 Nov 2021 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636110943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLxPNEM2GD7Go91aZQ+a5Vd2tg1GaD6ccNTj0i447lo=;
 b=Yc8K7mkrqSjLWMRxbOwz+tINNJm4YeSiQfbWzIvnoylXy+YwtOHQZGexlecUO+zj4N1Ub1
 TJuiBJts57c/QTKgV3oO0NJazz/P0OPZF1TQj1bvulpHHRgGRAX7WTn0q+pmWkwP5eVH2O
 qnyBDW1WShiEqLT69Xridr6p0wMalRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636110943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLxPNEM2GD7Go91aZQ+a5Vd2tg1GaD6ccNTj0i447lo=;
 b=earRJ4/qmwqSODBCShMPQZZsb1pvNv34XRsBEy5spq9vpwlv2yMdEwrQer5OWZK/xCY904
 OJBTgvp27mMY5sDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE8D913FED;
 Fri,  5 Nov 2021 11:15:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZxHwNV4ShWF5IAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 05 Nov 2021 11:15:42 +0000
Date: Fri, 5 Nov 2021 12:16:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YYUSmK17HZ4P95/E@yuki>
References: <20210224165045.17738-1-chrubis@suse.cz>
 <20210224165045.17738-3-chrubis@suse.cz> <YDyaEd7xNx3NcMGE@pevik>
 <875yt6988e.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <875yt6988e.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 2/5] lib: Add minimalistic
 json parser
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
Cc: Carlos Hernandez <ceh@ti.com>, Michal Simek <michals@xilinx.com>,
 automated-testing@yoctoproject.org, Orson Zhai <orsonzhai@gmail.com>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Yeah, it seems to be in the spec.
> 
> At any rate, I wouldn't mind this patch being applied immediately
> because there is more than one WIP it may be useful for.

Meanwhile I did a bit more work on the parser and made sure that it
passes JSONTestSuite as well.

If you need a JSON parser in LTP we should vendor the latest version at:

https://github.com/metan-ucw/ujson

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
