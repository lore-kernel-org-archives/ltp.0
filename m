Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B02AEB7ED7
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772626863; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=WcTapzwqSgvv9OKcJDfG5pU+vweE+ilX/PoGkJTgUec=;
 b=E7ond+9QZaF1HR8qj/klUIkzBHmRGNJaS7dsMMYw2JQTonEWTa7U10YOaf0hOJfhNj2CO
 MKpHEBMzfkw42reOOVr7VdDw4DTSWZodKNNyLVZKNQ9cGmU8GqdO0axG3sENtANSF4bDyAl
 CZ57A8anVs5kOhMEjzeI988/ReXFPQQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C94E83DB038
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 13:21:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEB263D0722
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 13:20:40 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 62050600A75
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 13:20:38 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4837584120eso50314995e9.1
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 04:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772626838; x=1773231638; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qSCnLV1cuiBFLi2Vm+AZaC5rczr439vt6oI1MVIoj7Q=;
 b=GnrhaByWMiegfcPGfnW1khtULAghY9bmYV6hmGzg3qPNOtS28b0BIW2oX7SW6PbAly
 igUSS1Qu/ghbKUbcYGdrmqZq6vqYxhC4sTTWNo5DkQPXPNx3fjyxgL6rJxO9koTrSGgf
 uzieucXnJ3DM52f65hEOWrnX0nEjNFIBhYNTrMhfgf+XWHQ3RJGN9hp7NtaghdC4i8BA
 WUV8OcRrDF+IWol7pbFSerwS6MEt5V6JxWn8mju1Y2ciq+vfedxA+pmmfKnEJQ4Lkb3e
 cm7hm79I3NNaoBHU9jd0K/di+ryEleXsudGuKWPkSdwRkzuBCAxrm+FIkXXgdaGNrtDs
 H//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772626838; x=1773231638;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSCnLV1cuiBFLi2Vm+AZaC5rczr439vt6oI1MVIoj7Q=;
 b=FL56BPWWjjmE4EZPXk64vouD7CoKRyGaV/Hk8yZsJn1FFv0qXVT5G5MHLHXce2wRUj
 qY7J8C4ecQWTqnZ/nOkFpnft4pUTeTfAOOo30ev0+A34lFcSF93Q2tZDmkCczUU3ONYS
 rZNMpCxDvRwlwN8Fsr88M+/otQQe6V4WwVh+L0hLHMWT0p/KbnBLZQJhMFNZMgjqw3zA
 kqGfpc1jtYqzl2hF/qfA0cmEJo0nTx3ecWcXb6wspaRBLdSgu7Uitk+QoFUatR5IGEeV
 x1ThP8St4E4ndQVy5spk0iptREfOx969UgcLbbafD3A82tXPXjp4Pt7Arvo4ekWGZzgu
 2UTA==
X-Gm-Message-State: AOJu0YzaJrHwea0+fHnwTs4qINHoqJTTasoABXk0/xzD4526RmdTqbfZ
 Hk89AlOcot0qIB/aOMvPYVVmn0Zurjhc7QCK094fgPB0PlcHM0HNuD1vjxc+Lj+z8kUiixPoUFZ
 aWtzK
X-Gm-Gg: ATEYQzwqTYxGudYtXdjNST5gXNa3hEdzVr9+KngWrZqe1QUW4gIcvTHoDrWdGYqSW9o
 hEVnqjCdRbLeWDjJPgmWBZHRhQOScCl3zpPuEbyXjnMiL6qe1euu8YWHwLr2GRD5doWZkDTf7Q4
 d79W3xjRkCs4aTBUHCe6ub/n4v0FuLoXeHQE1hC6xkHucZH9LMWN7burDiSuoLRhQkOAXR7Mo58
 p1pBlVWg/QYCQlmOIUeYbVKOhAPKwXSaF3qlYZtnfnBs3ZYWNcMhcUpCX8eiXNahecROtgzsAV1
 p8aRKgk8KTH9uEZ64/6DCR+OwP3Y6rAn32vGjbEoZWMIIplRVfmfJ/7yijcV7mECYE6tVwyZsyz
 I7Xxn211Iuj2YuSZcR3qKu8MmvQyEh6SnFcSCePOHjS3g2BOsZNJCrrJXLMr3IuLMyCGDWbgYJQ
 TCBt3xRoj7C4rVR8UGrKVn56YWGdul4rDIZU7D57hf
X-Received: by 2002:a05:600c:8b4c:b0:480:1a9a:e571 with SMTP id
 5b1f17b1804b1-4851987fdbamr27880925e9.22.1772626837688; 
 Wed, 04 Mar 2026 04:20:37 -0800 (PST)
Received: from localhost.localdomain ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b1b97927sm27896704f8f.28.2026.03.04.04.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 04:20:37 -0800 (PST)
Message-ID: <69a82395.5d0a0220.169c6.3c45@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>,
 "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <aZcCrH2i_KFhonAG@yuki.lan>
Date: Wed, 04 Mar 2026 12:20:36 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] Add safe macros for stream testing suite
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

> 
> Otherwise: Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Just one thing about the tag: be aware that `b4 trailers -u -S` command
that updates all tags trailers inside commit messages will use
`Otherwise:` as a tag (lol).

The best way is to keep trailers in a new line.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
