Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75D3C61DA4
	for <ltp@archiver.kernel.org>; Sat, 18 Feb 2023 05:50:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37C183CBDAD
	for <ltp@archiver.kernel.org>; Sat, 18 Feb 2023 06:50:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDA5B3CB041
 for <ltp@lists.linux.it>; Sat, 18 Feb 2023 06:50:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2795810004A6
 for <ltp@lists.linux.it>; Sat, 18 Feb 2023 06:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676699397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dUgX7iA34rv9TAGfaVMdCTHxNi0b63cr59agRxDe0Vk=;
 b=W+cxe3FrV472T88w510Jii5jLtUMIvUQCZEDKfil3lCpuVositqyrBFCKp+5Pi9NVrv4Ni
 dyHy1KXvd/24WfdqIH7A33Nvaz+bj/q3rXuMqIROw/YVsC2dyGXApuP/9XJ1vwLBgiauhW
 f9dc8O4b9U6U/OVVhjrwrQyX4Wa3diA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-uzkWjGrzPK60D_Xpp0s7BQ-1; Sat, 18 Feb 2023 00:49:53 -0500
X-MC-Unique: uzkWjGrzPK60D_Xpp0s7BQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 o25-20020a05600c511900b003e000facbb1so78193wms.9
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 21:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dUgX7iA34rv9TAGfaVMdCTHxNi0b63cr59agRxDe0Vk=;
 b=0FZ9WhkoCwCH7rcOOwH554Ez48fgIwOgqJZMxif/WNY3HYsEeeeQGbtkjnFGfWpiHA
 8X2wJ5icjoWfgU9Pk1C2g2pmfjogcYTPvQv0cnQxBnYKXpfvTyAlOslsoxQehUB+BE2T
 IBq8NIHIVPlSZZt+8aO+TI7k5s0vlKhYoJgYyxed1Pu5H5CGEjFxol4jd+0GpY2H1ONN
 Ho89r1VX2s7WJJtVMqXdjRTKVoI9OwQT6yaFZHVdpEi3DlzWYIA4ixHtko+9iUcjjE0r
 Ju/e/oidUK03CMdljT/c6jg4BNlUDw90X1y2ue9t/PFfrq3OCd5xkaz3US7X/XRzt3mD
 yJBA==
X-Gm-Message-State: AO0yUKVaX9vlwFgPHZVLDKphH7RzMgOzMfersDLPmVvJDYQJFhkb9kTO
 oPBzlor95GjcTEjxCc9SkIVElaZU9zbEDRFlgkmerD8WAwFAcEc7F7jUMwOC3Jjt45gEQTfMflM
 HK1wLoKFD7WZVTJtXcxbALAAuYWM=
X-Received: by 2002:a05:600c:444c:b0:3dc:42e7:8d38 with SMTP id
 v12-20020a05600c444c00b003dc42e78d38mr500687wmn.93.1676699392722; 
 Fri, 17 Feb 2023 21:49:52 -0800 (PST)
X-Google-Smtp-Source: AK7set+fX3WXcQm8kAt7BeFOnDKFq2HINt12xFRFv5NfVfe4UBe1T6zEUQ2zCmy16oCd6xDxSk5D6/d4RYp/uiv+4xU=
X-Received: by 2002:a05:600c:444c:b0:3dc:42e7:8d38 with SMTP id
 v12-20020a05600c444c00b003dc42e78d38mr500676wmn.93.1676699392368; Fri, 17 Feb
 2023 21:49:52 -0800 (PST)
MIME-Version: 1.0
References: <5ed4bc3d-9c30-8cae-e826-b2d0c37c2f6e@huawei.com>
In-Reply-To: <5ed4bc3d-9c30-8cae-e826-b2d0c37c2f6e@huawei.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 18 Feb 2023 13:49:41 +0800
Message-ID: <CAEemH2cEyLkWvrds9vvMX6S5dDkJvtJ5zhWRsySKL7ShD-cJDQ@mail.gmail.com>
To: Yongqiang Liu <liuyongqiang13@huawei.com>, LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [QUESTION] ltp: mavise06 failed when the task scheduled
 to another cpu
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
Cc: "Wangkefeng \(OS Kernel Lab\)" <wangkefeng.wang@huawei.com>,
 David Hildenbrand <david@redhat.com>, peterz@infradead.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 mingo@redhat.com, mgorman@suse.de, vincent.guittot@linaro.org,
 akpm@linux-foundation.org, dietmar.eggemann@arm.com, vbabka@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yongqiang,

Sorry for the late reply, I missed your email because of the filter.
Next time, plz remember to CC the LTP mailing list: ltp@lists.linux.it

We ever submitted a patch for reducing this happening in:

https://github.com/linux-test-project/ltp/commit/00e769e63515e51ee1020314efcf4fe880c46d7c
And from our team testing, there do not be similar failures happening
anymore since then.

-----------------------

BTW, recently we catch another issue:
      43 madvise06.c:201: TFAIL: less than 102400 Kb were moved to the swap
cache

And I started an RFC patch here:
    https://lists.linux.it/pipermail/ltp/2023-February/032945.html

<https://lists.linux.it/pipermail/ltp/2023-February/032945.html>

On Mon, Oct 11, 2021 at 4:14 PM Yongqiang Liu <liuyongqiang13@huawei.com>
wrote:

> Hi,
>
> when runing this case in 5.10-lts kernel, it will trigger the folloing
> failure:
>
>   ......
>
>      madvise06.c:74: TINFO:  memory.kmem.usage_in_bytes: 1752 Kb
>      madvise06.c:208: TPASS: more than 102400 Kb were moved to the swap
> cache
>      madvise06.c:217: TINFO: PageFault(madvice / no mem access): 102401
>      madvise06.c:221: TINFO: PageFault(madvice / mem access): 102417
>      madvise06.c:82: TINFO: After page access
>      madvise06.c:84: TINFO:  Swap: 307372 Kb
>      madvise06.c:86: TINFO:  SwapCached: 101820 Kb
>      madvise06.c:88: TINFO:  Cached: 103004Kb
>      madvise06.c:74: TINFO:  memory.kmem.usage_in_bytes: 0Kb
>      madvise06.c:225: TFAIL: 16 pages were faulted out of 2 max
>
> and we found that when we call the madvise the task was scheduled to
> another cpu:
>
> ......
>
> tst_res(TINFO, "before madvise MEMLIMIT CPU:%d", sched_getcpu());--->cpu0
>
> TEST(madvise(target, MEM_LIMIT, MADV_WILLNEED));
>
> tst_res(TINFO, "after madvise MEMLIMIT CPU:%d", sched_getcpu());--->cpu1
>
> ......
>
> tst_res(TINFO, "before madvise PASS_THRESHOLDCPU:%d",
> sched_getcpu());-->cpu1
>
> TEST(madvise(target, PASS_THRESHOLD, MADV_WILLNEED));
>
> tst_res(TINFO, "after madvise PASS_THRESHOLDCPU:%d",
> sched_getcpu());-->cpu0
>
> .....
>
> Is the PERCPU data swap_slot was not handled well?
>
>
> with the following patch almost fix the error:
>
> e9b9734b7465 sched/fair: Reduce cases for active balance
>
> 8a41dfcda7a3 sched/fair: Don't set LBF_ALL_PINNED unnecessarily
>
> fc488ffd4297 sched/fair: Skip idle cfs_rq
>
> but bind the task to a cpu also can solve this problem.
>
> Kind regards,
>
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
