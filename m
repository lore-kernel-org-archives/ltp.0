Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC57EC5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787212321; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=gMtU97glRe6HWWqyrjUzgItBkszcU5bMfeDdxON6kJtBySyy+cO972y/lgEq6XaOsolgF
 jZz2pIidNRkw/TFYTtOME2+MwFTnd8yK2HupGupzp0BQUwKBlmzoYK9HeuKgQDxTG5PWdqv
 OM46/8uuyqb6J3Lk0y63fNgN7JVCAvM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B1E93CF08F
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:52:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93BAA3CD73F
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:51:40 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 445E81000783
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:51:40 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so1611523f8f.1
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787212300; x=1787817100; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=aEU8TXhgAoeGUeQ5O6Yn9WwwURHE2jKadB93W0A9Qtcr8xOah2DE9mwcDvjPzKz/hf
 dYeQhsIBrdN2VXP25+eGbctCXsEDoI97XK2ivzeltMuGOJo74WsKA8oM/1nXZF4VemTW
 YSV4JYEfrtbfXWrqRtNeXaRBINl6knplSYQT5ShVSqO3Z2GoQECai7cqh8S++h7fozUh
 H4QrIiB+vuQS3SGgvCoTlzrmBNxGo14uDADputBxA1va+GvdJmkXUWBCd63kxBhJ3EOF
 lFfD2WxZi4RAJ2xdUL/ffsxKo2joouIiZGlX12ROodb1qEn5JmfKc1TQa5SbDrx+AFqK
 P4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787212300; x=1787817100;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=ZiupFitGVLq2gYDXbv/iuwmMaNkJhF4JJj2HrtQ6Z1dA4xZZJizuWXtUer3De9Fj8C
 7gyWGH9oVRwjWcEtRDfUWctwXshLafW/2/Gfyrbl9HTOm3j6kMh5a3S3GqCxLi97J78T
 4NH1wLMJnnaS6Ki1ZX7Xzr0tBIvPoSy92c8aevS6xYwMDuqVdol4cTIv5uvIKixBYGin
 QZSagfq8CpyIsdbfcnADPy0Z+l44LX9ij9Puk2zzMxKyJs2jUV6DSYDbpxgQKTRMt9S4
 ZBL1McR3UNYnSVHPeD9zZiT4qi8no4TTRMR4+zHeJtUhAPWYGfYY/kfZB95lWCI4wP3S
 Dzvg==
X-Gm-Message-State: AOJu0YzuVdMVxkZWPVvi36nM64Y45i0XR1Q3cWB29T5FPDSUfa40vncs
 aBxU7FY75BOa9VJ+D/ChpEnAOOKEX+7OHbfMpLObUVTPfm3WsnE/eeTXlI5s/j/Jurlh050KQiY
 4gHODKH8=
X-Gm-Gg: AR+sD13AuXxuJJtTIBf0ycNgnCH5yN9ufwQBvoD0mb4KhcyxEYUvCj/9s1cheFzv88F
 EYrDY6YJyCcasRN14bkGf1h07vc8apCpxcgGlYWcZBLchSCin3PdH4n0HVG2uk3+jgJk+j5a0dK
 uhJ31JHFOaXjl+5EIKaWrg92tf98e8mlNUfqPrOg98b2JxosI9Qg7mJIEX2gmOH7BVMgMdQa7FV
 n9erStkN+CC1fsLxFklTN8QS4i2mqr/m4oN+rQF6FqXrZnU9ILsWLfdGwfu11S4ZrDOTvW9TX0V
 O2J9+nwwwnAdiEelXODYyCBfqY3448GBSnhU72Pni67fg8EWl7p7EwTgvxFsZZzByPsTZ+UF+6Q
 oEPxiz3jekZz/7HzTS253RH57EBJ9IBIm053sQL2ojZlQr3EN4qR71SQ/QT6l0tKbH68iXWJg8B
 CYLkGnJfEh0ocZMQoBAHjmxEl2bTofBEv7lp4mRmjEP/PTEfa1QlAkzDILfOucWa9Ti+uO8xs=
X-Received: by 2002:a05:600c:a012:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-499aa180132mr209560485e9.1.1787212299622; 
 Thu, 20 Aug 2026 00:51:39 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b2b96537sm23656595e9.1.2026.08.20.00.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:51:38 -0700 (PDT)
Message-ID: <6a86b20a.1564b9b2.9e23c.20d2@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260811155202.1744316-5-pvorel@suse.cz>
Date: Thu, 20 Aug 2026 07:51:37 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/4] test_macros*.c: Simplify with macros macros
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
