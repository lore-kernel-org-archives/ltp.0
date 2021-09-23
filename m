Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913FC433EF
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 09:05:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2C061038
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 09:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D2C061038
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22E983C8F6B
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 11:05:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9FCC3C8F9C
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 11:05:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 01EDD600F4E
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 11:05:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E1F7522348;
 Thu, 23 Sep 2021 09:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632387905;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DCxgah9cWx2kPYvAWhBEw0nOuFI/XCxP0q7j8zmfTWo=;
 b=JWRK6GgrGBvi8ZAm81ES8BT0gMgXuUolzsMnYaLjN14Ihkc3OPGTx3aPpRaSQeM7Ij2xq9
 nXb8gZ2/1u3RxO3CXIlK9WLkCL1QYCDYo+M1qMasbRIMgz0kyKkrZPU4mDLimgzpTXKQ2m
 dEQhY8CF4EVuEeJZy/xtPRjOVnqRd+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632387905;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DCxgah9cWx2kPYvAWhBEw0nOuFI/XCxP0q7j8zmfTWo=;
 b=q78TW6F12JTBOaE1BBCDaI9sRH8c1M2w79gAV2pklwjziO52L7GuNIcaCm7nrRJY4UCYjv
 PqkMS+5v5RbjQxCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCB0113DCA;
 Thu, 23 Sep 2021 09:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W66QLEFDTGFGMQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Sep 2021 09:05:05 +0000
Date: Thu, 23 Sep 2021 11:05:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <YUxDQBYdEXdf5RPf@pevik>
References: <20210902010814.32448-1-zhanglianjie@uniontech.com>
 <YTBo6ZS2GKWb8edF@pevik>
 <c0a5fa20-dd40-161c-352f-407b8a2d6b08@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c0a5fa20-dd40-161c-352f-407b8a2d6b08@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] syscalls/clone01: Convert to new API
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

Hi zhanglianjie,

> Hi,
> Please ignore other patches about clone testcases and just focus on
> v3.thanks.

FYI you can register on our patchwork instance [1] with email you use for
sending patches and update status of your patches (e.g. set patches to be
ignored to "Superseded" or "Changes Requested").

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/register/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
