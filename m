Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5969A1061B37
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774959627; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=X1JqWB+JoLw+5/d2BlYCCOq6D7bkJiT6c78VusOfuD4=;
 b=QCaFwF/PepInoFWWAAiXxy8oBhMvyqEsYjL5lTkzm/bcWotfIMZMI4TXJLatpL15oT+K4
 t2dO4eodnTc7gsEyB71UOrfboCaJjcXZAZfo/1gVjRlfylCOxZ7jdF/SyWHUchL1NjEofEa
 venW9cp7tlivkb/luQEtJFQCcfkWCNU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 106DC3E4ECD
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 14:20:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B487A3C9314
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 14:20:03 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E4424600746
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 14:20:02 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so57096095e9.3
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774959602; x=1775564402; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PBz1kxqtmrHq1qbCVpcFooPhjizXatLTrsXOcI9IIg8=;
 b=YZ1aM7EQiolQu2Lm17gCWqlHT/0qt3uzBhEq4oWVb02B1ADvUs1Y+FuDqBnQaUAsp4
 XFBTzNXO9ODOJCVfzpAzj6fz18R9dizgKTUSy4iurRAg7em7f+azGj+q/m6DBm803YZR
 vNhxom4WZpFZvk0cmz6HmPdwuPSgMw0OXQ8+g4xc4l4YDXFD4Or74TJ4MUAdQZ3OMQu9
 kV6Z48F3Ptnnnc4t1o96dr8b2Xh6S+p7Kj0k8ncaYyr5Q8HoR7t4Lo1XjlPsQY31Lx04
 4NBkx7ncdhthM/9IWP7dnF+0rasqBdAT8/oe74vLW2plgjff4eVMSF1cfuCSBA4cDmIh
 2T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774959602; x=1775564402;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBz1kxqtmrHq1qbCVpcFooPhjizXatLTrsXOcI9IIg8=;
 b=migdfps9hOOOyoxLdmKMbvnVHRPm99mLAJlryy+u6FXoko9YC2DnwSqf1KXENKb9+F
 AKhW6G1qx1ixuINrzM04xjKAM3olEs2JsgqOjwQkRV3weRKi2VFezCkc8yFwmdmWdS1H
 OoMuUZAstdZ/wzCIsmqsY3MOcUTkh75iXxc++nuoBslOVGxijl5bxRaT4fao2I/lR3Ow
 QBneW6kbcqAHpkA9QgLgE0BngP9NG4hkV3TbjwJEl3dHT72bkKByQa3Xqwth+UEg9IGL
 9j7C2oLjWdP8FGR84uz8ovdN4AeOVr+f7gxEC3BfP1ybjS/PW7+rmE5TZdvMba4J5Er0
 Ibug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6ZZwdPbhGW2APyv1UobmWgcWiiSGwG29FTaNSA2Xg+4jJ27ONKLcBS4lMb9vunDi66/w=@lists.linux.it
X-Gm-Message-State: AOJu0YxsfG2LIqykyYaZo22KXAxJJW0Q9C0cisOglnEuu2Ac+4P0ioNr
 TAmrEsfESs46bhfd+GqxTZrTRQ9j4IanESQOiH6q3awqfvBFiMx1dDFnD0qGIKkF+AI=
X-Gm-Gg: ATEYQzwGPdeLkRvfwppe7M7uQbKIQBECTqyFRn0nHC9qy0rUlOmGtH38pbHkPeFoFWh
 rtCToBS5wObd3tfhPK1T/hM+9y8jDxgBe4daqM/rt27s1DUqQ8NqlzaIjmtlnsxRYwtlQFnY8KK
 x8Nw2C1r0b1l4BuFTUuooPDFLk/F55TA+2Zwqaj+O7OxiFCk7ybPlQOeJ5yMknxpbJRjATFD9oh
 9oR+lFUyHJOW9Ji1OSfJ6tfJNUENmcRgzqyBUvV0//432SUht6p0p75E15QLGEBbrba8Zy85RMf
 eaqItWaVxwuW3Vm9rrw6l/pi3PMwnrvlkIjYPr89J1AwNhXv4FZcopn9cfjWlQySslWD2UKqXI0
 Fc7h4oCwBi1Bnc8qZTE2gyb64JAo974NHIN0cuCNcBOsaciB8lRhr5n7fh5HE716LLx12gVWUK8
 DywoeoyYoSfxSCT5O+Hqhdd21lRO2JB2Jd0KVazKjL9hqatQT6qK6IV1kZ6pvjlIZawo8xofJNo
 7PVt8xKuQWtExfmnv7Pv1bd4h9VpwSI5C06p0V37sLy3YJx09XmQQ5BwUwpPP6/DDj3vZC56A56
 4J4hIro3vw==
X-Received: by 2002:a05:600c:8b03:b0:486:fdca:ea8d with SMTP id
 5b1f17b1804b1-48727ef5550mr299649735e9.25.1774959602279; 
 Tue, 31 Mar 2026 05:20:02 -0700 (PDT)
Received: from p200300ff0f0853018c5be4aef36ba14f.dip0.t-ipconnect.de
 (p200300ff0f08530146115d0b2dc6d03f.dip0.t-ipconnect.de.
 [2003:ff:f08:5301:4611:5d0b:2dc6:d03f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e735532sm41068865e9.0.2026.03.31.05.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 05:20:02 -0700 (PDT)
Message-ID: <69cbbbf2.050a0220.72fde.8c02@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <acu6odZhugXeNM_C@yuki.lan>
Date: Tue, 31 Mar 2026 12:20:01 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nanosleep: Use CLOCK_MONOTONIC for elapsed time
 measurement
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > All nanosleep POSIX conformance tests used CLOCK_REALTIME to measure
> > elapsed sleep duration. CLOCK_REALTIME can jump due to NTP corrections,
> > VM time sync, or other wall-clock adjustments, causing sporadic test
> > failures where measured time far exceeds expected sleep duration.
> > 
> > Switch to CLOCK_MONOTONIC which is immune to wall-clock changes and is
> > the correct clock for measuring elapsed durations.
> 
> Unfortunately CLOCK_MONOTONIC is optional in POSIX so we have to check
> if it's present at least at compile time with something as:
> 
> #if _POSIX_MONOTONIC_CLOCK
> # define TEST_CLOCK CLOCK_MONOTONIC
> #else
> # define TEST_CLOCK CLOCK_REALTIME
> #endif

good point. If it was a non-posix project it was called non-openposix :-)

Do you think that check is enough in this case? Or we should just mark
this test (if we really want to keep it 100% posix) as XFAIL ? I really
didn't see any option but introducing CLOCK_MONOTONIC checks.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
