Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BDDC83F25
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 07:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753167723; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vlWjeWDkk0eWMDOZfVxXznRqog0BfQO8YrUcy8+VUAU=;
 b=nqsT4Q/NcDBfnz3dSadBGFtrdBx/xxi7r5kIGUZJGm7nvtKtRwmQTIHGdDiD4VK52xY/7
 kmqtn5qKXPiNvm66H6vnvH4gIKMT15xVfVml4ZVCfJr9xCXKvUt9CtciOLq8crDO3kxziJi
 Bftqx9ksh7WL181CYGfdJIvTEeVz1Mo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BEAD3CCC6B
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 09:02:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26FF63CCC52
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 09:01:42 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D7DD0200AC8
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 09:01:41 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso3041434f8f.1
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 00:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753167701; x=1753772501; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yRL8gg83dZpr6Y5XAQLMATqzC4JN17l3ARME2j7ovmw=;
 b=L5RHymTvVdLhoIBwU8FzojAjh0p+O9SxDeHAyrEIu74yJMpGiPDwS384kqo2hklTrj
 Q70NMIM0di02tbdIUtYAW/2iRALSnUvUvSPskPPuIIohcsiUJb40pq9ENTRDuFDP5Ntg
 0eREd6Qq6ucg4xCj+97nEFMouBEzU37FtQQzCkmR304mNYXyfp58SaFG7ESBGhYAL4gC
 uPf5TnZhO5GB2AzHVD5PDru5FYBcICHV75VVdhEyfLI1z3y19Zpu4ndnrbeRi04VyLYK
 BXnHqhqBe1v1Z7F8jww3NurnI9irD1wSmKbkGbMLYGV9/zn+/mnm7sTYN6XD1WBtBiF4
 Iiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753167701; x=1753772501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRL8gg83dZpr6Y5XAQLMATqzC4JN17l3ARME2j7ovmw=;
 b=uIULG78s6SsIF5HJ1i600QPsHy351QOQfNL6797QTt+aryDqQmtQ4+M1FFDezz/RJt
 LvCVzir5CTIrEzRpnJuiUG0y/0gS4LQxDWYCisHsd9ET8/m4ac+1qyMTqCc/bTz8WICx
 RHVjxuRFSqSYr+nuF3rW73ID8re+fG6Ioj3ARP5BYwIKjA75ueidT5WrjQicptgEJKgA
 rr3BcQRVv7ptmg8Cnp4Mv1+051Vu/xIAxtHf0Zg68/DNHgnjNVid4+MtMyxyqfeuZfNL
 HA4dMe05Y492y/+l3LvXtF93z03EztcVe/hlzF+fPfn8RG4a+qXVqfoXnuld47tpxKpS
 UJ0w==
X-Gm-Message-State: AOJu0Yx43xp1UkdMm5WJvCGx+7t/sACyvRomHrR+zlyYqh8PToSqEHJe
 u5KmdPwzxR3wPTmHeNU0BKuKg24Ga47biOfROGCc35ViHAFnR950ppZK6Nfyx4P+GA==
X-Gm-Gg: ASbGncubAtGkDNrFwsxXcS5xr3IxnWuOGLiDmVSSMsGSJ2G9INljZaPHrORi+PXY0PI
 zIwBh3Wi1PN+hUe673e8ZsnEngZJ8TxvR5lj97RT1djTtAEONZyjoq+2CKVfGTpJK/7fAre0L7y
 lSJAFh2ZLj4HTnOe1d43HWo2PmrzCFlgH5ib23acruuzPUdR58xy5QPKDMRaMyjKrTHnNT9TvKN
 ODojFDabuA22HxvWKlmI86JGaXZP3MJ/T0ZcK7e0nEAv2GEson7tMUAU5DK5oJS+LoYmekFixwU
 GAG97PpUdtrW+qFB+AjXeftdragGSdYNY07fzce6Mi+UwDfU5GSb6tDkX4cQYvw/taBI7kFoueu
 NMmrt/8qq2NxQToPWSq/NuQ==
X-Google-Smtp-Source: AGHT+IH630LDagKBdq60HNbRvXU39FOddwIIQzkgV3n525r3ek+QR1Kz5MVw/0gJxOG7jwelkT98ZQ==
X-Received: by 2002:a05:6000:290d:b0:3a4:ef30:a4c8 with SMTP id
 ffacd0b85a97d-3b60e4c4ae8mr18605299f8f.10.1753167701253; 
 Tue, 22 Jul 2025 00:01:41 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6ef7aasm69006575ad.206.2025.07.22.00.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 00:01:40 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:00:52 -0400
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aH_f5JQcfc2wKInm@MiWiFi-CR6608-srv>
References: <20250321151143.11332-1-wegao@suse.com>
 <20250721200428.2627117-1-wegao@suse.com>
 <3a5abe95-3b9b-4232-a120-eda5fc7c86cf@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3a5abe95-3b9b-4232-a120-eda5fc7c86cf@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] mount08.c: Restrict overmounting of ephemeral
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

On Tue, Jul 22, 2025 at 08:40:02AM +0200, Andrea Cervesato wrote:
> Hi!
> 
> please achieve the v4 given by Cyryil before sending a new patch.
> 
Sorry, the diff not --amend before i format patch.
Resent patch v6.
Thansk.
> - Andrea
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
