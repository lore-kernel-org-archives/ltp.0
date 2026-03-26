Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472B7106F317
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 10:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774520062; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=GdUoY3Kr0NF5ZLTCT4ZvQKFu2Fq0vB8PVx0XLgIhEeE=;
 b=nTX6cSauhs0v1werL1DMKMzTZqIxseMRNPyhpNEimO6xJNA3Ya9TL8SAhRkiEHlwb8Y7z
 ZDnzmUuc7tqkurmSP8PHD8qWplXoq7gPpF61o+sL6m+J0bdGVBNNtpQpsYBPR8rlbDFzgaT
 fBPjrLysfkthcswZkbvISCDdTM/EX2E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5E263E2FDA
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 11:14:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 418EE3E2AB3
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:14:00 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 75A2F1400254
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:13:59 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so721581f8f.0
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774520039; x=1775124839; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DqbFiTPWKUkKjFuA6E6DdTkN5ltmv1Xvn/5Oke9STx8=;
 b=PkMy2Fej3AgtRWshxpmmk0H8If4L0vFfWm2PqaSRA+P9BqFnRyIxrJsq3MrnFqymDP
 X6FydpUaM520J+5LRVP/+ZLhxk0hin4x9ShEx6JMZQKZ1xTu1btQ/Mtz0xSW1miJ8o5/
 83Akle1zi8BZhp7M5X0WCiJOQYQ6zTncQg+3Jt93+QksR2BMtnMa/MwfUQ1mZONQShs4
 ae7NNnnKO26TZt1mhquzmJtjWnwy0/WTnW5gKVjrKgwws1ukx/5XFIyecHd0sRsbZafv
 gst5naUoCPzKEaZ10kVLkE5YDgv681c62ibaQve7TMz/WtW/WbXuAuV++UPCAQnJv0b8
 I9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774520039; x=1775124839;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqbFiTPWKUkKjFuA6E6DdTkN5ltmv1Xvn/5Oke9STx8=;
 b=fCiNdkdJRl+SPnBT7Ne20AIe6f8CjGMTa9tbJu88TG8DUobdcheBcGenrnVA2k6AyP
 1oXmMM+VjQWgwCK9wRCprzowMyXtJDtpsvEMaHkShFleL6jP+mI0/FnwD8sJQu1V8asA
 VaDAHde6XaEOw4LBVQrXZ9f9q3B66ZaJCjOercYX06j9z45uezJ00aQeTsYU/+xZwRhi
 GVqq+HrbyvPS2l/mfg11aXPLXGG3o/CAcSITsPpD578MXi/pGztOjfwAsy2OGqp68zmI
 +9GMmuBaAQcHhbUxDrblORfdftLV6ByuAWT6ZM9t6xsrKnJah5mWdlWgNT31RHblYx5e
 lvVQ==
X-Gm-Message-State: AOJu0Yx7/qgRdZfspoFKp09zGrv3a7ZHnD5Qa3GaaT7OPNgrSMlfCfH8
 SzvHgb4olymWgVvziZjpENIcMupuWadV2AwyQhIofa50cdK6nwCgBWyqQa5YbBdpieQLKaUskE/
 EtxaLh/+u1A==
X-Gm-Gg: ATEYQzw30Dxflf7s3akO3vhQ33uimpx1fKmLquC6R5UhkWTB9pPJCbYy1Jt2by0Bm5F
 UzMeM0UfxR1+dGzXxYS1+BGc8AFvOjVdkUrmjP0APHrpVq8hI1D7E4nEXE9aaUmk+E77duPMib9
 sD7TTXeylBXLbc07leNjhhlswEQ/viqUN5uMDwBHHbXWN0ra9aiKXI4AcTEGe9bbcHogbq7Czfh
 Xajfci3G3eLnLXgpiLUHpT5ojdk9272rDNBe9fxN3s6Nh9cWpomgqnahU86QPgFGzQ13jlvP0s5
 M8J5R0ef2lXpQ8L7lMjgTz5sLKCEtmhBYiSSaWRZBgTJ82bDMXJ7B8xUjs+dZyRX8RiC8nqcjhW
 VWdgeqZ4KbPpqkzJqTWFej0qyp1Yb+VAjEmj1W/BBAab64zYsCWC+YAGJu6JRixPpAFiSr+g2Wl
 o6BQOanHX2UHgZud/hmy2tKvklIFT84RT7ea30HZJ8lGTBz/7Gbcl6i68uYV9bdxVV1b1XrxbvX
 vZpo5wQKt7WWWNBKmgRPrVdKD1s+hIm0pU=
X-Received: by 2002:a05:600c:4e50:b0:485:40ed:2d1 with SMTP id
 5b1f17b1804b1-48716051d3fmr114049735e9.17.1774520038812; 
 Thu, 26 Mar 2026 03:13:58 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722cb0d83sm21713885e9.13.2026.03.26.03.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 03:13:57 -0700 (PDT)
Message-ID: <69c506e5.050a0220.11e839.b5c0@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260121225258.15820-1-pvorel@suse.cz>
Date: Thu, 26 Mar 2026 10:13:57 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/setup_mailinglist: Improve title,
 mention b4
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

Hi Petr,

I think we can merge this one:

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
