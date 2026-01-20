Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0D8D2ECF7
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 10:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768906553; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=puaUwGUs5dzavj52Fbf/Z17vuP6CMBm1vc0Z4vc0cng=;
 b=HUaCwaB4APnrX9+6hrNrQjlD2Eqw1pXvG0MPY/U4ZG4BMSpt12sPa/RbzM2Yho46DtGWs
 tMdjIormVVcf7GG0McV+urJC+P1D1r37A+oFghpmbbxlIYySLWzxnWI0fSxwjaue1OAyo/V
 GoDdjUfxGxu2V82DqdL3lXiUObmlRik=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56F0B3CAE3F
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 11:55:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 613713C4F45
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 11:55:18 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CBD3A200AE0
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 11:55:17 +0100 (CET)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b870732cce2so795965066b.3
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 02:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768906517; x=1769511317; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOsjtUlGGfAUpObFZiCPBc6TjB47TGsF8gJkslSxnL4=;
 b=IyoyiHEqFYDu5CP3C6QVDPMPvVbBo9eYu+WhAgnUEXiBEnjzlkWW+NgkdyeAlV/lnO
 ayULSP5CIzmJEl/YZeTOtIv+P6uKeMG2U+aqdLZgT7DTiMNMVjieReI6QR5HPbpZ3p2M
 M+OHLlQsSzOi7QEEcr68Dh0Iyv6IFP/WiWlw7gUOIr6T758HcYiXYkdLesiNlvZly5pj
 3XPxVqrAzutY7D/qLsXPOlMbmGw6re6cQhy9hgo1aUWKXT24B5EEBrAwDHPduCKFrXB9
 ISnDwx+vUkVFc/MlmeqFo0OsoN8BXknPiAscmgYZDDzlkCVywMXCqTUQotwj4NxwXp6j
 4LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768906517; x=1769511317;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JOsjtUlGGfAUpObFZiCPBc6TjB47TGsF8gJkslSxnL4=;
 b=waUL1bAgjT0aIrK1BkcTKOIRKuZfGUYGSEUFqAFbv86b3sDppCF/7S2j0rAivMi8fe
 fKOSYycdme+N/iG3F8b9Ai5T9FABOd4z4Q2u9rQOWZp3QdFcy7qbybjvbRIUrKhz6Tn4
 SzKyLXEq00N6t1AKCahbfnYNqSsXSZVXPbYIABjSYU8M1sVbkYBPZQXwcCybM6B3HbUY
 r9Uopp1QYB2goyy9uO4RHxdLYd75WYvt5BhOGpWsHw7jIXLHvov9iJKnaoZcWfjoHbtc
 V1mS6oWMG9pEALoLEs3eB/Pgl+eIgJI+TSx1sKPc8DVss+8YHotTgSWw8CEGh1/eFj0W
 zGKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWGsku1ZKJdzR4+kUJ0iHn56U9XXa8Xd+TRYDeCW583pTTum8wv9f0x1jY0QDNDh9PsqI=@lists.linux.it
X-Gm-Message-State: AOJu0YxwBUxaXnHqJwpOqtze6d3bVp05uBs6pr4rWEksxHK8DwEnvAVE
 1RQ7LlcTGLNu4UONzpEs3cVDmNA/RtpIc4FxNNKJw4Ri4dufnsIRdeJPBhn8qQms1I4=
X-Gm-Gg: AZuq6aL+NHR1J5dsRMCCsiWM5MiD41xXDSnM4trtBWztrNUOPSCyRyDyoPAmmRXwrSi
 7Bwm58KWOwhgnrCzL9TD3yj/CywfOJwVVwq4LD4AvjhrMjWDY833aMm8bdNKj/2kFiNwCU3Ng8m
 Ntb2mszcM9m5Y854lbmtu3oupUmrvtgxFAi3r3MjYPkRllUgEtecKmaNfj+smFlUzqMXkCPI4CX
 gEykNvUcoE+nM5sgvgkP+/CLKCi8bQkmgJ1oTbDPSAZs3Acoi/v+KtCgR0bR2FeKjXK4ohkOZEQ
 5ara4C8IIFC9LHzLI8kceSK5R54rGS+MwY7MygAtzXlE5XhHKUUjiKiYqNWqOA3vtoxbHYGOySk
 gdgrMerRl8E32nvuQ6091SJA3a2eD1J2cvBjR7Es1tQUWFhznY64mpRWPlp0qtZS7VaouKo8sNJ
 b9DAgSb2gDZkBL62R+cudEE0ToRSxetJdBzIejsB1Vk+R+VhMh8nBjRqfqLNQhFD7/aW4I3RvK3
 uZw
X-Received: by 2002:a17:907:c19:b0:b87:1741:a494 with SMTP id
 a640c23a62f3a-b87968f5a60mr1060310466b.17.1768906517137; 
 Tue, 20 Jan 2026 02:55:17 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fa4f3sm1346554966b.50.2026.01.20.02.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 02:55:16 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 20 Jan 2026 11:55:16 +0100
Message-Id: <DFTD0Z8ASCRC.ZENSGYXPZ4DA@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Petr Vorel"
 <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20251014-file_attr_eopnotsupp-v2-1-c9827c8d8127@suse.com>
 <aW4mDAH6pVh_VyC2@yuki.lan> <DFSMEBM9PYDT.3TJXEU3C8W31R@suse.com>
 <20260120095945.GA27808@pevik> <DFTCS1EEBMDD.21X779ISM0MTF@suse.com>
In-Reply-To: <DFTCS1EEBMDD.21X779ISM0MTF@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls: add file_attr05 test
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

> I think my approach is wrong, because the test is not really
> verifying if FSX features are tested or not, but verifying that vfat is
> not implementing file_setattr/file_getattr. Hence I will change this
> test, verifying file_setattr() syscall only, including all filesystems
> and checking that XFS features are triggering EOPNOTSUPP, except for

Typo: here I meant "checking that FSX features are triggering EOPNOTSUPP".


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
