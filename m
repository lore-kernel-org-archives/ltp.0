Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825E2C61DB9
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 14:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787667137; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=qm3nxkoOIWYGdtAkLij9tA4iUSgTmRZU77l6HEQ48po=;
 b=l6dc8vnYxvcsz9ufkl06cDSYUrcYXZ1dCqN/nEgA8/Dakc77OpVpSj8uB9ZZTRcs8OAoe
 MSPO21yTtEsPqiT2CJQ9KMWPjv6LKn/WP1czlU4xmBmXrHVixSAgoxKq02l8OlziRMXmZrB
 999uBQYD2FFxCxnn8z6cpjyAPJRximM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B62CB3C57AC
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 16:12:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2721E3C551D
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 16:11:58 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8D3331A00A5F
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 16:11:57 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15b1da6b82so531244666b.1
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 07:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787667117; x=1788271917; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zJi2gSlK4qgYilh4boJ+36zPLb2NXjZ3Lybfgm+erf0=;
 b=VE94M4pyyK9Ai+qF3iRbqsipAfyoCw8Y04Xbcxgtpjpt9Vv81hPozo2sUxV1DzgMfC
 gOPBVPdZtxh50gmmTYLg++W3CgANhajU0fvWsIGKv6UIVtw9HWXl/zYY8UchwcDAzrIp
 8Urr0pH/vE2hHm1GKXusa9mLVubWeIQTuacdqk9FQvfAGse4YYwRI+2QCOb/H98KU/re
 Qgh2P3ijEV1Jd2ptnB2EV/iUk5fZabGqRCQ09G2TV42r5gKjwtcekueSd7IxRIpDNJ+9
 dSZdw7J7S2GoUD2zeVEycrwonV2pykb83FrkLrZ6BKKgCcqzup819GwH44WY8s0zyNNa
 vrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667117; x=1788271917;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zJi2gSlK4qgYilh4boJ+36zPLb2NXjZ3Lybfgm+erf0=;
 b=MLaDHOu+1I9X0MjppBIDtCO6YLcDeTSN+yaaF3Pyn3fXgs6GYChLnURCvN9KAQGtGR
 LtISYO2qQDCRmsqPbcV4yT/OvuatUWSndhDor6vBTxTz6GCOw9vRpLYd+j75J41SG63P
 RDWBv4WcrvMZ/O8kChgbDJcaYwGj7aCuiaEvSthI+cEpTG51ZWlrZisdWLRCT648Hweq
 pNuwhRsu1g2TFjME8gPjKPtbYqgYawKYLKOj6h05lQyZdTazISWXCSGDP4KP17mmUDwF
 70LowCwJ6xIE9PViWeTB854C05SiCscTVQx3OlLKWYq6LQiNAARIsMMGU7S+k2cIrbSb
 1QNA==
X-Gm-Message-State: AFuF++llcn2D0QsACvoDFGbrquyIOSof7xXu0WXEpjXyd3r+7yCCoGUc
 BcL7G0AjAT2nRf/3gE72fswgbMXhWSSrlKEhd8FLmCriYHbccWJWXBzUVq+3R1Ownj4=
X-Gm-Gg: AR+sD13hl3CVX7lDVv6wfWzS9x3uJw11fxt/hLXiRlM9CHLj5jJTPUqFWFmA8INkBKe
 QsrwYwJ9OTHv3+wJcvzChsNef+rxMT74WFZ1F0Hec13E/mxu625IpDbIeEmqLayy7BPN2RJMo6X
 b03Bj5PtUQqnHGR3Oa9SVNmCEZKOjWp40k6g0H6nYTImSTd4DJAxFU2q5bR98x2J6+nF2Bkm0yP
 c+z7sJrMG95L59nVQQdEB5lQYwkhEnjSBalFNQJO3aTqkj7qK1PsDyF1LuoKD2FWatYr3M+yS72
 8eXuAyAeCtBtSMqXCPnsj1eBorRQGxpZiM4A9bkPHkwDkZGBo6I9wUIj/+/khRbmHrNVyfx0Vg+
 nEMNTVuUjZDu8DS56oZaP2JQX5UEXs7Ucbn87c/IYS+EkFsDX/9OJgAXybw1waI3CFoGsJkZZ+C
 UBSyuAV3qMahdU9PLRscELZAVrRiRHrQARFTKvsPWHfu3cI9N9x9PUu1wC/8iUJD3wck46Bt9jO
 60zFX93PmyRKcMTa2P0BgJ/oyK/f/yKo1Zk
X-Received: by 2002:a17:907:e1c9:20b0:c25:10a:4020 with SMTP id
 a640c23a62f3a-c25010a411bmr287592666b.16.1787667116922; 
 Tue, 25 Aug 2026 07:11:56 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496297c7dsm1762172966b.20.2026.08.25.07.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:11:56 -0700 (PDT)
Message-ID: <6a8da2ac.87996512.214a96.27cc@mx.google.com>
To: "Samir Mulani" <samir@linux.ibm.com>
In-Reply-To: <20260821083736.49869-1-samir@linux.ibm.com>
Date: Tue, 25 Aug 2026 14:11:55 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] sched/cfs-scheduler: Fix 'make check' errors
 and warnings in hackbench.c
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

Hi Samir,

mmh..I was about to merge this patch, but then I realized that
this was applied on a old API test, which is going to be
rewritten anyway into the new API. For this reason, I'm not
sure anymore if it's the case we are merging it.

Are you planning to rewrite the code into the new LTP API?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
