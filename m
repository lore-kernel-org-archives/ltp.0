Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD040CA0FE6
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 09:41:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85FB63CC5B4
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 11:41:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F01493C91D7
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 11:41:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3094B20174C
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 11:41:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 36E42210E3;
 Fri,  1 Sep 2023 09:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693561270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PyfooA6nHEGSY1GZEwASvarzGqx9MjPa4Vr7jUtBU4Y=;
 b=EI9KyemOzKqxNaLZnqhgJEBR6t54vwcrvOe3Qf4wtw1d/pEHjsguRO0zIM/faa1WXU+5SC
 qiSeffNBvXaY8sclRm0J1KoX9iWQTxrg+hf74h7Xd7igdXm6tBLrdQ8pKP7xRnSoWS6ILG
 GH6PXnSNAoq0m1Oedfv3D7fSYZH8Njg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693561270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PyfooA6nHEGSY1GZEwASvarzGqx9MjPa4Vr7jUtBU4Y=;
 b=TD3ummkd6bv+sP4T5v/wblyuNr51pjR6+9PtyiU5jWa5l8aEPBKZ8W8K2CGjy9qlzJdSDY
 +vssl2CTt0tXckBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17D5813582;
 Fri,  1 Sep 2023 09:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HgOkBLax8WRVRwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 01 Sep 2023 09:41:10 +0000
Date: Fri, 1 Sep 2023 11:41:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZPGx2VbtreROQC2N@yuki>
References: <20230818071323.89606-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230818071323.89606-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] sched_rr_get_interval01: Add another kernel
 tag
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
> NOTE: git commit is still only in next tree [1], although hash will be
> very likely the same, we should wait until it get to mainline (likely in
> 6.6-rc1).

The fix has reached the mainline with unchanged hash hence patch
applied, thanks.

> I suppose we could write a test for another Cyril's fix [2].

I guess that I can just send patch for that one, should be fairly easy.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
