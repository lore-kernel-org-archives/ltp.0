Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E622FE9539B
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770210975; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=S9F8FZrQS1/A6VaXNoIV+o+phW0OfskH8AQ2TydRqUY=;
 b=M0b6VxSqjA7qmDdNh7hv4YjkJMLklvbLMJNv9ttB6YhHBa8k4FwMlYRKp2ZEREkbY/NQp
 kIa8iNd3ovIpCqUfDxBO+xCJWPUohnVqZpeE+NzDMNKfsgKI3c249dHwOaxRiEHIBWhpjAn
 R0aCVXO4NBqD21BGofNQtqwM89UjDJk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 773953CE0E0
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 14:16:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A73D3CCAC3
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 14:15:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6C794600207
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 14:15:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770210951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XXJZc1gHgp/Je/NO3btUCg3reJjnCZ9YSkfIVFg/Z1Y=;
 b=REhhlnLcO00BxDYeIa2Tc69Uc7hctdUvLriRd1Bd+F9QHTPeiQ+H0GxRZ6LtY1So60ncLe
 uUkJf1xtB9mSNEpGXSlXTyIrifmAGRFKY8Tu7oWIqwdSIHIYla18c0pJ9olbo4WHXMfrVE
 tIqBEKJHqrt1Wrx4pmcSPwWd/3Pmnzs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-NQsmp7yRPXG4hxq8XLbP5A-1; Wed, 04 Feb 2026 08:15:50 -0500
X-MC-Unique: NQsmp7yRPXG4hxq8XLbP5A-1
X-Mimecast-MFC-AGG-ID: NQsmp7yRPXG4hxq8XLbP5A_1770210949
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c5539b9adbcso13748119a12.3
 for <ltp@lists.linux.it>; Wed, 04 Feb 2026 05:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770210948; x=1770815748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XXJZc1gHgp/Je/NO3btUCg3reJjnCZ9YSkfIVFg/Z1Y=;
 b=VLbQm9pz/kJH70SGuVGFt+iaAqARBh+aZ4dm41ViSx6UilWYV46p9UmXfkkexmfDaS
 hYoqoFd2qDq9XwPjhieoe8XJwu1AhajTuyrKLjWmAdBh9mvfSFATM3Lu40iDlIPsq3Vh
 Gy3ybVhyiBnqptc5Nvziil/AHPFvhjj8W9f4blzxameEcQjb5Bt3fSo035K1R7G4QFCu
 jzrPRYQFRsA8sb8BkP3ZzW47OAajM32+UOjlh6vJETSUCZBl0DuP1T2q1HxLjfgQGRKn
 AmlDlI+5km6yMxhWJx5pB3d6oox6CGs4MxWV5p+tay0gTewP596LpPeiija9aqphxjNs
 EiiA==
X-Gm-Message-State: AOJu0YxVrx4XdmBjZAgodiTFKMDHpBfcpvzqQCcXnmOK3HatrYaH9BNq
 ZIDtEF4AhqYKcDMZIH3n1NT3sdq3Jd4nxS641kcLX4R/1EwYe3GmdEotwISFFxVdxUFGoBRehfQ
 Z7qMUNhw7MlSt+TM4/tVqRo+X6GffvYEVZxZEbVa8wZMWZ4bk9rArVnO1MT2R
X-Gm-Gg: AZuq6aJ0mfxYdWoiK/NpZx/HRV20QVJQPnLKp+RH5/uS/FfCUIPDsZtIQZM4gJTvse9
 wSNJHzeaeBHmMxMMYxXN2E584HwSJngNZd4vJodjIutlzp/hzL0A6uhTJeluMD5Yix9H7EnOhtZ
 UirCfwJ8QPBmY7XvT9iOuHNZ1JKXa7RzqnpLjUZ4P+YYJ7AUq1iR7EFUeExnOqo+eJIRq9L2w+w
 dGBbYlrs9mQanbhwf8RTjqMISq0fKXdd3a0xD8QPC4qftBBZClQaMkXxXxSzNBVHgnBDazO7PLw
 RJP89xrTPOHPa7CZV9XOY7nHTLSRNxVtD8KjZNK2JES0cUvBRT2ltsqeL8dbEb1dXuGCc1bfWig
 lgzbz
X-Received: by 2002:a05:6a20:d523:b0:38e:90ca:5a4b with SMTP id
 adf61e73a8af0-3937241413fmr3020389637.45.1770210948628; 
 Wed, 04 Feb 2026 05:15:48 -0800 (PST)
X-Received: by 2002:a05:6a20:d523:b0:38e:90ca:5a4b with SMTP id
 adf61e73a8af0-3937241413fmr3020362637.45.1770210948136; 
 Wed, 04 Feb 2026 05:15:48 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c82e37b68sm2124035a12.1.2026.02.04.05.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 05:15:47 -0800 (PST)
Date: Wed, 4 Feb 2026 21:15:44 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aYNGgCJmEhv5nXYL@redhat.com>
References: <20260204115339.224261-1-pvorel@suse.cz>
 <20260204115339.224261-4-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260204115339.224261-4-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qE61kvPKUOhZAlnbb-a8Y3-DBCymwWOa1etRIViEWkU_1770210949
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] runltp: Remove
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel wrote:

> It was replaced with kirk.
> 
> https://github.com/linux-test-project/kirk
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  Makefile |   2 +-
>  runltp   | 959 -------------------------------------------------------

Perhaps we could create a symbolic link in the root directory pointing
to /tool/kirk/kirk-src/kirk?

Otherwise, people might be confused because they can't find the LTP
runner in the root dir.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
