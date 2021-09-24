Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9294C433EF
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 01:49:16 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E55B61152
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 01:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E55B61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EE6E3CB389
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 03:49:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E0FE3C6E48
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 03:49:03 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 115D66009D4
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 03:49:02 +0200 (CEST)
Received: by mail-qt1-x82c.google.com with SMTP id r16so8097186qtw.11
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 18:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rjn7aB7pBry+pt12kluBazATUfRYnl+KY0Tk2zBMeAs=;
 b=xXGolQmbMY9nWOtZ82JpsGiRwaKgwdc/ut6qui7AFXhd7/peL8bpCiI/XxfF8mSxJH
 NAwXVIu5L64W0OtkY7NyugIDogMYPbgsxOrZsbonmcK6f5mARCQNp8P3VQ7UOOz1pxko
 QgZLmKZFTG5chULqtp5IgYz9SPxW+etZ9xB8V4uRavMPLvm+/YHfBFMAlXZAnpF2ISdq
 5zvmapjJb9Bbb8oqZNETkyEaaf7g9Avolzj/Y0d9LezT5JUaomHZ9QzYaykU69NYyTLD
 RowQ2FcqcI4z3zbbR4vIYJFYQkYzMDjShBPBDDv9uc5vHaQSkSR9YvwxmhZf3hNZ81+j
 HFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rjn7aB7pBry+pt12kluBazATUfRYnl+KY0Tk2zBMeAs=;
 b=VQvOl0JY5tiJwpGdu22JbfJM1AFSGn0b2qEUMxvDHO/V8zZAQzmHZj3VrXUAHUcGqu
 BhlD+WYwen4HoZs5QGuiDGM9dqbqXMehaQ7W6asV41YIGpbPGVPJhAa/L2aizwdKrssz
 UcYWJecWs6UILU8Wwos4HRhnjLjloasBJmwUS3D5GZBTXxP81Z6GirT42hF4wHXDo2JV
 ACTLHRU2c4AvTjem4dLtolNH8z/JhBMwWDQKVAWZq74JyzaQHpHa/NRfYOmFnqqgV9KW
 wulGoN03ngCoCnsvPmNVh5JzKDbx/6tJSJKE2PUM0KHGupusfsnshkt8wOVp7t3WoXrD
 Xoqg==
X-Gm-Message-State: AOAM5306N0d9DaucOoyOFwDOhcMVecVCOcmcDAM2+rQ7rdl3lgrt8aCI
 IlLOkBlWOYquYsoLKn5p4fp9+Q==
X-Google-Smtp-Source: ABdhPJzvN85bX0dEtcyR9jSsw2Afqg8pyuQ3e9+WsJITPQe5kdzNhqgrFTOfbwBuQqotwX/tkUMplw==
X-Received: by 2002:ac8:4149:: with SMTP id e9mr1807641qtm.249.1632448141841; 
 Thu, 23 Sep 2021 18:49:01 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id az6sm5428444qkb.70.2021.09.23.18.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Sep 2021 18:49:01 -0700 (PDT)
Date: Thu, 23 Sep 2021 21:49:00 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20210924014900.GA3975163@maple.netwinder.org>
References: <20210817104625.2559362-1-liwang@redhat.com>
 <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki>
 <20210922165218.GA3081072@maple.netwinder.org>
 <YUyQMBLPbCs4/Gur@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUyQMBLPbCs4/Gur@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thanks for the suggestions!

I have tried setting .dev_min_size = 64, in addition to setting 
FALLOCATE_BLOCKS back to the previous value of 16. Unfortunately I am 
still seeing OOM when filling the tmpfs. I am confident I made the 
change correctly, as I can see the message:

tst_test.c:903: TINFO: Limiting tmpfs size to 64MB

For other filesystems (ext4/btrfs/vfat) the test is fine, and I get 
ENOSPC error as expected.

I'm testing on kernel version 5.10.52 currently, but I could also switch 
back to 4.19. I'm on ARMv7 rather than amd64.

Regards,
Ralph

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
