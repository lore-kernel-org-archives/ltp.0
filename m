Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C02DC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 13:48:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A195960E73
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 13:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A195960E73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E7353C69EB
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 15:48:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1771C3C69BB
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 15:48:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 574CE204928
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 15:48:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E98521963;
 Wed, 27 Oct 2021 13:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635342480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yhcinTCVlFP8cQ9Rhq0DoBrVT3SNTBWcrnH+hGRJVME=;
 b=1xzAhVeBy50nS8ZsWYbONbU+EZjQ2rqvmXu6Vv6qxEn7SQ1L+lUTjMucaZSBALbYmStEWT
 h5sQB+mkrARrh8L1I7O5V1eTs+mTP/B+jnQun0vKwqceMgNtT/9aGv0wbRh1fM5Szd4AbF
 IsC8by4kq8p6PQRpq2GaZdZlv8G73OU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635342480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yhcinTCVlFP8cQ9Rhq0DoBrVT3SNTBWcrnH+hGRJVME=;
 b=ajwzaQy0HlUIgSBDO9BiIpsCywJb1aX/4MMV2YTywRj89rLyWB3kScM2ZANAtg8QNm8uE9
 txCkSgNdeuAgj5DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5108A13C71;
 Wed, 27 Oct 2021 13:48:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gwFGDpBYeWGKNAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 27 Oct 2021 13:48:00 +0000
Date: Wed, 27 Oct 2021 15:48:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YXlYwi7+VUIitM7H@yuki>
References: <20211018154800.11013-1-chrubis@suse.cz> <87tuh2poue.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87tuh2poue.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/7] docparse improvements
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
> It's unfortunate that before starting this effort and the checker that
> we didn't know about tree-sitter (although Sparse may still be the best
> choice for the checker).
> 
> Tree-sitter can parse C into an AST and can easily be vendored into LTP:
> https://tree-sitter.github.io/tree-sitter/using-parsers#building-the-library
> 
> Then we just need to work on the level of the AST. It also has a query
> language. This should allow the initial matching to be done on a high
> level.

The only worry that I have about this would be speed, currently the code
I wrote takes a few second to process thousands of C files in LTP, that
is because we take a lot of shortcuts and ignore all the stuff we do not
need. Full parser that builds AST would be orders of magnitude slower,
so before we attempt to use it it should be benchmarked properly to see
if it's fast enough.

> If we continue down the path of hand parsing C, then it will most likely
> result in constant tweaks and additions.

Well I would say that this patchset is the last addition for the parser,
if we ever need anything more complex we should really switch to
something else. On the other hand I do not think that we will ever need
more complexity in the parser than this, as long as we keep things sane.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
