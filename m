Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447BDC43334
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 13:40:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A9F73C9262
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 15:39:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 278DD3C01CF
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 15:39:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 72F751000289
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 15:39:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2135220FD;
 Fri, 10 Jun 2022 13:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654868386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UM0Lfvs/9z75dLiqMa6UUtog7334SbIxKvsLQ8YYOGw=;
 b=PudiE7lAXeYeIN3f8VD57esnC3edqP0CLVP//nDwEahObzE+eFHYEMF8l+zXFaeN+Qnz0d
 8LMe4pWWuIDkrNsH2pCLqX2BlAg8k6e14o5O74v+USgSvrrOrkDHSJ13Oy/rgH1igZB+Xv
 tEVW/lsl5nHEunlTDkMWmUpRtF1QmaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654868386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UM0Lfvs/9z75dLiqMa6UUtog7334SbIxKvsLQ8YYOGw=;
 b=CgQgga8xskQIz4qCnkrVAUaI3wuIgKYdL6Ddw05uKlhzWCPjYuHk/C9JfgboPN38UObt7V
 Dq+73icU12+g/5Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8683413941;
 Fri, 10 Jun 2022 13:39:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3lK/HqJJo2IoTwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Jun 2022 13:39:46 +0000
Date: Fri, 10 Jun 2022 15:39:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YqNJjJdmn9e/aMmk@rei>
References: <20220610131442.5032-1-mdoucha@suse.cz>
 <YqNIIb/NFVBjsZdb@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqNIIb/NFVBjsZdb@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure: Check for KVM linker script support
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Skipping the whole directory will actually cause problems too, since the
> runltp files does include the kvm_pagefault01 now which will obvious
> fail because the binary would be missing.
> 
> I'm not sure what the best solution would be, maybe install dummy
> libraries that just print TCONF in a case that linker does now work?

s/libraries/binaries/

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
