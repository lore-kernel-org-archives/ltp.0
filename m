Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19CC606A31A
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=W7gPk+He;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ONcHMyyJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792657203; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=UYQqrAsbFaYxq5RhEDnXkCdFaCviDKtbrvre+olphc8=;
 b=W7gPk+Hed7BlA629Ux7eW4g3P4AONzbNgVu3xx1mLm9RV+twRWlRwShjc1IOfkTu2ywAo
 jRdbO+bCoNuhJq8Oxv4PkiPxDAsPOhWfkzZ/LKW+kEcYM+kLB/neILi7zfwM6LUtyZFbGyu
 A/Wsq01S7GewrOihUxnbYaa254vZvy8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05BB33CFE7C
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 10:20:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85F733CFD6A
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 10:19:44 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BB4331000A14
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 10:19:43 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-487049569b6so1033617f8f.1
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792657183; x=1793261983; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9D7dwWi8rs5N6lGbzAtpSq/EG6b8Jjc5MNiwCrXMyS8=;
 b=ONcHMyyJa0mHgb0MYOFuUObXwiRQvgsoZKCIaI0qe1qvuzkm7/FApvUKQkji7XPQng
 qiKawayvNqbEM0yiP6oiIM/Qzn3UlguM8fjR6c0LL2NZh/6Rvd5WbduZnr2tHTPn742n
 phc8VfyNWA2mmc9rc5LORH/Ng1amX1UlW9HBghkG8EfbYiLWTyc6O+gqsnr1cLxJhQHl
 T/vqmVXSBJjEp8pnmfafjt8OO7rSF+VvK9h3NDLz40JJw33wHoqAnfHJXQdEep3q8nc1
 FI7Y9uV8pc/HIXQ8LvQaUpoPAdjhM3tEnuxWQLF0Z24mpPfg7y5JuNUgYNBMkeck0P0y
 N9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657183; x=1793261983;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9D7dwWi8rs5N6lGbzAtpSq/EG6b8Jjc5MNiwCrXMyS8=;
 b=X5QPUIjHqMzBBpaeO4WVprnOawwitjuJmkSf+L64K72YtA4+OvBKfUuZwkVIjPwTub
 96TwfMWbBVRtJ1Roh7vUOu2Hv+ke956ISV30RsN8UgiJcYno5HE0WxMPosveB6uBcHaZ
 1xa6TkiqeEQ3o8vR8MEsZoHoX8EPVwumkYkCfj0bYJEQgjNRWaiXurQYdn6iDVVCs0CR
 LLSzks1TBWy6In0P2Uegh0HbIRQK+2pbQwJvl5rwjkpB/fDL3gDW86WWWXCTzQtAdrks
 F1dzbPJ3PQV5H7Ws5N+a8e0SvchBQr51rdS2suVlEi4Tr0/M8jkSsrUf5KtfrBHDf8aW
 SWLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnltW9KOx+gHudFIeC1GxoDJYnzMYl4ZQfKOooDMUPxp2hyCQBxLUCItZkKvm4Jpokg64=@lists.linux.it
X-Gm-Message-State: AFq9FYLSy5QpvjnQ6CWzeEyVOQj8qjTcS6UDvNCJ+zp96eLMf0e/HBY5
 HZWAZgabeobk0ZpNYMP9cEWmkyU7KVb3uEJHe8pJ4xSCEUlrMC1cTLbGINDq6mDaoho=
X-Gm-Gg: AYBFou20m/7ctB9wo6YXnJKG7roG8UgdF3jyjpY7x1maiKdc5JYan7UCdk9lkk48Ymb
 3o0A/7r2Bt1lQGhwLl1LMA89e8JQF3TOnI/SVwDxzrxF2QKDCxnCILSCFGOGlOlbu8LTot5nQQ3
 NIg65U5adlLNgTyb1uPznveaWI0+vy5B775U5KBnc1XAt9otBj9rSfregPM1odYpC3HWlBO0egL
 QpEKQjpBS54Ifp8DtgmJK/dho34OejcqpPVH6p0eiUZIvUGNlfpeGauWP20eRt3iay4I1afHG9n
 xXZ7GFthK421vCInUt0ggvqZ42Qg2XGzxQQ3uVafZWZLNZVzt5NLVXaIq4wIcb3qNBf+UN4gemw
 FvlIQfFxwT2TCOKFY471iYP4jBgEdbZsOlzUEuD3NecXgMnm0vjfIOCSWfJHimJV/eGtokl9Fgd
 boVsSK00V4RG4SMTFqP7cpvmvL3Jrm6xUckUENxt6dntEOa6ero7yl9Hp8VlDEHjxPQa5ZtWLuw
 PslK3oImGeSBabKJEk+x/xNAiddXQ5vVJlfeK0S0/PDbSuwUil2rZs91QKp8VIUsv+W6N6PWKrl
 +cX18HsUSYCnR+27O6rsg+LbPp6bKaLT3FwuQDtNOKdmyIYzrAAQb9U777s=
X-Received: by 2002:adf:e012:0:20b0:48e:932:aef3 with SMTP id
 ffacd0b85a97d-48e264b7005mr6686719f8f.23.1792657182956; 
 Thu, 22 Oct 2026 01:19:42 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583e25asm11409561f8f.46.2026.10.22.01.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 01:19:42 -0700 (PDT)
Message-ID: <1bR3w8ntAnNcr5mP7PK1jexPEO1duew9nEsW@localhost.localdomain>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <atltORji4cZMrRs3@linux.dev>
Date: Thu, 22 Oct 2026 08:19:41 +0000
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: LTP
 List <ltp@lists.linux.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> > > Wednesday 28. Oct is bank holliday in Czech republic, an independence day.
> > 
> > +1
> > 
> > If it needs to be Wednesday, then next one 4th Oct from 10 would work for me.
> 
> I guess you mean 4th Nov. Of course, that's fine with me.
> 
> > Or we can try to find another day next week (26th-30th Sep), e.g. Tue 27th from
> > 11.00 am would work for me (meeting from 11.00 shifted to 10.00).
> 
> I vote to 10am CET.

we can have it the 4th of November, but I will make an exception: I'm leaving
SUSE and my contribution will be reduced in the next future, unless I find a
company that wants to hire me to work on LTP as well :-)

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
