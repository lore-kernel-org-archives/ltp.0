Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9CAC54FCC
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 08:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771575208; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=F3r//9Y6Jan+CWzxHlsBr2Xp9gWPevzprHLes+xPmcg=;
 b=HZzp+OfQxRMGO47vp+Ek6pctlGQeDY8l/KM1n7Whefntja3tPCJKN/4qYvYCOc3YZVTd5
 VXHexCDeS8QsD59ODCtMOdXIsURcg0EmltAl+s5COtS03HqmhK6irDucV/2qTN7xNWPBTJQ
 BvVFL6HtTpQE9sH6/H9owlfLC2ykUiw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C24EE3D02E7
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 09:13:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85A183D02E7
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 09:13:05 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DA503200AD0
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 09:12:59 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so10615935e9.0
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 00:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771575179; x=1772179979; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yyq+9zi7zICtRc9D6CanQaSzuE38KaPKA0jtPXLijdo=;
 b=KUj82b3UHXCOlSVXLRgx2kL4b7+j61vrFDa/a8JVjNJQOiML7oDMjQX/mHYufevPFQ
 sTS0L2OLVYy1SKoXNsusr37vjDUQHSwQMHYlnqPWGNVgoM53jict7XHOXuXo9Rpn1JHg
 6L45g1zu4GiBMl+ToLHnJ2xeFj2J1TA2rsG5t4x7rY88PnYaYX6U0+i2qHnHmjw2r3IM
 8MmJ4+ikGGefkjWvC738IEVH/gmNSneB2FBADVreL2aanvbe1ppt7GV4fH9kqaPd3u6g
 RHV+jvNrZhdX7hjzGJUr7SeFm0IqfOA1Uf0Y+mo7OKVIgQ9AniDoOV2qWwLCvtoa5l7J
 pP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771575179; x=1772179979;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yyq+9zi7zICtRc9D6CanQaSzuE38KaPKA0jtPXLijdo=;
 b=HkNr4Pfx7VUpBPLOfL+sNxK2P5KpJMtkvzgbqlIeIKQBNW47n/NkDengs5qy+inHuS
 io3zM36lPQrrL5j7omCmWWdoXykTgZAsNxQput7SmZ2t8+1qhklpQmrDOo6sNZUrbvQg
 nStj/oTR74DTpBy6rtlIfjssRlu2ItMVtSfFgNJJVcd2OyX62btwv3xBOOAGN6V0cUZc
 YaqYor/NnofX74Q11PK0p8VFfBow0xwTaKAcuk895IWelGGhFS3bglC9fyE1PoPyhPcW
 0FiJa7bjuAuFuWF75P7DOSqYp4EaUB+LvHCgm6RdgH50I7yySMwxTUihXzLydFG7FvUG
 nfmg==
X-Gm-Message-State: AOJu0YycyMvfT+XZurgHpdPuclqIpDO4PiN50romb7RHMY1GYsS1UpDC
 cOOD44Si8+e8Mjtk0TxN9RAF1J+/8MDwndx8qBHQ+fzOZTxqLCyoSU+zACFKcWJ79QA=
X-Gm-Gg: AZuq6aL0zPMugqUSLJadXIJ9ik4fjQ/WVcoEsFIhczrs4jg9UlmWVgbB2WMnlRXuqVj
 8wnu60+fFVJrKC4bvhMpVPCgXwbtsie5+QdJlAjCZBZsOvzn80BsKyAPOTJ2UBbnLwzxXjKPSed
 l9dubpaDD77LY2IzYnKc0JUfrJOYZV/64dE3KRO5y5r3Pc1ctfLpDn42EmgHPGv+3ZREa5WLqHa
 OWVXJtTnGB06Zr4ExYXXtCXz4HRgV5SQDH3//vAxfEbKUnkQQkvUmvLaJAJOzJ7KY3y33bahwKq
 hIAWHV2IwsI+LTHFZ1Q4+Laxm8P6KMpttPpeiVhQYeJUlzUNJP8KBxczCMO5XP2/gHH2YedfzL8
 g/sLSSw4SnoxLz7ZK6BUNg1zTxHtLFu7MYzfmVmKwgb1d3LNHT3t2Lxtm/5/gnpFEiGnKu2kMoI
 6lL5C5GMaPLdnXB7sRXboRNv36DSn/gxiKFEujyuRwgR2iH1BF6m3qYzWhFB8p9ZqnYQDYo99GE
 qKRkVdX1+7vLtqItwM=
X-Received: by 2002:a05:600c:4eca:b0:483:6d4a:7e6d with SMTP id
 5b1f17b1804b1-48379be60camr296679605e9.30.1771575179182; 
 Fri, 20 Feb 2026 00:12:59 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3e01b0fsm16241775e9.8.2026.02.20.00.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 00:12:58 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 20 Feb 2026 09:12:57 +0100
Message-Id: <DGJMZLFK3YJY.EUUQNSIBR2PU@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Cyril Hrubis" <chrubis@suse.cz>
X-Mailer: aerc 0.18.2
References: <20260205121540.329921-1-pvorel@suse.cz>
 <20260205121540.329921-2-pvorel@suse.cz> <aZQytH7k6pVXqdsz@yuki.lan>
 <20260219202051.GB341772@pevik>
In-Reply-To: <20260219202051.GB341772@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/6] doc: INSTALL: dma_thread_diotest.c: Remove
 runltp from doc
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Anyway, I can wait little longer, but I got already quite a lot of ack to merge
> whole patchset.
>
> Kind regards,
> Petr

I agree, let's finish this PR and make a new release.
https://github.com/linux-test-project/kirk/pull/92

Then upgrade kirk in the LTP upstream and remove runltp one for all :)


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
