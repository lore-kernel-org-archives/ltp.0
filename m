Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAE2CD4851
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 08:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779180816; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=1etNJ5sZSab6vtdD/bu381lk2IKYUuoJH2GXtWhylZg=;
 b=f8iSdKKPIdGRqYhRO+eYK23Is+44KwntBRR8QRcfZhuktrFWcFVK2XYPDEv8+yehJCDpl
 BSS4BChtJc5KyQ4WKpY3v/UJWQR+gSZYf6nQdYp1toc5fUmr/KJj4nrAdMyEtT4xclbQEDJ
 p+4IfCch3Ucn/C0mb/OVEIXYr6WHfbY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 567803C66C1
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 10:53:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12DF83C06AD
 for <ltp@lists.linux.it>; Tue, 19 May 2026 10:53:13 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A12ED1A008B2
 for <ltp@lists.linux.it>; Tue, 19 May 2026 10:53:12 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so22952815e9.0
 for <ltp@lists.linux.it>; Tue, 19 May 2026 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779180792; x=1779785592; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hbLoU8ezVdfbPjMGlwB/i3AcxjOTdS7MEXpcRUHZZ+w=;
 b=IO2apYzV+9AxV9KMqk5EXxxc1xM6f1NsUxPhOjCIWwgYMY17UA71K0FCE+/RXeebzp
 51tLVSZAPyz9bhOiY1DE+Zeggoqj1K+64KdQbeOYc/772CtwdC9Ui4Y2oUJ8Y2MKZ7Nd
 MR4MTGNLmvBZBQ5Lc5xWpNUZAjzvJxEtXXhr0SU6tXG8gos1Xl4ktc8r29HMraNnupKo
 QGvXLJH4HlOJ++AixZjk2C8Sh5J3K1MMBsi27EamjjRwZAt7iNjI4NQKeTFpkDM7Xb0o
 +Itwo1s721p8GMwESghYW80qYv9GoAiSCw8A/XqpoljNREtTBuIWvcGAVA2LGbsr9v6I
 ZiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180792; x=1779785592;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbLoU8ezVdfbPjMGlwB/i3AcxjOTdS7MEXpcRUHZZ+w=;
 b=ri81fCGnWlNWxz4IY3qJNg+n29Ej1R+zbEgo3J4damyBWJUu+z9SIIIV6iZV5uiruB
 hE1Il76LpmkHx5E7PQjXl5Di7LXkGcXXMi0K14R5+ZTqBtki+zlnKiCHfkbSih75xNcg
 6ROqZgpJA2W7sukVr4HBd5icVnFXQw+hH92vwPSssvUoUPWk8150AwhnimHQutFRlrLf
 IdHmE3tpN7JC3J2jCNB0gswonSZMz+EkGSBHQDoqsLfeeYgS1MsZI6VVKkBBPmzmN28B
 puc3ONh85R02m/1HssH60S4Bne+OM2/OW+W22Ms9ScT1EmxVTr0NgxHq4gwKXTy2pVkx
 IJwQ==
X-Gm-Message-State: AOJu0YyFb2e8Xr1DYR/kdYNiClyaG3fC/WQ/3BrvJi6u+bg/NPDvzpel
 YaRKgsueigAQEbcbuzZGkmW5YesjzFS1pMThsFIeeGMxGh0G0S93B/+2IW2ui6/9PA+CGyOtlfW
 i39V+FeG6kr7c
X-Gm-Gg: Acq92OGr7wnyqQ09MfwEom9V3ic8LOnOwaKG9adwE6gzkhwS/c95NaZ06KvMTHdcF2L
 ixZUS0NkevbUYYQUlTFt9AK0OXewR8QNH3JeDwxEs2q8IIDSu3YfpDQWAksTE4lTTX05Wn+5xf4
 KysGn4Im3vVx9jJqV7m/ihVmVnGHMTL/YbtBD4LNXyvaX9cy6VTyXpMR+U8UjAvoQnGOJGJ4QwJ
 tL9inR51S6P2aYwuqnDMyO4+Zdald3mp7UyWLOXUlyN4zfpnZoWQyF78K3+0TqpSSno8cSndmh/
 G7sie4HJPn+/HGEUYy3mJ2ct4s7VnPJM5KXNJfz2+T8NNhZgbFesClqS1R5FCQdIL3RwpAntkW9
 FHRYJFCPWoVkLDuqyzlEF3o4TEpBoyyga2HdCBoR3NJEBGp4T/gGhxNDA9oTs8yac9rUqli9PH0
 FRR8OQ+vn0w6NEZ3atBgY/ce0kDz6YYPe7ncLOBv7912HYhA/0NdZddySjWynXfpAUbZJ1NPC5
X-Received: by 2002:a7b:cc15:0:b0:490:161a:38a0 with SMTP id
 5b1f17b1804b1-490161a392dmr61134545e9.9.1779180791971; 
 Tue, 19 May 2026 01:53:11 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm40449166f8f.26.2026.05.19.01.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:53:11 -0700 (PDT)
Message-ID: <6a0c24f7.2ffe362e.37b206.8df3@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a0c22a5.1e1038c1.175b08.7bc9@mx.google.com>
Date: Tue, 19 May 2026 08:53:10 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] af_alg08: Allow EINVAL when calling recv()
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
Cc: Wei Gao via ltp <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Sorry I didn't double check the CI. Can you please send a new
version fixing the patch applying issue?
https://github.com/linux-test-project/ltp/actions/runs/26086543445

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
