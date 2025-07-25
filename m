Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A717C83F26
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 00:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753404956; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/tKqWppvGR2PD4crZ3h+T5sCaZ74eTEEe6Yf1U2Kk3U=;
 b=MrCHRh+unm+BJEFPyYngCxwagiOthohnlZ7DucO67Yj/a7vw13IpNNQZN6pyus0UmPQ7u
 RfwA4xHVJ7kN87ya8WvUatDw+XnupHyWkYW5Sn6I+ZGNhaOkpCde5CxFEptPr/h7wlC9lmG
 OgaWMaDL1H1ACAGzT63OOuSZmEMVaZA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 803F13CBF98
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 02:55:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E4AA3CA085
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 02:55:33 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D66B2600940
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 02:55:31 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a510432236so1208422f8f.0
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 17:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753404931; x=1754009731; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gIlEGlpJXgdwypn/kNzxogGy+xiY+wS/wHbWEs6P/BE=;
 b=SG8x68FkFWYBEyfWl3AQHUt/du0x3cbEFCySFg+9urwMGfKC0fKAtFwn8gWYoo42m3
 RwHP546UAZQjceIssaOgKYV4oawvf6b/kTMfhvHEJio0+JdAup5DBXgjx8c+fdt6GJFb
 Cl9GyQkTg6+LDclgL9Pud61D1YPnraUiJtgjvtVBY2oeoDCZe8pUq5IBg28EX05I+C5V
 GUvgl5d+6tkOj1X8WzSHe4U8Z+U0r/iwoEwXOcKEd5wujsqyDinBZBPOJmB1zT50inKb
 MoODD6p3stTihA5XigpfMIp4B+gcK38kAaqUyvUY9BBCOjTfNRFrypDKBbsnYtKaKoam
 X6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753404931; x=1754009731;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIlEGlpJXgdwypn/kNzxogGy+xiY+wS/wHbWEs6P/BE=;
 b=k/lUrP/P8nf1MJNRyDFb1ziC9ZvGiqeTue1Z3w9iMcVYiZuvIoBcunjY4H/u575oRP
 nuOILURJ8ufAmuwgbPjzQusCL329buZAFGT2wmkV1/fGzMkOjwPmaXYERaOdBxy7cSSZ
 muN5HS7CL5kCNfPIU4YGkfo6KZhMZobqcc5VS+nw0p7Nu39+1Fe1MttOeRlrVbhLPFTy
 fgydrpYov/hl6efaJYW6YcicbYVLjSZ7qnDO4Tv8NXOkGtXb5yffvQzcuS+JqSLGA8ug
 5zgRJz9Mz+MZ86HikD+gPtNlhRYDqbsCT7lAWBjgRxNOEpw+GEvmQFxM9wQGDZ3vSnvO
 mzCQ==
X-Gm-Message-State: AOJu0YxGusJW/B1iaX2fXUf7lFwqFSycapMzp6f9CzlSjzsPO5DyWNeP
 gUyjUV58aN8dlmaxsOdD2VeG8TR9BUc04CvOlY2Awq/CtT+UZWKGfeKTqR6hQsv+sA==
X-Gm-Gg: ASbGncs8Z2OlXzZJY58cRPjanVqFrb7wqdNLgAyeLDgVaIDibsKZ+raxn4ujS2pTCHm
 cyC+eaWapxvc97UPRA3kTFpydgrTjZpbB8PmFGl4K/unwWQt0lNuzGZA/f1XXHsuj9K/oHCsZXk
 +IYKzrn6MvgN2fGiOSc7GutLfc76jA/xQFgtlSHdwsa9t41DfFZoWs9A0vVGu9ADOY/rj8T4Ubi
 UfAI8Yt8PWpwTxl6Hfz0XCNhAbDQIEQQ+4QaQAQHpsHMxyXfPyPpMEGfavcBYUDWS8N4eu7Ov3z
 csfD7Pvxd9B6PYf90cb8PM+QhgVwc3zbCZ9FIabbULqWXjsynP1F6hHA6eMugRnoTnDOEz6XfHy
 iMquuSm5sECdf46AcfFSXwA==
X-Google-Smtp-Source: AGHT+IEAB4pMsYTwjcKLmBsteF1h5Mqtc/Q8RETbTEQ1gCYq30sWzI/iF62/Jq88mkp1b3vcVXKREQ==
X-Received: by 2002:a05:6000:2883:b0:3a5:2e9c:edb with SMTP id
 ffacd0b85a97d-3b77668d454mr75251f8f.47.1753404931194; 
 Thu, 24 Jul 2025 17:55:31 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761b04ba67asm2407125b3a.65.2025.07.24.17.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 17:55:30 -0700 (PDT)
Date: Fri, 25 Jul 2025 08:54:40 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aIN-kNB2moTpjM5U@MiWiFi-CR6608-srv>
References: <20250721200428.2627117-1-wegao@suse.com>
 <20250722185503.3224765-1-wegao@suse.com>
 <20250724170424.GA108771@pevik> <20250724171036.GB108771@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250724171036.GB108771@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] mount08.c: Restrict overmounting of ephemeral
 entities
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 24, 2025 at 07:10:36PM +0200, Petr Vorel wrote:
> > Hi Wei, all,
> 
> > FYI Test is failing on Tumbleweed 6.15.7, can you please have look?
> > mount08.c:32: TFAIL: mount(/proc/130511/fd/4) expected ENOENT: EACCES (13)
> 
> > As Tumbleweed is very close to mainline kernel it will probably fail on mainline
> > as well. But maybe it's one of few Tumbleweed patches which causes that.
> 
> Maybe it's just the environment in openQA, because running on Tumbleweed VM with
> enabled SELinux it works well on both 6.15.6 and 6.16-rc1.
> 
> The same applies to recent error on ioctl_pidfd01:
> ioctl_pidfd01.c:28: TFAIL: ioctl(memfd secret, PIDFD_GET_INFO, info) expected EINVAL, EBADF, ENOTTY: EACCES (13)
> 
> Kind regards,
> Petr
Will check this, thanks for notification.
> 
> > Kind regards,
> > Petr
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
