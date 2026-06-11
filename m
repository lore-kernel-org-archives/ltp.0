Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914F3CD98D2
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 09:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781171062; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=fWQ5uK9v9861jVVeedFs8Zi9kC+CoTARjNiF245sxzc=;
 b=fYsl/7MhQn9cnMYwAOX14X1YS4O3D2T3oi8zwTC41RgSAFYoG52GHCoucJOL9Y6MK8TxZ
 CdM4lOFwHodRDl9o/WbbNy/fUwiDlJl4Vc7X4IQKIDUCzNhGJ/QVKhbp2rUY3+pgL4JgfY5
 SUATYCzGB3yF7LzhGeDkOuqMWerBqfs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD88F3E2ABD
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 11:44:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 425623CB67D
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 11:44:00 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 07B436002CF
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 11:44:00 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4905529b933so82350045e9.0
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781171039; x=1781775839; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6omdAvV9cqorGKUf53JOLGfPnF8btL84kXN92zVLcYU=;
 b=E3pT1GGSTAfX/SlliYPGNlJXCAmt30Q9AUOI9owj/X99xtL1ve71IfcIFEZnLfA3M8
 cNkY4wkF5wxmTFXVlETknt6/XwfTA1UWzLZCF9SXRT6Gd/qAqtdFp6mU5bhQHf6+fRhW
 5TQmTrMv0sPBIVgeP77gm0Q4qkLZwm8c2dCOj27WUlOT7qscsCeVvBqYb8xF3g6dSY0P
 xI21GBYoiWX1H6WzS05QAhUhRHG/Lin9uL7ODZAARlg4fV9F3nyQFo0SlVcNZmchxnMN
 wbIVlOaGh8pPvOOtFMzRX9qRYfTGG3IL1WHv03izr2WfGcnMLhQGe1P5DI1/DP7CaYSU
 Msxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781171039; x=1781775839;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6omdAvV9cqorGKUf53JOLGfPnF8btL84kXN92zVLcYU=;
 b=ns6quYf/IWG8SMq+6l4wvFOAZ8A+AZv9WvUMS1URacBUkvI7q2Iot/8OkYiYHnOXTm
 /p4vGnqNNANP9KNz19nnK2eRS8eIQoNCGvn+MckoVDPvHzSLDn4e/m1J9e9u73bzd4eC
 E3Spww2a2TlAVzRGpvjjtviFrF+M/wPfvM9swnRmMFIgWjlKFuUlkBcX/WV+tdK2oTsF
 GaYe14IBXcf31ew3khwMUKTiwEpEwi2Fck0dbzK/z0Qpp77hEAZs8CuzNzmC/bB+CKUO
 O8HTbA4t++1TiBanrjvdbmeX8FJrbD0Uf3NLEcqhKZcdBCS4rKwwWLoOQ0i0ot6mk7L7
 XStw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gUVgZM/knizYF8llF37+Eo3Yg2wsXkmof217+7Ijct/vPLvia9vayMxKLOvQycOqDYQU=@lists.linux.it
X-Gm-Message-State: AOJu0YxT1q+v1fRhtgE6tQ2feuw00FnjWzxU9CkPIe3h6nriI6PXiKPT
 2Rmjxfy+S2MUH4AS6j03WKewaOk7JQy/eleNaZLGch9oUCBYdIrIP0f/Ebevrrb0m7M=
X-Gm-Gg: Acq92OFf8qe6ZvRYS28ieEnGTUIoROTUWg9I6pSyE51CPH0KnLrpxshxQ830axrfjO4
 h6yfYFL0p8N2KjVfD22R6jC2cKaojdEOP7b9E1bMpvhjGArztmvfhxYaHD1Occr5ULaZHtJcrAN
 pvxeiVaa1N0SIpUK4oSGHXccqsa9yXUxvK2CBZr3Hf7ZZGKxprkuyj87x+yPKelPoGX4Xzn0s6x
 qbhfEk/S4mnyFEqrHGO+v0yJpVGHMaeHftLJXSWNRqx6OwnnI+EkyXP25TCXew+gtNSn0RUhsbz
 BlVzK8MsGXJlrzCjdaXZVBVcUPwf44WIYyIqituMR/4MYhDVoof7qqhFe9M+MIlCdxic1mCNR2V
 M7xjwD3+3Y79ewUj3TJvzK/k99gVofT5u0XEtTNOeAU8lLBaWvCq6qaqjyuJSv8QvehcBdBhyA6
 f+Q9CmuYuIrRgTPRtfON5Hvxl41la0KwqkYtQa6/nq0TyXNV0m+uqO1kkx58WAHo/T9/7wOdhDB
 p7H+E9hwe0g6Jqhv8+T3jPsPcDI27jnivvJD74jrgj6ZQ==
X-Received: by 2002:a7b:c399:0:b0:490:c024:2eba with SMTP id
 5b1f17b1804b1-490e56172f8mr20304695e9.22.1781171039378; 
 Thu, 11 Jun 2026 02:43:59 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e422e12dsm23396755e9.0.2026.06.11.02.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 02:43:59 -0700 (PDT)
Message-ID: <6a2a835f.5d1dab49.20a12a.a427@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aip-qWO-Ep2WxLr0@yuki.lan>
Date: Thu, 11 Jun 2026 09:43:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] firmware/fw_load: rewrite firmware loading
 test using new LTP API
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > ---
> >  runtest/kernel_misc                                |   2 +-
> >  .../{fw_load_kernel => fw_load}/.gitignore         |   1 +
> >  .../firmware/{fw_load_kernel => fw_load}/Makefile  |   8 +-
> >  testcases/kernel/firmware/fw_load/fw_load.h        |  18 ++
> >  testcases/kernel/firmware/fw_load/fw_load01.c      | 165 ++++++++++++++++
> >  .../{fw_load_kernel => fw_load}/ltp_fw_load.c      |   0
> >  testcases/kernel/firmware/fw_load_user/.gitignore  |   1 -
> >  testcases/kernel/firmware/fw_load_user/Makefile    |  20 --
> >  testcases/kernel/firmware/fw_load_user/README      |  11 --
> >  testcases/kernel/firmware/fw_load_user/fw_load.c   | 213 ---------------------
> 
> This is impossible to review. If you move/rename files it's usually done
> in a separate patch that does not change the content.

I usually review with double column editor left=old, right=new :-)
But I agree with you that diff is messed up. Should I send a new
version?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
