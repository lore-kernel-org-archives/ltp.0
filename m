Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409BEC6FA82
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 09:33:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1DBA3CACBE
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 11:33:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB0933C93EF
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 11:33:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 72354100092E
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 11:33:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 635E51F8F7;
 Mon, 19 Sep 2022 09:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663580011;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ufhKtJeunfeDv1qB78/U8tMwGBGzAIgGdkm72O2BI8A=;
 b=Rr+4Zv5IzFfR8i0bVRA7AovaBV8PS79Yxbymk7r32C1if++mf/T/aB4e/c2DviCX3mL7R0
 6QDT+DFo6bCXed2qPOdJEKBL4SD16vByRfErKq5R03PTXlVrlwCO/Lx6I161yUnXi9xAmr
 4fuqXz9pC0lb8i/DT+Z3tz8UOCcPU9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663580011;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ufhKtJeunfeDv1qB78/U8tMwGBGzAIgGdkm72O2BI8A=;
 b=KYCTbCjFM41eeNgkbMDrPJb6wodTBVEsYIjrfauP4s2J0Xy99J6tUznXaZmdJHEcO81uxS
 AxVFFFASHRM3c0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B6FD13ABD;
 Mon, 19 Sep 2022 09:33:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iuimCWs3KGOJWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 19 Sep 2022 09:33:31 +0000
Date: Mon, 19 Sep 2022 11:33:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yyg3aMfgfMoeOTMK@pevik>
References: <20220818100945.7935-1-pvorel@suse.cz> <YyTrqPxEABXGtAYF@pevik>
 <CAEemH2cqn=Pe_b3GiXD7A3k5Qxva=XTPGonbfyvA=3D8FVMjPw@mail.gmail.com>
 <Yyg1hW5jYQj7SuAV@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yyg1hW5jYQj7SuAV@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] Fix mkfs.xfs 300MB min size requirement
 (v5.19.0)
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Do we want to merge this patchset to get XFS fix before the release?


> > Sure, I'm fine going with this temporary fix for releasing.

> Same here.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks a lot both, patchset merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
