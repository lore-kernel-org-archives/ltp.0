Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC0BC636D4
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 15:52:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E9963CBF37
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 16:51:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80CFD3C1424
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 16:51:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EA0B4200ACF
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 16:51:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 930051F8D6;
 Wed, 15 Feb 2023 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676476304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIVZSRTPD3Oz5qowY6SiZ/ZEE4Iie7cp3j6YOh0BqfM=;
 b=2e+KGSckfRAmydOdV6aMx3LmCf+HtLWEPfvFHKCCV2RqFgjGReSXrX+a0cG/lhK/J3Kp/R
 7VIR5SWNuQZeykQkA7HZV4/msXkTjB9iSzk+HbLhix75++kaOAWPzi6xaAxGYReYRDsSBj
 s7qDFQYpOoH/iAlohMDbcF6vNgoB4/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676476304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIVZSRTPD3Oz5qowY6SiZ/ZEE4Iie7cp3j6YOh0BqfM=;
 b=FtNCIgmgbYn6N4JRp5/Ej4CmMl6AfbxuK5jDeTrX5B9zGTr5FQ7zTHKoDaLhwgX1055vgM
 qXwiA4KJtC8incBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63FA2134BA;
 Wed, 15 Feb 2023 15:51:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q5+EF5D/7GPDLgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 15 Feb 2023 15:51:44 +0000
Message-ID: <2b7a876b-7346-355c-7728-ce5c309f2380@suse.cz>
Date: Wed, 15 Feb 2023 16:51:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>, Petr Vorel <pvorel@suse.cz>
References: <20230215144225.25008-1-mdoucha@suse.cz> <Y+z4MNO+jwydz1w8@pevik>
 <abf5eb48-d63d-1b5f-4047-1a8c210a48a1@arm.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <abf5eb48-d63d-1b5f-4047-1a8c210a48a1@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2015-3290: Fix tst_syscall() return value
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 15. 02. 23 16:34, Teo Couprie Diaz wrote:
> I sent the tst_syscall return patch. I did some testing with what systems I
> had available when working on it and, at the time, didn't see any 
> regressions,
> including for cve-2015-3290.
> 
> However this was with fairly recent kernels and libcs, and according to 
> Martin
> the test failed for them on an older combination.
> 
> I shared the test suite[0] I tested the patch with, containing all the 
> uses I found.
> It might be worthwhile to run it on a system where we now know one of 
> the tests
> was affected ? Hopefully, none more, but having a result would be better.

Yes, we got failures on some older distros with kernel 4.x and older 
glibc. I've already tested the patch there myself. The CVE test works 
fine on kernels 5.x with newer glibc.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
