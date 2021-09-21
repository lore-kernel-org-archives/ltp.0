Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D09C433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 15:00:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2144060F0F
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 15:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2144060F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78A4C3CA2CB
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 17:00:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 575783C2201
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 17:00:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4D10210008F1
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 17:00:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A18701FEEE;
 Tue, 21 Sep 2021 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632236424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sTA19a4fFc7Jk4fR/e+yR5WOKfhUdyao2P93vvolQ8=;
 b=DpBur74L0fn6RfW7M72BFCrZIvelFOyuC3E9L0RTlf4cC9YockWb7Q5i/b8MhuJQNtLDkj
 19JQ/SXQeR5xmF+9J1AvprN+MfzrnjBOcnseYyZIzpMC/XBkNt/E9IficaiNk7K7vrf6os
 lVg0sMKV9/dnK7ZqLfsL8lBD55AsgHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632236424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sTA19a4fFc7Jk4fR/e+yR5WOKfhUdyao2P93vvolQ8=;
 b=Ti1NdURpMLGb23AHc68dsrybvVHpr+W0pzE2f6AYsIQM5XJTd87CHOrrZm4W8fvY9Kg5D1
 hFShDjSnSitTvDBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A8B113BD1;
 Tue, 21 Sep 2021 15:00:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Pl4oIYjzSWGDcAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Sep 2021 15:00:24 +0000
Date: Tue, 21 Sep 2021 17:00:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YUnzptWTllL/el/x@yuki>
References: <a47ecbd7-ba4a-ff2c-ead9-e731040cb845@jv-coder.de>
 <20210914083444.23848-1-rpalethorpe@suse.com>
 <940b657a-ae79-a9f3-c2aa-30d441ad1e4e@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <940b657a-ae79-a9f3-c2aa-30d441ad1e4e@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg_subgroup_charge: Remove limiting of parent
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
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I still don't know why the test even wants to limit anything, when it is 
> just checking what is charged.
> So I would still vote for completely removing the limits and simplifying 
> to just one test case.
> 
> But removing one limitation for now is a step in the right direction, so 
> I will not argue anymore :)

I've split the patch from Ritchie into two and pushed it so that we have
this fixed for the release. We should review and rethink these tests
once the release is finished since this isn't the only problem there.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
