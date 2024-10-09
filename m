Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4E5CEDD97
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728482019; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=UcBdQsBqsUiiia/3jIUK5wUnsA8lH53gWWv4q1iy+rQ=;
 b=MC8QLI3oBTIWWhEQHsNbszscrjuE492XB55OT9c3mZ2N9zEPFoZCvTqYLmIs1+ya/KA4c
 AUXhYWjZhqn1vmwmZ86phWDku2nbcBTjEm/lEqFjCHOlzYsCP0haoa+5gwhR0pVEL6D6204
 5DE5XpN2ZVcMlXpAuATxooH8PjNHUKg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32EE63C30EC
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 15:53:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C29B3C2F62
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 15:53:19 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BDBF1610230
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 15:53:18 +0200 (CEST)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fac3f20f1dso75067411fa.3
 for <ltp@lists.linux.it>; Wed, 09 Oct 2024 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728481998; x=1729086798; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v3x0o47MO14K+0pMDgFp1GYxi0S33Z5YzFChYVZByZg=;
 b=auSCxWGb0OVX7zWK5KZl8i7fEwSuHzAt0vlDqdjxiKAA/+KpJloQ05Aq+byx5SQPDI
 UUxtUWfHva7wFn16cutec7VyD2PqHkci2sQLNXY0IyedC9mYcgh/TdMH1zXKWbZP0xnQ
 21JsKUEwTqBORgAtewuFhVwJTUrBQAxVAUufQ/isvQbCcIHrpQSNlkm4mHepi7Ir01xI
 oZTiptsLivRav/YXdbDDncpJJTPqTOO5qmsU+st/6oWGOYcs/66unA1WD7wiAL5l3bfJ
 5bbfKDW0xTvWd31d3pU3JtQ9kWHr0cyQYH4i6V/HSe3dKOu3e6+Qmis2dcnjRoB8dgfv
 nQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728481998; x=1729086798;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v3x0o47MO14K+0pMDgFp1GYxi0S33Z5YzFChYVZByZg=;
 b=duMtEd+8NE3vILHNXftr31jvibkV6TAbn/uKJ/jKGVKD0+WL8jHrCuzyrePDD26OQC
 OLW1HvDVpcel4tPQic6M1KIww/LodLzViJVUNtLX52wh+HKeyIT7qxwvedrPK09DOiMT
 fxrrnMbCW83Jt843011mY8uGQhpQrFHsbZIGFzJpIgmn1RjSk5YuyWOlO4RYTZdj2k43
 hMe6oWsmPaXj0e+d2QJWM5YcMMEnmaucMxGcZb8ekr4F3YX+8ojgw9Q5ErnhBJa6C4G9
 P9PKVIZAVgRWKdFoCzAus91xfwtPe4x2ojjKIf/549Qtbi3k50RU7Z1XOStejL1hL+R2
 5CDw==
X-Gm-Message-State: AOJu0YzQFlqVCA4oJxW9oqz/kjJkcrBHYtRp6ciseOctFEn5Dtgw23Fa
 APj4QXWf1Xj2+Ff94F0woBhiKy9irOSUooRJwr7m4yRLdNrRWRzv0hQTM6X1Fxk=
X-Google-Smtp-Source: AGHT+IGtemMyeY6g2qVfzVgtRxaBMSChlBkVt6wRiHXrhi/S2ZHD0iYatGCV6a8TQ9yRnzz1HzWTcw==
X-Received: by 2002:a05:651c:b0e:b0:2fa:ccae:d1c5 with SMTP id
 38308e7fff4ca-2fb1872cdb0mr19568541fa.10.1728481997893; 
 Wed, 09 Oct 2024 06:53:17 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05ac2casm5499404a12.34.2024.10.09.06.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 06:53:17 -0700 (PDT)
Message-ID: <ca65b84d-a75b-47eb-a219-5a37f4411b1a@suse.com>
Date: Wed, 9 Oct 2024 15:53:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
 <20241009-listmount_statmount-v8-1-182cd6557223@suse.com>
 <ZwZzkfidubD6tZJ3@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZwZzkfidubD6tZJ3@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 01/16] Add SAFE_STATX macro
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I'm going to push the patches since this is the last reviewed file. 
That's ok?

Andrea

On 10/9/24 14:14, Cyril Hrubis wrote:
> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
