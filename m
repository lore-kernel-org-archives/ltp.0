Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE74C79FBF
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789046828; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Af+2CtjwZC3xIFcomWJzUNRjhEFEx48FS1hPqjfbgCs=;
 b=UaEdFTZXkZAgsHZ6I+hTg0uz6787nmvtg2yCSeLKESNnHisxkizw/JiuGV9RpCLxi85C1
 c3D8CcgG2hYj7lTs7ISKtXVYWmTkbA9383A6Gph2mj13qyOxyoJMDbvaR3KM5H6ucJLb+qr
 wlM47OdD9+4fVfLn/fVQ/PQzO6X43BU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10AFC3E72D7
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 15:27:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C4FB3C18A4
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 15:26:49 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A3E40140139B
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 15:26:48 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so14216915e9.2
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789046808; x=1789651608; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cV9vd63L8yFW/9vpLWgqj+8Y2MexJ4ofvwziJqSDMRs=;
 b=V3GhQupwkkhNZLgunn04rc2XFr35/umIwzY2OqwvQ+pryyH3A3Ui8mThWl5uuh6NiN
 0k5VuukSkNWT/RqPzjcuW4qg1naisIY1lqnMSCDVN0523d9Ick7r330CBL1y8LeqCx4p
 kt9/i4CNnUPl3gcUFRASC8ztqJGixMQt98zGndUIIIK9G9OO37cqBPSM9bzECSeDsdmo
 X0cFr2lFepH9SsKqVqCfL2OX7WsAmZjMtV9x5MKVQsKC6jXdWVwfvVcgo+VOBdyMWqhZ
 GcDVyHxnNgx4FcYOIkJrK3D5XrVz1z8+9LD/7biIkMyxV9oXkham57BBBXTSxf3qYmEW
 MvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789046808; x=1789651608;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cV9vd63L8yFW/9vpLWgqj+8Y2MexJ4ofvwziJqSDMRs=;
 b=GxpYOs45uLQMOtJCOa4mW4TMis/fthxJLc8A9BYrnBHpwwnLsUw+4lXnoN/4mQb1cv
 Jm6zanNmH7/z/yyVRvWqt2uqdw4Z4oNNL/cZzrbetqL2ZvqLLiA5fG/XCWk1Q6/xOdI5
 CxtH1nBlbQKpoFCFGU0fQuDCLs+N0e2xrfQIswRj6QxtFCivndzE5BwDPCHNIgq+W7ZD
 esQobAHI9KHRnjpo93J4IxQGfHq5okcdGedGqCHTRaPjR2l5Tw7CqHIKiZpPPYgnuAKs
 qgFRJx6u2aCrGjpDxa3AZ53ATBXeD58mz6H0hpw0gcMog59qs7q1St8BYjnzZOk+2iP3
 pVMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBztBD8SEiIvrYUuVQqLpZiJd4TdA0tHzGfna0QuQu7I3z6cTPGrcyPvb5bz4ssps511kkw=@lists.linux.it
X-Gm-Message-State: AFuF++kok9za7tptoLdrn/mFim1gONCiSzZfvtNCdP9hzca+sLKomy6M
 e9WqDfh5BLDcY49/RxByietVQfpApWM4xSiHxcVGbakeXrH2RQwv/CluOlJXEXS7Dm4=
X-Gm-Gg: AYBFou0ib18eVrk7WF4+2TfExlMF4e4af4Uy6ABYzm2sie43Si6GV6qrB9Nds8631Se
 WYR1ev/JW9AuMDED5GPMmxSKDcpi5QKEsIXuXWkpHsWhKzxzazV8m/kIoiOv5HibsjlHNT3cn2C
 vMfHix8VJJv602JVbxZjuHpN66/117UO2WTtEpPCdjlVEfW0NWhLNyPowXYpgBOovmyy5Ez79mv
 9AsnJwZT792Uo2o+giIe5lEJTN9Ncc4VX/mFKPhCn/l32ZdT1GhLNzV6bqwmlIZ9TlgL9G4+pt3
 3D3/hsachwvdnxOj1gunSm4y5U/hYSknctgD55cKJmEGw9aujFEQ+VEIAsPtviv1ARnka8MH4rV
 3Rf61mwOzwX8ouBCKUppGqpNHtYuvrHFBXOjGTinum+/OMXuYBlPKEt5KloJ6E7GBwtZG+AQ2mz
 0edL4hDZ0hxbs2fVaHevN2zWH2FDMgAnSHMvdozex9URhDjPnOALpIlr0hFbFy2FZviI6FaeAeA
 NLhJBbJBcfkr5E2Ktt3+dPQuv64E8oALkXeqNKu1iUAxv0=
X-Received: by 2002:a05:600c:8b74:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49d25551fc4mr157360875e9.16.1789046807944; 
 Thu, 10 Sep 2026 06:26:47 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d24e01c66sm46462285e9.1.2026.09.10.06.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 06:26:46 -0700 (PDT)
Message-ID: <6aa2b016.5a1be024.6a927.3cb4@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aqKqev1nXfieuJK4@yuki.lan>
Date: Thu, 10 Sep 2026 13:26:45 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10 3/3] coredump02: Verify ELF structure and notes
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

> It looks like working around potentional bugs rather than anything else.
> The elements should be aligned so that they could be accessed on the
> targed architecture.
> 

ok, I will send the next version with the cast

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
