Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2360C433EF
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 11:10:11 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2A661183
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 11:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F2A661183
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E55BB3C7621
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 12:10:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 895563C4B8F
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 12:09:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 50DC31A0148B
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 12:09:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 85C731FD36;
 Fri,  5 Nov 2021 11:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636110597;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VczwBtqKjlr4wx/TKgoTT/rQG51RAhU0Y+fWTH3byd4=;
 b=aqs/FAoTxJe58sl1iVO9JKmyE9Azy4JIp4R87yIqRTZj1wRciYHHfKVKOv3Ob/q+w/941L
 fTzFzmabLoyNvGoBuSmrxqB56znzu5gcjg9dIY+peuNGcC8Pb43RPLacd0NBcz96Ygnt2x
 5mXIlWdWIHElNc0so5LtgH6qZ5yfUJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636110597;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VczwBtqKjlr4wx/TKgoTT/rQG51RAhU0Y+fWTH3byd4=;
 b=bM4zw8syk2YhLm260FQ00YIRjmTaDN9PrVwhMlwVutuu5PsVe/KBYiB1fPkEAv71QsjTxZ
 gn7XanLvGXjzaGCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64F2D13FED;
 Fri,  5 Nov 2021 11:09:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H9vJFQURhWE9HQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 Nov 2021 11:09:57 +0000
Date: Fri, 5 Nov 2021 12:09:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YYURA/IDMHmVJypt@pevik>
References: <20211103120233.20728-8-chrubis@suse.cz> <YYKI9I05hEjiKNiE@pevik>
 <YYKLnxZL44ftguOx@yuki> <YYKMIuHDheI1PK8x@yuki>
 <YYKe0sdsN/qGRO8E@pevik> <YYKmqo3NCZi35DKB@pevik>
 <YYKsVYjYm0lk8cpD@yuki> <YYPb0HgsJ0YEZ9PB@yuki>
 <YYQ3O3XYoZ88GBBN@pevik> <YYUFSQ+7rLIqBrjA@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYUFSQ+7rLIqBrjA@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 7/7] docparse: Split into metadata and docparse
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

> Hi!
> > I'd still appreciate make in docparse/ directory could somehow resolve missing
> > dependency, but I can live without it as it's obviously meant to run make only
> > in metadata/ directory.

> The problem is that if we add any way how to trigger the ltp.json build
> from the metadata directory it will crash and burn when parallel build
> is invoked from the top level directory.

> We would have to explain the dependency in the top level Makefile as
> well as in the docparse/Makefile. Which would be complicated and error
> prone.

Thanks for info, agree to avoid it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
