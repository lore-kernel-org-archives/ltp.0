Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25B0CF6C13
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767776839; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Rai12RV+yFc2tOfclNIhgRbpC8mBzIdTjIWxBzGjGyc=;
 b=FlhB5ZYKOsoycuLdwxW8dCk5ihQ3MbIbHPzNRaCwj9HnS79Pgv5AexDTEgDOKn4XJwMx4
 AS/jnrTK96kBpJGPlpe0sYSTuQTI2sfK+DsfkR/jQVkDVU0ZI8Ig0ud4lrgEl+g+oXdlr2H
 Dq8/u4uj292kF2JqQiP/lvodA92/cds=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81E993C2ED8
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 10:07:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CEF63C2E03
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 10:06:55 +0100 (CET)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C92C560074B
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 10:06:54 +0100 (CET)
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-b804646c718so270365766b.2
 for <ltp@lists.linux.it>; Wed, 07 Jan 2026 01:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767776814; x=1768381614; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Sfyd1xG3iEoO+4T/afnpnohdZScVpmRGUeMl4H93hE=;
 b=Isa+yqMlvK0omUzVYwI9fxExGqwTd9kn0CmLyR5fotYpi8hoQegh6Q9RE1IdcrF6EB
 4wHbVysTpbPXG92byVM5A9qWTsuZauM3cTs6gALNMpXLmEsha1hFifNiyXnFfXclfbAm
 gy76D3/pf+kLRGGJStuC432+tVXhZsmyiZ8nWlHC8gmmyDnF7/1gd74KTMqIWJS7D88a
 dehLkL8bV6PlF/tFr8c58aEOI4vkG+CL9OFN9o1XpNiGJhCn2fApRhRo2WoGzPm2liqR
 ORtcahgdDdhNB+vZXkx2Ulgd9KEvuqC0fq1FOYtmedwMajsO3fsSOcP1GBQ0vkHF1N9U
 hHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767776814; x=1768381614;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Sfyd1xG3iEoO+4T/afnpnohdZScVpmRGUeMl4H93hE=;
 b=SK90LwEj8kt7Wro0L90i6/eIzdQOOne9P4SY/dvMpiDqmdBP7e6nIJSZP+w+SgwqxJ
 pCjGz0yVxOyo5pyltzZA5gTMRwMDC0I8DqDDi+lugBd4TE/xhkIzgsA0mLRvfu8M3eP5
 p4Un0ffTgmC6zMexVL8QTBnYgDfj33D+ec7BECJE0NaVwLjDjeLqpHhBXUtpGy/5j8qm
 3op3t2Bu4wFkiKx/nN6Qu8PnWJx04YFTE0Ra3k7/sCJirvO9jMx5TMZ9IrL3svrw0WYK
 znOy0czRe42gq55vJ/MK0+LY5TTJuPlBw/NIMzmBuwFhhgxr/fkiCXerhuzkw52cslP6
 b5FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuGdx09wfZ3tbE3MWHSfkqcVBir0TnGpv9QxxPRBSmo33fNf89Z7ubX3tHzcna6A0nXS8=@lists.linux.it
X-Gm-Message-State: AOJu0YxaOSIi2FhTsqp85vL8rvHvJTqlSzOXBY7mR+ndqSaYyIw0uNHr
 Yz0G84ItRUGewOP2wvgichuEmgENk16Wg93mAx1a+UqjZaFlqdz1cZ9iEuEUKGp1IEfJ54qvSha
 qqL9KU4OGsQ==
X-Gm-Gg: AY/fxX71kPSh+iTxdQiGt0bC+K777kEdyOxbufuYrI4Adirzw7JXS1QM0dJ6WCJaUmu
 yELd4lfvpCF51vMH7V9jHoPVwrX61xlm5xlREU3+Bi4mahlq/ZOhgcEJW5Sj9FChZLM1+5wiytC
 UgjWSExLbi9BPPjuILE60UvLVRNzKhGQaL9vqFXa7fCrOPhkNXEcBJkS/9odrc/rgktYTNdAUqr
 CRkFmwh/U3O5VHLI1NUsogCYRLFXxEewCPpNqujccmt8C6arRyb1GxQGD4srY5f8ZMCVrmSWBUm
 UBdMe1tILuKO88Fhm9fo+RvmWxzY4Pa75X1796N7wjzEAXmpI6tZlLc+sHbpIkNFXcdCq58D+fA
 DBQYL/gJJcYHF9iwZW1WG3R/MbjqHeB9Re3wpITRjxpPIv/ta65FJQP8isg0y7KJ2NnYodLf6DC
 fI9X2nBmwFCZ/0QjLNugxmTGDxFL5DqsqhfBqNa6JniZrs2c6YmFeH07dGeYqOc/4LS1F94l6pK
 hf2mbQ=
X-Google-Smtp-Source: AGHT+IHzyqQ3Fm5gs5xPQCViv3Q7Lvw44ZqHfmXs7BZUj5evx3kxGWLC/hnrTwsyIhQH9OXJRB2vbw==
X-Received: by 2002:a17:907:3e20:b0:b76:5393:758d with SMTP id
 a640c23a62f3a-b8445345c45mr151013466b.34.1767776814105; 
 Wed, 07 Jan 2026 01:06:54 -0800 (PST)
Received: from localhost
 (p200300ef2f19f800fd6433c69db8d45a.dip0.t-ipconnect.de.
 [2003:ef:2f19:f800:fd64:33c6:9db8:d45a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a564e27sm463200266b.67.2026.01.07.01.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 01:06:53 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 07 Jan 2026 10:06:53 +0100
Message-Id: <DFI8KWVS6CDK.1J4387C2I5FUC@suse.com>
To: "Liu Jian" <liujian56@huawei.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260106120545.3142001-1-liujian56@huawei.com>
In-Reply-To: <20260106120545.3142001-1-liujian56@huawei.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rpc: create valid fd to pass libtirpc validation
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

Before submitting the patch, make sure the CI is passing for all the
architectures. You will need to push your patch into a forked LTP
repo first.

We have a failure in alpine at the moment:
https://github.com/linux-test-project/ltp/actions/runs/20749270107/job/59574137088

Thanks,

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
