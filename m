Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A064CCD18E
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760434786; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SxwBfBL4vr8hsi4N9W8CqX8YHM/gCHg2p+yiHMGEJcE=;
 b=amHtY8CV/LST8IqHGTQJCmVBxTteuOh5/jHp26P8gKLR4pGNYhHmHE0lAoRwBahMorPa3
 xpxIcG/xajjl/vKs2Ex4iL8O+uH6NAPjB5HRTs/9Ajw8QR9iYj0KXTtOstL4njPLAfDAVYT
 0TqWXQzgq8Vvq5m3KStNGyuFB4yPkds=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4A133CEC8D
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 11:39:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC6933CEC3E
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 11:39:24 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1B2DF20006A
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 11:39:23 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63bad3cd668so3074432a12.3
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 02:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760434763; x=1761039563; darn=lists.linux.it;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0aGAj7/T4NGEHpgQLGi4oZTkYxfTuOa0fUy96Ytzu0=;
 b=IAXs1lurYfHXASGjLCKXSw96tMj200y7pT7z4Bw2aySoBvNuxDwXHyDSXZ2vMTYxQX
 fK3hREAjLAqLP6tDu65tFcgQ0VT1+5xpiz94g2ngVxNIkclxbR32dEBL5LV2BwoWe7NI
 3FP88yXuTM7IcZojNya05AQg67DLOipnjFxUPYjOEKCoYPUQlwU2i9CvgMCqndLowjOz
 TIjJOVwpBEU0Ot00ijwzC68/dZcQ9sieI1swh5G+a5PTP5RVMJPYkXBd48uSGEs5FbIz
 N27tp+mE609/h2zP+az7HOqx0O1wpyOxzbGH47kSCHZoJIYoloRS9ji9EdFOIZhrHolF
 ewFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760434763; x=1761039563;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z0aGAj7/T4NGEHpgQLGi4oZTkYxfTuOa0fUy96Ytzu0=;
 b=WsH3GsfO7JNEM+wSgHFqoeLuu3WtNy6OE3he0xK47bFb3zW9xeUzIFcjQl+1dIvtpi
 WvNKThql/cWrYPqDAQmqLwKbJ1CqLLcjrr6PvClAE5+OzcmwDhpYRz1SC9uq4aiq3/eC
 j7QyevUPTxv/GPwXBGnpprlaH9eJr8HqZK2KUYrzCO6E/GcukVOzQqBzZD03bKdMiKsi
 zVQfqTaN19S/SH/qpJIsXpvjlv4L9w1vqfqEO9V63zROGAhlN9WiQw+MRITpjToZjkRA
 U484ERNeZHdtrsCDRFmBOqfHxN3YXJt2x74mblerJxar0dDeP1ClqJ24tHK2KeXvqI9H
 hHjw==
X-Gm-Message-State: AOJu0YzXhrhcYNvjNjDIdNd8bIAxldgjqeLLEKPsOHbK7f31Ja6FPwCe
 ycjSIVD5raNM1YAEVZlOdmgP85N+oDc+McK4f8X3Js3DsbjfLLaO6nUN0ecMjkVg3gc=
X-Gm-Gg: ASbGncuc5rwpxFg8ERqYdcjEO82y4op1Q4SChBS6b4NLYEY7JZtcIH3yyRdusGyS8kN
 mzuqCiMwElWBKkSD0PihXJQiSZ/hhHmSyJ/E2P7gysTqsY3t81lj9cy/buvOlUUoVFZp2IVU2N/
 OivoJhoLYUWYgw4it9xgiVj8/gJW5QI6r9BC3NFLRXbdQIowfV5beZZKImWzu7Tlq6Gtb7C2OYF
 BeZp+m0txjKAB2lUlldjuaZLchiFwTrNUJmVmnEy97GoS7kQmNkzt94PRiiKmM4TW4lzyY4A+K3
 allEaSDjsDzkwFXl/HISZKWx/u8I21cAUgr8Thva2Pk7Sf6iZ667y/Xqr9c79mH6/40rSusKvdU
 CXaRI1iNvmBCCd1X9wXjOB9Uz7a061P45DQc3aPtsm0QFe0fgg7E15cxEpL4bIvM/q1e4TT2GZt
 9c9Kki2nYpDem7PRSBh0ouxqI4/F19JLRhZw==
X-Google-Smtp-Source: AGHT+IEeRzZyF0uT7a3BiqzWXEz90IW794A5H1LDXJLWaXN/a2rXPO2VzdImzs9+MZXujMzyCW6p3Q==
X-Received: by 2002:a05:6402:26d1:b0:63b:dd6c:7558 with SMTP id
 4fb4d7f45d1cf-63bdd6c7725mr549717a12.6.1760434763322; 
 Tue, 14 Oct 2025 02:39:23 -0700 (PDT)
Received: from localhost
 (p200300ef2f1c890086c8658517a2433a.dip0.t-ipconnect.de.
 [2003:ef:2f1c:8900:86c8:6585:17a2:433a])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c132567sm10657695a12.33.2025.10.14.02.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 02:39:23 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 14 Oct 2025 11:39:22 +0200
Message-Id: <DDHY1H984UNS.3R33TJJGW8UQB@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.21.0
References: <20251014-remove_todo-v5-1-2793dffdec2d@suse.com>
 <aO4WanlsicVtKsSw@yuki.lan>
In-Reply-To: <aO4WanlsicVtKsSw@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Remove TODO
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

>
> Maybe we should link the (now empty) shell API page here:
>
> https://linux-test-project.readthedocs.io/en/latest/developers/api_shell_tests.html
>

I don't know if it makes sense to link a documentation that is empty. It
would be nice to write it first.

Kind Regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
