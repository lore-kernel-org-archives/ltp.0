Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D565FC433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 16:52:34 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009526103C
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 16:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 009526103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 005303C91A0
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 18:52:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE9033C736E
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 18:52:21 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 40408600847
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 18:52:20 +0200 (CEST)
Received: by mail-qk1-x734.google.com with SMTP id p4so12089868qki.3
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 09:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ierQAEdCXty+AcvsyJItA7sNUYCuZ8859fONeEh+CGM=;
 b=OU/F/obbthRfw26zoOaoEN92/CCoBkQ9zO+rCgZzmF6CE5bBula9vMHbHcPrCSts66
 +jMrLQOrnXlUQEflScDDP227DufOOjKKNgwHAxTfDVAjSabj6ekzDDxfeNTIgNhn5hEk
 9/45oACWxLXD7/8p1zvaaitl2Be9MxAztvugBYSiHvS5udl8I1j13Z6wQItSULCussN1
 qFn/Fp6vs8VGKT6FGs4GxqWY9PKSTvb0HzzjXgqQnqB7E30gMv4KoPpdgxH+1BLoQxFu
 FJOXSSMVAYtVmTIzF3wQiDmaq1hmY8RabOnsV52ApeIW+eLfn0glMISRlZynnieZBQyU
 eZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ierQAEdCXty+AcvsyJItA7sNUYCuZ8859fONeEh+CGM=;
 b=vETm29u9kdWqv2RDzCPt1Xe64tPYHkmF0v7983PPrJe+u65v9yqyIBMXTIomt85QGx
 PDeYYJHsaHWUBXnXEEXCoMCX1fnOWlpcL+Rvi5416mf/pMe46/LM5qP8spkp9hkpJUdw
 kJRinzvUhynMZqkgxd9bGbD0DcyrxRobjI1soih47kS8dFgQkw6ilG20899JHOpQcNI3
 u+fU19FvSr57GwCswJxs9kjOI7sKGCBZ+fpHc3pGVnGHaTkhn7+rD404C367Nk7izFtb
 BlSQRrnfRZiNMZvypZ/SzT1hCPULhyHvOTB/l95EJEjLkUewCoQnRwSpwUNDwi6+Bd4b
 mpSQ==
X-Gm-Message-State: AOAM533HYu95vZTeDWOE/ieSKScSiD7HcG9kaFLF7b/m2LP8iXiqqyfc
 N1ZR6dOKqvbqoYq7HIZqcW9VHg==
X-Google-Smtp-Source: ABdhPJyj3Og4yBq/1gk7Q/K17K0E6d5FwWRLKyo5RYg0PpBmuFUvATjNDw4ZxLTY50Dan0q7KHwB2g==
X-Received: by 2002:a37:40c7:: with SMTP id n190mr190572qka.458.1632329539047; 
 Wed, 22 Sep 2021 09:52:19 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id a2sm2152030qkk.53.2021.09.22.09.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Sep 2021 09:52:18 -0700 (PDT)
Date: Wed, 22 Sep 2021 12:52:18 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20210922165218.GA3081072@maple.netwinder.org>
References: <20210817104625.2559362-1-liwang@redhat.com>
 <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUs+jf35Zqp8GjJl@yuki>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

On Wed, Sep 22, 2021 at 04:32:45PM +0200, Cyril Hrubis wrote:
>>
>> That try one by one block after filling full of the FS because nobody knows
>> when fails.
>>
>> But as you suggested we can do that as well for the previous allocation :).
>>
>> So, will you create a patch, or I do that tomorrow?
>
>I will not manage today. So either you do it or I can do it tomorrow
>:-).

I tried making a patch for this, which I can share. But after testing, I 
am still seeing OOM. Upon further inspection, it seems to be coming from 
tst_fill_fs() function, when operating on a tmpfs.  I see the message:

tst_test.c:903: TINFO: Limiting tmpfs size to 512MB

However the machine only has 256MB total, of which at best 200 MB is 
available after kernel has booted.

I'm now a bit confused as to why fallocate05 test worked previously. 
With release 20210524 version, I see the following:

tst_test.c:1379: TINFO: Testing on tmpfs
tst_test.c:888: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1311: TINFO: Timeout per run is 0h 15m 00s
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993
tst_fill_fs.c:59: TINFO: write(): ENOSPC (28)
fallocate05.c:81: TPASS: write() wrote 65536 bytes
fallocate05.c:102: TINFO: fallocate()d 0 extra blocks on full FS
fallocate05.c:114: TPASS: fallocate() on full FS
fallocate05.c:130: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
fallocate05.c:136: TPASS: write()

Whereas with the latest git version, it seems to create two more 
additional files, before OOM kicks in:

tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:922: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 512MB
tst_test.c:1353: TINFO: Timeout per run is 0h 15m 00s
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file5 size 4807935
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file6 size 90739786
<... OOM begins here ...>

Any thoughts on what might be happening?

Regards,
Ralph

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
