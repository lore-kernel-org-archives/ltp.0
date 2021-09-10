Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B4AC433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 14:29:22 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E727E6108B
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 14:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E727E6108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 044C13CA51C
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 16:29:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A78823C2195
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 16:29:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D5FFC2011C5
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 16:29:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 06347223E5;
 Fri, 10 Sep 2021 14:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631284147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zW2XxuxIwsEBHvxTkKohQruUKvDg+S3Y3Ae/FOETDRk=;
 b=yYJwqfmRqWSNpgf0AXd6/cIGFcz9eBVarbXsZO6EWpHuZ3mf1E6qX8sJZ343l7KGzr1Ao+
 MK49yj/DccPgrkymwynzDO65m67gCuGUhTlDH940IJ4mn3z5MR7dienclLspIRrMExw8jf
 IEJ0K/xAv/6H3jyK8iqlET2dmtam+Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631284147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zW2XxuxIwsEBHvxTkKohQruUKvDg+S3Y3Ae/FOETDRk=;
 b=GgdTV03ZEHQ1pjBYbyb4UkJ0/16T6VmO1xssDJSJc2EMAdZFXDudGpVWCPoQaSRL0owkV3
 GHla8vGMslp6W8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D764513D38;
 Fri, 10 Sep 2021 14:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oN8qNLJrO2ERbAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Sep 2021 14:29:06 +0000
Date: Fri, 10 Sep 2021 16:29:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: pvorel <pvorel@suse.de>
Message-ID: <YTtrwkSdUaQE/PnB@yuki>
References: <20210909155126.2720-1-mdoucha@suse.cz>
 <20210909155126.2720-8-mdoucha@suse.cz>
 <287a9879ef8b3342cb88225e4e319733@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <287a9879ef8b3342cb88225e4e319733@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 8/8] syscalls/setresuid03: Convert to new API
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
Message-ID: <20210910142922.0os95D2PIBo5dP_yeQENEWPu0gvyp2DqPayMSeNXRdc@z>

Hi!
> It's a second test where we could use TST_EXP_FAIL_SILENT() if we had it 
> defined.

Well the main point we test is that the call fails so I would just use
TST_EXP_FAIL() that produces TPASS/TFAIL and the have additional check
if the groups were changed or not.

I can change the patche accordingly before applying if you agree.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
