Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A40AC83F1A
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 03:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752205734; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=OFUDBVoJW6WxFQXuMPQ8GBB4PofzdHAqlIor6lT9cfo=;
 b=LaoHkK1pRlS05NYEcyyyu3FjpCB2GFj3ik9l8TipJ3AXjz1QFq0lRrbwvb7q/rZxBWqNR
 rzcsXobYCpCOCBLnea+GgDmeRazii3aaxhpdgcvtWwnqPe4RIxsQ7epaFIOGMP01XIbP3WX
 6m10olnmf7vOSza1eJTRNEi23UBOux8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C7723CB2BB
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 05:48:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 673B63CAF8E
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 05:48:33 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0A59D1A00666
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 05:48:31 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso11827915e9.2
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 20:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752205711; x=1752810511; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=96JxJF9UuYryDobI5D/PHhOKBv2eUzCzaVKWGqAb9Hk=;
 b=glTDMxXgi4manxFdDBBQgpiC/psAqfNLDJqwC9wcEdBCkbWkjkQLAV3b4PMyjJZYne
 lVMt73qdy0m3WUfXpn4xQLZ55cgvgP8EVQK8VYAAa2RAPSR4S8tVnwM856BSkKRWO0MN
 dPFLgTVVhh4sI+dgzfxMoZy0jtH7WxOtY7uvrO/XX8CPgEWhFbbzr5ml6ReWouf59Hy0
 3OrRITgXjkE1Krx+gizyucnUdZldcAUdRlbW3FJL/BCUZTmDUVuJHj+I+JcCLYkK8oAS
 6V97ywsUU9mZstW15/KHHAghgYqVYaahodHtjqWNGmrSfOL+UFgO08s2o29Qsbk349rq
 JZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752205711; x=1752810511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96JxJF9UuYryDobI5D/PHhOKBv2eUzCzaVKWGqAb9Hk=;
 b=FCVetaQhLllDz9e0R9ZrkNwTghI7BCP+gSeYK/KIplJZdOes5n7mxobi2wcKGaPn/D
 w8C6X0JEpoVVF1zwiKXAI6nJQ0yhzBCrE7fQ/ssrxWVsKVuSf/bg7Dju9yRSIrW//7Xx
 fMJlE4YTkR1zOmVsUo78AicB8sCUZSbK4idjbs8ngauXy8eLEpmafyI8NnI9BY+J3jSM
 5PSSW8n7SyoDHonMzjlGrWNJ3MLrsSONuImsCXFbxwSGP4lfGwcDIbzzdshmaD/VYyrx
 V1lmEzbDHXjgpFnzAPyDe0LKLeN+pIBZhHykCvkwW9eb3660XjjMvAgFGpjmKL83rR+E
 5akg==
X-Gm-Message-State: AOJu0YyL9CPe06iRA9LeaiioxAKPtfFakhHMNJo9/XZ+7lrgEvMW34+Y
 9nhT4TgLVfNABlZMpCG7jSsRmA5BqsbROj2CWVHhNRjq4vQs+ZNUx14NTNpymK1udw==
X-Gm-Gg: ASbGncuHxvYKwHFDm/hwsKiYDt5NjM1/dQ4KYEuIWXSZjSv3JXvLh1j0hVM5kNhgC4h
 XQbHf6IevY006WJp9M2rtCcLem7rqQSOARAgKTu/YExZlZ1Fl+7SER14Fd0REJXS77rhNMg8h7H
 53DUCPrqY0MOd/S+CI1lYNQVm4XWUREcANnNyWYb0D0IL9b9R46ZuUtRznJgipPbndLoDaa0VUx
 F7x4U8nJOqmImwzgKlx5QnS+DhwXbyQxDHZbkJ4tSbTKX2FuDvj2N0rl9niZYxHCn4zXA3MUI2k
 UcMZw6Oh9AX3PVv7x0zsK6g2RYOq/gupswuyCmfLn0tmgRxLQ//Cx72quOeT3/ASxPsf3G7ua7o
 54nx7q2pFxqYeOmlh8wGxZw==
X-Google-Smtp-Source: AGHT+IGnNS78z2RUnwr+tE4TE3kYUUAHyYZ2JypXGIiuz1+sqwjYfSSif/Ad+qx8IbTnoDPm2cMOZw==
X-Received: by 2002:a05:6000:e06:b0:3a5:1cc5:4a17 with SMTP id
 ffacd0b85a97d-3b5f18d835emr1031165f8f.42.1752205711298; 
 Thu, 10 Jul 2025 20:48:31 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f8f878sm3746752b3a.166.2025.07.10.20.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 20:48:30 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:47:49 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aHEyJQpeSY-fLpdH@MiWiFi-CR6608-srv>
References: <20250113055231.5908-1-wegao@suse.com>
 <20250226125141.27417-1-wegao@suse.com> <aG_bpRMoMs0XCGiD@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aG_bpRMoMs0XCGiD@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl10.c: New case test PROCMAP_QUERY ioctl()
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 10, 2025 at 05:26:29PM +0200, Cyril Hrubis wrote:
> Hi!
> I've pushed the patch with following changes:
> 
> - removed .needs_root since the test runs fine without root
> 
> - moved the check for ioctl() support into the test setup() and the
>   check for availability is only done on kernels older than 6.11 since
>   it has to be available since that kernel version
> 
> - made use of guarded buffers for the procmap_query structure passed to
>   the syscalls
> 
> What should still be done:
> 
> - we miss a few more errnos:
>   - EINVAL if q->size is too small
>   - E2BIG if q->size is larger than page size
>   - EINVAL on invalid q->flags
>   - EINVAL if only one of q->vma_name_size and q->qma_name_addr is set
>   - EINVAL if only one of q->build_id_size and q->build_id_addr is set
>   - ENAMETOOLONG if build_id_size or name_buf_size is too small
>   - possibly ESRCH if we attempt to get memory map of a process that did exit and was waited for
> 
> - the invalid tests should be split into a separate test and stored in
>   a tcase structure as we usually do, which makes it easier to add tests
Thanks, i will check it.
> 
> Full diff:
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
