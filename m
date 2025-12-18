Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E91D6ACED
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766058716; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=I8WtbpYnlZrQ7lBDbe3bshLFusraPq/Jwo9dPAAsp4Q=;
 b=jRkrSdtc6F/paEAcYXmu+B55XxkeXaYLrgO8IXPJEoa5UumOamTXcAHqmNg/L3bu8dL75
 xHEuOnFOYnuBukCdClXf6CAVGNvN58FUt8xSL+aBWLxUxBFoZ+ZCUyEXwJNtBtiwLM/riwl
 T3ANy19RtXEEEEqnRySvQMLJCaZNeeI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFD893D048A
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 12:51:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 749523CB780
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 12:51:33 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 241ED1400E7D
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 12:51:32 +0100 (CET)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64b5ed53d0aso528497a12.3
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 03:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766058691; x=1766663491; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoHHbTBZAwH84f5t5yUvnzqs9ZgPADT6pMIv1xs0Fg8=;
 b=YvWp5spMkkNWW11T+tB4erXgY/AbvgI/GKx6HVt9gSZ3Jt3OUZoMpRI0Yu2KAeVkf8
 07pTePeTaAoM31HrTbVeAsOxoAJTYNPnUgZw/Kk4mS8r6pxcN+/teR+qn/Xg7EyR/9CG
 sLgbLWOe6/1cGGApfqddEJTR3E5Ml3AUtbamv6cf9ruWJy6qLdcIFymdKfWvKseCu+2m
 z0WNJXKkpu+g3zUZi+HU1fUBVVSuhMVBchDibzqFi8s83AY+auRBWiGjwq1xu16pqcOG
 PN2NnkkgBFI2NAACwk1RJWOOFeW0jRjX606iNa0Kwbumi35YGWoxrzmkTy4NH/NgbCbF
 m/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766058691; x=1766663491;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hoHHbTBZAwH84f5t5yUvnzqs9ZgPADT6pMIv1xs0Fg8=;
 b=TbQAqNEmJGVcbcXveM1k5x/b8/4IwlMRXTrA79EZeEiJZhR9BGLU2WZEz2ZzoP+iso
 Xuzx8avR46Twf815fIClZ0f0ttuScTINTDSAV7kV6qFWU78TMuZ8I3MEEqGXdVmj6gKa
 R2/WGrlnv8+bmX2XJ7mZpdLuEVOw6sewkeZYiauRykh9SfOoyt91F/O5dYRpVOXHUM0Q
 1MuKK2ZsLrrMukV5Z4CMm7WeA3ZKvz+XZj0wZ3TL3aNfP2Jzgf/h2ljztzR4n3ZLLTY+
 fWbEAF36GMSX65PMGQRZ5wI+V6Z+IX/B45KBb8OEIwUpPF9G33PCjHXhBaYl5CrQAwqI
 5MeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4mWMja7dJTeNdmaLsRTZiLjZLFELFYClWx7vmIgkKwOm9Dv81uXJoP3Jdihk5KoObj8E=@lists.linux.it
X-Gm-Message-State: AOJu0Yyy6JRCI9eJXQyk7b9B5csAj81odDzpRqRQDSKkRozclGOYGtow
 Fx3rFwdopYmlOTb+aZqohBS2nNnyQOErbAEQQN6v8vH977v6oH6vDlHYdWi8Cv7JmCVAcVeyb0/
 6OMQGbGU=
X-Gm-Gg: AY/fxX5nt3F1nCmQWO4tukVR2qbRkWbudF25jqTP5VErDr9yPJqXg+ytkUdj5yS2egi
 Aw0PT6QHzPJypWoSPWhrr3vrTcVN6k2aKGtXMfO2Wr8LRw2bT+TCgwMeGcsvNHOSQxYOd/cBxdK
 GwqDCSHLWch2fnUo9C/uKBjyT8GgrFsVYMrI3sIH+axj6cBkT8YMgaODYJNp2ZSQ+krgTxQDkjD
 IqJ/LL1j1Btt27Udua3ZWpp1B9Zb/fZibQJCkWD8m1VRRecndoUbs6HnSGcKwwLx44L7x/An4vO
 lm1x/VRi8/4mF1H7yedzk7Yd5Vk513Spu45NkBvereXKvfRgRSI/hUwwg79ZIiI2OR+5AazVZd8
 ntc8dONoGEGE0VFvWOrRnM//WehWshXI6KF7rpBnRsEI6zXJmpEuLgFvDFavzX5gZBJeRiLMZH7
 n860Zw8048j+U92/g=
X-Google-Smtp-Source: AGHT+IFJwjmZCNIkA2x+sokCqG50eYTqFTAJkZYAhFAGJPVeDp4uYV/YcqjPhI8JvdieuVvV0jc/0A==
X-Received: by 2002:a17:907:3ea3:b0:b72:de4f:cea6 with SMTP id
 a640c23a62f3a-b7d23a43381mr2271609266b.48.1766058691334; 
 Thu, 18 Dec 2025 03:51:31 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8023466c01sm219623066b.45.2025.12.18.03.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 03:51:31 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 12:51:30 +0100
Message-Id: <DF1BK22BZF5P.1NEXGMJPZOFMH@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251120161957.331580-1-pvorel@suse.cz>
In-Reply-To: <20251120161957.331580-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_env.sh: Backport common functions from
 tst_test.sh
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

Is this still needed even if thermal test was rejected?

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
