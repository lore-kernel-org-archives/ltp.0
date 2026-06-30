Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956D4C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 11:13:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36D373E4B35
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 13:13:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AE943E4B35
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 13:13:37 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A155F60094B
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 13:13:36 +0200 (CEST)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-39b0c6488e6so18894181fa.3
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 04:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782818016; cv=none;
 d=google.com; s=arc-20260327;
 b=XJpfLXIZKolfLpUQKf10OPUHmnIC4At9CpM08b5dXXLV6DO7BMnqsIJLqJkPS5Q/UE
 dQkxG6TMon5av5NqtDCEuKvq+8ZIzeFqkPr5Ykl0pLk2RNuP6tEs86qwccVTppgFOsbs
 uDG9xCfoODVriy0q6UTDJAW1qwXwir+KhIvamiUZDcA/i+MGa3iLXu04nJ57JSU3e6OS
 YlVJU9xmbzFj1K3XapUpc104YERfbWtRmHid4+eU8VLDFESC8jT8K3f/azrFy58Ta7Ee
 ouj9upgaCyvPXqX8H5ot90YxcXTcOQmOE0+y+TrjauZ2dtsH3UDn7A9LdehZjW1m90Xa
 WqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bCkjDvde9m0qupae8aFb8zraMt2QE1cvIAheee7LGTM=;
 fh=UbaYMaZJHA8+s57qVADcfeH20bm7gHs6e2Ol6ZfNNyU=;
 b=ZqflRe1xp52/bwcdzXx8cMcOZpZaAMI/Mr/gTCDiQkywcepEofR0RovDbIGZ6A2YQm
 Ytr5BEJ7ve3EK1IoC4ogmGa0T7bU8czKVhPd8KeWOUHg7S8iBQoj8lpJD1D+VlHz/hMF
 eK96AhlwOAte8VkTe7UFGlPR25hCiXgt+1yJ3JhMBvsTAWCaYl0wAfRGf8OWNVAsrPd0
 MkO/QKx6LX2x80XUzFkAkWMgHcbv/iEDOPCD7//LN+0ErHIQrp+GMAXMl7oIVR0utJKX
 eoI4yoIU/E91tT80COyKt8mRVmhlG+anuKLiGZ2mk9BGFxHNY2tUh4Ukm/oJy1mrWdAj
 SX/A==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782818016; x=1783422816; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bCkjDvde9m0qupae8aFb8zraMt2QE1cvIAheee7LGTM=;
 b=HlaSUaN/Y0wFRBx5hIRI5LgEHcuBR+/sjCArIVpeAcIzecvhBjYgv2Ep9CqD2xvDNd
 Lau+UhnmTPx2nedm7fzU+PlPHHHqy5VokiX9Bv8YwqgZCbfRlXbAcS16X1MZVYYm+kjw
 jpEa9oDR1MxRnd6VSBBTXuC/EBbZtVBlwHZyyrSwzPa2G9pd3e1muwkQ1Q50qCTPaGl2
 3p1J+Gno1RnTMYN/EbzrhZebriml0BCxhC46W4pBUNSZ85TQDnQSjwnPWV4YuhiDKlUR
 ig+Vx6noOoT7g7Dw+kTWbK4V+ePW580d1IOJa3P3+YUplUQVSGaYBhjM38p5/KmTC+4w
 hXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782818016; x=1783422816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCkjDvde9m0qupae8aFb8zraMt2QE1cvIAheee7LGTM=;
 b=bZxhRm25oGL1pBiYsHFcV2Mgn8PBtUTMXSRrZ78dSHlvZ25FXkd33gwOyeMTr1JkCm
 e6SIPRhLeeplSrOVDT9ObJ0jAndjXkwLVianiY6VyIqyV8XNi5fTuuGhRi4DSCdYCd67
 zsNsuAGeMNxCcIGYYMb6r9OqfyahZUFyFmE20UcW85KMr8OsLCrsUP2gGrnzNrASclFv
 8kAG5Hdiy5AdkE+JRZ14Wqx60SH2+V7HCGNfoVVFbFH9FKNifZoONJRBsN4TI2bVJUlr
 rgx545pO2fLduM61hY7wQaG/iKXLhgx4FDMI0bcAFIlpapVRMydavKvL2q3Jo9KKh5jf
 iNow==
X-Forwarded-Encrypted: i=1;
 AHgh+RpimyxqyFjhpR15T3gS2VWXnPy0X3QDefZ1eg3Wh+WkwoW0FsAMhf+ztxdcMgJYF2GcXPY=@lists.linux.it
X-Gm-Message-State: AOJu0YzHxZmK9KdLgOEsvhKSa6AxWZXTsfFHRKrLDl8GTLm8Wlz93/MR
 nFgGVcUbarYGThs8ZPd2z+NHX++VYXI5CdsVmXHO9FTZIP/DGUewR3lwIdNx9PKI+2Y/oKVM64s
 /sUHJvwUz8IHd8v86DtKWlxQFmRwxGpo=
X-Gm-Gg: AfdE7cnd1yv5V5GYyMQI4vPazX+PaDv+zkINelWK97Z2+eAwxip8fJncPmm8jc/g0GX
 z1vuX9DyL+R7l3n4LIyxC1o98zr+yFLGxDDuyGbvkGW00oI/ykpcEHFbKrnkYCk795me8q69YiN
 5gYuvoTWGwlzc06MM5MA4m9CjLt+S0FVRTaSJwqANOiJeIMCStX5TPJcjN9wyC9AGrpC1xM5k9D
 EAvFK1xDe6ucAIA5Ap8JNhBqLvfEE55O4guAkZ/F/TFLlOU4xyGR5Y77QWel4STylK3
X-Received: by 2002:a05:651c:4119:b0:39a:e29b:791a with SMTP id
 38308e7fff4ca-39b1de8cd75mr4900011fa.39.1782818015455; Tue, 30 Jun 2026
 04:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260531000822.4114-1-linuxtestproject.agent@gmail.com>
 <6a4382ea.abb839ae.10559d.dfe8@mx.google.com>
In-Reply-To: <6a4382ea.abb839ae.10559d.dfe8@mx.google.com>
From: Pradeep Susarla <pradeep.susarla@gmail.com>
Date: Tue, 30 Jun 2026 12:13:22 +0100
X-Gm-Features: AVVi8CewZviMBD6bPRku_D0hBK9Yh_jLQ6onLFYA5EEAx5IVyl8RPqs5UlWF8zY
Message-ID: <CAGsesORhG7VtJP8oGOdBDN8SgbYGb7EZrVUyr+3M8bSF--cfnQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] hugetlb: Migrate library and numa helpers to libs/
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Sure. I have the patch ready with 2 separate commits. I'll submit them
letter today.

Pradeep Susarla
Mobile: +447710542285
Email    : pradeep@pradeeps.org
Twitter : @pradeepsusarla <http://twitter.com/pradeepsusarla>

On Tue, 30 Jun 2026, 09:48 Andrea Cervesato, <andrea.cervesato@suse.com>
wrote:

> Hi Pradeep,
>
> can you please split the tse_hugetlb.h and tse_numa.h changes
> into 2 separate commits? They are unrelated changes, but related
> to a bigger picture that is the full patch-set.
>
> The overall idea LGTM.
>
> Regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
