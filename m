Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE37AC433EF
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 10:04:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22839600D4
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 10:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22839600D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54D803C8F2C
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 12:04:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25D5A3C31E7
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 12:04:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 53F601401439
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 12:04:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7551B1FFE2;
 Fri, 24 Sep 2021 10:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632477864;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mn0ZsjJmxfSRFSyzhX8QIOM7kkjml8jy0M1iU39Q9ew=;
 b=MIiO3cUGhJWvoy097BpYbOs2Cr9C3jSpb7yetpx0dZdjEBxymdPIoNCAPpNYpwbmC+Tp/g
 /YkaGYsCBVt/aQNwKxOiBfQUdO9ZMJAbEDHH2BHbH6vYWQHgYfhbfuYCINNzxOAYyQZAK8
 XCcxk6+8tRP5uMWlLwBBZ14YygXg3Qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632477864;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mn0ZsjJmxfSRFSyzhX8QIOM7kkjml8jy0M1iU39Q9ew=;
 b=uwR7eU2SHx9OBCBwtvZr+bUym6c5i+MCbnfGH6r5ecRLpmuuYapZVs65YpZtOidfarO/sr
 E4weSrFQE0AqTTDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D04CA139F0;
 Fri, 24 Sep 2021 10:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lUaMMKWiTWGkRAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 24 Sep 2021 10:04:21 +0000
Date: Fri, 24 Sep 2021 12:04:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: songkai <songkai01@inspur.com>
Message-ID: <YU2iniEPyrNEIOzh@pevik>
References: <20210907235746.112665-1-songkai01@inspur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210907235746.112665-1-songkai01@inspur.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix the statistical number of results in the html
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
Cc: wangkaiyuan@inspur.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> From: wangkaiyuan <wangkaiyuan@inspur.com>

> According to the statistical method of ltp-pan on TFAIL TBROK TCONF
> TPASS..., the statistical method of the ltp test result type in 
> genhtml.pl is modified to ensure that the .log format of the ltp 
> result is consistent with the test result in the .html format.

> The original statistical method policy expression "/\ TFAIL\ /" in 
> the original genhtml.pl for the test result type cannot match the 
> "TFAIL:" in the normal test result, causing problems in the 
This could be fixed with :?, right?

> calculation result. At the same time, the statistical method in 
> genhtml.pl cannot guarantee that each test item has only one test 
> result, because the output of a test item may include TFAIL, TCONF,
> and TPASS at the same time.
That's a valid input.

> Signed-off-by: wangkaiyuan <wangkaiyuan@inspur.com> 
>                Chunsing.dey <daichx@inspur.com>
nit: both should have Signed-off-by:, you can also use Co-developed-by:
for the second developer.

nit: there are whitespace errors in the patch.

I do not dare to review it as I've never used the tool.
FYI ltp-pan is deprecated, you can try to use runltp-ng [1] which we'd like to
bring to LTP upstream (to replace ltp-pan and runltp).

Kind regards,
Petr

[1] https://github.com/metan-ucw/runltp-ng

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
