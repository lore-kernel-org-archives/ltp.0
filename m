Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4BCC5DF74
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787061630; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=YjzZu44+AFShj+MkyAikZfx8/xj4n1sdnxunz4cnYDA=;
 b=CINvcefDB6gIQZ+p5DszbL+S5nkrybqXESpcemE0I5p2V1//PPgwJ4fTWh4GyTsbtU9Rz
 ldaUzXR5XrkxM4/mLseoUEd1hlb03aiKbHokg2fxZ9m9iVXEEiq6gUrJmQcESAEyWZTtcM9
 1dqQMNq0yCBi8JHbiCBnpXbzLebvMAw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B17673CCB46
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:00:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9169A3CC17D
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:00:11 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C3992600746
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:00:10 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so4103447f8f.2
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787061610; x=1787666410; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RBM4DJ7y7Hvd1+QOvjPrwbeP9q68lLrdVj+Qius1Dhw=;
 b=PCR/egq6hTTSiRWDJyCjYafYcJrCkovjkDttyrJuguy7hoLkpeRFUlW35CnwZ5csGh
 0aDce4arAwUv7vCLCRxtFtHBjvdihsd44Cteudlq4/WPjO4q7mqwbocYrrd0xd2HDfGw
 5yg5RojeySCgETFrK4jDqbEkBJu111El9o9qRX3zGSRgROK3PMgEhjmXv1EJjfsKs6xJ
 F/PNqNa5ZE3cOxOheLzRE4oMw0zH7mpEP7JKfYu98kfLMtydH2qYy97F7VOy+G8btFYO
 BMr91i0lh0z87Jl1+sKhUq7P2TGN0gcSfesZ5psQfJk/I0mnTgWEfWldbKLOxxkMGEM+
 mYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787061610; x=1787666410;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RBM4DJ7y7Hvd1+QOvjPrwbeP9q68lLrdVj+Qius1Dhw=;
 b=Bxo/ND8QW+7MvI8Srb7EC55C8+u+xqlOYUGUvXznIS+UVgSstEaHm5kgeTLXAyNFUr
 QQ/bsmikkN2X6uq34jp4AcGVm0qxSGCWTrndWy2W2mD9HG215r07X52ntaiWPv9kq8l4
 HhC1SwOvWKH09+HdYMSnNi48qxAwxk5+UdDxwS5C8EBFyIneo/mVmsJkz+Zq7cYfTjmB
 tfUg2YMREcPE1NWpbzsCjB7nCGvi5ozaRhy2c7CICpyeXgONxp04Fax+QUo8cuUn666S
 PlwYQaNiBJuDpC63ypj9zd1SvG4ZTGAIBp1iPXgAiodlRFhRupL6WmXlgD9wVoyLUHq7
 C7bg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI9ddhqQrlTNLPu5FZ3RKSDtq8WzAbgUObCiYAwZ1MAResVHC6Qjej/K+vIR9Sc2Oz0vY=@lists.linux.it
X-Gm-Message-State: AOJu0YynYGY73w/YGf2Y9ZGLIYzW6+WmJ+uh9OjtynT6uWrQpXIrahr4
 QgUY6pgJrY9qND5J7UT8+CcEcL1djva5EfwItUHLUSi8Q5YYKs1lVMR6Hct9dL8Uagi+LlL17ga
 G3NJkc78=
X-Gm-Gg: AR+sD12QTvQjMzKL3xtRLG278JhrTm0FllbecGQW5+bxLJxAL7fAVil5LJjzcsH9PLh
 9ZhSuL2nME6yv07R10bdhbJ+Y7Jy1LsuKrPwFABtnauevxNrznqHgOyeaiM9IFJdP0g1V5CsdOj
 POD9T/HnIrz0iKtx3bW5US9beLtHg1W5flVpQ5rgo1dGMvLPTmxEWvufmyn/IWPWDC1Z5P+m+Mk
 jVXSVHl2yvXrGTw7WficSCa6U7AgC6+evsK48q8wE7+q3Yl2nwWQ5LcBfgXeVuezwDOTljpY6TS
 xv6r0y+0r7+zpyeferhf89ATMIDLlWBMM3/z4XE3r5i9vM9zo+lNJ8udjA7zYD/B4snpJISxh7r
 8lUCoTQ0TIHkytongyz9j2B9K8xfRc0x5oHHUSMF96/c7ZihVfh3yLDH85yYjXKRr4eqH8RQXBT
 CIetkPDYzwNqgzxkzMmRRfnY1d9wgxiemCAXCs3KsDAJoI5iU1oAayRN3Xp2JWUrfaZn66KFXpL
 lkQl2UHBQ==
X-Received: by 2002:a05:600c:68ca:b0:495:641a:bd3f with SMTP id
 5b1f17b1804b1-49987995272mr426083475e9.13.1787061609013; 
 Tue, 18 Aug 2026 07:00:09 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999618acafsm205859715e9.14.2026.08.18.07.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:00:08 -0700 (PDT)
Message-ID: <6a846568.bf927062.274a72.c3f7@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <an3Y03mKBzue5w2s@yuki.lan>
Date: Tue, 18 Aug 2026 14:00:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: Remove timer_*/speculative tests for
 invalid timerid
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> The only concern I have here is that there are UNIX-like OSes that
> actually implement all the optional behavior and in that case these are
> valid tests. AFAIK OpenBSD implements are these "may" clauses that Linux
> implementation ignores completely.

This is the problem with POSIX systems.. I would suggest to keep them
and simply ignore them if running on Linux. Do we have a mechanism for that
or we should do it at runner level?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
