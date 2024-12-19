Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD57E77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 08:55:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 165C83EC0C5
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 09:55:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C89823E12DE
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 09:55:06 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6378862FB75
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 09:55:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734598502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nVV4GSQk6KMacgfetuytahVWzR71aXt5L9M6BI92g4U=;
 b=JYaHvkJrxrlmOsKwnfV5SKuJJGjCPzDVtQgo7jS/mGZxZarR0462W/ARipQbit08TYnWyq
 0gWtn4fgRC8ip7cVvSxLtC1s7O+X1r4LeilDWsNrVwBCvVb1bpOp0wPyzMG2doEHqa3NnC
 xNgWcuI07CQ2eqJ8VB7bMznPiV46dbU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-_Lnnt4mNOv6M9dLA516gpA-1; Thu, 19 Dec 2024 03:55:01 -0500
X-MC-Unique: _Lnnt4mNOv6M9dLA516gpA-1
X-Mimecast-MFC-AGG-ID: _Lnnt4mNOv6M9dLA516gpA
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef9da03117so774618a91.1
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 00:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734598499; x=1735203299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nVV4GSQk6KMacgfetuytahVWzR71aXt5L9M6BI92g4U=;
 b=HYPUG+Uj41pzI29c70k+0yrJwrBN7AaOeuMAnyeSlmaCbmwC502IJlGHuV5xTdzkOQ
 4lqX2wPREcwHX4BitlMqelGdOdshOR5HGs3/2syKr6fqxZXa80DwNqgNSRxSsFoLGYVB
 nRfePtqUk/XxouQ2rOXfWTXbtzrdvVbEtQjPefn5eJS8QO+8nDZ2BAU3kImSR0GWg4iR
 Tdw6MfrmS2TM/ow8taqu+M7rAjvIQChfzTRPckOJLC9xmpdmofe9tscc8ALOBGkfPpHb
 ZfZUCqwNXdmc1EVRxuQXcTdUO+ZS/E6iaDA6eUhafPExTJqRC0LX2W/pJJO0XCgHNPEW
 6WNw==
X-Gm-Message-State: AOJu0YyCfbSY5rUx+m2QVCTzobWtUOX1kCw+t0+4lJe4vctAMgX/BVcM
 UXPDcu3wXg7rxTNrKjCybdaPECsLX5Llv6qVg8MbvWAgx7YvHW+Ii0vZqivi5sAGQ5J812OHS7p
 ABmS9I6VPicotDbB3xS1kjU8Sa4wHo587Rrji4EZp5Gcei82TjJdm9bzikBWwPnMxQK/lFLY6wX
 35miyxze14o7h4K6XZfm+og6t7aJoom6FY2i+F
X-Gm-Gg: ASbGncvR/uEYaF7RPtqMNRZoetDMbXbfWaVATZMWp4B3J9fPcl2UkEffbpUgS9RbHbW
 FEe9CM1pqGeLkc3wrVLsSukAxPwe+m5c0Ua5K2aE=
X-Received: by 2002:a17:90b:2f0e:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-2f2e937721emr7929304a91.28.1734598499182; 
 Thu, 19 Dec 2024 00:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFllRFj3LyJBGEpWm3En9E42lijjoZSm+MPGWYRZV6zxmBKBcn29dNZQwfZkpZYD/w4nvISajsoQ/4SfgeZvUQ=
X-Received: by 2002:a17:90b:2f0e:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-2f2e937721emr7929295a91.28.1734598498871; Thu, 19 Dec 2024
 00:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20241210225753.381770-1-pvorel@suse.cz>
In-Reply-To: <20241210225753.381770-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Dec 2024 16:54:45 +0800
Message-ID: <CAEemH2dq0Vg95SMSz1-Y-yAhs-or1Ua2igHFfJ=b-7Su5uN=kg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NU2qeZtKu5qyQWAbjcIHrYthJatBT5F1FnLNEyJJCm0_1734598500
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 0/7] ci: run shell loader tests
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

Hi Petr,

Petr Vorel <pvorel@suse.cz> wrote:


