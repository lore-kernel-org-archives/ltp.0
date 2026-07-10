Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A17C44501
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 06:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783666356; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=/jfqFzbxcsnpE4aB5cqsmUwxCC2a9DYIftae1sGRiqo=;
 b=NF6qwP/sIIN3VaI6YHaBa2LlPHaYrduRnXjWCxzzR/E9ecyvkTNG5e/Krw5FqVWpbQwn2
 mxfuUlufjwI3MAh8TTmiR0h0WAysqSrGc0/zCmEjVzvGbnJ/DSAqNVj+1BMd3AuTXH4P9U7
 +BJGqDRYj3HexIuyr1ZZRHPz+cwTmeg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0496A3E2789
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 08:52:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFCAF3E26AE
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 08:52:15 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BE374600A4D
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 08:52:14 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493bab44440so2906115e9.0
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 23:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783666334; x=1784271134; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1cBK+DCatjkJCf4GlARGwzFHDWrhbiKB5ZvvPJ/UJrk=;
 b=F/DnRrUkEnJuJ8stpyN4xnCy/bI+GN7LuQLR1KZYjX4j6Qz9jOD0megRbwX2vyRPEl
 OecnDl8bo+JqnJDJcZTO+W1j9C7XjdIO2/6Q+Br946dsQZjNwOM5xrK1NlzydV2c1LxW
 e0NnTgIbdKQQbLXo5/blPT2xq7qoAJuzqlIRxYlbeLPQqut3weSEnUHNlzQXS0TRG8u0
 w8bqgO6Z4lVTdhRgHAMbu59U2FQ66uCjEnb5BG4VAW7IY29OX4Whg5cfpPXWohfR1uzY
 tkzfbf+HCw1xsRNUbp8rem6VbQSYwZWVL+vnhO7QV4ppaGEyXu+ADXRzt5zTrFRtk5xY
 Nw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783666334; x=1784271134;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1cBK+DCatjkJCf4GlARGwzFHDWrhbiKB5ZvvPJ/UJrk=;
 b=Y/gZ7WEHGK5DWxqoNA8HQ1ePliz3H28p/w98yFQGluFmMzj7fAjtNCEo+Ryd8T3rIx
 koTKCINplrD5UwBBFK9yuA1rTiwAzFjso5u5Sp6hfeisgo4xyuCvFNHxV0EP6NbVS950
 bPPy0clmBbCY00bwDUCFsj5EI6kyogCD1XvOVqCscxuVOBNF6iRMti+kNoG500C8HIFu
 6jz0dZw3GcGYZ6Vk+KPOjEddDOXhBDm/rD2JMvr4l9zU/ZmgaLC+15n8DpEqH93+hKKP
 m+UcF+Npa+VvkhiEDwzgyHHYgr7Q8fVlltPihVk0bP7yBeKANg3acPOMCYfHjwu6lcK7
 KlAw==
X-Gm-Message-State: AOJu0YwvBzoUqWku+9cRDj7vKCyolcaw6lJZBeL5BjnJ2Cn6Yep7Da1N
 jobP1ZcCcWhyzdkZ0Voyu11DAceHhBjL1rgdXCpb9Ke8azFxY832OhrukN+zeLwoKNKDk4Y9H1X
 II/ZsdtKSPjYl
X-Gm-Gg: AfdE7clNStIDtfr91ZbdbXAXXJjdybcr6xCC5t7GgMOcwVyqu+pa/NFDIS35fmS0iCL
 ECebI91PRLP1GnmsnkmOHh04wjdr9DME2+cMbQLw9XpDNEIGmyAymjNK2xPu1s7GWfGplChos6y
 g9UXvJ4V4+JTL/pgEI8XX8CD52ICCGb7oSa0+sJ3r/nieglGVG1wKYQXTgR/E4c7L2iDzYRZBGt
 xCFARyx1ZIwUoeHzYH/tqAFQ74OFBWPHvXtj0/Gao/XkB/HVnMPg3RdW6tGu8NG9rnzZMA/jHNy
 STQYYwpMc9+17DBfPvX1Q1aZnOCWJjObkXgjWaAe+pwF9LW6UKCTpKtIoj0JFqUNmY12kHRjfzs
 v7e/x9G/pbvWRTG1mspHIYeMecKok/ea0U1E2EEmJ6I5MoUd+E7GGHNjBz6L2KFmtXW8ZwdcXgn
 HGqR0U4c+3Pp2EZV2aX62K68xSxiepFXiSOYn7U9EReNiXY7M=
X-Received: by 2002:a05:600c:e557:20b0:493:e542:ffd5 with SMTP id
 5b1f17b1804b1-493f2b2b3f3mr13367625e9.5.1783666334099; 
 Thu, 09 Jul 2026 23:52:14 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6d4f9fsm113934465e9.4.2026.07.09.23.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:52:13 -0700 (PDT)
Message-ID: <6a50969d.c5b9c171.16682a.3705@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260710021502.1798161-1-wakel@google.com>
Date: Fri, 10 Jul 2026 06:52:12 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ltp: syscalls/madvise09: Reset cgroup memory
 limits before test retries
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

the commit message is unwatchable. It's not following any commit standard,
including text length, format and description. Please follow the basics,
otherwise we will reject the patch before reading it:

https://cbea.ms/git-commit/

If you really want to use AI, as it seems, please use the rules in this
repo: https://github.com/linux-test-project/ltp-agent

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
