Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCF6108B912
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774008930; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=FJdXBfcGN7EtN0KYZaO3xF01oKcn/yJZGuhTAOqgrmk=;
 b=BUd9OIYyXAZLu+gXvHSRL55MjIy9h5DSdn996gdzEOtGsvrxWOb1xhiIuLRd3z3Mx1G5R
 JELBC8UARJEgVsKlUEv3LUaZvjOBcznRfXqSCsDQRqywUloY9+5rS0PwjRB1jaPar0sUPOm
 gbXDnpwzJIZg8SX212F3sXSTzJMBGEU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA7E23E30AC
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 13:15:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 013B63E1DFD
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:15:06 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 96F62600493
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:15:05 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso1916424f8f.2
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774008905; x=1774613705; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WycHsG+CtYNd5xQzelWA30aek3VYsDDwjjcbAg/0kbA=;
 b=dBpJNHwDSVFEtUniV3GxnYK88tcG6Nl3sGKVeDRqWVC5ZcGEn2cdnXOMqLBAI/WEl1
 7rVZqbDG0BPedawmqDkpy9gKCAoxt4143X/gvMOz10OJ0I5dLjeOtJT+05kVXbt2mwUJ
 nIC5r+nZEtpir3orMGGW4Jfa1cTu8MPzEonoRS0fHDbc/+58uVLzXjTHcZ53IBcSniYG
 YQ6dxFgM1ERmKIa7QaVWkzqSUOpzvyljy9Ro6w+UkLjBdTbAknGtg4RGHMlhQ3jOcj2Z
 UtjJv+IOLliM3XoCfx7rm91xIOCKRYWdwRVeY5BzKDhMXOdBPz3VqozgihhN/SKuhTmB
 LCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774008905; x=1774613705;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WycHsG+CtYNd5xQzelWA30aek3VYsDDwjjcbAg/0kbA=;
 b=RleejDMaSXw184MIpoJvG9Pmx2rwiUgRaNiR3qMQogTBa43rlCTlRcBZXKUYj8SXnZ
 gPV73pTDg20eJyANxf7e5HSaJuAOuJ6oq3kKr2YlInTlss+zkssJqZIEO91CyeIoG3If
 K3HZTV8/1vu5R/8arvfVwhRYZWRg3HiYanR9sUa1HUTadDLYTnPyi6u8nFsgnCj44vSa
 dF1rrS++xt174WJVmedVHI2bn6zM2nAQbQvlzCuvESWDosrBe9RT/K+yRFHw2uwjoQ8+
 s80MQj6Tq+tp6M/O+gxnD9QwUA/7QiJgZGfwIDLSh1ThQXWBXbq8IV5IPJEGxLqlfyY0
 QK4g==
X-Gm-Message-State: AOJu0Yx4Xj4RVh4S1CEJXl6C4AQaaPGhypzFDupZhh1FHZIHSwqk4W8Y
 +vLo32ekXIryzM0y+Tt84nMzFWmDiknbjp3qLXKhM5Pk4UkJuB8Q7PaZtehPraufabU=
X-Gm-Gg: ATEYQzxfR/OfpHZryzv/+2l5wV/Xo8o09zxfXbR1GXoWyzB2FGLip5VW55CBT9p7Get
 1fhXgFWMdsYFxLsUPlKQMrJAhIH6qABtKDaQcNiL9MnsvwoBug5Dpyv7az4MX3FOyzIb5z2jTpx
 NUaj+txsNQfMpojeBfUFjfNmmdCjG7vGwLc8efrJvTzY4GgIOQYWZO2/BgxzkL9Tsmu27GUgygz
 0P+qmsPiRUeQz7BpXBN+i5iAxDi9I8pKIvm6TQwUEhzcog62FgrD7aoG1RQ43Es2KwXHV+YX9eo
 ofknY51+uEdfPIEs+yW/H9ccjsJBDixBPcQH2BOTJAd7XH0SDVh9ZETSAO15PyrailwLQHbUadL
 TNhT5K7/uiHRH7I7+wXZv0QvtAJiJ9w2vkwyXHt5SHdnntTZSR2tH5djx2XXXmQ5A7aD+E98Qgq
 t860BovRl8BxxISBBNW/NDcJEuaYCDmWyoDG483AHxqQetLO8=
X-Received: by 2002:a05:6000:2383:b0:439:cc01:be0 with SMTP id
 ffacd0b85a97d-43b6428286bmr4939704f8f.50.1774008904899; 
 Fri, 20 Mar 2026 05:15:04 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703c27sm6247058f8f.18.2026.03.20.05.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 05:15:04 -0700 (PDT)
Message-ID: <69bd3a48.5d0a0220.120c62.3a2c@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <20260302120207.170340-1-rbranco@suse.de>
Date: Fri, 20 Mar 2026 12:15:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] userfaultfd: Add test using UFFDIO_POISON
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

Merged, thanks.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
