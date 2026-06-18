Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EA0CD98ED
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781782563; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=4j3V9eSDMmkzs5GImTfkeXgWOqphWN8fS/c6spLwuQQ=;
 b=BNqVt6BWbq3++M11aMRWpLWtjEeebxGGdi4Gd480A+gn/HIeO6EcLje/Yvy6mCkWdIqni
 AXSTW9yjPyU7aGVXADTeejl7IwsrsxOH9+RI1epSuzqsteGIKOI/j+9MmKfoBXwVeNC/uXr
 o/EduEZe5vJYhXbHAyhs/pZRTyJZZFY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAD4F3E5875
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 13:36:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDDEB3E4E10
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 13:35:41 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B240E1400E07
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 13:35:40 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4624a44e152so707088f8f.2
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781782540; x=1782387340; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/Vqvw2Ldw7kY32w3/xeDZNG3IGw2eKp7lfkUPbyWWjs=;
 b=N4ov3owVmb+RgXSIEvaUzeome/lDFWLs2JK2rjzFV77rtQ7hErvH1CKuMYNykbTMEy
 xtlPiE6XegThTz7srUuChFcPVcLXgjr1Fwb1yAVxQd29NmTevehWlI7i53yMC1070rV6
 4rWajrbqnFHn54GJ66V/rnt8990BkIAvx2WBdAcw81F++FnSWKecP/4VNpcSrqj7/Uwq
 lVHwOAIjXQGJYvBMThXZ1+PC9M7+r6RePLR43ib0Vg2GAqoqpWu5OL/DV1kLD9MQg7rf
 GdGEqLYJlvRxXqnb1j+EijZHVQcTpOc0WTJzYDFHysuHH9jxYKCyqujZnQCGmTVm66jO
 320g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781782540; x=1782387340;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Vqvw2Ldw7kY32w3/xeDZNG3IGw2eKp7lfkUPbyWWjs=;
 b=YDYOC+3dKNIDLZENCpbvCHYKXGy/aOxk66BNkMbRvXwMx5fUt8Suo36IrZpKlL5MUU
 4wV+O3Mg9enZJQfCeUuZvvX3XGkqY/8k3QKqvXWcfCfezelVERkSLBlcb4LUZy2oJsN5
 TrKjVqqErBgY/Arps2izqxP/zChsPuZiWYX4OccpTfohxHkdXy5I5FlkKXm9pfZSksX1
 1I15CfmiXwtfa3nNFGdd4g5fOuS2SGyhoCuqI5iwr8XxZiyj+5NeUl5gJDVd7x9p91zg
 uyzXWfw4Q3FaedrF3yKbVa6BrUg6liIYjaZLufKVzHRMGQbbcyJYiKCUKJjCUMd1mBXx
 GqOA==
X-Gm-Message-State: AOJu0YxdHkbtB6u/Ds/nYZdg1xfA7ydnimwKNAKeMjK1Nt4vhp3n3GHt
 fqESkzrT3sMvA39nQmCtLB+f+L2mDWb4RBCmTGOLzT/CPVfaEoyMDib+pMJxqFgstF8=
X-Gm-Gg: AfdE7clXlY/xFO2zt8Y6lyFZ1ogxZl49o2teorp01+IPnQ3PKfCEKaiWlM1uaJ7O9qo
 s9pff7GHA29INnaO2WwkhoSDsOvrJlMyBPGjWlcIaFPKAnXAbfn5v+9WgrLImqcPZfjIyBr7Kpj
 HpZv/xsirXx1Y47m2SPsQjVz7fIrtHnpTmCd6E7lFmEyVaQgg+ySHTI37SE7Gp+GXKN1DbXcjpO
 Z5mc4IkG/8jHfG0A4FuLsdsQIxSvtAZmhbvZ/c+C1pKqHlcEHzGexy8ruaC0xMZRb+RTE9NdST5
 msvkw1IuDJ1syZjiZw4HwHNBzETXTw5IB05ONJTn6vmlHGBzhKG6gwKLQJrBZznV5ftAD3xx+r9
 HIaAB9iC3VBIwCR7wLsbZ8fhkMxnfq6jd7ZvYi2yNTrewU0Dc/3ch16WWhAzcUI+DcekJFgLWkg
 EOB4tKfnhkhwPeIhue/x9UJHtpJDeDd5TMreJwZ8DkkoULAAUEDS7LB8C8waKD+w==
X-Received: by 2002:adf:f488:0:b0:45e:ea65:d329 with SMTP id
 ffacd0b85a97d-4623627634dmr10193517f8f.7.1781782539968; 
 Thu, 18 Jun 2026 04:35:39 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4620b3ed0d2sm26484519f8f.22.2026.06.18.04.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:35:39 -0700 (PDT)
Message-ID: <6a33d80b.cf2df9a4.12392.26f4@mx.google.com>
To: priyama2 <priyama2@linux.ibm.com>
In-Reply-To: <f3181c24-f3b8-4083-ac42-fb2da6cfa8a1@linux.ibm.com>
Date: Thu, 18 Jun 2026 11:35:38 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] RFC: Proposed cgroup v2 and openat2 test case
 contributions for LTP
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

Hi Priyama,

the cgroup testing suite in LTP can be a bit unstable due to the nature
of cgroup v1 -> v2 migration. The V2 seems stable, but sometimes tests
might produce false positives, mostly related to system configurations
or system overload. We digged quite a lot into it in the past years and
we ended up with a solution which "good enough" for regression testing,
supporting both v1 and v2.

Also, kselftests already cover many cgroup testing scenarios and we are
not actively investing time on it. But you and others are welcome to try
implementing something, if you think this can be helpful.

My biggest concern is the code quality. cgroups can be a complex beast
to handle with LTP API, which are made supporting v1 and v2.

If you are willing to implement new tests, please consider test cases
scenarios that are not implemented in LTP and kselftests. Those are the
most valuable at the moment.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
