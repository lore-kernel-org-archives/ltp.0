Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64494C55184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785846524; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=xcrRYpECByfmWZ73TuB1prctc0gsWursJhmgGS2vEVA=;
 b=VHsC255GbBaw5JLPKIK/JV4PSUkCH8mnHYiqK+fTHAuGsEdAuaNEeJ4I+8ehGshkCgOq0
 aXaBiItFs1fh12gmvgznBO7pLDCcKS8pB6Tdo7p2yY8sFQnz9cQ6RVfEFRBgdkhtMyZ+Mtw
 o5A8WS7MEr1RgkKhlPJZhxpkU6F96ek=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0ACBD3E718C
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 14:28:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 959873E7178
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 14:28:23 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8C0B41400067
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 14:28:22 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso37077905e9.0
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785846502; x=1786451302; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=op0edrJXVkwtsHd0UPIgj/J4Npx15kA5e4+M9cWqiK0=;
 b=H0tTMio9NoZf8fmGz+ph6TfCMDPQ5rno/MqfUL0DR7PiJnzTSf2lwbVPHcak+Pdi+Z
 m4FMI3ReEMUU4vBcSb1YMv4dsQrNVpktxu2Nx3TIhgkjTJaO2WS1TEr98K8mSoRL+dLh
 TbbOpDJcuYXlPeNmuHmuFhBKDUsm4wS/VWDDkZ3mGw5tPNrMWKYe9NHUnabCTD0vercH
 HHDpjTzTLgw8TUGQIv8ulqg355Xyn5YUCINvseA1IYhjGI4bmXVld+4/CvYi6Z8DrUvt
 wDNl8H23XKqBCgYiiA1gjI8v+X9DDWcksOUQ/1BDj5pSbYWMfc4qLsRb/hZD+MowWe6H
 598w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785846502; x=1786451302;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=op0edrJXVkwtsHd0UPIgj/J4Npx15kA5e4+M9cWqiK0=;
 b=mz+FasQ2Pq0q7mHY+oJtvr7AQPcDvAtS5z07g7lhbtC2DtGzp8K6pZO6185DeHSmFP
 w70fDVaG1ntHGnwC1aFt/x8Q1K+PC9piL3T91KMUTBqQMrgM0TMQ8jyzJun7gXrh6fLp
 fEmib13kKGjF5cxY0R3bBl0Q2vMUg3eMBrXBa//d33VuZvVXlar8qez0CufwhP8ycDX9
 8jKZk+N4gAxBX2/AncnmveHWDyEIT5kKi9x6+mlDbwhJed+8SZSvlLlYcCaIkRpbFs1T
 NFYgq13AfCGUVZ6eCPdvTorel1DpT9hTz3zcdNLNmn8dyZriHDF8LJFRfKZ+uGvRaDKS
 wKsA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1KLhm3l3P6N7LfZIbjEdUoI+fplIW62kwWvD6u4y3Qi4uc7SacIeJ1DDl6nQfNTAtGJk=@lists.linux.it
X-Gm-Message-State: AOJu0YwzcS4jfarTB3Elby+IMjg/UPGIFFwpmNBnlxn+yze8HEXtzQ10
 uZZ1y7sjN8l+Zmz2Vcl0tnd/hKpUDYfxCTR1LjgqXe0teF8hP1VkbR5cWsEKVC0D0yw=
X-Gm-Gg: AR+sD13esSfefNUfdexqS5DN7jFj+xbnuY45DZ3Kksh9Uv4vRyxstsB4xFKE4A46Q7x
 kUTkseVXI6GljYkkK/OpSAj4kqm1xgsQQ1oPbjZX/m66e0y4DoBAX7YTSvBzfYwtqztwyKxm7Zw
 cUfGv20mTv76PmLvb4Kc7dSUpi/OgxHSPs0/9rhTrQ1gQokdix3w1Rzaw53Y6lyD8x3sUi8kLvJ
 w0ukUaUmeyNq6ef8aFOH8b1M5BfqGe4RHCminb3OTfZqksJx4XFtSwb968RPD1P6Ks+DlruGJ3N
 abfQrockhUOBu3+vvh8elLT+UoZTWOvonFF0CFeseMidLeSrFup8XSYACIDvYx/T+bkz4X8TTVy
 yf6nbUPnWQu5SsZIqD+SEp6pElNTnXG7MzxmOEBNOv0y1TMU6vz7fet4MvwaJ/+U5/XFusIvSbF
 f6hGCa+I5qIRCXe9Jwe4Ew9q5E1X9ba8qDqWLKWhgU+9ACk+/6nS1AW+vbxEsVUgtTsMJbvHbnQ
 XQH8q6on/Bgg53/2BPU1YrFy3j1SxuuSVmZ2htK8zMA/KNBbfZjoZe/MXvYWJSeoUxX+hEqaiWP
 XTtHlRfFsZKiFaz9UAlrULa68o0xnbXSDdXH1A==
X-Received: by 2002:a05:600c:8b08:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-4980c694e4amr389245815e9.19.1785846501768; 
 Tue, 04 Aug 2026 05:28:21 -0700 (PDT)
Received: from p200300ef2f11090032755c67e6ad8da4.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fe2f4fsm98439095e9.10.2026.08.04.05.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 05:28:21 -0700 (PDT)
Message-ID: <6a71dae5.9b1caefb.2cdef6.e116@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <anHaUBEks1Kzq9_-@yuki.lan>
Date: Tue, 04 Aug 2026 12:28:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap/hugemmap41: Migrate ptrace-write-hugepage from
 libhugetlbfs
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
Cc: Pavithra <pavrampu@linux.ibm.com>, ltp@lists.linux.it,
 linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> @Andrea looks like the CI missed a few things in the code, see my
> review.

I think at that point we were still using Sonnet which is not the
sweet spot. Now it should be better.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
