Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B33FC5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787215100; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=tZQoU/0UH78vZ23A7zrjXFcTN7Uc/JJ2XvZTPvmkyuQ=;
 b=nyHf5zVr8OXzjLV4lyReBHy78P2X5C21aazjzi3ze7M6nGV3OoDi+iydGueOw1ladj4Jj
 f+9PnX6+mRZakyHGNBVeth1agGxHZsPNE2sAtvlmjpHR33IhvZ6TCWWDhiKdzyVmWqbsZcM
 pkoBrfPRpr2u7PNzX5CzP7oXAAmV6v4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F8463CDBEC
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 10:38:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B11523CD6A7
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 10:37:59 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ECABA14001EA
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 10:37:58 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso13382445e9.1
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787215078; x=1787819878; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HJieSgFcVrJaFhIU9QnppFAQu7qfiZJcrgh6oQFyeLI=;
 b=N+UUDt//e6yOKF1OE4u6tJpJBSZTMW6diXzRt7gqJO9xLUVsrU74sUHwQjAEt2MutP
 8ZVoGVN3g/MdVV1G7W6LU90VyZNqiGZaiceykRfX5y78R7LFKmcMRoYFWsSsaVDb9wGN
 9jUr0E/ite9GVWtvuQ1W9Z6uQmECyIE4K18S++an/1RBS5YSOhF65E0M2gGyotfbYwsO
 WUJWgimli7hGKaf6lYrRpHo78t76J1y0jejbzWKWWFbiIg4CGDI1dLjMSaiL67l2uHvW
 M1WSu4zzqkygy1Qv9u3Nn/m6SIllIYW32CTUBGUK1cStX2flwf4s9GG2g22lLkDatnBb
 lcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787215078; x=1787819878;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HJieSgFcVrJaFhIU9QnppFAQu7qfiZJcrgh6oQFyeLI=;
 b=CCa96bU3cN72O/MLnrw1c/uHTU+piLZGNE6IBV96571VQ6XOU8l9bYPjTIHxIB4Ibr
 ol0kIMPdaM1ES3IvtdrCsN+OxVuGw09NuzAx14aGDg3KeHTP4KAjTY4ZpL8T9ipfxdLj
 Pef3mmgRGwumSakAbr0NbD5dMYOEn1TE7C2cd4AMuWvl5/uu1g5oguHqXAW4I2Ckz2bt
 QwK0dsfE4r/v7vFyHdJm3W7hDizisUfCs3AD7lJfa9kzqu6hfb5Jk6fjQgCRw2qjfOcM
 Gojt3XAQkDTMk9RHqBrbVvE2ltg+RuqEz8/sanMWdYWOn4ex+QVb+pJi67kFWonvN0yy
 j2qw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCe4l4L5hDd7snw9NJt9MfTTMngaZnRwxV7mbNyqSMyoihcmxi9aJK/2zf573ruK48E8Q=@lists.linux.it
X-Gm-Message-State: AOJu0YwCuc0SEbtSlWn+JnHJ8eISk+MoyMHtaiXa7safhrv6miJk3q/1
 ouhDAa8mUunQ2+VusUaXJLx0lKcnea5ICX8LYVU87Ea9P3+TRgTSoB9co4lSRPwWgNo=
X-Gm-Gg: AR+sD11GdAit5cPti50Oqt7r3TNQCwt7rcuLMXtHBkHukMurR0O9+mM4QxlUDnvBTAx
 ko+MO9+1HFd0ZkPzG2XVz7K1aJ2WyvoImBuQYzPQ1m9xPgcSV6ifJxI8FaTqhgNAL+llziWFzy5
 xqtG29SQHbCMkfrWEPRIfAWynOpw+mTLC4fqST4nzPsH/m5QrW/m6EGf9r/yZDmYSSI4nNwmGKy
 B9r/MlKUWZIwpwQuFwDHQ0yETD4FxW/n3jkoKsieSw9QxRRv4uj7flEAreNQwqgUwJKOLmNG2Pb
 5p/u2tXtMl2QIJTjYjkT951EYxYQ6q71bDYX0mtpuoDmzm7R45UcDwKopYzUcZIsxpeD+EG1LYh
 esX9pzXEGgiLT8itgUtIb0Pjpp/Eex2LMBfKtYkE0vA/lD6D2hvPUb/SpJr6ywMTyO9RRygIXh1
 p9MBIXTVA0iNRsPiRa43CtWjOPKJvLCZS3UK4NdZF+gyc4g7ji+jb4eLFJx9YujwgxzQmclbQ=
X-Received: by 2002:a05:600c:8b81:b0:499:8ff5:8ec4 with SMTP id
 5b1f17b1804b1-499aa1802a9mr217784115e9.3.1787215078214; 
 Thu, 20 Aug 2026 01:37:58 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0fda98sm197263125e9.1.2026.08.20.01.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 01:37:57 -0700 (PDT)
Message-ID: <6a86bce5.47e43f48.1826d9.9f24@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260820083437.4219-1-linuxtestproject.agent@gmail.com>
Date: Thu, 20 Aug 2026 08:37:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: add v7.3 syscall numbers
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

> Could this subject be prefixed with [STAGING]? Linux 7.2 is the latest
> stable release, while this test targets fchroot() from Linux 7.3.

Please ignore this, it's handled by patchwork and there's no way to obtain it.

> >  * :manpage:`fchroot(2) `was introduced in Linux v7.3.
> 
> Could the space be moved after the closing backtick? As written, it becomes
> part of the man-page role target.

will fix before merge.

> > 	off += snprintf(upwards + off, sizeof(upwards) - off, "/..");
> 
> Could truncation be handled here? LTP accepts an arbitrary absolute TMPDIR.
> With a sufficiently deep path, off grows past sizeof(upwards), the size
> subtraction underflows, and the next iteration passes an out-of-bounds
> pointer and a huge size to snprintf().

this can be fixed indeed.

> > 	SAFE_STAT(tst_tmpdir_path(), &st);
> > 	TST_EXP_EXPR(st.st_dev == realcwd.st_dev &&
> > 		st.st_ino == realcwd.st_ino,
> > 		"working directory restored after setns()");
> 
> Could this stat "." and compare it with realroot instead? mntns_install()
> sets both fs->pwd and fs->root to the mount namespace root. Calling stat on
> an absolute tmpdir path succeeds regardless of the current working directory,
> so a regression that leaves pwd unchanged would pass this check.

this is funny, it was "." before and it was complaining. I will use "." before
merge.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
