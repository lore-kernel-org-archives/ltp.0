Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A13C3DA60
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 10:07:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED24C3D1B06
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 12:07:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AD2A3D0D24
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 12:07:03 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BE0FD141051B
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 12:07:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721297219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gky47ycdh5X7b1aaKOCZEQPyRGSBaAAExdUF2MldKFU=;
 b=Wim5tjYaQmHbmzWhxOKsoibDUH7K1RV1Eifr0e32D+mynX2SxM1nmY2Jjo85l2UPEjR9ml
 bPgR3F5LYEjt/eMzd+wejIk/lRwwr2ngOzOPHZhBa90zZL+dmixJF0QnADeEJIJp8vEtob
 EuTRujcimYe31nHdoMj7VGKYXpHLGhA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-PJVdluvxOFaQIIORDR_xWQ-1; Thu, 18 Jul 2024 06:06:57 -0400
X-MC-Unique: PJVdluvxOFaQIIORDR_xWQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2cb5ab2f274so151253a91.3
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 03:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721297217; x=1721902017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gky47ycdh5X7b1aaKOCZEQPyRGSBaAAExdUF2MldKFU=;
 b=ONI+QQiRVeS/brO/XfGNmIgqH7FSoWWDZWo0/8ArwEvsEM/lA+IJfPkLc6bwqPC4L6
 PnkjvYPywWXznY7hTAuw8x55or1q1PuhA/dzbbe5wbl3KNrYFYNxwi2MVMAdwxzSjcFu
 EmLrDHpPa/XtWq2pSQPxSXoPjWGglmThNX2HKl+SaFeJWalftSl+i/TKGfTai+67Crzx
 CKyFhrUU4krsTyGGItN+KKVktf44QMpVnuPqm2FwjLYcbDvLMtZi8Z5y3VwPOsLUkp0l
 MNowd54QXU9o4y2TqBPt7qdF1kWhsDMWmdKCdX3bSZaiAt4wfxBIudLzC13PdlAPi8yM
 Rh+Q==
X-Gm-Message-State: AOJu0YxykzfvlbX/Ww4nP2Cw7mR2mBCXnqBcXOmeQNCZPA41jp1JrPo+
 +k6o7aTfHfCYeQTAHSSbC4AFIVQpNL2Tjhz9JiAxFw9QGaOsWO5KQAk6UX+Y3yGhLx5WLjq+mjl
 ZNn6/CrD5Q54i+jz7OVyoHirbK6+eEJRGjU6YSFeh3ryqfDwAfz5YBuPDnE5SVga0x7HivIgKAP
 /0NidrBsPE7gs9OCSSZg1DQz4=
X-Received: by 2002:a17:90a:c902:b0:2c9:65f5:5f5b with SMTP id
 98e67ed59e1d1-2cb527b8918mr3760143a91.24.1721297216692; 
 Thu, 18 Jul 2024 03:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWB9todt5KecIXVoTz1XS7wCxLZ9++1eq2k7zqGohbvZQrlBD21e6N/agp9+0Z96Fhx7LrQpBQBZn4g2P8rXE=
X-Received: by 2002:a17:90a:c902:b0:2c9:65f5:5f5b with SMTP id
 98e67ed59e1d1-2cb527b8918mr3760123a91.24.1721297216180; Thu, 18 Jul 2024
 03:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1721293231.git.pengfei.xu@intel.com>
 <554f6a9949dae600e880dad306819afdf8aaf914.1721293231.git.pengfei.xu@intel.com>
In-Reply-To: <554f6a9949dae600e880dad306819afdf8aaf914.1721293231.git.pengfei.xu@intel.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Jul 2024 18:06:43 +0800
Message-ID: <CAEemH2cAXHb_bkUVk+bF3zXqROR_07MjVGvnQQcs9NDq6pdOeg@mail.gmail.com>
To: Pengfei Xu <pengfei.xu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 1/1] migrate_pages03: remove
 wait_ksmd_full_scan() check because it's not necessary
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
Cc: feij.fnst@cn.fujitsu.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Pengfei Xu <pengfei.xu@intel.com> wrote:

Remove wait_ksmd_full_scan() check because it's not a necessary step for
> migrate_pages03 syscall test:
> 1. KSM(kernel samepage merging) could be enabled and it is optional for
> migrate_pages syscall testing.
>

The wait_ksmd_full_scan guarantees the actual merging happens then test
can migrate those merged KSM pages to reproduce the regression panic in
kernel commit 4b0ece6fa0167b.

So this is a necessary configuration before testing.


> 2. When server launched any qemu guest, wait_ksmd_full_scan() will in
> infinite loop due to /sys/kernel/mm/ksm/full_scans number would not
> increase anymore, and migrate_pages03 will failed with timeout reason.
> After removed wait_ksmd_full_scan(), migrate_pages03 could pass without
> issue.


Yes, this timeout problem likely exists. That is the KSM design which can't
avoid "unrelated" page merging happening in the background.
But removing the wait_ksmd_full_scan might not be a good approach IMHO.

Cc @Andrea Arcangeli <aarcange@redhat.com> if he has good suggestions on
the test.


> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  testcases/kernel/syscalls/migrate_pages/migrate_pages03.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
> b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
> index 4d3299b61..f514ed10c 100644
> --- a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
> +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
> @@ -95,7 +95,6 @@ static void setup(void)
>
>         SAFE_FILE_SCANF(PATH_KSM "run", "%d", &orig_ksm_run);
>         SAFE_FILE_PRINTF(PATH_KSM "run", "%d", 1);
> -       wait_ksmd_full_scan();
>  }
>
>  static void cleanup(void)
> --
> 2.43.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
