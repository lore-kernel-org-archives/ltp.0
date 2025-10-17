Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5F1CCD195
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 07:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760687492; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ZG4M4kHtGxaFHhfyZv0g0HImaoZRJvwo7aw+Jg/E87E=;
 b=hsoixCxPokOYm70roTGH6bM7wEO5/Vj0RJceIxyY1CWPPpdiTE2uDZLJPedu4IP4RvY/c
 Xg0DALGA/IUFKhxSi1JlhgT4YZX0D6uVdI9kGYsH2PwOjHy1uxXcYbkuUH+7Nly2H1Q0/cW
 cJJ2BCWJuMW7ADZITID9SUpoNeya+S4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 586793CEE40
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 09:51:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 593D23C20D2
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 09:51:11 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 90BBA600B14
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 09:51:10 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47109187c32so8131325e9.2
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 00:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760687470; x=1761292270; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BNNeRuLEZGysqJDJnXmtWM8mrQbND8IBX9vIRpD1v0A=;
 b=DU7difto2siBnIO0JpDPXzhGhPqcWFGB3AaZQGpvoiwGU1ClfzLityUaXUf07/pT+6
 xoMg7wGATttilQupR4xjjAWTsQwb0VnQoYK6A0ni+JgBWK/my0DY7kuRnwyYxpEklSGY
 Lsqa+DekVM11ffxYGFv4cL6MyVhSPpdqLp1xEuSqjpIRbQK71wopUiwsRjvf/biDC7DB
 3Bxz/xPkzwWOLJyV/wyOs8T6Tprn9xHwBcRoY5TmJDHSxblfwazElGyk7b0O1AQrKbrc
 U6Fi9ylarOQkvSVi2qkxJrdUTMApRtz52fx+tCOXlxol6eFGMI8Ka2kG+08ubZiai13P
 emnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760687470; x=1761292270;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNNeRuLEZGysqJDJnXmtWM8mrQbND8IBX9vIRpD1v0A=;
 b=Tjmpiyve4N0oXksHfT8X8plx/ywQyjWiidoq8fooczyPSVS0h0GVeaQfHukRvuvQjS
 QzalLljHs7KprwMoQdqu3DDzUO7UXSFjpZJaCXzpa0py7oduEHD/4nHYAinTM0XXhS5p
 7QGMW8m7jXNt+X3LJKFg+fHIq3Nfj252DgxEGyVZqrNS7yVRi7ShJaxntHCgAJmzhbcF
 KF2VHqG7dTrM1GURdNC35NYibb1AMO2Eb7cw1o5iSqydxJiee+iaRK7UWYkeCUrY3m8w
 U+jrerSJ/W5vo39rzQDi8Gden6IMzBuNbmIY1qRHEZAimuCk3bFiWNL+0JhJwSIWsccV
 B5yw==
X-Gm-Message-State: AOJu0YwU+kkM0tAa8/WSEbzYT1eMMfP+1Km91ifp2kuWNjNzVzjh9xma
 qHADaoUVjZqhtZpiD9j/WJITHhNPgsC95s8t7NBX+PDcTt3qcXhtoD7ClWsAM5m8BpJe2sXL7oE
 ucjY=
X-Gm-Gg: ASbGncv801zR29KlqmVqKfM+NVVgmWijtxK9/guG9Ta0t3QvTXHWGfRm2XKMF1wJTKk
 cWx0dp7ttcmXVBuWHxFIw3u9guYh42DSbc0LZqPjfXMTi0Z9AlF3WM7lN5qGERXbCRB7wgo1qRd
 OsZ2M3dYM/SwKeIhgYTFUErwu0pkyu5k6X2gzImWIB6l0BhwTgw/8JZhLUXb/vvcNhoU3x1eipu
 Ps4Zlf6cm5WlZR952BspZhZrXZxB5ju32aRFO2scSoPwtLtJQ1dMxKnVk777UKILFK+UuWHc/mY
 ohl5YomoLEgGv16PM8kp5i33h0Xt0PhBAY35LwC1Uijh5NCJ1J7OMoz1Fd93N5uIwOlDf6t7DzC
 cUyecP3RC96OTTxj7XLZtcFZV3iSrcNSS3r5HQXxZuFHtOPIDwiTKT59/mHnIMZrA+Gp2OV1vpz
 g=
X-Google-Smtp-Source: AGHT+IH3AeveMZzr9+MCjdqtXII3Xe2I98QcUcymIztI1xhuzvJYMepfY2xW68TM6vCG8XzeQgM/EA==
X-Received: by 2002:a05:600c:5299:b0:46e:3dc2:ebac with SMTP id
 5b1f17b1804b1-4711791747dmr19089505e9.27.1760687469869; 
 Fri, 17 Oct 2025 00:51:09 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711443ec3asm65898985e9.11.2025.10.17.00.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 00:51:09 -0700 (PDT)
Date: Fri, 17 Oct 2025 07:51:07 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aPH1a43lTn_CKnH1@localhost>
References: <20250827230301.32614-1-wegao@suse.com>
 <20251015031540.2120-1-wegao@suse.com>
 <20251016133203.GA284465@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251016133203.GA284465@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mremap07.c: New case check mremap with
 MREMAP_DONTUNMAP
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

On Thu, Oct 16, 2025 at 03:32:03PM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > +static void run(void)
> > +{
> > +	pthread_t handler_thread;
> > +
> > +	SAFE_PTHREAD_CREATE(&handler_thread, NULL,
> > +		(void * (*)(void *))fault_handler_thread, NULL);
> > +
> > +#if HAVE_DECL_MREMAP_DONTUNMAP
> This is a compile check, whole test should be wrapped with #ifdef and fallback
> using TST_TEST_TCONF() macro.
> 
> #include "config.h"
> #include "tst_test.h"
> ...
> #ifdef HAVE_DECL_MREMAP_DONTUNMAP
> // other includes
> 
> #else
> TST_TEST_TCONF("Missing MREMAP_DONTUNMAP in <linux/mman.h>");
> #endif
> 
> This quits tests early.
Good.
> And please use #ifdef.
When MREMAP_DONTUNMAP can not be found config.h will contain:
#define HAVE_DECL_MREMAP_DONTUNMAP 0
So i suppose we should use #if instead of #ifdef otherwise compile issue
will happen on old platform.
If you agree then i will prepare new patch.
Thanks.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
