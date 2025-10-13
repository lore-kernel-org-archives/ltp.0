Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CB2CCD18D
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760362692; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=cDchDactjRh74aHcu/8Z6e1zp+uvrrYK7g+hkb07r04=;
 b=fBxzEhF43ROaqlRi3qDb030TkvKaWOLvA1Q5TFJNezoe99gM2+cgMOoLAbcwQjTWCt35B
 Uuc8k0rHLTGEfD3M6ZCBP1oquAUcmArHb7C8InLZTjTFu95Zvu9FA6Kybz9DFKYxFMo7aBS
 6+1KXvzJUSsq0RDVeqh+jT8quohqoec=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CBB33CEBA5
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 15:38:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 889823C8212
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 15:37:52 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 272BF2009B6
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 15:37:52 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46fc5e54cceso7202395e9.0
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760362671; x=1760967471; darn=lists.linux.it;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=caBkCgOhE59VvoTPkDdqtnwv1UppVFYfIXcZGmTHq90=;
 b=VzJFsrb9BwWfGK42tg8uLDOGsnyVPBGTw0ZmgupQvySoDD+onWlVoQ3/FPJ7GKE3mg
 9lTg0b9QmLjZpSSmB79T9NQMLxKc1WvpqewrorAMWwmtsek50IN/B17ADQRgUtrWOVjr
 HUyqH2zTHq08SSk71MtkZAwf4HiYlzGO2n+UCD6Dpyhg3YkIaeGBYHbtcSkjTzHv9ZGL
 bzP9zVOb9rhogQQ/yUsuDpbaA3zGsyLI9FVKHKMFWDZfssdXVEn4TtVj9k9/EK8dteuD
 L5bmKJyaBFexGR22d+umLX6PkL11t/x9k795XuCTgZzO3EVf2BrbKjyckkRGAFDd/Rwk
 XzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760362671; x=1760967471;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=caBkCgOhE59VvoTPkDdqtnwv1UppVFYfIXcZGmTHq90=;
 b=aZo0njLABOnJY6ndCSY1buIdoHHoFWra/wFNfDrFI+i1Zi2W00+6ZCQjBE8kJJ53mk
 WL2HwZpeEDSlaB0n7Q8Xk00oU2DEsQ1ROlsegV1ItVeNa6RIoS75J5Yrc4eYF7a4F+u9
 dQa351D0ueujbY2uu2UM2gNd/DAVLvJTcWOdeQ+xx+iGdUA3vZOoCXq8Pzv8TH6zyIDH
 BOHuPaOS/STEi2WbS0jxyV8YAQyAJnCrJJ31f3oOXVl+L/kA/wmlNTV51kBMgyqqBHE6
 xARkeD369r8TPkBcNeia4w/W0GNJ3liPrhuA/pCcYgOcK7nJhaDZz88/oMo+2Uyq4geQ
 rfYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmVdxpDXhJTjNUSq8JzM+LQKFRweEkXyoIEeuOgME5k9WA+W+YV5Ow25CqxPHdG9Xp2oE=@lists.linux.it
X-Gm-Message-State: AOJu0YzrBT0Ee0uaF1Yjks6YPNGDDKGFC2J51SwChT62BiHSGQw8+ThP
 /kaNuOgZ3o1/OjkKc3nGDMzUiJL6GwAFQScsZarT9ImjL4pj9hZ/VJGWtGPjEWid+tg=
X-Gm-Gg: ASbGncscUKNgs5fS8PvKxUJSeZtSqLcPk8AetGXnruKXR57e9eATQF6xo/S6/IBtjs3
 stSOKEM/oUZZTp42RWKPbiGHDd5F7Nm5ePxZFuBBOwK6Mu7r2AwjGI1iMCIyR2kWKKPz/Ss+SIx
 4AFFJ0CE6dXr1GoOHgXdpgq8mYZ13N946JGUZOe/Exfruy1s37590ZoPyrN5PbbPy6tXSXGhkrS
 uw/y6bu0MZBOZ0yYeia/ybOWduXXXosTT+pGSl+bFYUCp60SYf92tlr1oE0QLac6FRo4bmEiVDI
 1i2gKEadTXIaYjTcsvMRZStZ32byb95RIFlLwjCmUojd4wCTXixK7XkGTzSUNSPHm3l000rYhLk
 oLzfgVfxqargYcvqR3wB1V0alEjKrZPGSbqhyvUty86pA
X-Google-Smtp-Source: AGHT+IEdsxxJey121vlSuZd2p7XHsI1RGlqfffEpiWYV3xmGXQlliWJvdd7FOFRMN1lDi/vEjEcfnA==
X-Received: by 2002:a05:600c:3144:b0:46d:996b:826a with SMTP id
 5b1f17b1804b1-46fbbc93dddmr74054885e9.36.1760362671484; 
 Mon, 13 Oct 2025 06:37:51 -0700 (PDT)
Received: from localhost ([88.128.90.23]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49bd977sm186201045e9.11.2025.10.13.06.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 06:37:51 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 13 Oct 2025 15:37:50 +0200
Message-Id: <DDH8HIERQ0BT.1Y67BJEQ4THGD@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>, <ltp@lists.linux.it>
X-Mailer: aerc 0.21.0
References: <20251013-remove_todo-v2-1-d0a46ad14e34@suse.com>
In-Reply-To: <20251013-remove_todo-v2-1-d0a46ad14e34@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Remove TODO
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

Hi,

I'm thinking that maybe we can even generate the list of tests which are
currently using the old API and show it. WDYT?

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
