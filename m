Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31EBCD4F5B
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 15:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779204576; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=wW6Y8nKfyQGErHQ45xZZ2AtiQy8WfDWldHYnZyG5A10=;
 b=g8BQH5A/GtrByW9Ruu4JClg8fvirECBQSfG4yHYcejEjIDIKGw/fMoS4jiCOK0cTlQN8/
 YZvf4PIfn+2HcgZj+MFavTdSYKy+2/7u0k4tZ9GLziofiAR7tOc73Cs9+OxT1Y4qDh+LP3o
 7Bm4urDgJf2Z2pFbvQvUuZV+GRS3io0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A05E3C6FDC
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 17:29:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA77B3C6FDC
 for <ltp@lists.linux.it>; Tue, 19 May 2026 17:29:12 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4B6B72003B6
 for <ltp@lists.linux.it>; Tue, 19 May 2026 17:29:12 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so2338076f8f.2
 for <ltp@lists.linux.it>; Tue, 19 May 2026 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779204551; x=1779809351; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=maNjU10kCTyz/JyB/0H5+ME3tOj0rTuj+B67Nsd7GDE=;
 b=Um/yPzjRlE8KjrmtCGHxP9jY0CsB0aeaJB7Cpfi19c7oFjwxKzrX2zyV2WirPeaW5k
 Jvg47MYxO1gwFnyz3AMPnCW/sz7oYAvmriPu3RpGRgFV6k/QyCRe9GWHOpYyROvbor1D
 DJjoAgWdDe0jn5bj6gNaR6z6tVu15T3TD0zN+/wRHSnvSSfJb7TeUAY1KIGR+LuKIdBR
 qrpdzKiHNCyK1v++FkkoPLh+8FjwJs6OfUuRMdhnoplE1EUyWnd0vrtvDKr5mY0F3f2e
 hjfUkO514W8lNSXYOAw0FmD25ENDCgvXX9EeysH6Isag0Uvh1JtUz9aaCeGVt2LD03Nt
 0/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779204551; x=1779809351;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maNjU10kCTyz/JyB/0H5+ME3tOj0rTuj+B67Nsd7GDE=;
 b=Eq7ipPrA3DJVVKJ/lG+AVqN9w0dFebGVpoAzT0qR9FHWwAd3ELvXsWboHxGHb5LoJ6
 ml85ZWXyY0yyUmTQFfLb1TyIRQ1BhFyGyW5d7AAskATquUZmSPYo+IyQSpnEIVcoMttx
 +u/XbkuC8zpw75IzbB1ou0gDrqDIWDY0Cnq7AcZ6noba9sUFzLi9Oi9MQbSi/LsVDI7z
 nOf7jYa1/n2wSeXUaeVKXOfl+gzxX+XGv5uE2q1DtB0Z1OHmuA4XM3txBERXna+icfXh
 lon4hzVnFzt4bK2cP3B8tUZmud8XAtb4RGAfd/Axt1dD45T6o9VodghLFuBj95SbQZkI
 7ZzA==
X-Gm-Message-State: AOJu0Ywo8LupLBDj7mRSKj/yyfJzsQ5OM6iMVEhoL/xkHEB7iAVrNKjY
 sMmn5tFcNcRQG+iiuPl85Df6qLmwfDLeFetvIan8UOPTNm3BSnS1loG8GvNBBWMnMdF93J68a9V
 8jzbEL6Y=
X-Gm-Gg: Acq92OHj3o9wq8Zr4sca017Tu/FRd7Pn9ZO4OtIFUJeeUm4PeQQxdNZydeEuyJ9eyX2
 aHHRn4s+4NcqWa2U955Iq6fB27/LOk/49cENb6Fj3kgHWU8AIBxQZRithe5r5hfQDgolD0/HAjB
 CgY32YLByo90GEl5G+4n8px4dSiA5SEJYE5Ei2Vldu88D/8AjoNaF7g1LO4JPyKX/q9zapkG6Ch
 014VmorhUKzmDedgeHNPYbKigjHpmW3Lz3KlICJ8W9IGAG2K+EiqdtL9/AVYp+pZp24omgxlxYe
 sUr4RSeaQLuM4PHWs00v8kkZwrAsNZXZgEpOVOXikKQye7LC2TNaFjkbpkAOBV/SbGQB2yjFbIc
 MMrBoep9egI4bTBPbG6hKtBsrwSDNkeZqVHp8Lh273C2VX5TggsqAYmgqfTV4rNDr7Y411Y/Qww
 psYBtPmRCLAyWmDa5qDixAUwr06C8fMqPyRk8ll1KHaOTYk4jcS9ZF8RWAkIQnwg==
X-Received: by 2002:a05:600c:1593:b0:48f:f199:79f7 with SMTP id
 5b1f17b1804b1-48ff1997aaemr154490275e9.27.1779204551361; 
 Tue, 19 May 2026 08:29:11 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe794e7sm107681005e9.30.2026.05.19.08.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:29:11 -0700 (PDT)
Message-ID: <6a0c81c7.66a56f04.27dc15.5126@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260429062650.3191021-1-wakel@google.com>
Date: Tue, 19 May 2026 15:29:08 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/file_attr01: Dynamically expect
 EOPNOTSUPP on tmpfs without xattr
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
Cc: wakel@google.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

> Changes in v3:
> - Moved tst_kconfig_check() to setup() to avoid parsing the kernel
>   config in each iteration of run(), as suggested by Cyril Hrubis.
> 
> Changes in v2:
> - Replaced the TST_EXP_FAIL_ARR approach with a dynamic check in run().
> - Included tst_kconfig.h and used tst_kconfig_check() to verify
>   CONFIG_TMPFS_XATTR status.
> - Expected EOPNOTSUPP only on tmpfs when xattr support is missing,
>   otherwise default to EFAULT.

Please place all Changes information after `---` placeholder,
we don't want to have versions history inside commit message.

I can remove it before submitting this patch.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Kind Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
