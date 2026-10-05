Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17199CA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791202285; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=WSzVrwsoB9tJHaiSx3A2NPCdKcpA2I5HHPhU3JLxyBGrz1yu0aBhLLN2QWm7eLYrSmL0y
 Ci6TXw3ovG83Jpqzums2QDWErivdb1L7NkgUnuTYDw2ltWXQraxiqUqs4Oe1ADgNC+uQfuq
 M1ElozP5B+1VO1oq4XdwWp0OozDhIEw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DA3F3C9A74
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 14:11:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C74F13C57EB
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 14:11:05 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 545C91A0066C
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 14:11:05 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48b03f23305so1479243f8f.1
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 05:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791202265; x=1791807065; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=F8T3iHvXE4s3oZrQey6tCwqm0ZuZgt4yTp6YM83b+/WrAsAhPhw1hRGLJwJl9Y/gZ3
 h6GTvj/BxZjMLBs11TPSvE2mNSrm9duayU7+gd0nB6SzOVuoXGyyVlwS1CzXPTBlnWRp
 m5xuJQGbHLaygBlTHw3wyme9RULTJ+rs4MTH5Ehz7EYQpZroUAtlJsMdAkiXsffHwkYS
 IL3WvO0PyZsNQYzaZ25XPc7yPqRvHYqnGsvtXnuKcwcx/7qYvLBF13g/XvDp6pNN2qe4
 1P9RZ5WukLTQMLsIecffRL35NS1EFSsXx8tGPUhAaT2kNiTa7zg0NCZ996MkmweQrDZ3
 jySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791202265; x=1791807065;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=ycrkocTaPdfoVR1FKqojleW6x06FL1uKLlscTkd/89+/xa85JBH7nL6RC6ld6z5y82
 t04SbuMEJEbSIzyUEQieWwEatToPht9dGI4VUK22pbV1QPbsfzOps6vUt6+Z+lB0jUeZ
 bNDkdttAG3E++IRyQdfpjiUgG6b9/iEZYFr1zhe+rVQKwC3XKZNUJa6yT9TTYdA0gqT6
 3yZXP/WTObZmPzdb3cOSViszb9MbRrmLfvyZxdNN+ZTmWWLOpD0cen3raG8amkgTW9ye
 6/ai7qQfxeBRWiZ2W9pdNEcUj9wpkNlXVxRPAg85hNPratC1H9jOoxZqeOvIVj/N3ut8
 ZB0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsm0R2Dw2cCAx/cOwvVyH8YIvOeu4fdZip5PeuE0Nw2tr4z/YwQlIZhWi1XMZG67rOGOs=@lists.linux.it
X-Gm-Message-State: AFq9FYIW1FIuoP/ZHmS/cgj1xW9UuFin5S3FDHe91q6+0czkVHhagskq
 MNgs+XsP+DmZA0eQkf0/c5odkxsWKe3/Ce0pOw3BLdjKKyFlmpfsct7cAivVrClmLqV6I0UjPTp
 L0sZvqkRu+g==
X-Gm-Gg: AYBFou1MlLn3jUbYubpEnZzHSj93UQwuul87Pyy+I/UGgwegMGl7rTMK8cgNGkD881Z
 zplYU0KedEmlrHEZuKY8+TfBhmswLixwWEHbtNmrolnCWhmMTrQB5VGvhc3pzNomBH7gu+SBzn0
 TX4tpN7La+bNbtw56paJ1+QwOAlZBK23TEZQ4xMxEPC65GHn0h0+rXmnko2FuohtILrVVu590pK
 hL5AewWHHVAl5o5G7HUP7pje8vLcVfz+3njjeuy1ONkGR5uRJmpnMdRpaKZLSEFUAN6NS/CFNwQ
 f47X+B0gnoH83BMVNbuDsFVzoVFjmhAK6INe/g5jyJiHW5Qi5nsJO1m1efGE1EJTsg0w9TTtpIh
 s+rnNUvdHwRgX0S7x2uoWDLWTGmcZAQSx3hdYvG9I24guEPkW7KQUweiwTy7NO2WYIKoYhqzJ+8
 j0yJu73l3ctREzMGmqvDFw6EzvZj2fsEowxoh5Kn4/JT/NpQUoYzLWNOdO7h6TamvJ61Ve88RAM
 19lejuOF8yIFnuL/UOe03DMXcstNW8aBQO0Wqmm+iJxj5o=
X-Received: by 2002:a05:6000:40cb:b0:48b:a4b:5a2c with SMTP id
 ffacd0b85a97d-48c47c8fdfbmr12726094f8f.3.1791202264470; 
 Mon, 05 Oct 2026 05:11:04 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6229ce17sm3090677f8f.29.2026.10.05.05.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 05:11:04 -0700 (PDT)
Message-ID: <6ac393d8.0823b035.35e9af.4c94@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260929070605.34590-1-linuxtestproject.agent@gmail.com>
Date: Mon, 05 Oct 2026 12:11:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] open_posix_testsuite/sched_yield: Fix
 sched_setscheduler() check
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
Cc: "yang . zhang" <gaoshanliukou@163.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
