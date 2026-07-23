Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF15C531CF
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 12:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784809787; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=AhtswHa9j41QQn1CzXHKj5lJAnRn6SatG2cuoo5/vXhUHXTOaRWheVXnWbKqbxD0dOozA
 V8nG4H+FhEL308hbdZ90PtHvr5fBBaNF/VRr/kocjq5BPnb0zn7WrouHUsdYmmOe0QV0Lu/
 ns1w5F7+v1dZf9uJ1Kcv1a9b2uRYXTI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8B443E559F
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 14:29:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1DAA3E1C33
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 14:29:28 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 450682002AF
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 14:29:28 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-476a130c138so599134f8f.0
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784809768; x=1785414568; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=YQ5qTWedtbpL0RWBKGZzYL8n7cgmFY2fl29qD13hygwDyglCuYI+qyvgvHWXpJ32Jv
 PpzQWmh8cgMLI+YcNMebdTlrTOfpaDt5gMU37jakW3IF2mLkMIr8lJKyXBPOnct7eyKa
 aPpvGjizhUm3X3ZlO0WOuFBvHkk7K1HewMQYevA5eOX/q+k2U7Zr02OqiT7nWezR786s
 4TzmTRfUvEESau3H4OJUUGkVqbAOxgj1ku1E1E4XXGD319kD+cf8Ag6myetmyslU/6rn
 VoEXjmz6t28dwqg3ifB0oEQEtg8w2ekSYmFIxeqykn/XvEcZUM/KS2OSN+OCQOnRjpHJ
 Q2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784809768; x=1785414568;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=pp0gbnKyI0IFu7qylgr6BYsQpzdtOtp+TfTKNlqvAsP545K3s/7+pMWf1vUoNTeSBe
 EbixDmhFgzZee+Ar0yw1nrHT+o++mUBAW1/94xe8WHXzC2fy1TxYSTr3jRwbWw7oYAkq
 rCa2y0XNoxujOU2f7Bj2hXKdp25zbFIeT/Qzg+CP4Zgyq6Cr9jUAuXX4/RmoR+yrEqCo
 U4tYGQFOH57EF67es2HwDd26Ggev87o6d/dy/uC887d90WlHbsKooarsKmHU7o5eIK2/
 r3L7n0+Wphr6+SrzCfoen+zOE02oqwW5fgESEFR48tdyXpvmQz/SQxtEtYPy6G+t4iEx
 NtLg==
X-Gm-Message-State: AOJu0Yw8IJVDAl0nwQUy/So9oJoUUZCYtCKp7AcGBXq7Te54I9fl7Tk0
 oOWDPI9YZM8K1R7rlOMVqrq3PeFkmeEu5cdCEHb0s69a6AeybNEUizjyCbSD08eYIJr0hU9L3BC
 xo9GjIwhyzA==
X-Gm-Gg: AR+sD10diYpnllyJ8w5u5oe9jybA4oGD6/oaZkH9lP0UcR0AZjiI+XxKTWumM/HzL36
 Aqb3jZVOTirRV9WEPX9xJXodqmVRFKznL6CGPqAVc6OVJfBO6ZW0Njs/BxG2dnrGpstVjWwr6B4
 Bh2vj8l6IPQ4vZzbz72sbIM0w2WYzLwdxpNjALdFeIQ1e8B/QJ4yvBtI0QR2I+UrjfegJwJWaSV
 qkNoHlmV9c1WxHvY9N85TCbIxm3l8NzfOQtBrNra3mvvMsmMIqiF0vJhx9JNiv9O7x20jbKMnrG
 RUTr5N+BLIuFU82gPvs6ql+kN26lFzlZoh1ZYb7deeLfoZrsUkwYN1qcgcQmCBjEiKCgMX9mZiu
 VdnAufxreyc6swig6WNgIlSsuFAssEqjIPyDZSwk4p7ylDDmWa1OVW9ry/wYjYL+UNv1LuA3qBy
 F9Y7j4em15TfHtDMRiqYN+421kOg==
X-Received: by 2002:a05:6000:1a85:b0:47f:8183:e9b8 with SMTP id
 ffacd0b85a97d-47f8da7c903mr3639110f8f.22.1784809767528; 
 Thu, 23 Jul 2026 05:29:27 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f864305f5sm14633135f8f.17.2026.07.23.05.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:29:27 -0700 (PDT)
Message-ID: <6a620927.d1054386.2e8328.faf4@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260720213610.627213-1-pvorel@suse.cz>
Date: Thu, 23 Jul 2026 12:29:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] setsockopt10: Fix running with more iterations
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
