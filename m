Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A3DE88D73
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 01:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775265306; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EyLLtaUNThZCuJ1ZYQrX4p3E9Yf3ByLQcnd9kbPA2Xc=;
 b=IMf37Ja5gkzUDL+2kLX6Fx0nGfOQjmJF1urQQeX3lW7Vk8r1EWl68C8Mpy5Toq4uk8iYN
 8xbNF5/H9KU0Tpes8S3GIJMNuLLcVR/F1tSgP+Vy7z1bLyegBUwGDXUnt+4PoWg+26qMtTd
 frILgXyhZeDCq8dsEtPg0802rtpspmc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECC5E3E4E80
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 03:15:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5436B3CF512
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 03:14:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BE38F1000457
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 03:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775265278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjM8Gp357dnP1O/47c2v1FnZ74DuYX9OY8tv40NLR7E=;
 b=KwlVsCWfp5E3f6KW8M33ySbf7D5eYAOJ+uK5DEbQBeJSVQZMKbgG03TScgFjCAhiwt2nBJ
 EswPHeJZVCdyVDdwenK7OdLJEWelRYNB48f1XAYdhx86ne17tRnki+VQy3N5/qxRXdb22K
 zp1KsofbWqxWNDu5ZECITHgOpXYf9kA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Iziw3etXNb2rWkcF6r8dTg-1; Fri, 03 Apr 2026 21:14:37 -0400
X-MC-Unique: Iziw3etXNb2rWkcF6r8dTg-1
X-Mimecast-MFC-AGG-ID: Iziw3etXNb2rWkcF6r8dTg_1775265276
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b23c909256so34395815ad.0
 for <ltp@lists.linux.it>; Fri, 03 Apr 2026 18:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775265276; x=1775870076;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kjM8Gp357dnP1O/47c2v1FnZ74DuYX9OY8tv40NLR7E=;
 b=lu+O/JwFNWy92PvhFr4QfkvDy3xKRRGiemzCCn80hPWVeIdDPxhQsubfq6CrCJEyl4
 YY7XR30pjz530t7cUk4t4K33H07Syx6Hb0LWLMB41Nlq0PYokFH5opV4E6NvEGTfbPoK
 IBrbx0aTMFx5gl2WOkMC5FvBhTysI1GWSms6xAxZK0QOfn20iehCtXITcXaXkNaSVAM6
 gBcycFyJAhlibkM2WF/Twnl3xsRa2eWV/tFf3sAiqsYAIC4wruyffQiYNjvo+Mu+g62o
 mMMitv3u9xZBp/7XroQEClf7w4GfIY6s03YOq7iuTBwSqXPysirckaW5xyjs95MNJqmn
 Anbg==
X-Gm-Message-State: AOJu0YygEyuSBT4wx2t9mxPzCulBj0ZXThvZSBwh8Oy3FGaSnU3dlKx+
 N/DVfQybnkge1kmfBRtQp/H1SoVS1wqgoshbe9a0S5zqE8zx2+tMDSTw8Jlx3WlzZAXg0/dXWTB
 q70R1Cp57uDOYTAS1ljLEWeUaN6e5FhkAMga4azXuq+XVOrwUFfN1
X-Gm-Gg: AeBDiesLdYnD7h5pDHNPzMAXRmw/PodmdyoJvIzLJzIldvWTvWki7ZEGVRfTaOCARtK
 cu7tcVZiG3GyuQl+DP/cc7uVCI3/lfvEdnEZnGrVvfkvmelwG+JGnAh34drGkdDh6GnBTNd1CdU
 uP0k2vS4UrYRA++4uKzYS6bBUMBJJ9LJFx0DDIsqYIWzX3Vwz4lfLvftoJ6+0SV9UXNdO3QCpRv
 RR2R60e6/m4lRXlliIy1JxtA373YrByLEh6lP2L5e+R51lVmBfa5YvTfWjOI0OOv9RWY3sDu8IM
 njQbsFMcXtr2VeW9R9JJBvqKjdpB8NtBAZmPBvh+Id7ZIcFZFAPovAV1vbJqkYe+bhMQ26N7O7e
 w4sfgBTsFKmhjaUBIIA==
X-Received: by 2002:a17:903:2f08:b0:2b0:67fa:dbf8 with SMTP id
 d9443c01a7336-2b2817e97b9mr52018235ad.41.1775265276086; 
 Fri, 03 Apr 2026 18:14:36 -0700 (PDT)
X-Received: by 2002:a17:903:2f08:b0:2b0:67fa:dbf8 with SMTP id
 d9443c01a7336-2b2817e97b9mr52018055ad.41.1775265275597; 
 Fri, 03 Apr 2026 18:14:35 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2747530e4sm71177695ad.18.2026.04.03.18.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 18:14:34 -0700 (PDT)
Date: Sat, 4 Apr 2026 09:14:32 +0800
To: Soma Das <somadas1@linux.ibm.com>
Message-ID: <adBl-CJwsLk8i43c@redhat.com>
References: <ac8cNRNYBVHWi0o9@redhat.com>
 <20260403165947.9094-1-somadas1@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20260403165947.9094-1-somadas1@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N9agXS3zGc-D6GWoPUb5ENuxlQ_2vNVnamcnIuLZSmk_1775265276
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] zram: skip exfat on systems with large page size
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thanks for the explanation.

I still think we should go with the -c approach rather than skipping.
A couple of points:

On 1, I don't think this changes the scope of the test. zram01 already
invokes mkfs.$fs as a means to exercise zram, adjusting a parameter so
that mkfs actually succeeds is just making the test work, not turning
it into a filesystem configuration test.

On 2, 25MB with a 64KB cluster size gives roughly 390 clusters, which
is well within exfat's limits. Could you point out a concrete constraint
that would actually fail here? If there isn't one, I'd prefer not to
use a hypothetical concern as justification for skipping.

On the TCONF, reporting TCONF here would make it look like exfat on
zram is fundamentally broken on 64K-page systems, when in reality it
works with a one-line change. That is a false negative we should
avoid in a test suite.

Please send a v2 with the -c approach.

On Fri, Apr 03, 2026 at 04:59:47PM +0000, Soma Das wrote:
> On Fri, Apr 03, 2026 at 09:47:33AM +0800, Li Wang wrote:
> > Or, can we specify the sector size with 'mkfs.$fs -c $page_size'
> > when detecting a large pagesize system?
> 
> Thanks for the review.
> 
> Using mkfs.exfat -c $page_size would technically work, but I avoided
> it because:
> 
> 1. zram01 tests zram behaviour, not filesystem configuration -- using
>    a non-default cluster size feels out of scope.
> 2. The cluster size must be valid for the disk size (only 25MB here),
>    so large cluster sizes could hit additional constraints.
> 
> Skipping with TCONF honestly reflects that default exfat tooling does
> not support this hardware configuration, which is useful signal.
> 
> Happy to send a v2 with the -c approach if you prefer.
> 
> Thanks,
> Soma
> 

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
