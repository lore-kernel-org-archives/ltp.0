Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8926ECAAD6
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 08:50:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACB833CA48E
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 10:49:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A6013CA03B
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 10:49:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82CA3600789
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 10:49:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB8AC33710;
 Fri, 26 Aug 2022 08:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661503787;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V2Yqh4heJFLJofUV5VNjBoW2AtXtI1WHfu7epGg9Llc=;
 b=fGiVc5kFpG3tyzIGrZysIDnKhbjhrgAP+rX+iLVrbG6wag8ApU417yfK1O3guJXgtI8Z9I
 8q+7eK+qdAjZ1f6q0w0vocvmSX5i3fne82beb9N6uUyWDrq7A+sSVKjMPzy0tqOaZw+zFS
 UOxXrSk5WKC4R21D0ZuJbmnGR2k4szY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661503787;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V2Yqh4heJFLJofUV5VNjBoW2AtXtI1WHfu7epGg9Llc=;
 b=+3z0nP9x1vwxTXpkQPdmn7B+wmd5OTF1vb5kl7s5+HEGgKWveW7LhEWX+g+xY7FIEXEOra
 VrSsMHdS5mC28FBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E63C13421;
 Fri, 26 Aug 2022 08:49:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id n5UKHCuJCGPMMAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 26 Aug 2022 08:49:47 +0000
Date: Fri, 26 Aug 2022 10:49:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YwiJKHTxbLnyDkob@pevik>
References: <20220727053307.3009235-1-lkml@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220727053307.3009235-1-lkml@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/3] openposix: Fix installation file layout
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

Hi all,

> Update to v1:
>  - Replaced deprecated AC_PROG_CC_C99
>  - Fixed whitespace
>  - Fixed help message for configure script of ltp
>  - Added a more verbose commit message to the last commit

I didn't remember the reason for these fixes. It was in v1 [1]:

	as described in my RFC, here is a first implementation of a fixed
	installation layout for open posix tests.

	I implemented this using autoconf, to be able to specify the
	installation location of the tests.

	If build standalone, the open posix tests are still installed to
	/opt/open_posix_testsuite/{conformance,functional,stress}, but when
	installed as part of ltp, they are installed to
	/opt/ltp/testcases/open_posix_testsuite/*

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20220627125321.1560677-1-lkml@jv-coder.de/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
