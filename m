Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7F2C2BA4C
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 18:15:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73BD33C96DB
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 19:15:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83AFC3C54C9
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 19:15:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B938160049C
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 19:15:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0ABB921901;
 Wed, 26 Jan 2022 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643220900;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kmBQRZXRxgIctWIQPUdoBc6gr1glIn82p9HPiUYaaGo=;
 b=mT+kAyD+k4bPIliEPKcN1dt4Ixm5VN6ClMppo48pCHV2khLWIAaDqqoaqZkUpFa6OeNm4z
 RUZwjz7q3f/RdZehGYisWNlhFyMxp1NVpUUbCaYq8y2iATXrEfNElO313tWv9UHielff4i
 zARXzXBlz23rqE/FiwBKBviMYGjwNHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643220900;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kmBQRZXRxgIctWIQPUdoBc6gr1glIn82p9HPiUYaaGo=;
 b=Cke2VXt+esEtADBXODag/VgGUzy6PrMWPW/NCsd6FHvvV8cW1q4qDcHdj9MwkzvsjZpDAK
 7yQ71WiTm2OtnrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B92E513E30;
 Wed, 26 Jan 2022 18:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lMuKKqOP8WGbcgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 18:14:59 +0000
Date: Wed, 26 Jan 2022 19:14:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YfGPoTFwN9r4f/UV@pevik>
References: <20220126123547.13298-1-pvorel@suse.cz>
 <YfFn6DCo0ZHHXTI5@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YfFn6DCo0ZHHXTI5@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/7] m4: Fix warnings, remove old checks
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

[ Fixing the address: automated-testing@yoctoproject.org was wrong,
now using automated-testing@lists.yoctoproject.org ]

> Hi!
> Generally this is a nice cleanup, I guess that we should wait for a
> while if there is someone who will ask to keep the ltp-scanner and then
> we can go ahead with the changes...
+1. Please let us know if you're using ltp-scanner.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
