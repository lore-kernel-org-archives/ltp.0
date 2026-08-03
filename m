Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AF1C55184
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785749317; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=wls5gXbKbv8d/7+1akQ7EjcUXcGc5zsUmceE9w0LpuE=;
 b=avCGn9xotgVNEoS6TOilh1u2moHjaPb+xoTJfj2PUe9K5viLL0+2LoGp/mY9ODG+Qnsav
 J7ZY9Ul2+8ozOZ2WWWBoPrUI/HdiqIm8pwhMObfZuxkH49G1kDmxR9oLFpqjw5s++M/wpBQ
 RYL+nHqYJiWGgVXzSQrDXaNXfF7szeI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19C683E5A2A
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 11:28:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A50973E30C5
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:28:17 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F200A100067D
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:28:16 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so9756675e9.0
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 02:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785749296; x=1786354096; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=m3KLgzGDWT0kkGL5ULHQgU1MJJwlR9AzbH8ko4UmWc0=;
 b=AdzuafikFBlar7QHluj0y3Ho/eQu2q/UCaKuc3bm+8Yu0/WchHUBdiDzoDfDtQCW+t
 KonaE6c59AI0t3/VE8JusinyYImf4pCT9Dd0VT4tBK5Dni3+RxubQAufqKEOjiU4b8+E
 WDHpMDIKUTZaApISzY5iBYl44sum9c5lGDutTvihB6vYsn/PhrnjxCbMKJ+v6N/yCAja
 U/udztf9nM0ncyS082uwuQXZfygwbXl38E+0DdrJWoYsroqbdUtD4ZFsQQ+v2s/IHgec
 HdS2N9UwOH1UoSqMCz6y8nbK92LQiCN4RPTLVuCNWES9k+BWhDVfeC1h5NWZJKQ9Bfb4
 6gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785749296; x=1786354096;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m3KLgzGDWT0kkGL5ULHQgU1MJJwlR9AzbH8ko4UmWc0=;
 b=a270Mht5RL9WRh/Cq7FrR6GfFKqJEYzG4anwWFwtf3K6AaduIWVWnFyAQag7rfrCeh
 cfPm89EdfX2iImyoWdGsUjaTZdjEkiP1l06GM3HPTu7w47waJmXPn51mAzTOlT5zSsXU
 UktrTnz5WVmwBWLK3l2uKTFVeUMrVg4pD0trymQ7NI1ITa7m07JJ17GIyCwWJCS6NAbm
 zO1XdD8Djpl9C7tWcmYZ/dgmthcTsU24B4V51uaqTNXuysI7ygfGn8AHKJKR8Olms9Pn
 7G0DHF/O9UtlcSJOJwErLQT6BljVeEgNdbcBH1mVUlyVgMULsqJ76z7DOpeJzfd2ucPj
 7Gog==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmSe3hKJLOfrr4id4ZQUiY8twE4kFjX9c0eMg9QwDvh/pSfj3u/5l/9AnfuMx6Qxg79lY=@lists.linux.it
X-Gm-Message-State: AOJu0YyG0ZlSZDLe20wOBqIJ+3qVUskeGIpGRTloHWR7YhxDveuq6ZSr
 SonOOaOte8L1Tv7xTE/g5SlaPRav+46lU4nguSehRhZAu6SHhqPx61ylqR+4VHlehkU=
X-Gm-Gg: AR+sD12dbHS87RkCp3tfRCd8dYfhd7Vasoyc6qLnF3sLcIxgzRQk3VZeFzo2LHVKYgs
 lhTxDsWfEzA+i4unKuLww3Vn/LXpzo94etfq9PIaQMbAZMyup4cuhrpXJE5Jw9rHaEvcxDCSVSj
 rAaw+fMHaj9dMoIMYtGAhja/De7c2iQPxuFOMBcl201k03oJRR+odaBMQXxcSmD1q8Q56diLogR
 Gzd7lrglMlxnJj4pzdVZZEJOHojJD7Z0RKJWarNfLzcnlSle62kX1Z6DNVIX8FP9gVrbEYr4G8G
 GrAxKmOIiU7szXD2w/zrR9LHqTsk6WCti2tXTQU2tt4iMYzauXcnNWp8nmAFFmg7+6mSVy0xUOi
 EX9Y9lOK+xIJVVLdzLepbJTcgmRHcBGYlOofEVgwe6oPRP+hS1EWVMjsUyEOO7unmxD9ossckp7
 Ms+IGF97TZgLoDJSp0Bmq4m0s9zk7AxFzNxzTcHEO5tgtjpyMSGE9ETbskyaB9tWnRJiNFMAg1J
 laFrVnsBuHKABneo/BsLQ+NPh512G2q5OhUZo97J3Qdkop1Bce/iqko5VtKDxqb+eXINdE=
X-Received: by 2002:a05:600c:5395:b0:493:faf3:3ea5 with SMTP id
 5b1f17b1804b1-4980c66c751mr253851045e9.4.1785749296379; 
 Mon, 03 Aug 2026 02:28:16 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498081a1006sm298032855e9.7.2026.08.03.02.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 02:28:16 -0700 (PDT)
Message-ID: <6a705f30.cfe55ba5.e6eae.189a@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <anBdxCKHlpedf2rf@yuki.lan>
Date: Mon, 03 Aug 2026 09:28:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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

> I would keep it around at least for a year or two, I sometimes look up
> old patches there.

that looks like a really long period of time. lore.kernel.org/ltp/
is not enough?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
