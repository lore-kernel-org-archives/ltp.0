Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD1EF3380C
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 07:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773733052; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1UTZYhf6MJCZ/4jBiXrovEDQzaEfip98p8HPytwed2U=;
 b=Sq/gtqz494U7Lt/+i2ErVIk7uDLQv6U+tdD45vPEVgLOIsZqHymG3nH8YUlYgqtS5CJGA
 2PT6yK4wom5hQm4SKKu3MDXOy5M3GICes/vTN7vKf4mgLcrAeUTnnMWCsQ3ywDQbpKypzgL
 +obo4kQnUD52yZriHwisojCsXMjwdW8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 326753D0320
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 08:37:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74E8D3CA05C
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 08:37:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BE80760150E
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 08:37:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773733024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pKgi1iaN6G5Sf6kT5dkcCteF+d/uIwOuNubJhm1+osk=;
 b=NHLoPPyonKyAtQOfJqbpptoLkG0MBzxgkm2UxYyNWfx5z7ztk3Wms12g2QT442Pjcli1zb
 ZdQBW53+bh+NEoqtJpvjdZLxcYHYCYoaPQhPboGCfTsVt5zduDMjGKyOFJErlTghQhFwiO
 ffmzL8fZ3sMF0z9OVturWBkKo0f2n/A=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-aZw_oVVTPB2CqMCX8u7nXg-1; Tue, 17 Mar 2026 03:37:02 -0400
X-MC-Unique: aZw_oVVTPB2CqMCX8u7nXg-1
X-Mimecast-MFC-AGG-ID: aZw_oVVTPB2CqMCX8u7nXg_1773733022
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b051befbb8so28428265ad.2
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 00:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773733021; x=1774337821;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKgi1iaN6G5Sf6kT5dkcCteF+d/uIwOuNubJhm1+osk=;
 b=oMKYN0/XaLF89aHiY7+xH4pcTXskkDSfsjQBjYuYuacWU6Xn4fjhf4B7J4qMnCiGFJ
 c5Dqp7F/YU2UnVQ8U8vdWNV1fu+M7xcvcVC/PNp4rRxV/O8X7tCEBfSlkKL7TeQY98tA
 kbqxwNsyVj1mP7p8v1JizapwZR1Iy0w/OZgtq7M1biIkGg5UCpOkBdL0gPVkAmjUCo6W
 YR8DTDXqXxKMSZY0Uo2RD2ishvOffrfOznR/m26jTvYnkzlq469Rrp0+T/CTjgjaKM4w
 OJVW1d+AbAQOIhfxSXKKRCIO+vCQkf54WhgctUYJVywhvmSou0OPsIm5oTW5v/OdzMwu
 6P2g==
X-Gm-Message-State: AOJu0YyKuO6HJoyA8tz+Ii4zokLKHVFgBQhM1LZJWzpnqhpE2M0TqT2r
 /xI7onDKoEf4cGArmWUUzKYbkgGtyupLWQx8aUuKY7b5dt4ErS/r+v4Er6uu4fNxPLoIa9z7NtI
 ISJ9Q40yaWSc3cVghB9cWRdC6l02LrWxB2dLkN2YJal/f8yM1Wjwk
X-Gm-Gg: ATEYQzzKMNVSr+dFsTKd2Tf4LkUPu0DmuuKRgnHG+ZJexfecd2K1g9z5nHbf12NrOuU
 rFNx+Pq+ewefNhza3uEJ0vLpdoXid/4aUKQPRn9ecKahOLj/B6Y2PBd1pKbXBT/bKvrsWqGEjUv
 W/aChS91zeFKKQUxNjTqjARepsigoSpboP/SOczVsf5RSl1jlBHTNdHm5XYx2YDj3+VZsPNlE0Y
 mefco68RjveV3Ie6/g3ODHy6IZyxMwce6ck6HM86XGJrujqsYL9toyYx0cYoR7ncXXSpW9cfE9M
 La9ZjdiWHH07eLukaMwoQh1djRnYvfPIk+UHSALVIKd1lh3DVrwQTsLRu2JVUP9ol6guuleVGDy
 MT2hdVQzV+KRkmBJF3w==
X-Received: by 2002:a17:902:cec2:b0:2ae:4a6b:68ea with SMTP id
 d9443c01a7336-2aecaaa88damr171849335ad.43.1773733020844; 
 Tue, 17 Mar 2026 00:37:00 -0700 (PDT)
X-Received: by 2002:a17:902:cec2:b0:2ae:4a6b:68ea with SMTP id
 d9443c01a7336-2aecaaa88damr171849185ad.43.1773733020418; 
 Tue, 17 Mar 2026 00:37:00 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece8233e1sm129902135ad.71.2026.03.17.00.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 00:36:59 -0700 (PDT)
Date: Tue, 17 Mar 2026 15:36:57 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <abkEmdVQycn3wySL@redhat.com>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-2-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260313142600.243939-2-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z6byY8SZz8WT6e1hAdFPCxqYkQyRBDrDDreLybGa6zQ_1773733022
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] tst_run.sh: Fix passing arguments
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 13, 2026 at 03:25:55PM +0100, Petr Vorel wrote:
> tst_run_script() in C API correctly sets environment, but it have to be
> also passed to the shell functions.
> 
> Before:
> 
> $ ./shell_loader_tcnt.sh
> ...
> shell_loader_tcnt.sh:-1: TPASS: Iteration
> shell_loader_tcnt.sh:-1: TPASS: Iteration
> 
> After:
> shell_loader_tcnt.sh:-1: TPASS: Iteration 0
> shell_loader_tcnt.sh:-1: TPASS: Iteration 1
> 
> Fixes: 8202494493 ("shell lib: Add basic support for test setup")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
