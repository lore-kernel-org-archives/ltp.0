Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B079D6ACF0
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 11:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766058844; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lvsxGy19eBiezaVIU1w5vZyt0cFYgfnk7zG5qPffEDQ=;
 b=X9uFUqoUWUH/IYA8WWmwrk6iuK7VoiNFGz0TuDDFONHkZ/HpZEPfBQZ15ZZyy+pLW54Ch
 9q7DpsSJ1b3lPS4Apvl/TGYIDbv9H7fY1Wi03zb3ZZ5frsl5PljktBQzKu95ZZpgNd8oghg
 epm3LyQXhW12YdQicXjChU6fv21xrqo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94BC33D0486
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 12:54:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27C963CAA5A
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 12:53:41 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 838BB1A00CA0
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 12:53:40 +0100 (CET)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b79ea617f55so108780466b.3
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 03:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766058820; x=1766663620; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JDvH/UUjMs8HS5XCp5+8j1KMDW5dwLLT/mx+RYjUWw=;
 b=QiC5/paTWMJkuVUR+jgMCEh8c7mptmRbdjl+qjHtT63ONG9ONnAgroUgYE6CF6gLku
 zPH+yVy9dVz0d+F9R3FvhktH3oEWc6l63IxbMgiFlHmSakoWjsAevn7MsVbiXeW2FHoU
 sXLRFfc+cfdzw2tEn5zcoydcjcKKAC7i8QLUY0ELy3cq9hJQtPeNzhqGCCq/V9NAY85w
 KU7UnGJZGXCWBdRK6RJSmr54+fe8aBeTc6OH8sv6vRYgJm9PpBStsSt9hmgozWCH/dv0
 ql6yS5i2NhmUFXzleIn5F0k7MXpyaJl/e7Pg9tVmN5zMkiP3sZp/L0DopxQBWGjeBVOv
 bg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766058820; x=1766663620;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+JDvH/UUjMs8HS5XCp5+8j1KMDW5dwLLT/mx+RYjUWw=;
 b=ARvYNl1nSPZF9zc6WqHP4N5X0TU9MSnoEXqLpzc0tUxr+ARO65g/pCCTu5t5FSqZFp
 c2zu74ktp6rrQ4ja+K07mGOozzDkOYXcu4AW3PL8h51qUmBs5e42kcuZYOu2QY0AY+57
 D3gYSy51n6EdnrLqh+j97ZJWMCiiWKvJeE7NJeozeERAIHLmqPd7cg1DlXdQgwSf4aoL
 rJSScF2YG3Fd4yZROKnLRL6ruvtfjzqrmT4HY4BAQ6SfPq9U9E+mE8/ZmY4j6f6sHY9i
 en/jDjaIQxhlSFoE0X8MAcVbo+UuCWqeBe6kH3k0EB5U6v4TJktBPr0DEMqA8KUOWVOH
 fMpQ==
X-Gm-Message-State: AOJu0YwFYkaJbpTBilzPDbZurtYLP3HWpzZrqQJP2hvmSjTws5/o1Pwh
 tFVmoqqtfbytlL8ijRE1snc6tcIe2x7R938L5WPEgrPQLlEPdxKsO5fKJtrZqGWjZI3REX78IYR
 cks3rx88=
X-Gm-Gg: AY/fxX6TNlvHNwm0c3uh4gs0GHBr4DiTQNLW/4dmuVXIxm0fItBSU85M0FDwP9tjdnf
 NDHl1+xSmBI88HcN6BLDkxYRJsmbqICw8ZnV1SOO7xFaQeIN2ggi1dG8JTi6Eotcrc237PRUjBI
 JIr9jO7qd8L8s/dTNhESBuhBZ3/GlMn/kXdbYNReQUtSzqtuyeXLOS10+WKWDZxt4lGT1dKVMkF
 SPps6jMgLZ53LmNJPUHXc4Yx9B/jQaeWqlY3Uzc/u2E+t9YhSnaJHisUwjpjsKh2UVfHFX9OBZi
 nBqoL/o9C1xS94Ki893xX7iTijB4MQV4+32lZdo4VhswZfo0xcXVuKw/kITpaHz9vahfm43bIhM
 FvPC0/vPGE95CwOrtFkfIO2L931tn7bu4KOFRnNpPQMdEb3tH0tDkDypIADT2HA+LXHiIbVBgmW
 6NYYtuLmxgjF2DYmE=
X-Google-Smtp-Source: AGHT+IFYMRSnXeI3oBKz1zGLkNCmWK2shI+vWUL9oPJikjA2tw7Omj1s8/Xq02moxvzsVi4hZ61EZQ==
X-Received: by 2002:a17:907:2d8f:b0:b73:845f:4432 with SMTP id
 a640c23a62f3a-b7d23a972d0mr2540535866b.32.1766058819796; 
 Thu, 18 Dec 2025 03:53:39 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8022f952f9sm210242466b.8.2025.12.18.03.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 03:53:39 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 12:53:38 +0100
Message-Id: <DF1BLOZ4TVR3.1PHZZM9X0PBPZ@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Avinesh Kumar" <akumar@suse.de>
X-Mailer: aerc 0.18.2
References: <20251107102939.1111074-1-pvorel@suse.cz>
 <20251107102939.1111074-9-pvorel@suse.cz> <13884671.uLZWGnKmhe@thinkpad>
 <20251114100657.GA52218@pevik>
In-Reply-To: <20251114100657.GA52218@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 8/8] tst_test.c: Change fork_testrun() return type
 to void
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

Hi Petr,

On Fri Nov 14, 2025 at 11:06 AM CET, Petr Vorel wrote:
> Hi Avinesh,
>
> thanks for fixing all the typos.
> I'll wait little longer and merge with the fixes.
>
> Kind regards,
> Petr

I guess you can merge it now, there are enough reiewers who reviewed
this patch series.


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
