Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA64ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 07:05:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2303F3CA914
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 09:05:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DAD53C004D
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 09:05:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 523756008E5
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 09:05:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E14F5FB3E;
 Mon,  5 Sep 2022 07:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662361501;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zk4zVm5Yy9r1bKBEPrY67yGfMpVbs8ha9RGFt7LEJwk=;
 b=rhH3vURAnHJKj9ebTy+OsHYA4zLMu8He/7Ygl4dqkyr1O6TQyQ3txq6SF+KJ6zFrmNR8m0
 rfp5WvTMxuMDRDyPEWdXIdnk4qMnsDFjiwo/8KmNAl7CSvLH9b1gsqhpHVro7Pnz7KG4Vs
 9p0NziDTNBkr0DUuolEp4TCz0yw3ITU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662361501;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zk4zVm5Yy9r1bKBEPrY67yGfMpVbs8ha9RGFt7LEJwk=;
 b=Y3K2BiunVGOb2sPRVU8L7YYzGO+2mesBqm33VVR+2Juxsuazo1MtIfjrsfu6QhWGB8K4Ph
 zJPfy93bOU4YHgDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44041139C7;
 Mon,  5 Sep 2022 07:05:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FkmDDp2fFWMqZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 05 Sep 2022 07:05:01 +0000
Date: Mon, 5 Sep 2022 09:04:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YxWfm7Hi/XA3LjuX@pevik>
References: <20220902133710.1785-1-pvorel@suse.cz>
 <CAEemH2fetx7L+B+=YTsNH=8QR+292s9w+LuRnJBM4nu8UkrR9w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fetx7L+B+=YTsNH=8QR+292s9w+LuRnJBM4nu8UkrR9w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/9] shell: df01.sh: $TST_ALL_FILESYSTEMS
 (.all_filesystems)
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
Cc: LTP List <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Hi Petr,

> The whole patch set looks nice!
Thanks a lot for your time to review!

> Btw, it might be great to wait for the series patch set of
> "Track minimal size per filesystem" and merge together
> in case this can't complete test on XFS.

FYI I marked patchset "Track minimal size per filesystem" [1] to changes requested,
I have WIP version which will track set size for .all_filesystems based on
max of all supported filesystems (as we discussed).

Because these two patchsets
modify the same files: lib/tst_supported_fs_types.c,
testcases/lib/tst_supported_fs.c modified in this patchset in commit
"tst_supported_fs: Support skip list when query single fs" in will likely be
changed in "Track minimal size per filesystem", I can either merge this now
(probably simpler) or sent big patchset which implements both.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=315621&state=*

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
