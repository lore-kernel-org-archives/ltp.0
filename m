Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FEAEE49A9
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 13:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726062462; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=EpB1bAeNKv3AhfBywQzavlTR2ZI9jRaymbpuJtZXGgk=;
 b=eGa8YAG/z/7H8Hnyy4PeVmhyWo0A0YI3Xv9K55G6EZrPNsckXX1Itr88PwE2Brok5CncM
 k6NtzthC4bTp8n0UxWgQjm43L9DI2GzGX5B4d6rHk1nz7I3p069/o1dUdCAReXYs6hnii6F
 xXI2aOUMq2oAKPecCssuvI4m+mTvdm8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6DD83C1D25
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 15:47:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61C5F3C068A
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 15:47:22 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DE50E200C20
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 15:47:21 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so20152155e9.0
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726062441; x=1726667241; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZGh2Ighb5AJmQShJXkLkS9FDmfQAl0xDuydl6Eke5bI=;
 b=IthTwDZEdAFAfDXhEXmUsy6DDEG1G+1oEbz663sD36TPjDlRqx8PyfwSsApKjwvYkT
 NIe6d2uReOCnaZVVSBtkh3bpLXqYq7h/xqP1q2j0adeuJaUAvL2VobTnISfyGrMz8rpc
 7KYGDxdMXITKZPXHuz056zzQ005C9I3emoj6zP0Eyq/tSQWSzoq+F7vK3I5oiziDKTCQ
 CG2mSaf18Ac4BYKQiTDpaf/WQhdnPddgNb5fj1kN5vRPkKgAUMWL3QiCKdWUG/kuSacG
 plz8XbgF49DQJRsYLReTVotKnnCxu/t80ZKxoxTNXwJ2l9grzUhH0nAH0zRJ0DlC2NLn
 gFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062441; x=1726667241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZGh2Ighb5AJmQShJXkLkS9FDmfQAl0xDuydl6Eke5bI=;
 b=LDdYZHXuWeMNqXWCoYSr6otxOcf/OBalRyuW6hlWwLksnS3LzNOiRXoiyjr0oGgSuS
 O7aGOyHkAvqsrpEm1JgRb/HtzD1N0CxH/CJVjHCJdqag6Wj5F1RtMSJUHJio3Y+9E3/P
 WBNY/TnUeQRtJ8tFZ9RMDFlTC6106jrKXrgmNjw5gA8BearuKkALZJ5MDx+zReWhcvCy
 r3vmWO5QDTQP2ohLHmCXtUzMw/O1LZmBt95rDr8tFapAEFZBXQnhuwM5M4IKzQeOA9Fw
 46Qr+wt80nCM9jyS0fk/v/TiEJRbAYWMzqynwqe1IuqyWFG6RO7eFInLxcg/wjAdjq9D
 3i6A==
X-Gm-Message-State: AOJu0YyZ3puM7ujrAoaOw2pFeKDoSAifOGS/4H1qP7sOnwXs6eI7hKNn
 j6zjsqEuY8+h3p2NUtRNtruPFAt+Pg5NiAPtsdrIb8xynvCwKEZP4FmRI6V2T4k=
X-Google-Smtp-Source: AGHT+IHRlbOx604cK5XDCYSeaqY2U32HkOrCvaqn4KqPxCHjzibeF7iHuqvBW8CHmJOR668RdKwyVg==
X-Received: by 2002:adf:a2d9:0:b0:371:8a90:112f with SMTP id
 ffacd0b85a97d-378b07f6404mr1975734f8f.44.1726062440624; 
 Wed, 11 Sep 2024 06:47:20 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd76f4asm5448649a12.72.2024.09.11.06.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 06:47:20 -0700 (PDT)
Message-ID: <f30db8a5-e679-439a-b6af-258d25308343@suse.com>
Date: Wed, 11 Sep 2024 15:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240911082151.16971-1-andrea.cervesato@suse.de>
 <ZuGcVG_HTNuBlEaa@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZuGcVG_HTNuBlEaa@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] Refactor fork05 using new LTP API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Uhm, isn't CI passing enough? 
https://github.com/acerv/ltp/actions/runs/10812861601

On 9/11/24 15:34, Cyril Hrubis wrote:
> Hi!
> The code looks fine on a first glance but there are a few typos and it
> does not even compile. So recompile LTP with LDFLAGS=-m32 CFLAGS=-m32
> and fix them.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
