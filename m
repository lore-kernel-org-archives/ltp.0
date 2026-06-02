Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C35CD6E60
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780417293; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=3s0qgHx4QYEftojYEa2CTHFWXCMqUU2xbpj08jgZsJM=;
 b=LpZDJ5o/lEPc27KX2S45aYlrufcZx1IvnGNirhfpLUAUQDZxFlvhvtu5SyYED2DtiW/4D
 BkK1jWlD/1LNVVuo86WqjHvriXlTww9045Iz/Hf0045Ki5kqjO1H47M8/Klwgd30vhHrQIC
 jDyrCHaIFsdXIMDntOtFf+DrMnCl15Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9D513E7229
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 18:21:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52BF43E4B69
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 18:21:13 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 01B0D600709
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 18:21:11 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso105247745e9.2
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780417271; x=1781022071; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XVymW2pIj220fOIPE/JhQcN+FPwmmx0T1HXi/3ygVEg=;
 b=POi8/u9F755s9bOjKxRC0gB8mzUfrlIyR3u6AzinTpG6u6BLIK35QxtBzarBZ8rPc+
 Tm4ci6tair8JSJqP9tJriDrFCeBQq2BwjCTnnc3LyGvl/9VIU5SV34Ks27GPHmLhL0SL
 +OMoQguay3elW2jp+UnwJ0+xIzI62plmtX6OH4F3njJmsVCyA863Tgss04jVH6fIwSbO
 2BJJOI3F2ehRkJ8D9MFBwJ7EMirNTz0bAyj6HbBNKvAxZvfje+ef5NoO2FRGnLFhvyeb
 103zpFBYsl8bB4w4/QV62SMKrromAyVpx4QA9PFJucmIPIMnbeQBRMwgfNXuq7c05Pjv
 opsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780417271; x=1781022071;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVymW2pIj220fOIPE/JhQcN+FPwmmx0T1HXi/3ygVEg=;
 b=rIVUCNi+rmEZ6Uk1oSfn58XveXB7xMCswnbMlOSxojlv+5zbVNk4yKdXcfzOwx2FbJ
 y+u/IdrYqkZ7zuOgDwtbXuV8BdZFPmvX+ARYPVGjARbd+wVlH9ulKavIXZXtBi9vDyFq
 guuLu17NXWAtjAbwrSCqiG3rY2ues81gQYZiszyCg92OnSWeNCXH5vyDJZqpnLsU49wX
 f2XmCRHmBRFpf7guY+Q1PdgRylt//h7N0RJBTMarfJ80AQQTzOTsL3o814NS2kBLpYzv
 SKr5ACpiBgFLJ2BXj+qMfozGiqsAb9Qz0tGXuN7Zxq7V724hYSRkN5CwQqUnPQPwFCWe
 wb9Q==
X-Gm-Message-State: AOJu0Yxgnk2URYfETFKvQ+n4ypyW4SGehM7JY7WQnJMn3LVswGIEMuJo
 GfBvmK6JLfaY3dTovICyLHx2ApWtrOTKHmv2gjZrBdQPf4mgutGGnRO3PdKpNBbuxtU=
X-Gm-Gg: Acq92OFw3zGf8ZhqOajsoLxyz0GlbNZeMDchHG4+6CHw3uah22ZsXZ+Iugki+ZyScq/
 cYmtdO4nRgWKLSlAJW8RsSgXN++2RB/HLJMkQEYbuKoaD+5aayfA+DDUCm2Z+QRkeo/UHYRv5xa
 PQOria5NZivIW1qxUDQ+qQQzeWi827DhgsVD4aymqNFVlagNOZzbupzmqv6xjnwQeFlmUY/vDlA
 eYjzeeLwxox0T9VCT/ii784Qs7s984aQGpVocA0Flp3pQ87CDkDtc1N30RrJcK6EuFEyDi6JIDX
 bSt3ZDfJCkvzV6p8hphDmpVX3QZ9thEjA5a6B/vfIsK++cB5+O+8F9oXiWnjksN+dfWDSQfodgB
 DTMXcn/B9v/qJiQBE/72gL6Uz8HxoObwO32KTB5t1lHemHM5K+a7zCPxZ0qj6Ac4o9zj6jUEbB9
 B9HOxGl89lNsn44ebonV5pK2BYxfO2bbVfL7/+bNT5H8X3fbXaLz3S7qicd+4FWTMzHs/hDFDJt
 e/LKTmvOfQLkCWG02wZ/A==
X-Received: by 2002:a05:600c:5394:b0:490:548e:b854 with SMTP id
 5b1f17b1804b1-490b50a9555mr7059265e9.26.1780417271376; 
 Tue, 02 Jun 2026 09:21:11 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e239f4sm119007285e9.7.2026.06.02.09.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 09:21:11 -0700 (PDT)
Message-ID: <6a1f02f7.7f42fb59.655b8.ca60@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <20260521032759.18727-1-li.wang@linux.dev>
Date: Tue, 02 Jun 2026 16:21:10 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] lib: Introduce tst_path_defs.h to
 consolidate system paths
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

Hi Li,

this seems like a good idea, indeed having duplicated strings
around the tests is not the best. I'm up for merging if you
update tabs, but I would like to hear what other guys say :-)

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

@Cyril
@Petr

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
