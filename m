Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D66C433EF
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 14:33:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52966109E
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 14:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A52966109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1B123CAB2F
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 16:33:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB31E3C330B
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 16:32:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CAE8860106F
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 16:32:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EA4301FD85;
 Thu, 23 Sep 2021 14:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632407569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mGsRdb1I39kcdiEauBXZuCyxC+kK75g34b6QSVlJAu4=;
 b=0gYwHqtnDndadD2e7L+L9qotEEf9EozO/pSu0iXBeG688PFC7tKvOHup6fRVpuyWlw43dj
 qwf3EW4PMHi4xxOLwsRGqRcX1Npa+gmB3x215LMkskxzEblrI6bY3koageEf4wPbNNi4NU
 Qc2RDJtdz/w2QeL07J+UVjBoVzp50/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632407569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mGsRdb1I39kcdiEauBXZuCyxC+kK75g34b6QSVlJAu4=;
 b=G/OXe3+Kj3WrMFoaB+PsQNxT5gmdclOMTFC6LfC5fKCJUAKoiOpris7cPjmOvgmTv4AO5/
 sQ0uxjRVAMhEaOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE38813E76;
 Thu, 23 Sep 2021 14:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ek/QMRGQTGFIcQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 23 Sep 2021 14:32:49 +0000
Date: Thu, 23 Sep 2021 16:33:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Message-ID: <YUyQMBLPbCs4/Gur@yuki>
References: <20210817104625.2559362-1-liwang@redhat.com>
 <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki>
 <20210922165218.GA3081072@maple.netwinder.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210922165218.GA3081072@maple.netwinder.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
FYI I've tried to run syscalls on a VM with 256MB RAM just to see what
explodes and it looks like futex_cmp_requeue01 fails as well because we
don't have enough memory to fork 1000 processes. I guess that we really
need an API for at least rough scaling for the number of processes we
can run based on free memory. With that we could finally fix the
msgstress testcases as well.

Also it seems that in my case the tmpfs returns ENOSPC correctly when
the machine free memory gets low enough regardless of the limit set at
the mount time, and that's 4.19.0-16-amd64. So I guess that there may be
something wrong in the kernel you are testing after all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
