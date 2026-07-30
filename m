Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07185C55165
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 12:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785415899; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=Ol722O28F6/s0FKTvu9Pt9aiCIyogP0S42hikN461fb4d1ooV8XxT/BmNYOCAit0fNqBH
 lr5zwwYuqkjkypx/uBlrCajcW9gvOw7UbVeEl94C67gKJGOO+gtDRHUHD5AErnDNMn/h8eC
 /DjhG13OZuQJZEVtdF/XxNAN5uA72pI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44F5B3E723F
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 14:51:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 444613E2D30
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:51:18 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8A4C61000609
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:51:18 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso9658675e9.2
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785415878; x=1786020678; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Vy+GtE7xDGDy2goQAfSuJdIvAJt8uVJGxztJR9j31pa6mFKlPnwXjzXvfuP4x+tXVy
 nBey23a5OuFCqxpGJG4Y4OubjM18BNpXibFBFUruNOC6L8m/97Z4CLIJk9mAuulsydnt
 ErEDhvUKhaSoG09lDpRsqODQhDDfpx7SqAUQIuk2hXIDuSh1DptaSW+vF5y6+D2OU7v/
 F+eAu06o6u+qR/etX8F1HQ/C6EuUUB+UqqBjE5PS5dYqAecwQ/VWWL1CnAfqVCDedhbT
 IHncSHD/9ACs/WWa6peER79HRB8UvguyDHwqfrTIeBOWLg/2xR7MrkN79Kss5glHsQ6E
 fvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785415878; x=1786020678;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=aUF8ErsumymNRJ9aOb+1QGa5GI/BnSjazHd70dnXZ4g8fkta4jZBvQiHItFu/C2lvg
 kXR4sPMPFVKGMHar6CTyd5QsoK6OKUDRee0JLsiMQERjFDTdhicmr4mkOyIUdge7myDq
 5RA2I9jx4UkjHs0euc9UBUyqn2+Q7bYzRduG/idGICkX/oiw4zUMX0M43q7aWrjAbf02
 ssICuwvF0sVYt5nR9nllVcvLbUou+Mr8gBUsQWO0K1CRNoXFzlN5WUtoYLsFU7CFBYfe
 gHgmkcNckx/xRCE/jTN74DJggHSJz4V+xHn9wALHMmDei1OIxsYfLZGd5++WHp25fFnw
 M/jw==
X-Gm-Message-State: AOJu0YwRe3cVFB6IuZ0ZOud6KCjgfVoMQ+OgQ8n0Xrur9j6tDhNQmp6v
 ItWYRL7RP3LGNRqfp9hyiLjRVCxzyAGqFuk0ddklLo017jNwcXzmMYT2gplfuY4VE970cyqaFAQ
 NSRtraPaakw==
X-Gm-Gg: AR+sD13K8V+6rN5Wd40x5DN/meRxMcUqQb9ShFGeMqhelzl6jC81xG6/IVYYERzDbvx
 lqLCrWTycyEToOfOiEFmSF9Qhsq+8vvSuq0tc5nZlxJPa/0Q9PaueprFbVLgdeGyZ60J7pJ1RWF
 nmdsPSDHPOXSG985f4f4i7W72vx8Yp8e8yTS9OYl9moqmBeRqm8SQQ68u0n2ilKV98mhNcLOZS2
 Mj7NoUk2u05PoBzLmurggksIe47gSNhsMESt261VkVFmoGzRb9PAdV1471UKzY2b3sgS34Daegj
 ONnkBTb4a9gxAfY1P7pz/44jMlwvjxvXp7YnFeQqMxztRrA0/cKALMYh1/hrmmSY3Hb0CQYjdgR
 Kl1gRVCFs7y/maOiH9XahagOsKE3/FkUI+8WlEk+2EpcokvHnNQ0HT8TVw6Ib98FjeEw25SiIL7
 8IaoAvwyvfgAg7QQgeWt3F7RXYebeZl8eFcyodzNycHtXy5DCElAhqQgPbnwEc86FAhr+7MqnrM
 lHmIJPf8jQ3tPCz2RUSgcBYhj6dJiVkGQTIUV7GaY0Wdupd
X-Received: by 2002:a05:600c:5297:b0:495:6788:c229 with SMTP id
 5b1f17b1804b1-49804c1548cmr4113045e9.4.1785415877889; 
 Thu, 30 Jul 2026 05:51:17 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e439asm5491555f8f.11.2026.07.30.05.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:51:17 -0700 (PDT)
Message-ID: <6a6b48c5.9b582779.331aed.7b20@mx.google.com>
To: "Stephen Bertram via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260713170129.1177772-1-sbertram@redhat.com>
Date: Thu, 30 Jul 2026 12:51:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] pipe13: Scale child reap window with
 LTP_TIMEOUT_MUL
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
Cc: Stephen Bertram <sbertram@redhat.com>, ltp@lists.linux.it
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
