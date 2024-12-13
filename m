Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C2BE7717D
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 04:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734063005; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=OOi6Bs2fDGY0ZHTRV8Hx1ttB+rc6o+6/1BjCUxBF30I=;
 b=rvecTkcGA7sK3UNXyGOtb/3V/BfZ1iyP6ypqCp7KFcfo0L7NlpIwkVOxU2e3G3YN7u+eN
 2BbbiKzWoeBs5GKQOGwb3FOCejecudt8rq4BtH2Uy8wIdJCiaoN/Yng1WQHyQq8qkvkQ/hT
 H3TbZWNvg9kbJEAKxZZBwUIqgAZIq8Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2607C3EB217
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 05:10:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C41693EB1D3
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 05:09:44 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C902E142BF95
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 05:09:43 +0100 (CET)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so157527666b.3
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 20:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734062983; x=1734667783; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=abi4YYpSQs0c/pj6iXvC1Rp1Guiq6mNpaLfmITlkSBo=;
 b=PTyugxOaj7YCcLqbVbmEd3ESqGHLsMRVOGXC+ZnPt7UPDcx2+0LEx/CYrzPe7wBe/7
 XSeTlQ8E0dydKtnU2lMNzqg0qoeB9LKqIIAkd+Mdr+Wck26gAtF9Nfh8cObtwM1OyBCr
 nutBXsN5K2onhMjBumuYcDi7BazkTFYV+j33yUb8pZcpudUT2peipa9M97Q6ifXbAnrC
 IaZin6CDmQlTJFOpt6CZBjXGV8vLgp7VXGmgGk3bzekY33PlyEhLODw9QnaIDDZglDBa
 bqlrwlJQwYbeE6u4lMQ6rm8YrMMYAOeQAsEc651ajBDyaXVQgmO/Fk0vIK9Dch0SRanT
 QRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734062983; x=1734667783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abi4YYpSQs0c/pj6iXvC1Rp1Guiq6mNpaLfmITlkSBo=;
 b=qrWNYNqYzmlyxZNBLhUyDKoFLDUehOJqN7Z2yP5iYgYDL170va5UY6ONRstRJYdFFf
 vYYvv62AmhSGf80Zg9obbohmlJEd0/2qV8lEk1p5KNSoDj8vQX2fRPuKCsuVVrAGTQNo
 3YnGeANPgmHbS4zLWCZfSWgwjylSJGoWl4ZwGdQunjLXiIQw51+crGqNYwCWXREm3v5U
 /comWoS8I6riKjE4xtAyydqyjAgGUFoKUgq85srNMyKRLT2VxhkERt6icpB+EI1KZsk+
 XAb1H2SVKDETpIGZFOeTAIdm8XNogD3Qckg8Lb7dQabBity2H87eSUDHnt0DKqeosL5B
 4uVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz0hZx/VYGorJj72MwmGzxiqeJG/VAW9QtGASlWVlMO+1IxMKCOQZmkhLt36p7cgyqZxA=@lists.linux.it
X-Gm-Message-State: AOJu0YwVF7vu2CnwZdFLWClI6m2vlcSFV9lCvM5cAkxiNH3ofFfn5tBD
 kR6KPaia5Vw1Usol0n4BNw9DH+yX88j8ivDQu47eWxcSDWOpeKf+Oo63WJSjn6wGEaxEUq0cj64
 =
X-Gm-Gg: ASbGncssz1qVjnZyARrNVZH4LAlFIAmnQ+S/IexBU96p+SPayRy0DcdtQPVCG/en039
 ELLkVLyG3FNgKlypfHbcj92ETSskhIJQK3Y3Pxf2MgIiwXBVsWsaBBAYS0K+L6qMIpvKJA0v4Ze
 2C1uogh/6U1A0FmYG0TcSFNH0n99Ls7DbWUweBieNCsQvzBiWBYrBmYzLEyC5myAY0mGVFOzZ3E
 ZP2qO+2VcSJVnrJhGn7x8Qj66X4YL858B7Cgs7M
X-Google-Smtp-Source: AGHT+IH495VV6fw8KFwqNJR9kaY0z66GnuR4QjROaA1SezqNYoPtK1wcgZWkeBMsXHvxRPxfK9tC6A==
X-Received: by 2002:a05:6402:34c7:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d63c407452mr2025207a12.32.1734062983104; 
 Thu, 12 Dec 2024 20:09:43 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3cbd14892sm9528807a12.39.2024.12.12.20.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 20:09:42 -0800 (PST)
Date: Thu, 12 Dec 2024 23:09:35 -0500
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Z1uzfxfIatBdzxnW@wegao>
References: <CAASaF6xtjp4cTWydtqfUsqMe0q0fym+_Dhqg=KAWPgF=CM6DBw@mail.gmail.com>
 <30448a47662f0cf71acddd2f12eb2a08092309a3.1733995467.git.jstancek@redhat.com>
 <Z1rfW8Sl78BwDuiN@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z1rfW8Sl78BwDuiN@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap34: change how test finds suitable huge
 page and stack for test
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: samir@linux.vnet.ibm.com, mkoutny@suse.com, ltp@lists.linux.it,
 emunson@mgebm.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi, Jan

Thanks for your new patch, test on my setup and result is pass.

Reviewed-by: Wei Gao <wegao@suse.com>

Regards
Gao Wei

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
