Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05DC433EF
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 13:09:42 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11763610D1
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 13:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11763610D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E9743C8FA3
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 15:09:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 741AC3C79C0
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 15:09:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8B0271A01545
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 15:09:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B447A1FFB0;
 Thu, 23 Sep 2021 13:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632402568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xUISyGj9ite+0PPleIQtCiv7xvBGPFUoPW8ILZCCIKg=;
 b=QGG0mjJ4e0oAAw+EpCn0WT675PXy7zmKEa7bHZt7v/h2LR8sFlCQ689vsIQAaUlDN8K/0K
 Xj8wAB1rDHx3wOXOBtARfvNpQu+AXYnYtxrPY/qXDyvgMDoIRNYAiMzR6E8scuhwP1hmYN
 1cdDaw3GnW/hKDwGY+zopQ1ysMKBmkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632402568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xUISyGj9ite+0PPleIQtCiv7xvBGPFUoPW8ILZCCIKg=;
 b=S9a6f8t8yc/37OY8hjMShRNqh+7kyHrr8mgWqSp0Ab9Pm09yFKO5rVpoma39wLuR36nZK0
 T8Q6nls9cexzKZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E9A113DD5;
 Thu, 23 Sep 2021 13:09:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QofcJYh8TGE8QAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 23 Sep 2021 13:09:28 +0000
Date: Thu, 23 Sep 2021 15:09:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YUx8p515ro8Y/Z8l@yuki>
References: <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki>
 <20210922165218.GA3081072@maple.netwinder.org>
 <CAEemH2cj3AJU01aUrodUh6WnSioyWmzC4U53gEumM9p7hnxmfw@mail.gmail.com>
 <CAEemH2f0+SL6pizzNs4syontAD5SeKmXFbVchRs=oXM-oEsEzw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f0+SL6pizzNs4syontAD5SeKmXFbVchRs=oXM-oEsEzw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
> Or, another way I can think of, is to cancel the tmpfs size limitation
> when MemFree is less than the twofold size to be mounted.

This would fail horribly if the machine has all RAM used but there is
plenty in buffers that should be freed.

I guess that we should really add tst_available_ram() function that
would print either MemAvailable or sum of MemFree + MemCached. And of
course we shouldn't eat more than half of that in the tests.

> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -895,6 +895,9 @@ static const char *limit_tmpfs_mount_size(const char
> *mnt_data,
>         if (strcmp(fs_type, "tmpfs"))
>                 return mnt_data;
> 
> +       if ((SAFE_READ_MEMINFO("MemFree:") / 1024) < (tdev.size * 2))
> +               return mnt_data;

I guess that we should as well skip the tmpfs completely if we think
that the size is too small as well.

>         if (mnt_data)
>                 snprintf(buf, buf_size, "%s,size=%luM", mnt_data,
> tdev.size);
>         else
> 
> 
> -- 
> Regards,
> Li Wang

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
