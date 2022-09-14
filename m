Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C97ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 15:19:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAE093CABF0
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 17:19:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 154953CA599
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 17:19:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9810A600F4B
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 17:19:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF5301FD5A;
 Wed, 14 Sep 2022 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663168741;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XxhR9/c6rscbYr2UpdZAKhbH03FeDjciCwSzTdGRGVU=;
 b=okuL/wMw/paqAeNp5gZblZBGkJppO0Uj473ceDRrN9fu7tld/tDkvdO7KiswTo1Eqa4YU4
 rAgE/X4ZkoCNfgRcOgZIhFLzH9XHYYf3YA7zniNeVCAZeYFZn5IFxPJs/yunY3BvvBK0xh
 jCg+pj9s04RLPo0+9BdIe78Smct8ILA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663168741;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XxhR9/c6rscbYr2UpdZAKhbH03FeDjciCwSzTdGRGVU=;
 b=wJ7lA/GSmZtO4oqnwV0/P1i34++zM8YDYhy/9hENaLoWwk3m1WhyFHNre60g4OXErrJHYc
 15dGmnqBXp9XXeAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C76213494;
 Wed, 14 Sep 2022 15:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FrowGOXwIWOoSgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 14 Sep 2022 15:19:01 +0000
Date: Wed, 14 Sep 2022 17:18:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: lkft@linaro.org
Message-ID: <YyHw4gzHXzk69xYL@pevik>
References: <010001833bc43066-a4966c03-28d5-4c2f-a5a5-74dd2195f287-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <010001833bc43066-a4966c03-28d5-4c2f-a5a5-74dd2195f287-000000@email.amazonses.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for 2a7734f
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
Cc: Martin Doucha <martin.doucha@suse.com>, lkft-triage@lists.linaro.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> ## Build
> * kernel: 5.18.19
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-5.18.y
> * git commit: 22a992953741ad79c07890d3f4104585e52ef26b
> * git describe: 2a7734f
> * test details: https://qa-reports.linaro.org/lkft/ltp/build/2a7734f

> ## Test Regressions (compared to fe31bfc)
git log --pretty=format:"%h %s" fe31bfc..2a7734f
2a7734fa4 shell API/tests: Require root for format/mount tests
6c5659e6a shell: Print mount command in tst_mount()

FYI these commits did just small change in LTP shell API,
no C test can be affected (and shell test is also OK)

> * qemu_i386, ltp-controllers
>   - cpuacct_100_100

> * qemu_i386, ltp-cve
>   - cve-2018-1000204
This one (i.e. ioctl_sg01) is probably just timeout issue, Martin Doucha has
prepared a fix [1] [2], but there will be v2. This will be fixed soon, definitely
before git freeze before LTP release (this month).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20220830135007.16818-5-mdoucha@suse.cz/
[2] https://patchwork.ozlabs.org/project/ltp/patch/20220830135007.16818-5-mdoucha@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
