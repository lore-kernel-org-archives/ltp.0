Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB87EC531D0
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 08:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785399067; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=LbtzJpqTesShh92YyhgKgcpTq879/oMO572EF+tv2sM=;
 b=ZaqcRDwfFHUyABqErJyf0U15NL73zJQq3JzIBRfUZ/wTG3sKalgnpV9BL8jo35HNn0NpE
 EPQQz9Cdiaf3F4TahQMQhpw5BaVrP0tForr0ONV/VN8CpC5tybYDHiuKe53AkFjsPl2n89J
 +PgFkfHk4wgHOSNS8Dm42mca2sbg/9o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27CB23E5859
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 10:11:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75AB63D07C9
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:10:46 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0CFC0600832
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:10:46 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso11955435e9.3
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785399045; x=1786003845; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BJpHBQNYDsxNBCXfqd/QOYTbRDgrCOgd8DgZJIlDZ0Q=;
 b=MlvVO/T+OdQnAxqwReMblKaAFzKBRRo+RYQTgOMcLL+WOYnkFEiAGQG2fCGsDXf/ZX
 nlV2Oo+5+KDHuek850BO05Hs0r3nBDfzxqtVR8AHtp19pTFGcyYQRsRkvfZxU+p3tQMC
 hzJfJSNhsqvN718Uk2FXMzKTQXJcSug3PjDTsuAjyc47OfU6VCc12X/8KQEVuKjCXptA
 gQQTNhgzEutZNjONc5hCTdeTgjDua9w9AcGEzUEmAsgyOkS1opnyjoOL3Q+5XaaZwwDX
 7Z088BZNCXxd2+7cuTuT1bEWLCDnbGTHJqnn/5t73iRdJdup6APXv/UuDMKGhXTzlOJp
 02XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785399045; x=1786003845;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BJpHBQNYDsxNBCXfqd/QOYTbRDgrCOgd8DgZJIlDZ0Q=;
 b=U+oB7aRt70I+3oVH9KYrSaZE2HyEicZIVJIu7XWKnro9dUkin9HdGhCetUbOdAxyPE
 NAh0r4y0eaklJLS9qKIYurNcpbnIfc7psn8SZujXtLFEC0qiaFmVJiWxDU8+m0zVm123
 cF74EerVLVexblTnf7/6oKTskkyIFBNdC1oSt22KoaAjAdPdc8KDN7ZVR0CKTayxluPz
 5twLl3eIUJ8Dx3CPryvhaBLPsBgSWlkqWkuhaPe+neeU5SlOmIji2ga7njJLRMvtDafF
 vRqv5D9yO4em9sWN/WmEDH0VWMNAWNoabNNBRN9a3v1IYwVK9Hk7+Kck1p0ZgE8di2uw
 WTDg==
X-Gm-Message-State: AOJu0YzL8lF+yESz9y3KMR4iW/Nq0zoQS7Zb6hvP7JiLrKKNWCSZGAQm
 OzdVAwkFiWnTlde2J+yXp0MoyhFcMsfvL11FiyfC0b3ls7C7t3Xr592MuuoWcCinZCV9ot9DL0o
 EsXkm/IYNVA==
X-Gm-Gg: AR+sD11zHniMpz8Xy97AxOiJU7w6cH43iWBpsUMn79ZHBX+YznXbJ5pAIKNzc7BJEAc
 iPV4HOzZh3/LsRu+4TlJAb+GepbUqUgHblTFl6M4OQni5CRb/ReS5ltrTN9+aXX6Qy8BybitQtR
 YfCQyxGd1/HCfIVE9tBViBEadryHvieE6F9/H5f+UliNkzuxtmUkiFUmE49xHhDkL7guoH7bQJJ
 rvvx7Ruy/c/+sUQ0JtWHSYZObwNmtHq5UlEhT0QEAtECEi3elMHlCVEwmGEE3P2k3Vq/U2DvYvr
 ByCHQ4oALcPKC8uC+xvN1h3f7GTlnPtpN2ohTi3GK7l2WsSk52veWlueN1xuv7rhAQNEmP6OU0K
 OEJuD0vNGAuZMjklXFklA/Ig7imSAFQhvak2W6WcN3vlB32MZ7MzJ9u10Fng4JPNIwKFx/kJPfb
 c08LRTaLoSXwO7T2hFhPqKF4AIZjCWQwUW6Bh1O+6H0ThfdlT1cs5u3H6R+7pFGSK7JI6TrqFMh
 JmuqmZ7xlr9rb4Txu/CDVv59y6CbztLnmjk28aH/nmAOpdE/xxb9fKNVBN3cQh1clut3n4=
X-Received: by 2002:a05:600c:3553:b0:495:6a24:a92d with SMTP id
 5b1f17b1804b1-49800ea1229mr20303065e9.22.1785399045323; 
 Thu, 30 Jul 2026 01:10:45 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49800f1a91fsm36708795e9.6.2026.07.30.01.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:10:45 -0700 (PDT)
Message-ID: <6a6b0705.9e856a68.2ba196.adb5@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260729120820.5646-1-always.starving0@gmail.com>
Date: Thu, 30 Jul 2026 08:10:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls: consolidate getpid02 into getppid02
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jinseok,

> +
>  	if (pid == 0) {
>  		pproc_id = getppid();
> 
> -		if (pproc_id != proc_id)
> -			tst_res(TFAIL, "child's ppid(%d) not equal to parent's pid(%d)",
> +		if (pproc_id != proc_id) {
> +			tst_res(TFAIL, "child getppid() (%d) != parent getpid() (%d)",
>  				pproc_id, proc_id);
> -		else
> -			tst_res(TPASS, "getppid() returned parent pid (%d)", proc_id);
> +		} else {
> +			tst_res(TPASS, "child getppid() == parent getpid() (%d)", proc_id);
> +		}

You can use TST_EXP_EQ_LI.

> +
> +		*child_pid = getpid();
> +
> +		return;
>  	}
> +
> +	tst_reap_children();
> +
> +	if (*child_pid != pid)
> +		tst_res(TFAIL, "child getpid() (%d) != parent fork() (%d)", *child_pid, pid);
> +	else
> +		tst_res(TPASS, "child getpid() == parent fork() (%d)", pid);
> +}

Here as well.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
