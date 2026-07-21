Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6090CC4452F
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 13:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784638966; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=8wEY8sT4RpzvnvuphPkcmdGJt5N6fz1HMCGs1BsWJNU=;
 b=T9+hF5t3ryra+0vr9SKccI3oqqOzQWNb8MKk1yPc82xc6idyT8RTFerYAtDwyrJjRPmnk
 J3Z5jXiT0+Gd7TX6LMCsezRT4x6gV+qKLtH4YACET/yOlm//SlJ2ttua5wpageMEtJ4QyEA
 VwzITEnEFRv6GVT//28UB/zUdI2S9gY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB1A73CEF3D
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 15:02:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A88113C0440
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:02:25 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 15587600681
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:02:25 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso24023975e9.0
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784638944; x=1785243744; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ATKHnB/oezkr6E/WnrODIdbHU6JlAQFZRiCIYm78D5Y=;
 b=BxjBKmnivxAWZUByMTLkTqc+oWEcez3IUmXIco4DbeOx41dDkeWfUFeVn97hWjdxAE
 j7WTr1LTELREmo29U0ccCkukm6Whp2/uCy2v7fPOkndhrK/ggc/iYvNNoIAHrci8jIgz
 jEup6wM8bBBgn+ZwGDHMXThbxA7hbt/rCrrUQviumpMM8AcXZm+Wu0sFrvciKAwDYr/+
 EcYJRWjA9Kwl+Zbs6Tk/+6O/CDrwOiMnOpNn+D/kpUfXbDMCquCVc2rFoAourcus0ozL
 JAvp8hnVobJ5Q6yV6kEGEIFV3+C2euUWeuyEb5lsrV4oea4znH3jukRD2TvGZk5vsIMq
 QjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784638944; x=1785243744;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ATKHnB/oezkr6E/WnrODIdbHU6JlAQFZRiCIYm78D5Y=;
 b=cZU20hcYZYl7GFArQVOylmyekCR5j89rSCm89OX4ip5+TN5BgcQJpR3gEtlEgJcgN0
 qBpm9rbHJsUcLovyj/dhNNgWXgc/LbumIscZ3qwkYZKmJrc+PsHyKE+58RD4Pa6/gkSm
 FEnHR89ZRLel3wQqMLw+hzbTuSvkW0g9xvtGKgcwdKNozcvblFYOgv4TgEGmOEUxcF5H
 WVjGHSlwV9rR38LUSY+q9yfAFpnoswoW3keRDQFY3qZmt+PSS7Vdu153unTvONYMLw2V
 /hWZ2JqgSP8dpqmeKy0IoSVsAxDnBNPowGiEk4FVEONyf6AZbwkdDUb085j9V7LWRCeB
 N0Nw==
X-Gm-Message-State: AOJu0YwDUJ1Fg809ME+QKxKyIzuHu5TAyU59go/boVuUnvCdkF139EJJ
 yplBFgkdXBjqwA59A9hAXJYkein89JSwieClvkvSO4EBn17s/BAREXMcAA9fakleMhMyOAvOkCH
 Fm1WGPt5F9g==
X-Gm-Gg: AfdE7cldtoFjj2jNUSVd8TVe217KSnZ+MYAhb7u5ofu5u1ixe9LEu8FLQ5ZAddETny5
 omhGXK4hceFKbF+kcNfk9Jc1Wm2qcb6uCT+o5U1ZYIrC/K7qkr9Yja/V/HfADN+PA1CI9NwT+1a
 Xb/4qX8nfTgEXqkoq0MXLht3xHokAn+GBD8l4WAayOw+vPTTFhSbrfLmkJd1OsS6SA5ET+qQYMc
 99v3RoIMS8isGSFjQdlHlwdWObf8b5+eL0niXSrb01EBdFqBVg8rE9xw5dssDu+kYRqoU2GTcD6
 ErqTEyqS34sb6ckGvMSUMTLx2vAc0jGCG4YBUDplunstTAUTmE8Pvw8NakSByYQyX6JoHVY4S44
 2i3EHLEHfsP6ycvNG8mgkWxF/gLIsNzPbDD3P6d1bu3NzbqEzoqU1dTo8pzbf/O0iNbTty33k/1
 6Z1mTfhbm8xRR8JG4J0YcNnth65A==
X-Received: by 2002:a05:600c:1389:b0:495:5dcc:52ae with SMTP id
 5b1f17b1804b1-4955dcc5372mr99488635e9.3.1784638944109; 
 Tue, 21 Jul 2026 06:02:24 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956547319dsm68202105e9.5.2026.07.21.06.02.23
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 06:02:23 -0700 (PDT)
Message-ID: <6a5f6ddf.af19844c.1da3fc.55a9@mx.google.com>
To: "Kuba Pawlak via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260717102000.1318116-1-kuba.pawlak@canonical.com>
Date: Tue, 21 Jul 2026 13:02:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib: tst_rtctime: close RTC fd on the
 ioctl() error path
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Kuba,

>  	ret = ioctl(rtc_fd, request, rtc_tm);
>  
> -	if (ret != 0)
> -		return -1;
> +	if (ret != 0) {
> +		int saved_errno = errno;
>  
> -	if (rtc_fd > 0)
>  		SAFE_CLOSE(rtc_fd);
> +		errno = saved_errno;
> +		return -1;
> +	}
> +
> +	SAFE_CLOSE(rtc_fd);
>  
>  	return 0;
>  }

Why do we need to store the errno? Simply call SAFE_CLOSE() before
returning -1. If SAFE_CLOSE() fails, test will break anyway..

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
