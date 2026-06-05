Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4646ECD6E74
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780651228; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=3TA5WxhC0ChHE3BOzoIe8uWzn08irAwfzGJ0e8WSz4M=;
 b=FzEZYhPJ/eOSgHhTWFgweDpPxvPcdWHJ+P/mN9YeuJiT7hOKcEB1kpPJeA28KkOrA4taw
 lZSzG5DOKa0ljG7IUK1CFpbr3FribxHqraliOupQ7X1dvgqkRUgUWSt0ihZUo2gOdA5c72A
 HCE5IAK/jyda9atBbXqAzGkAdE9n+sU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2DD33CFE82
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 11:20:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C75A3C7404
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:20:08 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 830EA200ACA
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:20:08 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45eedcdaeaaso1204595f8f.3
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780651208; x=1781256008; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=w3cXG884hBcm8MRe2pH3RzMGcMLSl7ruBqfRcChdduw=;
 b=YRrvA1dO7S7WWx1LCiXF2md3N4LajOXgXc1Ts/X1AURNQmWuWyz8kyVIdd9lT0U4+a
 kdjk1XAjZhol+YQYPApz6eS/e1DmkKgdEXyuLpjIGUjX8RG9NxOVjrfHE8hAfXPWimDo
 coyifXcZrtXhUq5FpMOySBNgWhNSLYyY5f3cTT1URM15HOGg8lnL3GXGCkiBGAvhaG8N
 3QPrtzdg2Q34S4b4Jzhns0u+k1B9BUPWXdoS4wVpPrOq/SMnejLHYX23FNzSiNgRWOM1
 SIdVY7sx9snBuaduBiYTicN2TOz5D56j2kzuJxAa5OYU8g4annJyBniFstjjFGFDcRlZ
 stWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780651208; x=1781256008;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3cXG884hBcm8MRe2pH3RzMGcMLSl7ruBqfRcChdduw=;
 b=o0C+SZBuNXREQ+7d/1wABa6xD62zGjkxBEOHtk4UDQept/JhVX6C/n4rd2fa0Djm+h
 Db6Cq3DrKyYQftylJOy3grdT5IUj5KGIKk/srmQnajz+9rEC1+Nbd+r/jWmBOhKCLHLR
 Q5eaNhJWQXna+ifno9T1lWJalfFXE93CpGQKxy2W+zdWgRx/yjO508b1hZQws/OWjpbh
 KvTjAje/IN2OC9NNezjH6zNivTKbYfLcC0jAYS6p8BFipdJ2QFIxvXxyQfvjC3NDANuz
 QJ0mKQyr5c3zdj7CGnb4GIdF+ZPwE+ExnZVslEi1bpVbwjqYzxHKdhFjcYZ3ezL211Y5
 Yz7Q==
X-Gm-Message-State: AOJu0YzvroWMe3x+BHYk1jLo3WtbcA8cKUbQyiopPIhII1meZr3SLJ6h
 hfTnlwcz2P9Y2M820UaRSIPBlr2MUmWFmDt/6ajHGyC9bfxq5YYJb7jiQ4MAR9miY+OHanBKTHW
 SI4McbDusePvB
X-Gm-Gg: Acq92OF1RP9aPVmBIQGUaRunIWpwbTtCt5nkerNF3O9zANMyCzoJ6onxrcw6yfYeEJI
 sRQ8HKXO9kfXwSi9oz4KdvgMseuTwEyiMMi4cxNLow/id/eR6HtuRQf6jjtH66XnREBQN+Z/qcM
 eQwu6lo525QN249IhkqZQL5mzDdPknjNm6aBSl2bjdaajD49Au2ff0/sopq9WbAofwTwP4AB7hU
 tO0NZhbrnNJcO2spi0XsilOY0eZ1+NlFbSKiFi9ZdI77SSZhexRwBbzWrOA+IQiwnhvTGZzxzm1
 oK7PV9RmrWC/k/sI7Vfq7zWwjo6eI/ib0VWybFqLGDEI8+hSeE2zX9UUa8cdqaCDh6jumnvi9dB
 OvzdVG7nEbr67NhTOO8TN8POQ3FHXhAM34o6n55yTuniGrpcP09RSZHa01lptQs9K6X9hWtxcHF
 /+9IW7RWIIQBKqfK4UT1iYWFRV9U52luVFU90CqUjUx9kUvCirVKg6J+Qorw==
X-Received: by 2002:a5d:4149:0:b0:45e:fa17:a1d5 with SMTP id
 ffacd0b85a97d-46030759ab6mr3096949f8f.33.1780651207865; 
 Fri, 05 Jun 2026 02:20:07 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dc412sm24810400f8f.4.2026.06.05.02.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:20:07 -0700 (PDT)
Message-ID: <6a2294c7.f91b49e4.b48ea.92da@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260602125228.4098-1-linuxtestproject.agent@gmail.com>
Date: Fri, 05 Jun 2026 09:20:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permissions test
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

Hi Sachin Sant,

please consider the agent review bugged. We had some issues with it
and now it's finally fixed. You will receive a proper review soon,
I triggered it in the CI.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
