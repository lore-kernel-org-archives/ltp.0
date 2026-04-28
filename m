Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014A8FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777363011; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=HyZd6Es2ZllT+tWOII91Z9SNRz/weajIWW2hl/p4xS0=;
 b=O9oPCEqHsW3StknMySuJh/Vdt8slbA0Sysm3yBospUk7UNXs+HD47jiHShL9FAmSLrkUM
 MtpZPEuewIwE+q+4+puxH5hceHyvSUfxSyJ7IPRFIDxrWKuNPK3o3Z3VNJNhT0bEWm60Re2
 x3sDUxgoHiOc8RSowbBdLMFZHzYgb7w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 952A03E2541
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:56:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FD063CA104
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:56:28 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A3343600B28
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:56:27 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so9090094f8f.2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777362987; x=1777967787; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+NpGHfkAKAUS6pQeZW8AEfDVTthSsGItiG6lkIgLCz0=;
 b=bvN7BQ34gjWLrcL6ksa5q3M9551BFg0LEiL8gHFLtWkwYARtI7B+1uf5iR6CAElMXv
 6ycovBNzRQP5OnYc5DTQleq9kJqV4GL9luPfDElLKznC5M2IFxjebOVGR2SOhb1gPl76
 afUR8mhONM2P3WbayvTcgE3pnpIQRtiFhaMISO7XHxa2kj8AQ3j9oaF8IZ6uqRwxYiq4
 7RYiQo0hqV9wg19RL+URylFkfkfS7sMP/ZvE7aTTJzqhyIaV8OS6CLBfbK8304nLw1Oc
 noniVfX7mIXhQLtVBS4E26BZSce4+6gbFwZOvsnQvSVJUDSlVo5ETIGnsHBu2vDURNeg
 awHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777362987; x=1777967787;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NpGHfkAKAUS6pQeZW8AEfDVTthSsGItiG6lkIgLCz0=;
 b=Vp0hBjsuI58k5HHONNnDht5mu7nMZzKxhYqp2WAeHEbZ04JOX6CoISLJtOOzvJyuw/
 BaK7WyUwumZMM+As/9mT7qdiEYSpIEAgCC/KEP8b7091EWNSRzWeaw+LUFYl4bdXLtYT
 LshdPMm4lX5E/rWHg4DMYGo91OanEUnZKPAErbmFaazNHB61tBf+kWa+PU3U1pAmY1Dv
 cb1l/3bTOQohuu9qYeBvthVpLXiygDbXLR2dv/kKLBt24HlIki3qSc7wIE+vkxb6lCrZ
 YL7BQ23J6Am2XnMy/qmvXIQcpB5GD7Hqe1Xn416C0e6W+KGNG7bNfKqjJsXcAWopH5pr
 GcdQ==
X-Gm-Message-State: AOJu0YwEjsU82VR0j0uUAeJGiMQvzGW74d7JvwAm05aI+oYRquSF8Rgw
 8ueXSg3v61YVCuGK4gV0bo1q8q8DbK/ojGMJ/Z2ierKeTyRWsEZkwM7rp8wBk0AdJ9I=
X-Gm-Gg: AeBDieu3hQPLu/xM8l4V/dg9ziHIfzyrdGCfZzOi0tn8TktXxy5C/1ZdrQWZZHZZKOh
 wrzyVsZ+2cXEhc7NLQ0vnaO4oPf3rbaJX9+i5c7uvOW+31Zn6SO1SlCx9Kl3uoQgCfQUsyG/125
 nfWNEatdhRBMnd1FOpdniKdHISlloYnbwNyiyXqBA5pfI5zVUJKQiOYEF+UEiLvnKH1/qWtwUBW
 EShkjCS5hdfFrxDhQ0g1l/SKpdFGE4kKEWrW2uqmAxF7Bu0FXzXQqexqvNNuQ77L7SYxAwHMVo1
 PrmxaMAbCWyzkMnd/UES/uiyG/74yMUxRcsHf4htEkv/D8f2EsYCEaUjLVimmxj5yHPYKTbB0sj
 V0zQzui81W/D79p6bJ0QzqJJMNF9IbOBJ6o7vB0esxcVGIwwj0XsesScwkKu4xXlQAtuKe3Ni3z
 jjO+x5q2+KXByXMZ7oAVvAL8ymJ3TNVZBCp2vbMXFyfGOuEjX5AT6D
X-Received: by 2002:a05:6000:61e:b0:43f:e7c4:a36e with SMTP id
 ffacd0b85a97d-446481b090cmr3684581f8f.16.1777362987047; 
 Tue, 28 Apr 2026 00:56:27 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4464004ec73sm4177317f8f.36.2026.04.28.00.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:56:26 -0700 (PDT)
Message-ID: <69f0682a.df0a0220.3d60dc.a063@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260423095834.11932-5-chrubis@suse.cz>
Date: Tue, 28 Apr 2026 07:56:24 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/8] syscalls: Add epoll_ctl06
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
