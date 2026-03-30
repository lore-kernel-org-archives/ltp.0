Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5598FB3CF8
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774866217; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=OagrGGFQzKtKfI3oI+NQmzUUzCPsv/5Lc58IsrUcwts=;
 b=i3SFtz5q58rWQwJG4SX/Igbll3VT99E8cnT1idhdZaVK5GUdylvYkN4+fq2TdWKgHjcfa
 tMGB3q0oWAKocfOavIo8feTLTM5kk1IFiURPoXVh0dx9vJVht+mf1eRGNK7jjC2K1/AVaL4
 YKhsqJ5KiIGEk7uHXx1/EfWaI+eeYbk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B64B3E4F12
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 12:23:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0D683E2A58
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:23:13 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 239361A00250
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:23:13 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43cfac48bc7so614443f8f.0
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 03:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774866192; x=1775470992; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6yoRcbuBtVr+pY1TRXlxTXDcKfvRgHs3YBaUEnn+glo=;
 b=exCnHmj3O/89txkcr3KC9yPWcl0nvHBrGXMo2xmMiq0ldqhrrrJzBSLC3al9k4QWRL
 ArSNTy8gVy4nZNv1Uxa8d29uEuKDRRo7H5vjn0nL0nsIgxw9i6r5KsXkL9FPjCgyMv5k
 THKf9bwgpfDXsBU12IqwYC6s/jo73rlkTaUDNt0CsL4X6gJ8oP38IjBIJ7Gay3/60lWt
 RqS86X9V/gYlzb9/8kSv61yzjQZP0T4tO24zuJBZKMUXctUAL87nIw96wh2hHvrV7DnX
 mgn+ZmIkZIfxeRL6F5LPbUpUL7kGwmtjNHtG21ZztPKGhztNF9aiMNxmJZz6nnstxbfd
 MbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774866192; x=1775470992;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yoRcbuBtVr+pY1TRXlxTXDcKfvRgHs3YBaUEnn+glo=;
 b=nDoRbJpIJVP6R40icSdnFWe2VQmZ1wE5kE7w8dTPKzmBBuDgfwZebCC2pCZhlgbfWe
 3ZnxaJKquCt8X04+/CT9P/Hf6WMK/kCxqCPorb2gb3WBMeQwIXUS0M3yVL6B5HDEI+rC
 Fs430Gh7ima53BUQYzIdx8bxE+xRPMpX+F4MSiLpf37HeRmkgo1O/WW7H56O9qtc7KkY
 plZJAQqbX8aypHL/RJIEdpmECYc/Ta7cerUvX/4GJMinS27Buh/BVwGT5650M95J5UFp
 Lyg2vKmEEAFyt/HhCLJ+HSt1IOdiEguaxMK9OPMdi3pbuXCnZi/itBObbkZU/2TO04i3
 6aMg==
X-Gm-Message-State: AOJu0YyBDt6ihmUK8ZY3SAFDUPrggUeGQXx6XYnXssMTyqSVM8pojb4+
 MMxjvKf8N8Obzph3c4cWYfgjg06NuJ4Dvv89Jvz1SbSykx41HgF+/MCPMqCOYc2OR8Pra2ZsmWz
 svn9VpeE=
X-Gm-Gg: ATEYQzwoifdIIF7zy0mQrB9Sip8eGw10BdKodmm3N6GaWmD50UYan0046rhMS+cGng3
 Io/UqiKiDSwa9a+g1CSEXdxfAroSmKsdQxrGE68rqKxMXbKbxgq/XFzA7MjJgD9SsazhYviYke5
 J87b54HZAI1urmZ0DtMS+OAVx4WMpCh8LKlGYJxJcHN++6re9WAubowNdVfI2uB81ul3r0bFFEZ
 zwYouRPXKJ8ZMfaQnvyzKz82UXM5XmhWNQqIHsXElANtqa0Ml/wE5AIztyUT1nmkflwo29GytJY
 C7/f0p1i4SKuHtmltBIbQJvpnlOl3IkFYeAXC1+aLQE03lB7GAhMXGaZe0AuJR0KOygvOszJwUr
 /yHtl4LRVpYNB605Fd2xAxzbkQEDvADhmMeq3UiVJF0DUwljs001W6LdYlt8w54Ey1XqXx5KcQz
 woV6O6+03LomF/sadK5spM57V7qCJuQeihlt0YgUL16ikjT81gkz+llnWReVOvSzTvgk8fWDnot
 U+XeIg4X2G8kZWmiM2dEfl8YgfNheUw48s=
X-Received: by 2002:a05:6000:612:b0:43d:60d:944b with SMTP id
 ffacd0b85a97d-43d060d9570mr607862f8f.37.1774866192100; 
 Mon, 30 Mar 2026 03:23:12 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf245ebafsm16475939f8f.21.2026.03.30.03.23.11
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 03:23:11 -0700 (PDT)
Message-ID: <69ca4f0f.df0a0220.131966.a7bf@mx.google.com>
To: "Vasileios Almpanis via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260330100750.858390-1-vasileios.almpanis@virtuozzo.com>
Date: Mon, 30 Mar 2026 10:23:11 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pidns32: fix PID namespace nesting depth
 off-by-one
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Vasileios,

> -	if (tst_atomic_inc(level) == MAXNEST)
> +	if (tst_atomic_load(level) == MAXNEST)
>  		return cpid;
> 
> +	tst_atomic_inc(level);

Makes sense, the old code incremented before checking, so the counter
hit 32 after only 31 clones. Splitting load and increment fixes it.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
