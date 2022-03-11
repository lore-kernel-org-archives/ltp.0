Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D460C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 14:50:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8D733C8C8C
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 15:50:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EEC03C887F
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 15:50:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 80CDC20007D
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 15:50:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E55EC21115;
 Fri, 11 Mar 2022 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647010236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7GyqIHMFHX4XKfZcik9odigGHf1EyUJ6Sz94t21kY50=;
 b=aAk/D1s9UIF5++OJLj5e0qeMr/z24581/E7DojrAlCeyI2P3mFPsXyFxsm+JZVhi0p3Xt5
 y0pRxhPG5qdVhIY1bA6SZADwxFfVJFVtK5AgciONsZt8cVvUV++BlXXWg2Tj7RiSiYwFUP
 VjSAudk03ByfZRu+iSu7ElP70cuVPC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647010236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7GyqIHMFHX4XKfZcik9odigGHf1EyUJ6Sz94t21kY50=;
 b=c8xVRv39cbvXYD1wvlSsMLt2e01R0YE0Imkn+6PZWHWRrfc/RuK2MoYsnDwGJaYFLaUiNr
 AFnCj+80IIdQwrCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A88A513A8E;
 Fri, 11 Mar 2022 14:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id O/PCJ7xhK2KefQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 11 Mar 2022 14:50:36 +0000
Date: Fri, 11 Mar 2022 15:50:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yithu47z+Cv4h3gk@pevik>
References: <20220311110015.20951-1-pvorel@suse.cz>
 <YitEA0Pot/ivUQa6@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YitEA0Pot/ivUQa6@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfs01_open_files: Fix pattern for deleted
 files
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
Cc: Neil Brown <neilb@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> Maybe we should also do:

> #define TEMPLATE_PREFIX_LEN (sizeof(TEMPLATE_PREFIX) - 1)

> And use TEMPLATE_PREFIX_LEN instead of the hardcoded 3

+1, thanks, merged with this change.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
