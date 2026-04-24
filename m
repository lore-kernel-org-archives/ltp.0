Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66F9FDEE28
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 01:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776994323; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2tIXZQFozzf+7oIVkqBJjfXrI0qAVrI2PCeR/TaMwYw=;
 b=BqKCSkM3AymJhp1nNv8vF4bDBs8SyVsr++U7HS6gjO/BIchNyX2MDj0r1nKl22roe6cBx
 Gcg23ukwoGxZv6wG8S4UyHnqKA9SRzhR8YikVJ8tivmsku4p8KbloKPSoaVgpUEryCbB+RO
 ISu6g3vUedcvpjOs5+efDB3CLD5xAeM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4CC93E5807
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 03:32:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 705223E25EC
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 03:31:38 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DCE5C200AC7
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 03:31:37 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so75051335e9.0
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 18:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776994297; x=1777599097; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iMP5uDDxIysDCk3wwYe7hKHGGX/FGXkImwBblH/LJGY=;
 b=MnLnH/9RhH4J2ueQMZPsA3HWw+dk6bK8yfphjxL1lmargsQk882eTrGLRlWmgo2e1o
 2q78BhEFwi8lNmQuUWlrMc7ztT5X1GcFs/T6YaaK8Qt09F3eh60GHaB0zhtjjWeYynjq
 e9Hr1GSSzeltpZbUUuRcDhPQkCYvdf+f/BtWLBQukjesuMfVq7sxZ5YwU6NfiGrhTKu3
 xhGmyR9Lh2pUZ4eVbhH0AIveyImDlepXBTVHMw8zRThZZYeTHmQb+1/ssub0ARzCphpA
 GfZDPmjXnYWObmkiJNZFRFE/TPOy9cFPWRU7YJ/CRSQAp0dFH4dkSRqZFkIvAAZUwiwU
 hOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776994297; x=1777599097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMP5uDDxIysDCk3wwYe7hKHGGX/FGXkImwBblH/LJGY=;
 b=Z6K33oz/CzMZ5sJSgBpsGbK16pPMGj+fzHf1iopVu21YuYFZ5MRniSZeVgUO9je0oJ
 E/C8wVLUztFtsnvZag3g0cvb9DHGh5B1w1dJcw74KZvE2VZ3+vA/YOXre0ckBl68mF2K
 +us8GFGInrGKlPHQ2rz2dhTQICAZmDVjYAGiYd9jnaaYrbXCL9bxApO1JtfZtlG//w/D
 Fu8UUj9IzkM1tv/9p0g5j8NwoIvJPuXesPtRRlmyLYEQMViW49VRJlZ9UBsoZbrFo4z6
 xZ7gkFlicpwCVh2xnW/97HOktEI5ILGI7hzZCwhA5QYTyNY9fis4//mQi7ulR/H1JkWJ
 z/OA==
X-Gm-Message-State: AOJu0YyikJUPJx+N1wC1LOjQZYZQ2gSWDCUh1f+MvI0v3lkORVhBua/l
 dBOXeo9+5vwIjouOZSsBbEBKwJGqolwIRs65yYmxf89Qm/ZzEQCcGDRnHdDSl4hVgA==
X-Gm-Gg: AeBDiesxW/GZ4MNnLzIhf7G1pwlZo2Phclp3LyYYG/c9ThBPjk7uZDBOOgn/5hzz+CV
 vMU0wfhIb1vo0xiOkeF3PRz7kFb0vFAdLbSAeqclZxRHeKyKtoLQkvEVLcw2BoeucGal5xVqJmd
 Th64Hqr94UtIjCMJtLjqstwz93zTlgE7UNtcUTjeD9J4SEbriHuQvf+YLu9NnI5okwNXBr2WVbM
 rfdGXFNwuDWfJLH1ZMGUQDugPwxWmLE5ZRg0z01lc9zrl6Vl+6VMydcMBBC67lqQc+Zd52pIJtH
 dF2WbAAFHViyzAhd56/qjeD7gVFs529FTR8YdQZnic/Mo9wTUnO1F0RJDpafy1gOJHMaAcxrC2u
 K1nFbQxI1PRkspxdEtYhQ1S6uSIGvpTC2ogAWeEvi4piyU50mSaaCKUuHsLaXb9jI2j13pLHUUT
 m0Pthc76ag4YVmwzcirPEOdraw8VwR/cT4r3YIwFleIREYGXfjl70=
X-Received: by 2002:a05:600c:3e0d:b0:489:6c28:dbc6 with SMTP id
 5b1f17b1804b1-4896c28dd4emr258337505e9.31.1776994297243; 
 Thu, 23 Apr 2026 18:31:37 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm60481881f8f.30.2026.04.23.18.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 18:31:36 -0700 (PDT)
Date: Fri, 24 Apr 2026 01:31:35 +0000
To: Li Wang <li.wang@linux.dev>
Message-ID: <aerH98nQSax5OBHW@autotest-wegao.qe.prg2.suse.org>
References: <20260423134838.32141-1-li.wang@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260423134838.32141-1-li.wang@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH COMMITTED] mailmap: enable li.wang@linux.dev
 address
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

On Thu, Apr 23, 2026 at 09:48:38PM +0800, Li Wang wrote:
> I hope to dedicate this email address to Linux and LTP
> development work.
> 
> Signed-off-by: Li Wang <li.wang@linux.dev>
> ---
> 
> Notes:
>     I apologize for updating the mailmap twice in one day. I didn't
>     realize kernel.org has approved my email account so quickly :).
Congratulation :)
> 
>  .mailmap | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index b488d309e..d1e4419f0 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1,4 +1,5 @@
> -Li Wang <wangli.ahau@gmail.com> <liwang@redhat.com>
> +Li Wang <li.wang@linux.dev> <liwang@redhat.com>
> +Li Wang <li.wang@linux.dev> <wangli.ahau@gmail.com>
>  Petr Vorel <pvorel@suse.cz> <petr.vorel@gmail.com>
>  Petr Vorel <pvorel@suse.cz> <pevik@users.noreply.github.com>
>  Xinjian Ma (Fujitsu) <maxj.fnst@fujitsu.com> <maxj.fnst@fujitsu.com>
> -- 
> 2.53.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
