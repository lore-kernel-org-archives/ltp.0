Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85792E909C0
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771340541; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=fUWzfHA49JQhbPBbgRvw7UP4Z6mxARMAFsQ1vAelqxc=;
 b=RYLlOQA0mYfxAjJK+fFBdTZtT4yL7jlE8QFnvuyIwT3BWTKRTykE9wzcRBgd0pwa2YZKI
 jDtQOBo3oz8QmSKYxhk0kqykgHi4Z2SM0UmbFQlAKuuVGXB5eaKAHwjvqlGCG43iHu1YVkD
 TpSJ6RBK9ypWzXDVD1hSCWW6ogbQrJ0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22DF63D063B
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 16:02:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FB503C7721
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 16:01:57 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85E62600829
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 16:01:56 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso59470475e9.0
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 07:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771340516; x=1771945316; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+dVkB5ic2CaQCGJ5eFGIItIYEKCa4roG7r6OONFKGA=;
 b=AdbTD0C9BaaqPs6FcCbWgso96IDT7ujAubS8YC2tZ+4HS21SFaTQGN5HIal2z0akK3
 IqlkGQeqT4U67AxysRd26zZ11kNXdV820syTdxn/zIgrcI1fO5hQ+wK5mC6chXsSXAFv
 VbzJLDXkrCTUfHChoch918L/zR5+oGuNdSDa994Ryrn2F37/8OIcsnzxuDOMrOldqzZr
 71xmXheytFA1MT2uPYvuBGtmzdgPTDVnX58gHbXxf44fEDHEWgcPsd2CQfuIVq6V9cSD
 WIFt+ZQKIQEhJwiu9XoNKjwawIPojAs9R/o9KHHYiaGr6LYIIQfBmA+qs6dIMxv0kEVr
 xYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771340516; x=1771945316;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W+dVkB5ic2CaQCGJ5eFGIItIYEKCa4roG7r6OONFKGA=;
 b=eXrEm8wLFdF+M5yq3FGQaXkRBGB4zA5+AWNoXOkWaEsumwcCtDxa3sXe20/XXkK4Lk
 Ma7hJS/40REiX2sRPTyO5rR5+n/r8Ma4qEqqKhudCqjMVPBbWwNgnCq/kPkeUHfzynj7
 jpcMDC1JbqR72qt6XBanEmj0JeW/8hpcGaW4EOv7hrigUiZ+amtgTHE/MTWN6f7MIa0n
 9y7g8pL6aKezBlUgqcKkTR6cHZXgJb7f10YfOytwmvsAcJONutz53CQw6nyX9vyLOc5e
 fuIA11OKouDioHiNWrfqiAAW0JOEWXYSIKstA00xfhjJnu6y7y9L99iK6trNZvhgrMp0
 rqog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZaChRvHSu1SfykwGgxTHeMWs78k3jsXEHzIqZotN13gYtc4MP1x43eScBguAu4PzpHBQ=@lists.linux.it
X-Gm-Message-State: AOJu0YwK0Fmwq1Vzgw8+Cp66OnxGDU3Jrf3fS18DhIDEU+uTN1kVMf1G
 W4jlfqFs/PMCzRQSjLnhclUL0EwsmXbqyTJ3tMkGno1XO3O8GHumKRkOgPP+Ix4iPJMDX2X3ne8
 nYmCu1Vk=
X-Gm-Gg: AZuq6aI2imKZEAngQE/dz9S9NOlkHZu2Hl2xgPiz06x8PfLf9Clysh7RbQSGHqQS9te
 v7VALnshugBQ1FI9InrweT5/NXtC4MqqZRKGgg4wPPVoHUQshNoOVit9v+WvwnWu7Jwq5tQqhKX
 h9ViNVemf0+xElKNOGtRchkSShX2z+HIAPdXfZBgIXl4MQvPCf7tOEpXgxzLfaWU53GR9ffNRsW
 oEw2mv3Fusn9N7LRD2PBPJrC8CYgIGXmDz/syFn39YI2U4X+bO0vJydJsQI7TsFEeTNEO/atMms
 I+gP1/g4cea+JsimR5kQhze6G5HgkjhB4ouFLoP01MUXjA/ktwKxSeKuOoMSD7xzsDE48XAZvPH
 rqVEk21Nuw1OoCR8+yoWAZ+Cg/cs1AOBgddfJw0nuRB1Nnt6oEqu2N+4Fgp5SEiLKIzz1dwRMaq
 65tlNZPEZA7ASswttpPj7NMuGyH96RQEMjg1KkHSDdi+t9tEcNmu3UtBNINUNMSJFhMjowNGsRa
 ugazxT3LGXXFeaWXf8=
X-Received: by 2002:a05:600c:19d3:b0:481:a662:b3f3 with SMTP id
 5b1f17b1804b1-48378d6bc48mr204039245e9.7.1771340515709; 
 Tue, 17 Feb 2026 07:01:55 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acf5b9sm32833008f8f.34.2026.02.17.07.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 07:01:55 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 17 Feb 2026 16:01:53 +0100
Message-Id: <DGHBT2621H7C.1YL3ZXJKLUXQY@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20250523210950.1019560-1-wegao@suse.com>
 <20251125044057.20922-1-wegao@suse.com>
In-Reply-To: <20251125044057.20922-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

>  				sprintf(err_msg,
>  					"lstat(%s) failed; errno=%d: %s", obj,

Here we are still using sprintf().

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
