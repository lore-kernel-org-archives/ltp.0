Return-Path: <SRS0=2GLJ=P6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09AEC433EF
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 14:29:16 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC4F6115A
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 14:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFC4F6115A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD0B83C7210
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 15:29:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 966823C630D
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 15:29:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AFA67200B39
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 15:29:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 71AF621B3E;
 Thu, 11 Nov 2021 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636640942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tbsZL0grzbPtO7uqQkfQXqAGaKR6+l/cX1EEdR1f8Vk=;
 b=wLbpTgJmNMbo43ReLwQvhkeLSw7XPxlRzdXH7FB8sMHyWV6Ay2V1+HeYvffCDtbdCqbBww
 shWB7OOm89bFx/2nf5AiTxv2FT9Ev+W8lCX0bJIfZHnsJy4L1Se13DNJ9NCMZxHglt6Sms
 68qU9dECvPs+4caSORNmjuc6Q/OCFXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636640942;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tbsZL0grzbPtO7uqQkfQXqAGaKR6+l/cX1EEdR1f8Vk=;
 b=zdcPtObaHkOkYoSV99pFLUo6aW23uPjs6MS7E3M56LE/2/wuEwABAhsOCz+w2ZFpdwUbzs
 GTVtna6e2i8kLsDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AD2F1407D;
 Thu, 11 Nov 2021 14:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MywGDq4ojWHnVgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 11 Nov 2021 14:29:02 +0000
Date: Thu, 11 Nov 2021 15:30:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YY0o7jAxgIHvmczq@yuki>
References: <1636455285-8372-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1636455285-8372-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YYv0Kn16GGGgJpIn@yuki> <618CD8F5.4070408@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <618CD8F5.4070408@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 07/12] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >> +	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
> >> +	rc = fscanf(f, "mke2fs %d.%d.%d",&major,&minor,&patch);
> >> +	if (rc != 3)
> >> +		tst_res(TWARN, "Unable parse version number");
> >> +	else if (major * 10000 + minor * 100 + patch<  14300)
> >> +		tst_brk(TCONF, "Test needs mkfs.ext4>= 1.43 for quota option, test skipped");
> >> +	pclose(f);
> >
> > Ideally this should be added to the .needs_cmds instead so that we get
> > the minimal version in the test metadata too.
> Good suggestion, I am looking your code. But As my commit log said,  add 
> a lib mkfs.ext4 version check after this quotactl patchset are merged.

Sure I will continue with the review of the patches next week.

> Then we can add this version check and make use it for not only 
> quotactl04,08,09 case but also for statx05.c.

Indeed, the plan is to use this for all tests that needs to check any
versions of the tools.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
