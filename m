Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433B9CE7A81
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 13:17:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA7383CDD37
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:17:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 991433C01D0
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:17:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CE24B601566
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:17:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3807021850;
 Mon, 25 Sep 2023 13:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695647822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6iqMabh04KOaBcTYfJgqJc4CFwvPTIE9gotJdUOaoiw=;
 b=DjuDV4Y5vMQFWDssPvyfz3onmGmvo17Jc5A4VXDuaE6VlpujUV+m882aaEOl3lv6AZOeQK
 4nQ/7taCis8ZeZZlB+lBEDfLI2xg3r2B8zJ7ZY2WkVLJsHP9Azq+xABeWISUKJ7s1cIr4Y
 DQYiZnpUmrxaNs8MJzbZhYr74fbAdOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695647822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6iqMabh04KOaBcTYfJgqJc4CFwvPTIE9gotJdUOaoiw=;
 b=MZUExEWOqSuonzIrdbVAmRsFi2mNXEMP1GHdjXsjcYZ5dhysvJ8ftSfyTqB7qSPnCBAibV
 /fKTsHu/HUKgPpBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22B7E13580;
 Mon, 25 Sep 2023 13:17:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +4gLCE6IEWW2CQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 25 Sep 2023 13:17:02 +0000
Date: Mon, 25 Sep 2023 15:17:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZRGIeNK0Cf3-caZb@yuki>
References: <20230920153145.30891-1-mdoucha@suse.cz> <ZQ2E_pKz2QSG61LY@yuki>
 <20230925131235.GB60471@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230925131235.GB60471@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pidns05: Use tst_getpid()
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
> Well, Martin found that some of SLES versions (e.g. some SLES versions based on
> kernel 4.12 or older) started to fail after rewrite:

I mean that the second instance of getpid() is not called from cloned()
process, the first one has to be replaced for sure.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