> 2024-12-10T21:07:23.4757888Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484:
> TINFO: Minimum sampling period ended
> 2024-12-10T21:07:23.4758941Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307:
> TINFO: loop = 10000, delay_bias = 0
> 2024-12-10T21:07:23.4760498Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: start_a - start_b: { avg =   -10ns, avg_dev =    17ns, dev_ratio =
> 1.62 }
> 2024-12-10T21:07:23.4761822Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: end_a - start_a  : { avg = 15683ns, avg_dev =    76ns, dev_ratio =
> 0.00 }
> 2024-12-10T21:07:23.4763095Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: end_b - start_b  : { avg = 15947ns, avg_dev =    71ns, dev_ratio =
> 0.00 }
> 2024-12-10T21:07:23.4764323Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: end_a - end_b    : { avg =  -275ns, avg_dev =    18ns, dev_ratio =
> 0.07 }
> 2024-12-10T21:07:23.4765493Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: spins            : { avg =   341  , avg_dev =    27  , dev_ratio =
> 0.08 }
> 2024-12-10T21:07:26.9727369Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494:
> TINFO: Reached deviation ratios < 0.10, introducing randomness
> 2024-12-10T21:07:26.9728387Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497:
> TINFO: Delay range is [-15945, 15847]
> 2024-12-10T21:07:26.9729228Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307:
> TINFO: loop = 218505, delay_bias = 0
> 2024-12-10T21:07:26.9730199Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: start_a - start_b: { avg =   -85ns, avg_dev =     8ns, dev_ratio =
> 0.09 }
> 2024-12-10T21:07:26.9731309Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: end_a - start_a  : { avg = 15814ns, avg_dev =     7ns, dev_ratio =
> 0.00 }
> 2024-12-10T21:07:26.9732397Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: end_b - start_b  : { avg = 15913ns, avg_dev =    10ns, dev_ratio =
> 0.00 }
> 2024-12-10T21:07:26.9733462Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: end_a - end_b    : { avg =  -183ns, avg_dev =     9ns, dev_ratio =
> 0.05 }
> 2024-12-10T21:07:26.9734493Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: spins            : { avg =   184  , avg_dev =    10  , dev_ratio =
> 0.05 }



> 2024-12-10T21:08:22.5072327Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:654:
> TINFO: Exceeded execution loops, requesting exit
> 2024-12-10T21:08:22.5073965Z
> /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TFAIL: acs:0  act:1
> art:3  | =:24   -:2999931 +:45



> runtest TINFO: * tst_fuzzy_sync02
> ...
> 2024-12-10T21:09:01.0848787Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484:
> TINFO: Minimum sampling period ended
> 2024-12-10T21:09:01.0849660Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307:
> TINFO: loop = 10000, delay_bias = 9931
> 2024-12-10T21:09:01.0850640Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: start_a - start_b: { avg = -3787ns, avg_dev =   134ns, dev_ratio =
> 0.04 }
> 2024-12-10T21:09:01.0851859Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: end_a - start_a  : { avg =  6983ns, avg_dev =   645ns, dev_ratio =
> 0.09 }
> 2024-12-10T21:09:01.0852990Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: end_b - start_b  : { avg = 13154ns, avg_dev =   190ns, dev_ratio =
> 0.01 }
> 2024-12-10T21:09:01.0854078Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: end_a - end_b    : { avg = -9959ns, avg_dev =   347ns, dev_ratio =
> 0.03 }
> 2024-12-10T21:09:01.0855485Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: spins            : { avg = 16071  , avg_dev =   555  , dev_ratio =
> 0.03 }
> 2024-12-10T21:09:01.0856560Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494:
> TINFO: Reached deviation ratios < 0.10, introducing randomness
> 2024-12-10T21:09:01.0857498Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497:
> TINFO: Delay range is [-11296, 21198]
> 2024-12-10T21:09:01.0858300Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307:
> TINFO: loop = 10001, delay_bias = 9931
> 2024-12-10T21:09:01.0859260Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: start_a - start_b: { avg = -3787ns, avg_dev =   134ns, dev_ratio =
> 0.04 }
> 2024-12-10T21:09:01.0860356Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: end_a - start_a  : { avg =  6983ns, avg_dev =   645ns, dev_ratio =
> 0.09 }
> 2024-12-10T21:09:01.0861433Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: end_b - start_b  : { avg = 13154ns, avg_dev =   190ns, dev_ratio =
> 0.01 }
> 2024-12-10T21:09:01.0862510Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: end_a - end_b    : { avg = -9959ns, avg_dev =   347ns, dev_ratio =
> 0.03 }
> 2024-12-10T21:09:01.0863584Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295:
> TINFO: spins            : { avg = 16071  , avg_dev =   555  , dev_ratio =
> 0.03 }
>


> 2024-12-10T21:09:52.6826456Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:654:
> TINFO: Exceeded execution loops, requesting exit
> 2024-12-10T21:09:52.6827841Z
> /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync02.c:164: TFAIL: 2| =:15



From what I understand, CI environments (GitHub Actions) are shared
infrastructures with limited control over CPU allocation. CPU time slices
may
be interrupted or delayed due to resource contention with other CI jobs.

As both last TINFO print "Exceeded execution loops, requesting exit,"
they fail to meet the success criteria due to resource constraints.
So I guess we'd better stop the test once the loops terminate early.
That's the way to guarantee the precise data needed to satisfy certain
scenarios (HW, VM, CI, etc.).

I will send an improvement patch later. And your patchset itself looks good.

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
