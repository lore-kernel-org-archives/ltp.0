Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88C4C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788441018; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=RxLrgcci2shZkI3vB/aNF7EGXBWW3/xTXU20k/a1RDaWkl8TCyVcuU/dfBoM09zOcukfp
 8OF4XUx++7aZvvWUaP39A5tIscW52r4h8tAGLtCuxoiTCEp3FJlc+4xu/i00XQfg8DcznFm
 +NFGNzcSFMEWTFoLTSv6McCvX16dcXA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D14F3EAD7A
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:10:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B07E03E71B6
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:10:00 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1A2491A006FC
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:10:00 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so23848885e9.1
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788440999; x=1789045799; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=E/q0vRRgGWS/baWpHjAB1DE0tYQguFpZQNrFFawrwm243FKmsxGTAG8jVuXkw2FByY
 2gp1O3sVTdCc2i49u437igwdMjrPNXyuFhGYjWHlVS5uFgiJvCJcJ6HCwoBK2FZr48Gz
 VxlJkQDV2hzS57H5zJeuwa0tOU+za1yy4BNl00nnnJG9KZlvWUIAw8FU34Vv3atbyGhI
 ip+P69rV0zRKqsvEBIuD9EL7FkwYTH7vRo1aKSzfS62Z79sYCxIsXizoGshOctc4RJKJ
 28GYW5qfBTWCVaAX5zfYGZReVfjuXqMXVbYi2x2zIDc2K0BVENHdBB877kjyLVpC1s7g
 IZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788440999; x=1789045799;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=gEC/QRgSxRDT3A+uasskL6nqT2zcOfYUfVf6EcCrfCigY0bkboOaWoqRicHNyJ21l4
 J4E8TaV1GxGQcBr34drn9BGfOfPQCNfiZKxXVmrkkEdtOK+oUus3KI+X3OKGzKjaSgZ/
 Fe1bjxrJPLP8TKPvpdlMCaIi1vxJHRIisCWpl8Ds4TFt5tXasTYgFSquaeuFk2/hlE2z
 RLsdhjR+9hZdUvjGLVd43JFqQPuGl0fG3ryk5CCzZZ0guZTHTmgrzzy2BQq1C4E7KR/n
 kEpkibgh4V9UR4JPTvN7kyYiasOWk7e2VaQQdAXDyulsMNMU+D/j6XLnbE5sIVSdlslA
 wT9Q==
X-Gm-Message-State: AFuF++kcVMnbpaGYpphs6SdKqYg8VkyM2lEd/KaOK7matY0v9WMXZxm5
 o2fdJU0iAOD/W1j6qY2KemnyuqsrDrZeaSlafE1bYwThR91KuBOJPY9smS+nFC5Ho91MPS9FxE/
 uJtSXHdwhYA==
X-Gm-Gg: AYBFou2OqhmbmkK5VEFJtpJDT2USDmttPc6NivnHZOHSxydtAmOsKXEKtdBuQ3IbX8L
 QYmcw3KKmqBxpGPXYdx+DgyZ0SANhtCMOJlQ502zNVi77WUI+asZJP76g4vsw6K12HUynrwnb6+
 ZrT9BtWSvpPOWN80MDkherWR7Hd7xJKl3XIjxHiySlTVkzw3Fc0hBf2EkOvdLgGFiTTJaB+wzIL
 RHGsVr8m90COTyDaf9RCiUTW9poTrRxBgNwm3AKAS78vxB3VlxtqE9cLeYecx5DWU3RBhJk9LXy
 E6a9OkqyLZkjvhA5QsSSO9sA9+81m/ipAloukL0UCabUZuQYEjJ2RteI78gwLt3wUMcFGSfZhO7
 eX9OUMOeOH8RWOFrc3ZZ+xhzSQ0RhWndxT1YSL1WWjqp5ne3bFbAZKTzowDX6tNJcxjnN/yqsA1
 YN7ZYcgMemGk4ugDNP4Dk1BlcaCM9yef35UHlmOq6Lj8Q/yDN76bTRRjf0BEOyesEgwDcDzo+50
 Zg44nuS2ghy
X-Received: by 2002:a05:600c:a086:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-49ce5815dddmr235615345e9.11.1788440999363; 
 Thu, 03 Sep 2026 06:09:59 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf2abe1basm39377155e9.10.2026.09.03.06.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:09:58 -0700 (PDT)
Message-ID: <6a9971a6.52e1abf2.146b11.87f7@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260831163310.137399-1-avinesh.kumar@suse.com>
Date: Thu, 03 Sep 2026 13:09:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] openposix: timer_*/speculative: Don't pass a
 stack pointer as timerid
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
