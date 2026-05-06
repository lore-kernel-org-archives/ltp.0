Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D65CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 12:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778069444; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=6mnWmKKqA7bcgZXfaZ4KjJwxUbpCjPg3aLlxL5bEmYI=;
 b=Jt8a4qAKHsyqx2dOgUluAYRqaNGx7FNgP/zp3qLOznSRoymBnQQIwKzp73URrQwUEpI+f
 e7eDLqfK5Fv0KsSG4dzHHC9mHA14X/XTrpC06M/TZqQpLdGet8YfzAjn6uCY5c6q0eTExfv
 DatDBLwXCjC4mz7B5gR9zUt5zhUGfqY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 640E93E6156
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:10:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 048823CBC10
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:10:19 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 50D36600BC7
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:10:19 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so71300565e9.2
 for <ltp@lists.linux.it>; Wed, 06 May 2026 05:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778069419; x=1778674219; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=36SDFMqC8uYduzraropkt4xFDnnk4pRT6W/reHg1rmo=;
 b=FgYYGsw2PUxbVI+MpoVJllhoC1wFXeQGMAZK5I2HkgeTjbUyU+hRnQUkpUMKQTpNLL
 7P3ZedmNlRBJj820nGmgH+aebyP91YGf1hnJkhqppPX7JZJCE/sDq5kp2uNDI/RncvNQ
 0+5g9o07HhT9Fm0Njj71lz+WgMzGfJtG0nMiwOtdwVWHQWq+cGvCedHc1ZlRjADqtDVh
 xCkehT+9ypmRads8CcfNpdz6XUXxwwR5KKYAvPZWEa27Z7YzmVqItDJ9cdF/RoQMMNcg
 fRs62r/3O6QdMNDpgVqxkLVGBR8wjvMlz0X01rBtOpivYV/4VjWycyZ7KdJ2Xe18WnEF
 d/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778069419; x=1778674219;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=36SDFMqC8uYduzraropkt4xFDnnk4pRT6W/reHg1rmo=;
 b=i2GYPuhBIMbHIM+5l+OdrQhlwYtwnO5C4r5i+XU7nNADDXozw5WsgxPpvp+AcN83mX
 Utq09YJkmLQkrz9Q8cHdg0KxO65+Kek5ZmdVvwUpEVI3O+8n4BhBxQMMvDSkfmmI4kg3
 mGfgRIpV6rbknWHQhNOEiS2/3UyHGjuWaVPLSIWHpTsSupknf/jgOU7r968i/taY/RrX
 HaFbb++P7ZloAZsPnhcsWqvvEzUlohTnDciPxiSrI2VJV9U7VB2t0ybb5fiiIV8cZgO0
 jmmEC/2rtm+s+mfdoSDRAp6+bIkjZOovlqYOGpt4DyKxSJMU5ufM1uVtZL2N8ype4aWm
 UvOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Pj/oQlBI1Py4GSV37QNYM8OBn/0Li1OPfJjimALRHH8AWKGkh7KUKejZMYsDGgc4OEgU=@lists.linux.it
X-Gm-Message-State: AOJu0Yz8edjOms46nlvB6Q9OhKNrs/HnDEqrlLJ8OaKCGaR1cOhYkhAU
 911/T64458xCZ8+fPhB/fOF1x6D5wv71PqYNw0NbdZEeaEhUR2nHggwughgOlPqxdbs=
X-Gm-Gg: AeBDieu1QzhlYJ9ccWrci7ws0MCjpk3pQBBHotZBP9ZOQQjpBmBPLTRX7edNrwu036N
 +MtcOip63QEUtYCA/T3V2rIzVF29Q6iRjdo4zc5BN5wz13pqSqDHIuUahlPjYXf5gYRuta9zLWH
 LLRQDl+JX5nl6M6g8B7eigFULwi7YHo1JlQIAGUGbYRptRjTmBxTy5Z9XosE5W1SGhfhdnE5r2F
 Fh0+uWS54b4XV66euUPiTn8RpKlYuuu8e9KaQXe/KtHSsE+SgrmSgbzTANOyaE/mqyzaq2Z0c3K
 vs0bXlFwdGgLKmquehgH2pLzzUxNoddt5/GFi9i8kNP3r6tCcjkSEV82iLAojUurjy3wR+OujzL
 KhE55Tf6bLiQvl/8zYP5E1bqgqYzMfQhiL/LKAbViq66711vRr5oXj9nt3Q0Cc5zvjNqo6iOVUM
 aUC1FzzF5g1gmg93RJ+ylDLxZitIeTCzWwWZZHO0pU3rkcG0Vulfm87dl7b/0KN5/Qya6Qk4ie7
 jLgEtFc6TNHIA6ulxHbgYDbw94+5Kxf3d2K7cUWfTMlvjB1rJCyGhAvA9os3d6Bm26ukwa1ggY4
 7+V9gozaSRQN
X-Received: by 2002:a05:600c:811a:b0:489:1c32:210d with SMTP id
 5b1f17b1804b1-48e51f369c3mr56478495e9.15.1778069418640; 
 Wed, 06 May 2026 05:10:18 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53895f0asm47427135e9.2.2026.05.06.05.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 05:10:18 -0700 (PDT)
Message-ID: <69fb2faa.050a0220.230394.be73@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260429151834.3982-1-linuxtestproject.agent@gmail.com>
Date: Wed, 06 May 2026 12:10:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] close02: add test for double close EBADF
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

Hi Jinseok,

The review agent is actually correct here. If we close the fd
with SAFE_CLOSE() it will end up having -1 value. You need to
use the raw close() plus checking its return value.

> Hi Jinseok,
> 
> On 2026-04-29, Jinseok Kim wrote:
> > close02: add test for double close EBADF
> 
> > +static void setup(void)
> > +{
> > +	fd_closed = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
> > +	SAFE_CLOSE(fd_closed);
> > +}
> 
> SAFE_CLOSE(fd_closed) resets fd_closed to -1 (the macro does `fd = -1`
> after the close), so both test cases end up calling close(-1). The second
> case never exercises the double-close path. Use a local variable to
> preserve the fd value:
> 
>     int fd = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
>     fd_closed = fd;
>     SAFE_CLOSE(fd);
> 
> ---
> Note:
> 
> Our agent completed the review of the patch.
> 
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
> 
> Regards,
> LTP AI Reviewer
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
