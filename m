Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4772BC27C52
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 23:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717715045; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=sgyykTDSx6Wk6+gCMaV90Zp830LPxSwgqQeJUfY32NU=;
 b=ZjoZUNV1UpMsraKzIg0ao5ZrDTY53jEECwVc7A4KgvbTiM7PuAOCk2klKTuq7mjN2MWjh
 +W2Q6HDvIEiJ8Yz2+w6U/SiudX6YMWMK8Rnoyz038gHXawOAu0oKEzokmFfi4wcXqfhAky7
 qB74s+7cY8kZxM+FlIQoUx7Vqjuoh8U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BADF3D0A75
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 01:04:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AAA53C132A
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 01:03:43 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DEBE4200BDA
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 01:03:41 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35e5604abdcso1666487f8f.0
 for <ltp@lists.linux.it>; Thu, 06 Jun 2024 16:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717715021; x=1718319821; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c+NFBhn6A0niekk7ftGjLjxR7S3s5uW5xSahTd8Xsws=;
 b=AOet2aYFEvQluM3pg7h3yb7ObYLcVl5V51aJjqwxo80BKIoGfGryHCuoZtPjZahKpB
 oseKY2WX0DvjJoIKnjdG6vSOeHhUfKttiZIUADeok5xfPZUWCXMOTGdJY2UChgCm3Ii0
 kUQeVzSzRPm7EwZy1nd2QEjUGyN2uitvD/oDHO+geBQJOapsLtZKPD7t5l/9HUlPNiAG
 WGo6MXA5x2gJUrSv6MD2Ag9AU4CLsqx4HZ9w4g1CzDJHF6k6wbWW1OVYY4PxZjB7mK5V
 RMV6i1tFvFaEovya5ACrW8jchiL6DRrhDtFz5RHYXN6MHjiAymg1OA3BTBSaujdWDG1N
 5MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717715021; x=1718319821;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+NFBhn6A0niekk7ftGjLjxR7S3s5uW5xSahTd8Xsws=;
 b=MRRtjyG4/dNKIlFqBVj6n0Qh7wAl0ExHsaoIPNdqlBVwclkpianPDrvtX7d7GClAS+
 4Xh6Z/mL6/EHbMtFFrQPCiDW4eVyAs8CXrkDXtb/mL2KgYreBfcgzDQfoBEo4F2VGlfw
 Sz0Xq7tRoeb6P/VRh8gfEpoTsEvM6bY5FAgxTo/hokEdFeCa8sAF1EoOwYn2syFDNXo8
 jFcwvkYkBkY8yXqRV1mGhJ8dNy7V8XXTXOjzxQjfu+PqORiRcDia4iS0wbp5Gj7TFYqA
 LiHbFh3SKuqzYqGWHo6g8/30eTkHOZcWOgGz92WUlu66XxnyLT6xsMPI4RbFP6kH7QDB
 9X4w==
X-Gm-Message-State: AOJu0YzZY3MSFJq3j1w5pXDwqUfBLIUYR2QaI1TZAibq+tIoLL4WZ4Jz
 ZiK5KGexqrwDsrUk07o67pc5cRckMxiUwZ+79LOyWVCJ4/sa2Tk/cotLX2Up5rkamYj2caKn6lw
 =
X-Google-Smtp-Source: AGHT+IHNUvUZMZr4W+SKibmjAVi95SYDWk/HB2+ads0FyfAQGejCu2NmPw6KkMDxtnG6ufnrh29YTA==
X-Received: by 2002:adf:ed42:0:b0:35a:e093:7682 with SMTP id
 ffacd0b85a97d-35ef0ddab35mr3610655f8f.30.1717715021159; 
 Thu, 06 Jun 2024 16:03:41 -0700 (PDT)
Received: from wegao.75.89.121 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd50bc86sm1614502b3a.175.2024.06.06.16.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 16:03:40 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:03:31 -0400
To: xufeifei <xufeifei1@oppo.com>
Message-ID: <ZmJAQ7li2EBhVfwq@wegao.75.89.121>
References: <20240606113243.19768-1-xufeifei1@oppo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240606113243.19768-1-xufeifei1@oppo.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Different hardware always has different
 performance,
 and we cannot assume that platform performance is always above a certain
 standard. please consider change the threshold so it can easily pass all
 devices with a good margin.
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

On Thu, Jun 06, 2024 at 07:32:43PM +0800, xufeifei via ltp wrote:
> Signed-off-by: xufeifei <xufeifei1@oppo.com>
> ---
>  testcases/kernel/sched/cfs-scheduler/starvation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
> index eb9fd6ff5..0f2196868 100644
> --- a/testcases/kernel/sched/cfs-scheduler/starvation.c
> +++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
> @@ -23,7 +23,7 @@
>  #include "tst_test.h"
> 
>  static char *str_loop;
> -static long loop = 2000000;
> +static long loop = 100000;
Try run case with parameter such as "starvation -l 10000" instead of change code.
>  static char *str_timeout;
>  static int timeout = 240;
> 
> --

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
