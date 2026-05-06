Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ED8CD343B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778083349; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=Teey5TQ0nu7NYTyQVvYMH1pMJ8wl7ksDu9OgpSmdovVAL9EQ9LGFF6xSAq3xUxrqg+y99
 4hCt/q+G+NNU/QBHYne1bu+Bc88gZ0oY6LUi+O1zP2w/+5vXpaYRwrewbaI7fV5xjsSlXCG
 LVJEVEbwgkB/AD45Gk3Klv9FAzm0NW4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D29173E6A98
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 18:02:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A66563CCB1A
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:02:06 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EB4621A00982
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:02:05 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891f625344so12667495e9.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778083325; x=1778688125; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Fx8F4FabtxGLY1Dsequ9GYn+QbK+9eaI+AuhOWH1yP0dRTBvC2YgnyyK+pBpss9q89
 pWoZZLgOylPm2B90E7oUs2Gx8anJcYJorrIOzeBtK84NSG7mJpifGLkfZw5/vskm0dYD
 iEY2Y+0Ohvri7s1JribWVPpQnMSugYkCRrDGWHIstFjiiWNhkgkmaLzy5/2A+CyxLRjb
 UHEuyIW4OMkgJwOjvHFuzLzgZuH3Gr+b4w9SrkGFLrriAc5jQ4tuYRujUw3kZ1utVQ28
 LnPx9K66JhmJ7rs0L7LKMCajU7tdDfnftSX5v9eSDRlq0alLijyFqly9aPuJBolsEg+K
 DSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083325; x=1778688125;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Pkl5R6lxWFew0fBLl61KSJUa+zmIPGKmaqSAUkjX6o8sWPccAyTxfMXVcETJPkSWxZ
 ZutgK61Nq5U4SUeAtB0h95W8NX5zKjza/0NSmohF1qqNFkGVbYF1xrQrhRb3WTaLHh1j
 XIW9EDZxMTqeHJVjpTF45hlTcc3MgqxgGRs96ljade6XTaaS5+qajXdwzCeSvsC2mcXw
 mEX9+8PH6lEwfH8P0oJxuI71y8LUl8919njOAWeFk93W4xQreD5osOBDrz9wILmf83nx
 BPFDJp1zxU54u1Y8XNF707mk2Hv16CfDUpUS3ar1YQJUNyTDY+YCKg96Mzvt7g3zwjOQ
 tG7A==
X-Gm-Message-State: AOJu0YzWwKjh9MRGCqOmqm1PC8ah6c/fDPE9vagdps+QaCwaozBcsuGW
 3ZdFsN3l1DlFQWQ56Jk+KQzNwk/QqcMgx3iZWsqmFiqu3WJnr4T9f2es/YCiB/FEKwBpYB+OmL1
 I/M+WAewRcQ==
X-Gm-Gg: AeBDieurFbu5DhY5U7f3BoWk80c1quhBmbO7r7tyvy+CnfsUPcgHKEhdi5jQ95M9HfI
 4pYuvMJO5WxFdad+GCXowybsILDvvYjxsELmKkmQ2LNcJyBotjOdyBFcBEvl/oNADfqwUfpvy3i
 D/eZBrRuJLnUpdxeg0a5u97OpQWudJOxCQzaBe1EeEjrkO3TWE+hWVEJzthcr8BBFPNxwhlpoNv
 09QO0Q5tX2Q+G36j2DFHDwow/8ICpVsWGxgwTF9zoda83v+3X3nlR3DF5rvzTbVcnnPRuLrqQlI
 GLUEihk421WUJe/Jfn+5SffLOrLQ8ghHmTiq1MPHpHAli5phB62iM7AS4Ho9RgGlxYXWhpgTG88
 MD74wOhM124lP/yL25PMtg1y0cQGrkYM37Iadu/5xMRyK6+MtLyv3GUB+v1BQVMr/8khcoH3m79
 6fLMzIs9QWFxjl1XOWE2oEylDEqKqTgUpMXqUGJzbcyuoqmdAfkaOdDOSDTiLAGzKtZusHHFalC
 HTUEydo7DSL71nUPDeZfwa7EEL3rQDrQFI3WZG+7DVimwNgBf4hxqY0
X-Received: by 2002:a05:600c:6612:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-48e522b71f2mr59540125e9.10.1778083323689; 
 Wed, 06 May 2026 09:02:03 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530b19besm21181745e9.7.2026.05.06.09.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 09:02:03 -0700 (PDT)
Message-ID: <69fb65fb.050a0220.3cea67.b536@mx.google.com>
To: "Sayali Patil" <sayalip@linux.ibm.com>
In-Reply-To: <91e8e5a0259ba981e530d099eb053395d8991177.1777377311.git.sayalip@linux.ibm.com>
Date: Wed, 06 May 2026 16:02:02 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugetlb/hugeshmat05: use size_t for hugepage
 allocation sizes
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Pavithra
 Prakash <pavrampu@linux.ibm.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
