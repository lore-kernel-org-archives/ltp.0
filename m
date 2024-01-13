Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BEBC4707B
	for <ltp@archiver.kernel.org>; Sat, 13 Jan 2024 07:05:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F4A43CE3AD
	for <ltp@archiver.kernel.org>; Sat, 13 Jan 2024 08:05:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D092B3C2209
 for <ltp@lists.linux.it>; Sat, 13 Jan 2024 08:05:21 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C5D3860055A
 for <ltp@lists.linux.it>; Sat, 13 Jan 2024 08:05:20 +0100 (CET)
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-68141aa810eso8031946d6.2
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 23:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705129519; x=1705734319; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GqUVJ8s7EGwnf8VW2qN30KaMR9GjPb0OJdm4xU8DVmE=;
 b=fCp1g9oAR/KM0KR/SyILP8Rr2M7P7Y+N0Ar23ZU6fHBczBfwo5h1zy38DfHw/UU8oX
 ZpNa4vITQPHfQ71WJz+aIR09+zWAoYSuwftgVU02U2GJAQ1ip0P/H1CwgNA7UWo0Kx9f
 SPFpL/xnZNP+lPO2I2a1VDrYc4eBA/HqlVx9/SZ1L1KwKhMRhVKJUMSIPJJjxYUkw3Rw
 pgN+35/c7Yt/ne4oEs9BzY3c13f8rbWJ4ibqvcvFHEFqrzzMV2ylfbZ+mm6KWPRk2QHE
 xP45JP+4lj7Xee3G/mM2Wcz5sQLtNAE3s1io8qw6b/b/uGs7Ooj6dDRU9IAZceaaK7FJ
 S6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705129519; x=1705734319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GqUVJ8s7EGwnf8VW2qN30KaMR9GjPb0OJdm4xU8DVmE=;
 b=u9dvib4kwzhK8k8idW7ZhhqWLZbT8DoshicA9tUPvoIxQMdGbGn2uT9qBeTeXTlv1u
 8+lTmNGQwFVAU6vQ/ft/6YAwB8Qi+VehjhNAMEs6h5OAe9c7wI3JflRfmdCFLE6n/UJW
 ULEwhDdhGBFDGFMZ4iCyy3scfvoe6uTg3LAetCApjodX/ftUhUqhhS8jUtkr4AYh5mx+
 0Yea49E82MM9Ods3m8KJgMSAkWiTc/COkt7fjPofG3J5HQQlk3VZmMzhasFiCfZENIZ0
 xi/PqBdQZfZ8EMLCnJcMZJWM6AzI/hwRFF6gRcBXrrNy0qLdWEO6PKTWSk95hS9I6JKu
 Hi8g==
X-Gm-Message-State: AOJu0YwjGMKtBQez+SU+RwZOHbDmEYvwVAAX7CLr3if5lrQEt+AjvTHY
 lddSeNKfDD7hfd/GPodBhyWk4FL78XhOHet65hqvKyhd12h2oQ==
X-Google-Smtp-Source: AGHT+IFc0y2uSmt7xB6X4CM/6iYzv7XLzqDXm1OMDLNeYk0eIgGxUlMEo1QaTfdT2BHiqR6aEvzb2Y8BVfmQGNWecLs=
X-Received: by 2002:ad4:5be2:0:b0:681:3b95:cedd with SMTP id
 k2-20020ad45be2000000b006813b95ceddmr2122750qvc.59.1705129519531; Fri, 12 Jan
 2024 23:05:19 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYu1hB2OMf0EFrt_86OE=0Ug3y6nQd3=OZeEeM1jp3P92g@mail.gmail.com>
 <11a31e09-2e11-43a4-8995-ae70c5bef8bf@kernel.org>
In-Reply-To: <11a31e09-2e11-43a4-8995-ae70c5bef8bf@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 13 Jan 2024 12:35:08 +0530
Message-ID: <CA+G9fYthC3qsH8ey=j3RvCr4-0zp1S3Ysr5QvY6SptorHpju1g@mail.gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] scsi: block: ioprio: Clean up interface definition -
 ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <niklas.cassel@wdc.com>,
 Linux Regressions <regressions@lists.linux.dev>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-block <linux-block@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Christoph Hellwig <hch@lst.de>,
 LTP List <ltp@lists.linux.it>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 12 Jan 2024 at 10:49, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 1/12/24 14:15, Naresh Kamboju wrote:
> > The LTP test 'iopri_set03' fails on all the devices.
> > It fails on linux kernel >= v6.5. ( on Debian rootfs ).
> > Test fail confirmed on LTP release 20230929 and 20230516.
> >
> > Test failed log:
> > ------------
> > tst_test.c:1690: TINFO: LTP version: 20230929
> > tst_test.c:1574: TINFO: Timeout per run is 0h 05m 00s
> > ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
> > ioprio_set03.c:48: TINFO: tested illegal priority with class NONE
> > ioprio_set03.c:51: TPASS: returned correct error for wrong prio: EINVAL (22)
> >
> > Investigation:
> > ----------
> > Bisecting this test between kernel v6.4 and v6.5 shows patch
> > eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
> > as the first faulty commit.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> This is fixed in LTP. Please update your LTP setup to avoid this issue.

Please point me to the fixed commit id.

I have the latest LTP release test results as ioprio_set03 has failed.

ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
LTP Version: 20230929-258-gec0a8f18b
on Debian rootfs.

Links:
 - https://qa-reports.linaro.org/lkft/ltp-master/build/v6.6.10_20230929-258-gec0a8f18b/testrun/22035919/suite/ltp-syscalls/test/ioprio_set03/history/
 - https://qa-reports.linaro.org/lkft/ltp-master/build/v6.6.10_20230929-258-gec0a8f18b/testrun/22035919/suite/ltp-syscalls/test/ioprio_set03/details/

- Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
