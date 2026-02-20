Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789D8C55ABC
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 11:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771588558; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QIg1XtfGuMTcGngl85pgfCtzRU6QLEyoFeA9R/1kvHs=;
 b=OoR0bwaIhm5Ta8UkpifyVpLgEwJjl1UxuirB9Bp3GsZ05DSCwCqc7T8Bt7o5riK7N96Lw
 v2xuAtmtu7hhenEAFKKNJ/jzgBFQL9v1L4XxOoR28Ih7QETEda6p7WsOVoVP71XrMEA0kge
 j7UrpHy8UXaJfZ4MMpb6rwKgf3wx2ZU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1D9C3D083B
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 12:55:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 586623D07AC
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 12:55:36 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D69C1200071
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 12:55:35 +0100 (CET)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso1874614f8f.0
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 03:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771588535; x=1772193335; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4/OdIxyFyVWxl7J5dQ++1uc3vIY9sggRip6A+LW10A=;
 b=C/DxES4v3df08LYNYI0m8Ms4TFGBZf8KBz29x7sB/YuDd0oOEF5bVTH9SKuyOA/Hbx
 ViLuH71o1whihj45PixmvkQRn7AbhA0mmJsOoxaNkuWLx9xpm/HU0QfLvLEjq3I6XMNu
 rfMKV9ZJfuz72eXtTFbJ6wpOkwbXK21ZD+KjBAE7eyPipFi5ggz4Ad54p3w0Esiz6mLJ
 CYoW/Ief2PkgOKG3GPHJj18r0ZhA1OLszWBHRjYv3FEW77xYLOlu7EdihLHQjrPcxjeC
 N/0mNUVvkJPQ0YlCodDgwVhAXXMf+MDP91GFAn0DQSD/NqhZs3xgDiMMY+Tcfot80DMj
 n5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771588535; x=1772193335;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T4/OdIxyFyVWxl7J5dQ++1uc3vIY9sggRip6A+LW10A=;
 b=B0FgXNFBI7bB+wzqxqrEkWvvaMmEeI2ZaCa5yEMciGDYUpXBgPGJNvc4VjdwDoxFDQ
 Sv6h6owBsIZIQB2xRt/Y7IHT4M98qe3TjV7M5sRyB0BGpNZdUekvrH3xyV/X9Kprn2gg
 kjVPNgyfF2iTyDOD0UmdI1Um4NX0Ujmy0LMSNKNtAKT/R7szTkGMDRIniurgElrPjlDZ
 jUTshgkuHZBEKIabwVdnghKy8vpyhPSPpqxqCwez+RlS6flLQ/D/8DRR/anmeGkQE1qL
 5vtc6bJXUSwz7WzNuQ+c4ER9/PMH9NrntiJ7/+H1esMa6JFAQhN4/G18mJAaCXNQrTUA
 gXYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX23xpK+d9OBpwqyPQGJWM5qEeSt9qXFFJINJzdG/RWokial8dgjEz1obb6ESArEZywNpY=@lists.linux.it
X-Gm-Message-State: AOJu0YwWTEFPnjkzGxrLGqbwP39t4E+BTj9F74KsRkjrYvkxnMvVCXMo
 oPpUig/Zr4LZMzK/Vqu9RgXb6YGQsPG5DOpfrtJmOKlPpsZ/EawbD8YUCEDB+vK5kII=
X-Gm-Gg: AZuq6aLP4ZH3iZN+HokbOlrfpAxO8t0mlIxvJa137X3NZvN/uFSTV2glkOhDt7UuhcJ
 bxHNAi7qV0jW5ek46TIbICYq4ERyjf/rO4X1bH4gw3Fm1mNXAPK2zLEX9x7JHpZcqCJmDRtGZLu
 qKl2AzVRdOH2Ze7QaR6HnW1BTS302oNIXIUbhX8yTssocfjTftNi4FAfFCxwI2tLVnTXPEQg/D6
 GyaytMx5+jRXqQRRKBDIQoJYIW23YYhTVWJT1+ysixdyi266De3PVeeBNLyt4/9jptbDdAy/3ie
 NspPWMHwcZYmYrdaWSSVND7pc9sfFMZ1xQLqOY/fK1BG/7ze8WRm8n86tnVCvYrzt/MRvQlNeuk
 ZC3I0yeYUtBBaNcDEm9nFttQxQ3VI1/TFK8w2ANV0g94/FmL/Qw+3ftiG0/jNtTTVYiGsnCnepY
 1zX7WOx8mNIEZBGPV2pgZ47irvC622FVW/1nnO1kvDeaSooEFfF8TreAJ82syVaHIOmWfdtT/y4
 AaDlyouE/sM/PO32BA=
X-Received: by 2002:a05:6000:40cf:b0:437:6963:a104 with SMTP id
 ffacd0b85a97d-4396af28679mr2987785f8f.20.1771588535207; 
 Fri, 20 Feb 2026 03:55:35 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6c1bfsm55764824f8f.13.2026.02.20.03.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 03:55:34 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 20 Feb 2026 12:55:33 +0100
Message-Id: <DGJRQ12H3RLS.2VQKINB5A8PDE@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260205121540.329921-1-pvorel@suse.cz>
In-Reply-To: <20260205121540.329921-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/6] Remove runltp
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ok, let's kill this runltp! Can't wait to have the kirk PR list full
of bugs to fix ;-)

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
