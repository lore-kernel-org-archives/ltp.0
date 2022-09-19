Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD0CC54EE9
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 14:16:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA1683CACFF
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 16:16:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4478A3C8D45
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 16:16:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6CD63600642
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 16:16:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6FCD7220F9;
 Mon, 19 Sep 2022 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663597002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyS1OAEGvr8pbkfK8uYy+aNbuqlI/u2E+OgR5evoMFI=;
 b=a4+sWV/cSs0p9eg885UoSMBFyEFmBX4tLzll+aveMYjU4+1wuEbw5mcgijPqcsQFGntab9
 aZKgGK4F5nvGHRYHOCiyjM8yf6T9eVStu2S4206zX6bpdqjEzepNRjfcDNXvnUC02sek7N
 f0x/AJe3KAMjFt8cxR6Th9szDz7UG6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663597002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyS1OAEGvr8pbkfK8uYy+aNbuqlI/u2E+OgR5evoMFI=;
 b=AHoTAdI3hike4JIMoj9HUOswimduZaPj65iJw2/NIZthVhjTrmzO5Nii+uKQgTmvkQI5TH
 2uTiXVSXQUlazFBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58FC313ABD;
 Mon, 19 Sep 2022 14:16:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8NReFMp5KGNPXAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 19 Sep 2022 14:16:42 +0000
Message-ID: <0304d088-900d-9224-28c2-df4e4fde12b5@suse.cz>
Date: Mon, 19 Sep 2022 16:16:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: lkft@linaro.org, ltp@lists.linux.it
References: <0100018355b1edc0-de081137-73fa-4649-80be-4c68e9432534-000000@email.amazonses.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <0100018355b1edc0-de081137-73fa-4649-80be-4c68e9432534-000000@email.amazonses.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for 8ff3f5f
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
Cc: lkft-triage@lists.linaro.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 19. 09. 22 14:21, lkft@linaro.org wrote:
> ## Build
> * kernel: 5.18.19
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-5.18.y
> * git commit: 22a992953741ad79c07890d3f4104585e52ef26b
> * git describe: 8ff3f5f
> * test details: https://qa-reports.linaro.org/lkft/ltp/build/8ff3f5f

Looking at the syscalls log through test details link above, it appears 
that the test is running the latest stable release (20220527) instead of 
the commit reported by git describe (8ff3f5f).

- commit beedc4211b2afddabf2469668b4f32f06a91f12c is clearly present 
because preadv203 timeout is 2m30s (LTP_TIMEOUT_MUL=3)
- commit e0c6fbec7f4d5e8df7ef2c3d86cf5ab8a9de6fe5 is missing because 
there's not mention of mount_setattr01 in the syscalls log.

https://qa-reports.linaro.org/lkft/ltp/build/8ff3f5f/testrun/11965314/suite/ltp-syscalls/test/mq_timedreceive01/log

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
